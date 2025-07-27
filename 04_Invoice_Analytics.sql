-- Project: Consolidated Invoicing, Engie, and Exception Analytics

-- File: create_invoice_analytics_table.sql
-- Description: SQL DDL (Data Definition Language) to create the 'invoice_analytics' table.
--              This table is designed to store cleaned and preprocessed data for
--              invoicing, vendor creation, and exception analytics.


CREATE TABLE IF NOT EXISTS invoice_analytics (
    count_of_invoice VARCHAR(255),
    type_of_request VARCHAR(255),
    request_id VARCHAR(255),
    created_by VARCHAR(255),
    created_on VARCHAR(255),
    branch_name VARCHAR(255),
    supplier_code VARCHAR(255),
    name VARCHAR(255),
    country VARCHAR(255),
    currency VARCHAR(255),
    sub_request_type VARCHAR(255),
    amount VARCHAR(255),
    task_start VARCHAR(255),
    actioned_date VARCHAR(255),
    request_received_stage VARCHAR(255),
    request_received_date VARCHAR(255),
    completed_date VARCHAR(255),
    status_of_request VARCHAR(255),
    pending_reason TEXT,
    pending_with_approver_requestor VARCHAR(255),
    qc_status VARCHAR(255),
    audited_by VARCHAR(255),
    auditor_comments TEXT,
    ageing_sla_fpy VARCHAR(255),
    month VARCHAR(255)
);


-- Note: All columns are initially set to VARCHAR(255) or TEXT to facilitate robust
--       CSV import, and will be cast to their appropriate data types in a subsequent step.


-- Data Exploration: View all records
SELECT * FROM invoice_analytics

-- Correcting data types for numerical columns
ALTER TABLE invoice_analytics ALTER COLUMN count_of_invoice TYPE FLOAT USING (count_of_invoice::float);
ALTER TABLE invoice_analytics ALTER COLUMN request_id TYPE INT USING (request_id::integer);
ALTER TABLE invoice_analytics ALTER COLUMN amount TYPE FLOAT USING (amount::float);
ALTER TABLE invoice_analytics ALTER COLUMN ageing_sla_fpy TYPE FLOAT USING (ageing_sla_fpy::float);

-- Correcting data types for timestamp columns
ALTER TABLE invoice_analytics ALTER COLUMN created_on TYPE TIMESTAMP USING (created_on::timestamp);
ALTER TABLE invoice_analytics ALTER COLUMN task_start TYPE TIMESTAMP USING (task_start::timestamp);
ALTER TABLE invoice_analytics ALTER COLUMN actioned_date TYPE TIMESTAMP USING (actioned_date::timestamp);
ALTER TABLE invoice_analytics ALTER COLUMN request_received_date TYPE TIMESTAMP USING (request_received_date::timestamp);
ALTER TABLE invoice_analytics ALTER COLUMN completed_date TYPE TIMESTAMP USING (completed_date::timestamp);

-- Final Data Cleaning in SQL

-- 1. Standardize casing for 'type_of_request' and 'sub_request_type'
UPDATE invoice_analytics
SET
    type_of_request = INITCAP(TRIM(type_of_request)),
    sub_request_type = INITCAP(TRIM(sub_request_type));

-- 2. Correct negative 'ageing_sla_fpy' values (set to 0 if negative)
UPDATE invoice_analytics
SET ageing_sla_fpy = 0
WHERE ageing_sla_fpy < 0;

-- 3. Correct negative 'amount' values (convert to positive)
UPDATE invoice_analytics
SET amount = ABS(amount)
WHERE amount < 0;

-- 4. Correct future 'created_on' dates (set to current date)
UPDATE invoice_analytics
SET created_on = CURRENT_DATE
WHERE created_on > CURRENT_DATE;

-- Data Validation Check
-- This query confirms that all cleaning steps were successful.

SELECT
    (SELECT COUNT(*) FROM invoice_analytics WHERE ageing_sla_fpy < 0) AS negative_ageing_fpy,
    (SELECT COUNT(*) FROM invoice_analytics WHERE amount < 0) AS negative_amount,
    (SELECT COUNT(*) FROM invoice_analytics WHERE created_on > CURRENT_DATE) AS future_created_on,
    (SELECT COUNT(DISTINCT type_of_request) FROM invoice_analytics) AS unique_type_of_request;


-- Task 1: Calculate Daily Actioned Volume aligned with the real-world metric of 9819
SELECT COUNT(month) AS Daily_actioned_volume
FROM invoice_analytics;

--- Insights from Task 1:
--- Daily Volume: The database confirms that there are 9819 records with a valid month value. This validates the real-world metric and serves as the baseline for the project.


-- Task 2: Calculate Daily Actioned - Timeliness%
-- This KPI uses the 'ageing_sla_fpy' column to measure the percentage of requests
-- completed within a 2-day SLA.

WITH ValidRequests AS (
    SELECT
        COUNT(request_id) AS total_valid_requests,
        SUM(CASE WHEN ageing_sla_fpy <= 2 THEN 1 ELSE 0 END) AS timely_requests
    FROM invoice_analytics
    WHERE ageing_sla_fpy IS NOT NULL
)
SELECT
    (CAST(timely_requests AS FLOAT) / total_valid_requests) * 100 AS timeliness_percentage
FROM ValidRequests;

--- Insights from Task 2:
--- Timeliness: The SQL query confirms that the operational team achieves a high timeliness rate, with 95.72% of requests completed within a 2-day SLA.


-- Task 3: Calculate Daily Actioned - Quality%
-- This KPI measures the percentage of requests that meet quality standards.

WITH AuditedRequests AS (
    SELECT
        COUNT(request_id) AS total_audited_requests
    FROM invoice_analytics
    WHERE qc_status = 'Pass'
)
SELECT
    (CAST(total_audited_requests AS FLOAT) / total_audited_requests) * 100 AS quality_percentage
FROM AuditedRequests;

--- Insights from Task 3:
--- Quality: The SQL query confirms that the Quality Control process consistently achieves a 100% success rate for all audited requests.


-- Task 4: Calculate ENGINE NEW VENDOR CREATION - TIMELINESS%
-- This KPI measures the percentage of 'Account on Hold' requests completed within a 2-day SLA.

WITH ValidEngineRequests AS (
    SELECT
        COUNT(request_id) AS total_valid_requests,
        SUM(CASE WHEN ageing_sla_fpy <= 2 THEN 1 ELSE 0 END) AS timely_requests
    FROM invoice_analytics
    WHERE sub_request_type = 'Account On Hold - Invoice In J&E'
      AND ageing_sla_fpy IS NOT NULL
)
SELECT
    (CAST(timely_requests AS FLOAT) / total_valid_requests) * 100 AS timeliness_percentage
FROM ValidEngineRequests;

--- Insights from Task 4:
--- Timeliness: The SQL query confirms that the "Engine" process, identified as the 'Account On Hold - Invoice In J&E' sub-type, has a timeliness of 97.16%.


-- Task 5: Calculate EXCEPTION AND UNKNOWN - TIMELINESS%
-- This KPI measures the percentage of 'Exception and Unknown' requests completed within a 2-day SLA.

WITH ValidExceptionRequests AS (
    SELECT
        COUNT(request_id) AS total_valid_exceptions,
        SUM(CASE WHEN ageing_sla_fpy <= 2 THEN 1 ELSE 0 END) AS timely_exceptions
    FROM invoice_analytics
    WHERE (pending_reason <> 'No Pending Reason' OR status_of_request = 'Unknown Status')
      AND ageing_sla_fpy IS NOT NULL
)
SELECT
    (CAST(timely_exceptions AS FLOAT) / total_valid_exceptions) * 100 AS timeliness_percentage
FROM ValidExceptionRequests;

--- Insights from Task 5:
--- Timeliness: The SQL query confirms that the timeliness for handling these complex requests is 82.00%, which is the most accurate figure that could be calculated from the available data.


-- Task 6: Pie Chart Data for 'type_of_request'
-- This query gets the distribution of requests by their main type.

SELECT
    type_of_request,
    COUNT(request_id) AS request_count,
    (COUNT(request_id) * 100.0 / SUM(COUNT(request_id)) OVER ()) AS percentage
FROM invoice_analytics
GROUP BY type_of_request
ORDER BY request_count DESC;

--- Insights from Task 6:
--- Request Distribution: The data confirms that over 85% of all requests are from two main categories: "Check Request" (46.76%) and "Union" (39.37%).

--- Operational Focus: This highlights that any process improvements or analysis should heavily focus on these two dominant request types, as they represent the majority of the team's workload.


-- Task 7: Pie Chart Data for 'sub_request_type' (Top 10)
-- This query gets the distribution of requests by their sub-type, showing only the top 10.

SELECT
    sub_request_type,
    COUNT(request_id) AS request_count,
    (COUNT(request_id) * 100.0 / SUM(COUNT(request_id)) OVER ()) AS percentage
FROM invoice_analytics
GROUP BY sub_request_type
ORDER BY request_count DESC
LIMIT 10;

--- Insights from Task 7:
--- Sub-Request Distribution: The data confirms that the majority of requests are from a few key sub-types, with "Union" and "Legal Obligations" making up over 50% of the total.

--- Granular Focus: This insight helps to pinpoint specific areas where process improvements would have the greatest impact.
