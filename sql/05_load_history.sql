-- =========================================================
-- Load History
-- =========================================================


-- ---------------------------------------------------------
-- 1. COPY history for CSV table
-- ---------------------------------------------------------

SELECT *
FROM TABLE(
    SNOWFLAKE_DE_LAB.INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME => 'SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_CSV',
        START_TIME => DATEADD('hour', -24, CURRENT_TIMESTAMP())
    )
)
ORDER BY LAST_LOAD_TIME DESC;


-- ---------------------------------------------------------
-- 2. COPY history for JSON table
-- ---------------------------------------------------------

SELECT *
FROM TABLE(
    SNOWFLAKE_DE_LAB.INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME => 'SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_JSON',
        START_TIME => DATEADD('hour', -24, CURRENT_TIMESTAMP())
    )
)
ORDER BY LAST_LOAD_TIME DESC;


-- ---------------------------------------------------------
-- 3. COPY history for Parquet table
-- ---------------------------------------------------------

SELECT *
FROM TABLE(
    SNOWFLAKE_DE_LAB.INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME => 'SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_PARQUET',
        START_TIME => DATEADD('hour', -24, CURRENT_TIMESTAMP())
    )
)
ORDER BY LAST_LOAD_TIME DESC;