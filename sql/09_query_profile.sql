-- =========================================================
-- Query Profile / Query History Demo
-- =========================================================


-- ---------------------------------------------------------
-- 1. Run a query worth inspecting
-- ---------------------------------------------------------

SELECT
    CUSTOMER_ID,
    SUM(AMOUNT) AS TOTAL_AMOUNT
FROM SNOWFLAKE_DE_LAB.RAW.TRANSACTIONS_CSV
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_AMOUNT DESC;


-- ---------------------------------------------------------
-- 2. Review recent query history
-- ---------------------------------------------------------

SELECT
    QUERY_ID,
    QUERY_TEXT,
    START_TIME,
    TOTAL_ELAPSED_TIME,
    BYTES_SCANNED,
    ROWS_PRODUCED,
    WAREHOUSE_NAME,
    EXECUTION_STATUS
FROM TABLE(
    SNOWFLAKE_DE_LAB.INFORMATION_SCHEMA.QUERY_HISTORY_BY_SESSION(
        RESULT_LIMIT => 20
    )
)
ORDER BY START_TIME DESC;