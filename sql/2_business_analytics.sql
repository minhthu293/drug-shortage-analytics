-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- TASK: ADVANCED ANALYTICS
-- ====================================================================

-- 1. Longest Drug Shortages
-- Measure shortage duration for each product and identify the longest-lasting shortages
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

-- 2. Company Shortage Duration Analysis
-- Calculate average shortage duration by manufacturer
SELECT 
    company_name,
    AVG(update_date - initial_posting_date) AS avg_shortage_days
FROM drug_shortages_clean
GROUP BY company_name
ORDER BY avg_shortage_days DESC;

-- 3. Root Cause Analysis
-- Calculate the percentage contribution of each shortage reason
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
  AND shortage_reason <> 'Other'
GROUP BY shortage_reason
ORDER BY shortage_count DESC;

-- 4. Dosage Form Impact Analysis
-- Identify dosage forms most frequently affected by drug shortages
SELECT 
    dosage_form,
    COUNT(*) AS shortage_count
FROM drug_shortages_clean
WHERE dosage_form IS NOT NULL
  AND shortage_reason <> 'Other'
GROUP BY dosage_form
ORDER BY shortage_count DESC;

-- 5. Monthly Drug Shortage Trend
-- Aggregate shortage cases by month for time-series analysis and dashboard visualization
SELECT 
    TO_CHAR(initial_posting_date, 'YYYY-MM') AS shortage_month,
    COUNT(*) AS shortage_count
FROM drug_shortages_clean
WHERE initial_posting_date IS NOT NULL
GROUP BY shortage_month
ORDER BY shortage_month ASC;