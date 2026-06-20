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
