-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- FILE: 03_advanced_analysis.sql
-- PURPOSE:
-- Perform advanced analytical investigations on drug shortage events.
-- Focus on shortage duration, root causes, dosage form impact,
-- and time-series trends.
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
ORDER BY shortage_days DESC;

---

-- 2. Company Shortage Duration Analysis
-- Business Question:
-- Which manufacturers have the longest average shortage duration?

---

SELECT
company_name,
AVG(update_date - initial_posting_date) AS avg_shortage_days
FROM drug_shortages_clean
GROUP BY company_name
ORDER BY avg_shortage_days DESC;

---

-- 3. Root Cause Analysis
-- Business Question:
-- What percentage of shortages is attributed to each root cause?

---

SELECT
shortage_reason,
COUNT(*) AS shortage_count,
ROUND(
(COUNT(*) * 100.0) /
SUM(COUNT(*)) OVER (),
2
) AS percentage
FROM drug_shortages_clean
WHERE shortage_reason IS NOT NULL
GROUP BY shortage_reason
ORDER BY shortage_count DESC;

---

-- 4. Dosage Form Impact Analysis
-- Business Question:
-- Which dosage forms are most frequently affected by shortages?

---

SELECT
dosage_form,
COUNT(*) AS shortage_count
FROM drug_shortages_clean
WHERE dosage_form IS NOT NULL
GROUP BY dosage_form
ORDER BY shortage_count DESC;

---

-- 5. Monthly Drug Shortage Trend
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
 
