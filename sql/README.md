# SQL Scripts

This folder contains all SQL scripts used in the Drug Shortage Analytics project.

## Workflow

The analysis follows a three-step process:

1. Data Cleaning
2. Business Analysis
3. Advanced Analysis

---

## Files

### 01_data_cleaning.sql

Prepare the raw dataset for analysis by:

* Creating a working table for analysis
* Converting date fields from TEXT to DATE
* Handling missing values
* Correcting data entry errors
* Standardizing categorical values using ENUM types
* Cleaning inconsistent records

---

### 02_business_analysis.sql

Generate core business insights, including:

* Companies with the highest number of drug shortage cases
* Manufacturer concentration analysis
* Distribution of drug shortage reasons
* Dosage form impact analysis
* Yearly drug shortage trends
* Manufacturer analysis during peak shortage years

---

### 03_advanced_analysis.sql

Perform advanced analytical investigations, including:

* Longest drug shortages
* Overall shortage duration statistics
* Average shortage duration by company
* Monthly drug shortage trends

---

## Key Business Questions

The SQL analyses are designed to answer the following questions:

1. Which manufacturers are most affected by drug shortages?
2. How concentrated are shortages among major manufacturers?
3. What are the primary causes of drug shortages?
4. Which dosage forms are most vulnerable to shortages?
5. How have drug shortages changed over time?
6. Which products experience the longest shortages?
7. What is the average duration of a drug shortage event?
8. Which manufacturers face the longest average shortages?

---

## Dataset

Source: U.S. Food and Drug Administration (FDA) Drug Shortages Database

The cleaned dataset contains 1,682 drug shortage records and serves as the foundation for all analyses performed in this project.
