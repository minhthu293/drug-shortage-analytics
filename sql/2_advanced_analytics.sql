-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- TASK: ADVANCED ANALYTICS (PHÂN TÍCH NÂNG CAO)
-- ====================================================================

-- 1. Đo lường thời gian khan hiếm (Shortage Duration) theo từng mã sản phẩm cụ thể
-- Sắp xếp giảm dần để tìm ra những sản phẩm bị đứt chuỗi cung ứng kéo dài kỷ lục
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

-- 2. Phân tích hiệu suất vận hành (Operational Performance) của từng công ty
-- Tìm ra số ngày ngâm hàng trung bình của từng doanh nghiệp
SELECT 
    company_name, 
    AVG(update_date - initial_posting_date) AS A
FROM drug_shortages_clean
GROUP BY company_name
ORDER BY A DESC;

-- 3. Phân tích tỷ trọng nguyên nhân cốt lõi (Root Cause Analytics)
-- Loại bỏ dữ liệu nhiễu (NULL, Other) và tính tỷ lệ % đóng góp của từng lý do
SELECT 
    shortage_reason, 
    COUNT(*) AS C, 
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM drug_shortages_clean
WHERE shortage_reason IS NOT NULL 
  AND shortage_reason <> 'Other'
GROUP BY shortage_reason
ORDER BY C DESC;