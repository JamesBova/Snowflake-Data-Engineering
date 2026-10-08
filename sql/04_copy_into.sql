-- =========================================================
-- COPY INTO Examples
-- CSV, JSON, and Parquet
-- =========================================================


-- ---------------------------------------------------------
-- 1. CSV
-- Direct load into relational columns
-- ---------------------------------------------------------

CREATE OR REPLACE TABLE SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_CSV (
    RECORD_ID NUMBER,
    CUSTOMER_ID NUMBER,
    TRANSACTION_DATE DATE,
    AMOUNT NUMBER(10,2),
    TRANSACTION_TYPE VARCHAR
);

COPY INTO SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_CSV
FROM @SNOWFLAKE_DE_LAB.RAW.CSV_STAGE
FILE_FORMAT = (
    FORMAT_NAME = SNOWFLAKE_DE_LAB.RAW.CSV_FORMAT
);


-- ---------------------------------------------------------
-- 2. JSON
-- Load each JSON object into a VARIANT column
-- ---------------------------------------------------------

CREATE OR REPLACE TABLE SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_JSON (
    PAYLOAD VARIANT
);

COPY INTO SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_JSON
FROM @SNOWFLAKE_DE_LAB.RAW.JSON_STAGE
FILE_FORMAT = (
    FORMAT_NAME = SNOWFLAKE_DE_LAB.RAW.JSON_FORMAT
);


-- ---------------------------------------------------------
-- 3. Parquet
-- Project Parquet fields into relational columns
-- ---------------------------------------------------------

CREATE OR REPLACE TABLE SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_PARQUET (
    RECORD_ID NUMBER,
    CUSTOMER_ID NUMBER,
    TRANSACTION_DATE DATE,
    AMOUNT NUMBER(10,2),
    TRANSACTION_TYPE VARCHAR
);

COPY INTO SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_PARQUET
FROM (
    SELECT
        $1:record_id::NUMBER,
        $1:customer_id::NUMBER,
        $1:transaction_date::DATE,
        $1:amount::NUMBER(10,2),
        $1:transaction_type::VARCHAR
    FROM @SNOWFLAKE_DE_LAB.RAW.PARQUET_STAGE
)
FILE_FORMAT = (
    FORMAT_NAME = SNOWFLAKE_DE_LAB.RAW.PARQUET_FORMAT
);


-- ---------------------------------------------------------
-- 4. Verify row counts
-- ---------------------------------------------------------

SELECT COUNT(*) AS CSV_ROWS
FROM SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_CSV;

SELECT COUNT(*) AS JSON_ROWS
FROM SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_JSON;

SELECT COUNT(*) AS PARQUET_ROWS
FROM SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_PARQUET;