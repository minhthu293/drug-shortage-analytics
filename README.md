# Drug Shortage Analytics

## Project Overview

Drug shortages can significantly impact healthcare systems, patient outcomes, and pharmaceutical supply chains. This project analyzes drug shortage records to identify shortage trends, major manufacturers involved, root causes, vulnerable dosage forms, and shortage severity.

The analysis was performed using PostgreSQL for data cleaning and analytics, and Power BI for dashboard visualization.

---

## Dataset

**Source:** FDA Drug Shortages Dataset

**Total Records:** 1,682 drug shortage cases

The dataset contains information about:

* Drug manufacturers
* Product information
* Shortage status
* Shortage reasons
* Availability status
* Posting and update dates
* Therapeutic categories
* Dosage forms

---

## Business Questions

This project aims to answer the following questions:

1. How have drug shortages changed over time?
2. Which manufacturers are most affected by drug shortages?
3. What are the leading causes of drug shortages?
4. Which dosage forms face the highest shortage risk?
5. How severe are shortages in terms of duration?

---

## Data Cleaning

Data cleaning was performed in PostgreSQL.

Main cleaning tasks included:

* Creating a dedicated working table
* Converting date columns from text to DATE format
* Handling missing values
* Standardizing categorical values
* Correcting data entry errors
* Creating ENUM types for status and availability fields

SQL script:

```text
sql/1_data_cleaning.sql
```

---

## SQL Analysis

The analysis was divided into two stages:

### Business Analysis

* Manufacturer impact analysis
* Manufacturer concentration analysis
* Root cause analysis
* Dosage form analysis
* Yearly shortage trend analysis
* Peak shortage year analysis

SQL script:

```text
sql/2_business_analysis.sql
```

### Advanced Analysis

* Longest shortage duration analysis
* Average shortage duration by company
* Monthly shortage trend analysis
* Severity assessment

SQL script:

```text
sql/3_advanced_analysis.sql
```

---

## Key Insights

### 1. Drug Shortage Trend

* 2023 recorded the highest number of shortage cases with **372 cases**.
* 2025 followed with **339 cases**.
* Drug shortages show significant volatility rather than a steady upward trend.

### 2. Manufacturer Impact

Top manufacturers by shortage cases:

1. Hospira, Inc., a Pfizer Company — 206 cases
2. Fresenius Kabi USA, LLC — 172 cases
3. Teva Pharmaceuticals USA, Inc. — 117 cases
4. Hikma Pharmaceuticals USA, Inc. — 97 cases
5. Pfizer Inc. — 91 cases

The top 5 manufacturers account for **40.61%** of all shortage cases, indicating a high concentration of supply risk.

### 3. Root Cause Analysis

Top shortage causes:

* Demand increase for the drug — 36.43%
* Manufacturing discontinuation — 23.37%
* Active ingredient shortage — 23.02%

The top three causes account for **82.82%** of identified shortage reasons.

### 4. Dosage Form Analysis

Most affected dosage forms:

* Injection — 975 cases
* Tablet — 434 cases
* Capsule — 146 cases

These three dosage forms account for **92.45%** of all shortage cases.

### 5. Shortage Severity

* Longest shortage duration: **5,268 days**
* Average shortage duration: **1,444 days**
* SteriMax, Inc. recorded the highest average shortage duration (**4,090 days**)

---

## Dashboard Preview

The Power BI dashboard provides an interactive overview of:

* Drug shortage trends
* Manufacturer impact
* Root causes
* Dosage form risk distribution
* Shortage severity metrics

![Dashboard Overview](images/dashboard_overview.png)

Power BI file:

```text
dashboard/Drug_Shortage_Analysis_Dashboard.pbix
```

---

## Business Recommendations

Based on the analysis:

1. Monitor manufacturers with high shortage frequency to reduce supply chain concentration risk.
2. Improve forecasting for drugs experiencing rapid demand increases.
3. Strengthen active ingredient sourcing strategies.
4. Prioritize risk management for injectable products due to their high shortage exposure.
5. Establish early warning systems for long-duration shortages.

---

## Tools Used

* PostgreSQL
* Power BI
* GitHub
* SQL

---

## Repository Structure

```text
drug-shortage-analytics/

├── dashboard/
│   └── Drug_Shortage_Analysis_Dashboard.pbix

├── images/
│   └── dashboard_overview.png

├── sql/
│   ├── 1_data_cleaning.sql
│   ├── 2_business_analysis.sql
│   ├── 3_advanced_analysis.sql
│   └── README.md

└── README.md
```
