-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- FILE: 03_advanced_analysis.sql
-- PURPOSE:
-- Perform advanced analytical investigations on drug shortage events.
-- Focus on shortage duration, severity, and long-term trends.
-- ====================================================================

---

-- 1. Longest Drug Shortages
-- Business Question:
-- Which products experienced the longest shortage periods?

---

SELECT
company_name,
generic_name,
package_ndc,
presentation,
initial_posting_date,
update_date,
(update_date - initial_posting_date) AS shortage_days
FROM drug_shortages_clean
ORDER BY shortage_days DESC
LIMIT 10;

---

-- 2. Overall Shortage Duration Statistics
-- Business Question:
-- What are the maximum and average shortage durations?

---

SELECT
MAX(update_date - initial_posting_date) AS max_shortage_days,
ROUND(
AVG(update_date - initial_posting_date),
2
) AS avg_shortage_days
FROM drug_shortages_clean;

---

-- 3. Company Duration Analysis
-- Business Question:
-- Which manufacturers experience the longest average shortages?

---

SELECT
company_name,
ROUND(
AVG(update_date - initial_posting_date),
2
) AS avg_shortage_days
FROM drug_shortages_clean
GROUP BY company_name
ORDER BY avg_shortage_days DESC;

---

-- 4. Monthly Drug Shortage Trend
-- Business Question:
-- How do drug shortages fluctuate over time at the monthly level?

---

SELECT
TO_CHAR(initial_posting_date, 'YYYY-MM') AS shortage_month,
COUNT(*) AS shortage_count
FROM drug_shortages_clean
WHERE initial_posting_date IS NOT NULL
GROUP BY shortage_month
ORDER BY shortage_month ASC;
