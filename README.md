# Global-Layoffs-Analysis: End-to-End Pipeline & Dashboard
## Executive Summary
The tech industry experienced a significant shift in workforce stability between 2020 and 2023. To understand the root causes and patterns of these layoffs, I developed a full-cycle data pipeline. Using MySQL, I transformed a messy, raw dataset of over 2,000 records into a structured format for analysis. Through Exploratory Data Analysis (EDA), I identified that the "Post-IPO" stage and the "Consumer" and "Retail" industries were the primary drivers of layoff volumes. This project provides stakeholders with a clear view of industry resilience and identifies which company stages are most vulnerable to market volatility.
## Business Problem:
Raw data tracking global layoffs is often inconsistent, containing duplicate entries, missing values, and non-standardized naming conventions (e.g., "Crypto" vs. "Cryptocurrency"). This makes it impossible for recruitment firms or venture capitalists to accurately assess market trends. The goal of this project was to:
  1. Ensure Data Integrity: Create a single source of truth by removing duplicates and standardizing data.
  2. Uncover Trends: Identify which industries and geographic regions were hit hardest.
  3. Provide Actionable Insights: Determine how funding stages correlate with layoff intensity to guide future investment and hiring strategies.
## Methodology:
1. Data Cleaning (SQL): * Created multiple staging tables to protect raw data.
Identified and removed duplicates using Window Functions (ROW_NUMBER) and CTEs.
Standardized text data (trimmed whitespace, merged industry categories).
Performed data type casting (converted text strings to DATE objects).
Imputed missing values by joining tables on shared company names.
2. Exploratory Data Analysis (SQL):
Aggregated layoffs by Industry, Country, and Stage.
Created Rolling Totals using CTEs to track monthly progression.
Utilized DENSE_RANK to identify the Top 5 companies per year with the highest layoffs.
3. Visualization (Power BI): * Connecting the cleaned MySQL database to Power BI to build an interactive executive dashboard.
## Skills Demonstrated:
SQL: CTEs, Window Functions, Joins, Data Cleaning, Schema Modification.
Data Analysis: Time-series analysis, outlier detection, and categorical aggregation.
Analytical Thinking: Translating raw code into business-focused recommendations.
## Results & Insights:
The "Post-IPO" Trap: Companies that had recently gone public (Post-IPO) accounted for the largest volume of layoffs, suggesting higher sensitivity to public market fluctuations.
Industry Resilience: While "Consumer" and "Retail" saw high numbers, "Healthcare" and "Fintech" showed a more stable retention pattern despite the economic downturn.
Peak Period: The rolling total analysis identified a significant spike in Q1 2023, surpassing any month in the previous two years.
## Business Recommendations:
1. Risk Mitigation: Investors should consider the "Post-IPO" stage as a high-volatility period for workforce stability and adjust risk models accordingly.
2. Strategic Hiring: Recruitment firms should pivot focus toward "Series C" through "Series E" companies, which demonstrated more consistent retention rates.
3. Geographic Strategy: High-impact regions (like the SF Bay Area) require more robust severance and transition planning compared to more resilient secondary tech hubs.
## Project Structure:
layoffs_cleaning.sql: The full cleaning script including staging and duplicate removal.
layoffs_eda.sql: The analysis script used to extract trends and rolling totals.
layoffs_raw.csv: The initial raw data source.
Layoffs_Dashboard.pbix: The Power BI file connected to the local MySQL server.
## How to Replicate:
1. Import layoffs_raw.csv into your MySQL environment.
2. Execute layoffs_cleaning.sql to create the layoffs_staging2 table.
3. Run layoffs_eda.sql to view the analysis results.
