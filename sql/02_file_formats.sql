-- =========================================================
-- File Formats
-- =========================================================


-- ---------------------------------------------------------
-- CSV
-- ---------------------------------------------------------

CREATE OR REPLACE FILE FORMAT SNOWFLAKE_DE_LAB.RAW.CSV_FORMAT
    TYPE = CSV
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('NULL', 'null', '');


-- ---------------------------------------------------------
-- JSON
-- ---------------------------------------------------------

CREATE OR REPLACE FILE FORMAT SNOWFLAKE_DE_LAB.RAW.JSON_FORMAT
    TYPE = JSON
    STRIP_OUTER_ARRAY = TRUE;


-- ---------------------------------------------------------
-- Parquet
-- ---------------------------------------------------------

CREATE OR REPLACE FILE FORMAT SNOWFLAKE_DE_LAB.RAW.PARQUET_FORMAT
    TYPE = PARQUET;