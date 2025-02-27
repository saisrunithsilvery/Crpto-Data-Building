/*-----------------------------------------------------------------------------
Hands-On : Assignment 3-B of the DAMG7245 course, 
Script:       deploy_notebooks.sql
Author:       Vishal prasanna
Last Updated: 2/25/2025
-----------------------------------------------------------------------------*/

-- Create the Yahoo Finance API Notebook
CREATE OR REPLACE NOTEBOOK IDENTIFIER('"CRYPTO_DB"."{{env}}_SCHEMA"."{{env}}_Yahoo_Finance_API"')
    FROM '@"CRYPTO_DB"."INTEGRATIONS"."CRYPTO_GIT_REPO"/branches/"{{branch}}"/prototypes/vishal/notebooks/01.Yahoo_Finance_API/'
    QUERY_WAREHOUSE = 'CRYPTO_WH'
    MAIN_FILE = '01.Yahoo_Finance_API.ipynb';

-- Add a live version
ALTER NOTEBOOK "CRYPTO_DB"."{{env}}_SCHEMA"."{{env}}_Yahoo_Finance_API" ADD LIVE VERSION FROM LAST;