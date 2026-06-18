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


-- Bước 5: Chuẩn hóa cột status từ TEXT sang ENUM (Kiểu dữ liệu tự định nghĩa)
-- (Dữ liệu gốc có 3 trạng thái sạch: Current, To Be Discontinued, Resolved)
CREATE TYPE drug_status_enum AS ENUM ('Current', 'To Be Discontinued', 'Resolved');

ALTER TABLE drug_shortages_clean
ALTER COLUMN status TYPE drug_status_enum
USING status::drug_status_enum;