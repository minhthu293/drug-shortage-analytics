-- ====================================================================
-- PROJECT: DRUG SHORTAGE ANALYTICS
-- FILE: 01_data_cleaning.sql
-- PURPOSE:
-- Prepare raw FDA drug shortage data for analysis by:
-- - Converting data types
-- - Standardizing categorical values
-- - Handling missing values
-- - Improving overall data quality
-- ====================================================================


-- --------------------------------------------------------------------
-- STEP 1: Create a Working Table
-- Preserve the original dataset and perform all transformations
-- on a separate analysis table.
-- --------------------------------------------------------------------

CREATE TABLE drug_shortages_clean AS
SELECT *
FROM drug_shortages;


-- --------------------------------------------------------------------
-- STEP 2: Convert initial_posting_date
-- TEXT -> DATE
-- Source format: MM/DD/YYYY
-- --------------------------------------------------------------------

ALTER TABLE drug_shortages_clean
ALTER COLUMN initial_posting_date TYPE DATE
USING TO_DATE(initial_posting_date, 'MM/DD/YYYY');


-- --------------------------------------------------------------------
-- STEP 3: Convert update_date
-- TEXT -> DATE
-- Source format: MM/DD/YYYY
-- --------------------------------------------------------------------

ALTER TABLE drug_shortages_clean
ALTER COLUMN update_date TYPE DATE
USING TO_DATE(update_date, 'MM/DD/YYYY');


-- --------------------------------------------------------------------
-- STEP 4: Convert discontinued_date
-- TEXT -> DATE
-- Empty strings are converted to NULL before type conversion.
-- --------------------------------------------------------------------

ALTER TABLE drug_shortages_clean
ALTER COLUMN discontinued_date TYPE DATE
USING CASE
    WHEN discontinued_date = '' THEN NULL
    ELSE TO_DATE(discontinued_date, 'MM/DD/YYYY')
END;


-- --------------------------------------------------------------------
-- STEP 5: Standardize Status Values
-- Convert free-text status values into a controlled category.
-- --------------------------------------------------------------------

CREATE TYPE drug_status_enum AS ENUM (
    'Current',
    'To Be Discontinued',
    'Resolved'
);

ALTER TABLE drug_shortages_clean
ALTER COLUMN status TYPE drug_status_enum
USING status::drug_status_enum;


-- --------------------------------------------------------------------
-- STEP 6: Standardize Availability Values
-- Fix spelling issues, handle missing values,
-- then convert to ENUM.
-- --------------------------------------------------------------------

-- Correct data-entry inconsistencies

UPDATE drug_shortages_clean
SET availability = 'Available'
WHERE availability = 'Avaliable';

UPDATE drug_shortages_clean
SET availability = 'Unavailable'
WHERE availability = 'Unavailabld';


-- Convert empty strings to NULL

UPDATE drug_shortages_clean
SET availability = NULL
WHERE availability = '';


-- Create controlled category

CREATE TYPE drug_availability_enum AS ENUM (
    'Available',
    'Unavailable',
    'Limited Availability'
);

ALTER TABLE drug_shortages_clean
ALTER COLUMN availability TYPE drug_availability_enum
USING availability::drug_availability_enum;


-- --------------------------------------------------------------------
-- STEP 7: Clean shortage_reason
-- Convert empty strings to NULL.
-- --------------------------------------------------------------------

UPDATE drug_shortages_clean
SET shortage_reason = NULL
WHERE shortage_reason = '';


-- --------------------------------------------------------------------
-- STEP 8: Clean therapeutic_category
-- '[List]' was identified as an extraction artifact
-- from the source dataset and is replaced with NULL.
-- --------------------------------------------------------------------

UPDATE drug_shortages_clean
SET therapeutic_category = NULL
WHERE therapeutic_category = '[List]';


-- --------------------------------------------------------------------
-- STEP 9: Clean dosage_form
-- Convert empty strings to NULL.
-- --------------------------------------------------------------------

UPDATE drug_shortages_clean
SET dosage_form = NULL
WHERE dosage_form = '';