# Invoice Exception Analytics Project  
**Consolidated Invoicing, Engine, and Exception Analytics for a Global Industrial Services MNC**

---

## Project Overview

This project demonstrates a full-cycle data analytics workflow designed to optimize invoicing operations, improve SLA compliance, and evaluate vendor creation efficiency for a global industrial services organization. It includes rigorous data cleaning, KPI development, SQL validation, and dashboard reporting using a realistic, synthetically generated dataset.

> **Disclaimer:**  
> This project is based on a confidential dataset sourced from real-world enterprise operations. To ensure data privacy, the dataset was fully mocked while preserving the original structure, column names, and business logic. The data has been intentionally modified and made messy to simulate realistic cleaning, transformation, and analytical challenges.

---

## Business Objectives

- Streamline invoice exception handling.
- Enhance timeliness and SLA compliance across request types.
- Evaluate the performance of the “engine” process for vendor creation.
- Deliver data-driven insights through KPIs and dashboards.

---

## Repository Structure

├── 00_mock_dataset.csv
├── 01_data_loading_and_initial_inspection.ipynb
├── 02_a_cleaned_data.csv
├── 02_data_cleaning.ipynb
├── 03_kpi_analysis_eda_and_visualization.ipynb
├── 04_Invoice_Analytics.sql
├── 05_Consolidated Invoicing, Engine, Exception Analytics.pbix
├── 06_power_bi_dashboard.png
├── 07-Findings-Report-Presentation.pdf
└── README.md


---

## Data Cleaning Summary

Conducted in `02_data_cleaning.ipynb`:

- **Column Management**: Renamed columns for clarity and removed null-only or irrelevant fields.
- **Duplicates**: Identified and removed exact duplicates, resulting in 10,013 valid records.
- **Data Typing**: Converted date fields and financial figures into appropriate formats.
- **Missing Values**: Applied business logic-based imputation; retained meaningful nulls where appropriate.
- **Validation**: Corrected anomalies and inconsistencies in SLA and monetary fields.

---

## Key Performance Indicators (KPIs)

| KPI Category | Metric | Value | Insight |
|--------------|--------|-------|---------|
| In Daily Actioned – Volume | Total Requests | 10,013 | Approximately 21 requests per day; consistent with real-world benchmark of 9,819 |
| In Daily Actioned – Timeliness% | SLA Compliance | 95.72% | High adherence to the 2-day resolution target |
| In Daily Actioned – Quality% | QC Passed | 100.00% | All 3,870 audited requests passed quality control |
| Engine Vendor Creation – Timeliness% | SLA Compliance | 97.16% | Vendor onboarding process demonstrates strong efficiency |
| Exception & Unknown – Timeliness% | SLA Compliance | 84.02% | Slightly below internal benchmark of 84.3%; minor definitional variance noted |

---

## Exploratory Analysis and SQL Validation

- **SQL Validation**: All metrics and KPIs were validated using PostgreSQL scripts in `04_Invoice_Analytics.sql`.
- **Python-Based EDA**: Performed in `03_kpi_analysis_eda_and_visualization.ipynb`, covering request distribution, SLA trends, exception frequency, and outlier analysis.

---

## Dashboard and Reporting

- **Power BI Dashboard**: Developed for dynamic, filterable reporting with key SLA and volume metrics. (`06_power_bi_dashboard.png`)
- **Final Presentation**: Delivered as a business-oriented summary deck. (`07-Findings-Report-Presentation.pdf`)  
  Structure includes:
  - Executive Summary  
  - Business Problem & Analytical Approach  
  - KPI Outcomes  
  - Key Visuals & Insights  
  - Final Recommendations

---

## Technology Stack

| Category           | Tools and Technologies Used           |
|--------------------|----------------------------------------|
| Programming        | Python, SQL (PostgreSQL)               |
| Data Analysis      | Pandas, NumPy, Matplotlib, Seaborn     |
| Query Management   | pgAdmin 4                              |
| Business Intelligence | Power BI Desktop                    |
| Reporting          | Jupyter Notebook, PowerPoint, Canva    |

---

## Conclusion

This project replicates enterprise-level invoice analytics using a multi-tool approach to produce accurate, validated, and business-relevant insights. From robust data preparation and KPI modeling to final visualization and stakeholder reporting, it reflects the analytical rigor expected in a corporate production environment.

---

