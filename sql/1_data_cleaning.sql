-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- TASK: DATA CLEANING (LÀM SẠCH DỮ LIỆU)
-- ====================================================================

-- Bước 1: Tạo bảng làm việc độc lập để bảo toàn dữ liệu gốc
CREATE TABLE drug_shortages_clean AS
SELECT * FROM drug_shortages;


-- Bước 2: Chuẩn hóa cột initial_posting_date từ TEXT sang DATE
-- (Định dạng gốc: MM/DD/YYYY, không có dữ liệu trống)
ALTER TABLE drug_shortages_clean 
ALTER COLUMN initial_posting_date TYPE DATE 
USING TO_DATE(initial_posting_date, 'MM/DD/YYYY');


-- Bước 3: Chuẩn hóa cột update_date từ TEXT sang DATE
-- (Định dạng gốc: MM/DD/YYYY, đã kiểm tra không có dữ liệu trống)
ALTER TABLE drug_shortages_clean
ALTER COLUMN update_date TYPE DATE
USING TO_DATE(update_date, 'MM/DD/YYYY');


-- Bước 4: Chuẩn hóa cột discontinued_date từ TEXT sang DATE
-- (Định dạng gốc: MM/DD/YYYY, chứa 1,176 dòng trống cần chuyển thành NULL)
ALTER TABLE drug_shortages_clean
ALTER COLUMN discontinued_date TYPE DATE
USING CASE 
    WHEN discontinued_date = '' THEN NULL
    ELSE TO_DATE(discontinued_date, 'MM/DD/YYYY') 
END;


-- Bước 5: Chuẩn hóa cột status từ TEXT sang ENUM
-- (Dữ liệu gốc có 3 trạng thái sạch: Current, To Be Discontinued, Resolved)
CREATE TYPE drug_status_enum AS ENUM ('Current', 'To Be Discontinued', 'Resolved');

ALTER TABLE drug_shortages_clean
ALTER COLUMN status TYPE drug_status_enum
USING status::drug_status_enum;


-- Bước 6: Làm sạch và chuẩn hóa cột availability từ TEXT sang ENUM
-- 6.1 Sửa lỗi chính tả do nhập liệu thủ công (Data Update)
UPDATE drug_shortages_clean SET availability = 'Available' WHERE availability = 'Avaliable';
UPDATE drug_shortages_clean SET availability = 'Unavailable' WHERE availability = 'Unavailabld';

-- 6.2 Chuyển các chuỗi rỗng thành NULL hệ thống
UPDATE drug_shortages_clean SET availability = NULL WHERE availability = '';

-- 6.3 Khởi tạo ENUM và ép kiểu cấu trúc cột (Alter Structure)
CREATE TYPE drug_availability_enum AS ENUM ('Available', 'Unavailable', 'Limited Availability');

ALTER TABLE drug_shortages_clean
ALTER COLUMN availability TYPE drug_availability_enum
USING availability::drug_availability_enum;


-- Bước 7: Làm sạch cột shortage_reason
-- (Chuyển các chuỗi rỗng thành NULL hệ thống để chuẩn hóa dữ liệu)
UPDATE drug_shortages_clean
SET shortage_reason = NULL
WHERE shortage_reason = '';


-- Bước 8: Xử lý cột therapeutic_category bị lỗi trích xuất từ nguồn
-- (Chuyển đổi chuỗi vô nghĩa '[List]' thành NULL hệ thống để bảo toàn tính chuẩn hóa)
UPDATE drug_shortages_clean
SET therapeutic_category = NULL
WHERE therapeutic_category = '[List]';


-- Bước 9: Làm sạch cột dosage_form
-- (Chuyển các chuỗi rỗng thành NULL hệ thống để chuẩn hóa dữ liệu dạng bào chế)
UPDATE drug_shortages_clean
SET dosage_form = NULL
WHERE dosage_form = '';


-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- TASK: EXPLORATION & INSIGHT ANALYSIS (KHAI PHÁ DỮ LIỆU)
-- ====================================================================

-- 1. Tìm Top các công ty có số lượng ca khan hiếm lớn nhất hệ thống
SELECT company_name, count(*) AS total_cases
FROM drug_shortages_clean
GROUP BY company_name
ORDER BY total_cases DESC;


-- 2. Kiểm tra lại phân phối nguyên nhân khan hiếm sau khi làm sạch
SELECT shortage_reason, count(*) AS shortage_reason_count
FROM drug_shortages_clean
GROUP BY shortage_reason
ORDER BY shortage_reason_count DESC;


-- 3. Phân tích xu hướng: Tổng số ca khan hiếm thuốc biến động theo từng năm
SELECT EXTRACT (YEAR FROM initial_posting_date) AS shortage_year, count(*) AS total_cases
FROM drug_shortages_clean
GROUP BY shortage_year
ORDER BY shortage_year ASC;


-- 4. Phân tích đa chiều: Các công ty chịu ảnh hưởng lớn nhất trong 2 năm khủng hoảng (2023, 2025)
SELECT company_name, shortage_year, count(*) AS total_cases
FROM (
    SELECT company_name, EXTRACT(YEAR FROM initial_posting_date) AS shortage_year
    FROM drug_shortages_clean
) AS sub
WHERE shortage_year IN (2023, 2025)
GROUP BY company_name, shortage_year
ORDER BY total_cases DESC;