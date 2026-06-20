-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- FILE: 02_business_analysis.sql
-- PURPOSE:
-- Generate business insights from the cleaned drug shortage dataset.
-- Focus on identifying key manufacturers, shortage causes,
-- and shortage trends over time.
-- ====================================================================

---

-- 1. Companies with the Highest Number of Drug Shortage Cases
-- Business Question:
-- Which manufacturers appear most frequently in drug shortage records?

---

SELECT
company_name,
COUNT(*) AS shortage_count
FROM drug_shortages_clean
GROUP BY company_name
ORDER BY shortage_count DESC;

---

-- 2. Manufacturer Concentration Analysis
-- Business Question:
-- How concentrated are drug shortages among the largest manufacturers?

---

WITH company_counts AS (
SELECT
company_name,
COUNT(*) AS total_cases
FROM drug_shortages_clean
GROUP BY company_name
),
top_5_sum AS (
SELECT
SUM(total_cases) AS top_5_total
FROM (
SELECT total_cases
FROM company_counts
ORDER BY total_cases DESC
LIMIT 5
) AS sub
)

SELECT
top_5_total,
ROUND(
(top_5_total * 100.0) /
(SELECT COUNT(*) FROM drug_shortages_clean),
2
) AS top_5_percentage
FROM top_5_sum;

---

-- 3. Distribution of Drug Shortage Reasons
-- Business Question:
-- What are the most common causes of drug shortages?

---

SELECT
shortage_reason,
COUNT(*) AS shortage_count
FROM drug_shortages_clean
GROUP BY shortage_reason
ORDER BY shortage_count DESC;

---

-- 4. Drug Shortage Trend by Year
-- Business Question:
-- How has the number of drug shortages changed over time?

---

SELECT
EXTRACT(YEAR FROM initial_posting_date) AS shortage_year,
COUNT(*) AS shortage_count
FROM drug_shortages_clean
GROUP BY shortage_year
ORDER BY shortage_year ASC;

---

-- 5. Company Analysis During Peak Shortage Years
-- Business Question:
-- Which manufacturers contributed most to shortages
-- during major shortage years?

---

SELECT
company_name,
shortage_year,
COUNT(*) AS shortage_count
FROM (
SELECT
company_name,
EXTRACT(YEAR FROM initial_posting_date) AS shortage_year
FROM drug_shortages_clean
) AS sub
WHERE shortage_year IN (2023, 2025)
GROUP BY
company_name,
shortage_year
ORDER BY shortage_count DESC;
