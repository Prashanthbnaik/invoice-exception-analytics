# Invoice Exception Analytics Project  
**Consolidated Invoicing, Engine, and Exception Analytics for a Global Industrial Services MNC**

---

## Project Overview

This project demonstrates a full-cycle data analytics workflow designed to optimize invoicing operations, improve SLA compliance, and evaluate vendor creation efficiency for a global industrial services organization. It includes rigorous data cleaning, KPI development, SQL validation, and dashboard reporting using a realistic, synthetically generated dataset.

---

## Key Business Objectives

- Streamline invoice exception handling.
- Enhance timeliness and SLA compliance across request types.
- Evaluate the performance of the “engine” process for vendor creation.
- Deliver data-driven insights through KPIs and dashboards.

---

## Repository Structure


---

## Data Cleaning Summary

Performed in `02_data_cleaning.ipynb`:

- **Column Management**: Renamed and dropped redundant or null-only columns.
- **Duplicate Handling**: Removed exact duplicate records to maintain 10,013 valid rows.
- **Data Typing**: Converted date fields and financial figures to appropriate data types.
- **Missing Values**: Applied context-sensitive imputation or retained meaningful nulls.
- **Validation**: Fixed invalid values in financial and SLA-related fields.

---

## Key Performance Indicators (KPIs)

| KPI | Metric | Insight |
|-----|--------|---------|
| **IN DAILY ACTIONED - VOLUME** | 10,013 requests total | Average ~21/day. Matches real-world filtered benchmark of 9,819. |
| **IN DAILY ACTIONED - TIMELINESS%** | 95.72% | High SLA compliance (requests closed within 2-day SLA). |
| **IN DAILY ACTIONED - QUALITY%** | 100.00% | All 3,870 QC-audited requests passed successfully. |
| **ENGINE NEW VENDOR CREATION - TIMELINESS%** | 97.16% | Efficient processing of vendor creation requests. |
| **EXCEPTION AND UNKNOWN - TIMELINESS%** | 84.02% | Close to benchmark (84.3%) with minor definitional gaps. |

---

## EDA & SQL Validation

- **SQL Logic**: Written in `04_Invoice_Analytics.sql`, cross-validating Python results.
- **Python EDA**: `03_kpi_analysis_eda_and_visualization.ipynb` provides in-depth trend and distribution analysis for each metric.
  
---

## Dashboard & Reporting

- **Power BI Report**: Embedded KPIs and slicers for dynamic stakeholder reporting. (`06_power_bi_dashboard.png`)
- **Final Presentation**: Executive-friendly summary of the entire project. (`07-Findings-Report-Presentation.pdf`)
  - Executive Summary  
  - Business Problem & Approach  
  - KPI Results  
  - Visual Insights  
  - Recommendations  

---

## Tech Stack

| Component | Tools |
|----------|-------|
| Programming | Python, SQL (PostgreSQL) |
| Libraries | Pandas, NumPy, Matplotlib, Seaborn |
| Tools | Jupyter Notebook, pgAdmin 4, Power BI Desktop |
| Reporting | PowerPoint, Canva |

---

## Conclusion

This project replicates a real-world analytics engagement and delivers measurable insights using structured data workflows. The approach demonstrates strong data engineering practices, business acumen, and dashboard storytelling tailored for executive decision-making.

---
