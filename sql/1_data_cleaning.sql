-- Bước 1: Tạo bảng làm việc độc lập để bảo toàn dữ liệu gốc
CREATE TABLE drug_shortages_clean AS
SELECT * FROM drug_shortages;

-- Bước 2: Chuẩn hóa cột initial_posting_date từ TEXT sang DATE
ALTER TABLE drug_shortages_clean 
ALTER COLUMN initial_posting_date TYPE DATE 
USING TO_DATE(initial_posting_date, 'MM/DD/YYYY');