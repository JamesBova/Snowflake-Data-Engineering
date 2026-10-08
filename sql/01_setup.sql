-- =========================================================
-- Snowflake Data Engineering Lab Setup
-- Run initially with an administrative role.
-- =========================================================


-- ---------------------------------------------------------
-- 1. Role
-- ---------------------------------------------------------

CREATE ROLE IF NOT EXISTS SNOWFLAKE_DE_ROLE;


-- ---------------------------------------------------------
-- 2. Warehouse
-- ---------------------------------------------------------

CREATE WAREHOUSE IF NOT EXISTS SNOWFLAKE_DE_WH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;


-- ---------------------------------------------------------
-- 3. Database and schemas
-- ---------------------------------------------------------

CREATE DATABASE IF NOT EXISTS SNOWFLAKE_DE_LAB;

CREATE SCHEMA IF NOT EXISTS SNOWFLAKE_DE_LAB.RAW;
CREATE SCHEMA IF NOT EXISTS SNOWFLAKE_DE_LAB.STAGING;
CREATE SCHEMA IF NOT EXISTS SNOWFLAKE_DE_LAB.ANALYTICS;


-- ---------------------------------------------------------
-- 4. Warehouse permissions
-- ---------------------------------------------------------

GRANT USAGE
ON WAREHOUSE SNOWFLAKE_DE_WH
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT MODIFY
ON WAREHOUSE SNOWFLAKE_DE_WH
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT OPERATE
ON WAREHOUSE SNOWFLAKE_DE_WH
TO ROLE SNOWFLAKE_DE_ROLE;


-- ---------------------------------------------------------
-- 5. Database permission
-- ---------------------------------------------------------

GRANT USAGE
ON DATABASE SNOWFLAKE_DE_LAB
TO ROLE SNOWFLAKE_DE_ROLE;


-- ---------------------------------------------------------
-- 6. Schema permissions
-- ---------------------------------------------------------

GRANT USAGE
ON SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT USAGE
ON SCHEMA SNOWFLAKE_DE_LAB.STAGING
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT USAGE
ON SCHEMA SNOWFLAKE_DE_LAB.ANALYTICS
TO ROLE SNOWFLAKE_DE_ROLE;


-- ---------------------------------------------------------
-- 7. RAW object creation
-- ---------------------------------------------------------

GRANT CREATE TABLE
ON SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE STAGE
ON SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE FILE FORMAT
ON SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE STREAM
ON SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE PIPE
ON SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;


-- ---------------------------------------------------------
-- 8. STAGING object creation
-- ---------------------------------------------------------

GRANT CREATE TABLE
ON SCHEMA SNOWFLAKE_DE_LAB.STAGING
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE VIEW
ON SCHEMA SNOWFLAKE_DE_LAB.STAGING
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE STREAM
ON SCHEMA SNOWFLAKE_DE_LAB.STAGING
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE TASK
ON SCHEMA SNOWFLAKE_DE_LAB.STAGING
TO ROLE SNOWFLAKE_DE_ROLE;


-- ---------------------------------------------------------
-- 9. ANALYTICS object creation
-- ---------------------------------------------------------

GRANT CREATE TABLE
ON SCHEMA SNOWFLAKE_DE_LAB.ANALYTICS
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE VIEW
ON SCHEMA SNOWFLAKE_DE_LAB.ANALYTICS
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT CREATE DYNAMIC TABLE
ON SCHEMA SNOWFLAKE_DE_LAB.ANALYTICS
TO ROLE SNOWFLAKE_DE_ROLE;


-- ---------------------------------------------------------
-- 10. Service user
-- ---------------------------------------------------------

CREATE USER IF NOT EXISTS SNOWFLAKE_DE_SVC
    DEFAULT_ROLE = SNOWFLAKE_DE_ROLE
    DEFAULT_WAREHOUSE = SNOWFLAKE_DE_WH
    DEFAULT_NAMESPACE = SNOWFLAKE_DE_LAB.RAW
    MUST_CHANGE_PASSWORD = FALSE;

GRANT ROLE SNOWFLAKE_DE_ROLE
TO USER SNOWFLAKE_DE_SVC;


-- ---------------------------------------------------------
-- 11. RSA key setup
-- ---------------------------------------------------------

-- Run separately using the public key generated for this project:
--
-- ALTER USER SNOWFLAKE_DE_SVC
-- SET RSA_PUBLIC_KEY = '<PUBLIC_KEY>';


-- ---------------------------------------------------------
-- 12. Future grants
-- ---------------------------------------------------------

GRANT SELECT, INSERT, UPDATE, DELETE
ON FUTURE TABLES
IN SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE
ON FUTURE TABLES
IN SCHEMA SNOWFLAKE_DE_LAB.STAGING
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT SELECT
ON FUTURE TABLES
IN SCHEMA SNOWFLAKE_DE_LAB.ANALYTICS
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT SELECT
ON FUTURE VIEWS
IN SCHEMA SNOWFLAKE_DE_LAB.STAGING
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT SELECT
ON FUTURE VIEWS
IN SCHEMA SNOWFLAKE_DE_LAB.ANALYTICS
TO ROLE SNOWFLAKE_DE_ROLE;

GRANT SELECT
ON FUTURE VIEWS
IN SCHEMA SNOWFLAKE_DE_LAB.RAW
TO ROLE SNOWFLAKE_DE_ROLE;