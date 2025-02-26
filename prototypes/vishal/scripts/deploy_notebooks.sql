/*-----------------------------------------------------------------------------
Hands-On : Assignment 3-B of the DAMG7245 course, 
Script:       deploy_notebooks.sql
Author:       Vishal prasanna
Last Updated: 2/25/2025
-----------------------------------------------------------------------------*/

-- See https://docs.snowflake.com/en/LIMITEDACCESS/execute-immediate-from-template

-- Create the Notebooks
--USE SCHEMA {{env}}_SCHEMA;

CREATE OR REPLACE NOTEBOOK IDENTIFIER('"CRYPTO_DB"."{{env}}_SCHEMA"."{{env}}_06_load_excel_files"')
    FROM '@"CRYPTO_DB"."INTEGRATIONS"."CRYPTO_GIT_REPO"/branches/"{{branch}}"/prototypes/vishal/notebooks/01.Yahoo_Finance_API/'
    QUERY_WAREHOUSE = 'CRYPTO_WH'
    MAIN_FILE = '01.Yahoo_Finance_API.ipynb';

ALTER NOTEBOOK "CRYPTO_DB"."{{env}}_SCHEMA"."{{env}}_01.Yahoo_Finance_API" ADD LIVE VERSION FROM LAST;



