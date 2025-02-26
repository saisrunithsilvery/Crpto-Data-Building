/*-----------------------------------------------------------------------------
Hands-On : Assignment 3-B of the DAMG7245 course, 
Script:       setup.sql
Author:       Vishal prasanna
Last Updated: 2/25/2025
-----------------------------------------------------------------------------*/

SET MY_USER = CURRENT_USER();
SET GITHUB_SECRET_USERNAME = 'vishalprasanna11';
SET GITHUB_SECRET_PASSWORD = 'personal access token';

-- SET GITHUB_SECRET_PASSWORD = 'personal access token';

SET GITHUB_URL_PREFIX = 'https://github.com/vishalprasanna11';
SET GITHUB_REPO_ORIGIN = 'https://github.com/DAMG7245/Assignment3B.git';


-- ----------------------------------------------------------------------------
-- Create the account level objects (ACCOUNTADMIN part)
-- ----------------------------------------------------------------------------
USE ROLE ACCOUNTADMIN;

-- Roles
CREATE OR REPLACE ROLE CRYPTO_ROLE;
GRANT ROLE CRYPTO_ROLE TO ROLE SYSADMIN;
GRANT ROLE CRYPTO_ROLE TO USER IDENTIFIER($MY_USER);

GRANT CREATE INTEGRATION ON ACCOUNT TO ROLE CRYPTO_ROLE;
GRANT EXECUTE TASK ON ACCOUNT TO ROLE CRYPTO_ROLE;
GRANT EXECUTE MANAGED TASK ON ACCOUNT TO ROLE CRYPTO_ROLE;
GRANT MONITOR EXECUTION ON ACCOUNT TO ROLE CRYPTO_ROLE;
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE CRYPTO_ROLE;

-- Databases
CREATE OR REPLACE DATABASE CRYPTO_DB;
GRANT OWNERSHIP ON DATABASE CRYPTO_DB TO ROLE CRYPTO_ROLE;

-- Warehouses
CREATE OR REPLACE WAREHOUSE CRYPTO_WH WAREHOUSE_SIZE = XSMALL, AUTO_SUSPEND = 300, AUTO_RESUME= TRUE;
GRANT OWNERSHIP ON WAREHOUSE CRYPTO_WH TO ROLE CRYPTO_ROLE;


-- ----------------------------------------------------------------------------
-- Create the database level objects
-- ----------------------------------------------------------------------------
USE ROLE CRYPTO_ROLE;
USE WAREHOUSE CRYPTO_WH;
USE DATABASE CRYPTO_DB;

-- Schemas
CREATE OR REPLACE SCHEMA INTEGRATIONS;
CREATE OR REPLACE SCHEMA DEV_SCHEMA;
CREATE OR REPLACE SCHEMA PROD_SCHEMA;

USE SCHEMA INTEGRATIONS;

-- External Frostbyte objects
CREATE OR REPLACE STAGE CRYPTO_RAW_STAGE
    URL = 's3://damg7245-crypto/raw_data/'
;

-- Secrets (schema level)
CREATE OR REPLACE SECRET CRYPTO_GITHUB_SECRET
  TYPE = password
  USERNAME = $GITHUB_SECRET_USERNAME
  PASSWORD = $GITHUB_SECRET_PASSWORD;

-- API Integration (account level)
-- This depends on the schema level secret!
CREATE OR REPLACE API INTEGRATION CRYPTO_GITHUB_API_INTEGRATION
  API_PROVIDER = GIT_HTTPS_API
  API_ALLOWED_PREFIXES = ($GITHUB_URL_PREFIX)
  ALLOWED_AUTHENTICATION_SECRETS = (CRYPTO_GITHUB_SECRET)
  ENABLED = TRUE;

-- Create the "dev" branch in your repo

-- Git Repository
CREATE OR REPLACE GIT REPOSITORY CRYPTO_GIT_REPO
  API_INTEGRATION = CRYPTO_GITHUB_API_INTEGRATION
  GIT_CREDENTIALS = CRYPTO_GITHUB_SECRET
  ORIGIN = $GITHUB_REPO_ORIGIN;


-- ----------------------------------------------------------------------------
-- Create the event table
-- ----------------------------------------------------------------------------
USE ROLE ACCOUNTADMIN;

CREATE EVENT TABLE CRYPTO_DB.INTEGRATIONS.CRYPTO_EVENTS;
GRANT SELECT ON EVENT TABLE CRYPTO_DB.INTEGRATIONS.CRYPTO_EVENTS TO ROLE CRYPTO_ROLE;
GRANT INSERT ON EVENT TABLE CRYPTO_DB.INTEGRATIONS.CRYPTO_EVENTS TO ROLE CRYPTO_ROLE;

ALTER ACCOUNT SET EVENT_TABLE = CRYPTO_DB.INTEGRATIONS.CRYPTO_EVENTS;
ALTER DATABASE CRYPTO_DB SET LOG_LEVEL = INFO;