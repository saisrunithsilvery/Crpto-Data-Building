/*-----------------------------------------------------------------------------
Hands-On : Assignment 3-B of the DAMG7245 course, 
Script:       teardown.sql
Author:       Vishal prasanna
Last Updated: 2/25/2025
-----------------------------------------------------------------------------*/


USE ROLE ACCOUNTADMIN;

DROP API INTEGRATION CRYPTO_GITHUB_API_INTEGRATION;
DROP DATABASE CRYPTO_DB;
DROP WAREHOUSE CRYPTO_WH;
DROP ROLE CRYPTO_ROLE;

-- Drop the weather share
-- DROP DATABASE FROSTBYTE_WEATHERSOURCE;

-- Remove the "dev" branch in your repo