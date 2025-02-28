# Cryptocurrency Data Pipeline with Snowflake and Snowpark

This repository contains a comprehensive data pipeline for ingesting, processing, and analyzing cryptocurrency price data using Snowflake and Snowpark Python. The pipeline pulls data from Yahoo Finance and CoinGecko APIs, processes it through a multi-stage architecture, and provides analytics and visualizations.


### ➡️ For overview, prerequisites, and to learn more, complete this end-to-end tutorial [Data Engineering with Notebooks](https://quickstarts.snowflake.com/guide/data_engineering_with_notebooks/index.html?index=..%2F..index#0) on quickstarts.snowflake.com.

## Project Overview

The cryptocurrency data pipeline is structured to handle data through three main layers:
1. **Raw Layer**: Data ingestion from Yahoo Finance and CoinGecko
2. **Harmonized Layer**: Data standardization and transformation
3. **Analytics Layer**: Metrics calculation and insights generation

The pipeline focuses on Bitcoin, Ethereum, and Dogecoin with data from January 2020 to the present.

## Architecture

![Architecture Diagram](assets/architecture.png)

The data pipeline consists of the following components:

1. **Data Sources**:
   - Yahoo Finance API for cryptocurrency price data

2. **Staging Area**:
   - AWS S3 bucket for intermediate storage of CSV files
   - Organized with prefixes for different data sources

3. **Snowflake Components**:
   - **RAW_CRYPTO Schema**: Initial data landing zone
   - **HARMONIZED_CRYPTO Schema**: Standardized and cleansed data
   - **ANALYTICS_CRYPTO Schema**: Pre-computed metrics and derived data
   - **Streams**: For change data capture and incremental processing
   - **Tasks**: For orchestrating the pipeline execution
   - **UDFs**: Custom functions for volatility calculation and price normalization

4. **Analytics Tools**:
   - Jupyter notebooks for data analysis and visualization
   - Snowflake worksheets for SQL-based exploration

## Repository Structure
```
crypto_data_pipeline/
├── prototypes/vishal/                # Prototype directory
│   ├── notebooks/                    # Jupyter notebooks for each pipeline step
│   │   ├── 01.Yahoo_Finance_API/     # Data fetching from Yahoo Finance
│   │   │   ├── 01.Yahoo_Finance_API.ipynb
│   │   │   └── environment.yml
│   │   ├── 02.Load_raw_data_from_csv_files/  # Loading data to Snowflake
│   │   │   ├── 02.Load_raw_data_from_csv_files.ipynb
│   │   │   └── environment.yml
│   │   ├── 03.Data_Harmonization/    # Data standardization
│   │   │   ├── 03.Data_Harmonization.ipynb
│   │   │   └── environment.yml
│   │   ├── 04.Data_Aggregation_&_Analytics/  # Analytics generation
│   │   │   └── 04.Data_Aggregation_&_Analytics.ipynb
│   │   └── 05.Task_Orchestration_&_Automation/  # Pipeline automation
│   │       └── 05_Task_Orchestration_&_Automation.ipynb
│   ├── scripts/                     # SQL and Python scripts for pipeline components
│   │   ├── create_tables.sql        # SQL script to create tables
│   │   ├── deploy_notebooks.sql     # SQL script to deploy notebooks
│   │   ├── deploy_task_dag.py       # Python script for task orchestration
│   │   ├── setup.sql                # Setup script for environment
│   │   └── teardown.sql             # Cleanup script
│   └── 00_start_here.ipynb          # Entry point notebook
├── scripts/                         # Main scripts for deployment
│   ├── deploy_notebooks.sql         # SQL script to deploy notebooks
│   ├── deploy_task_dag.py           # Python script for task orchestration
│   ├── setup.sql                    # Setup script for environment
│   └── teardown.sql                 # Cleanup script
├── .gitignore                       # Git ignore file
├── LICENSE                          # License information
├── README.md                        # Project documentation
└── requirements.txt                 # Python dependencies

```

## Features

- **Yahoo Finance Data Integration**: Pulls cryptocurrency price data from Yahoo Finance
- **Incremental Processing**: Only processes new data since the last run
- **Advanced Analytics**: Calculates returns, volatility, and correlations
- **Automated Pipeline**: Scheduled tasks for daily data refreshes
- **Visualization**: Jupyter notebooks for data analysis and visualization
- **S3 Integration**: Uses S3 as a staging area for data
- **Error Handling**: Robust error handling and logging
- **Environment Flexibility**: Configurable for DEV and PROD environments

## Getting Started

### Prerequisites

- Python 3.8 or later
- Snowflake account with ACCOUNTADMIN privileges
- AWS account with S3 access
- Access to Yahoo Finance API

### Installation

1. Fork this repository:
   

2. Set up a virtual environment:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

4. Start with the main entry point notebook:
   ```
   jupyter notebook prototypes/vishal/00_start_here.ipynb
   ```

### Setting up Snowflake Environment

1. Run the setup script to create the necessary Snowflake objects:
   ```
   snowsql -f scripts/setup.sql
   ```

### Pipeline Execution

Follow the step-by-step notebooks in the `prototypes/vishal/notebooks` directory:

1. **Data Ingestion** - `01.Yahoo_Finance_API.ipynb`: Fetch cryptocurrency data from Yahoo Finance

2. **Load Raw Data** - `02.Load_raw_data_from_csv_files.ipynb`: Load the CSV data into Snowflake's raw layer

3. **Data Harmonization** - `03.Data_Harmonization.ipynb`: Standardize and cleanse the raw data

4. **Analytics Generation** - `04.Data_Aggregation_&_Analytics.ipynb`: Generate metrics and insights

5. **Task Automation** - `05.Task_Orchestration_&_Automation.ipynb`: Set up automated pipeline execution

### Deployment

To deploy the pipeline to production:

1. Deploy Snowflake objects:
   ```
   snowsql -f scripts/create_tables.sql
   ```

2. Deploy notebook tasks:
   ```
   snowsql -f scripts/deploy_notebooks.sql
   ```

3. Set up the task DAG:
   ```
   python scripts/deploy_task_dag.py
   ```

## Key Components

### 1. Data Ingestion
The data ingestion process fetches cryptocurrency data from Yahoo Finance API, transforms it into CSV format, and prepares it for loading into Snowflake.

### 2. Raw Data Loading
The raw data loader takes CSV files containing cryptocurrency price data and loads them into Snowflake's raw layer, preparing them for further processing.

### 3. Data Harmonization
The harmonization layer standardizes data, handles duplicates, and ensures data consistency and quality across all cryptocurrency sources.

### 4. Analytics Layer
The analytics layer calculates key metrics for cryptocurrency analysis:
- Daily, weekly, and monthly returns
- Price volatility metrics
- Moving averages and trends
- Correlations between cryptocurrencies

### 5. Task Orchestration
The pipeline is automated using Snowflake tasks with dependencies:
- Tasks schedule data refreshes
- Streams track changes for incremental processing
- Error handling mechanisms ensure pipeline reliability

### Running the Pipeline

1. Execute data transformations using Snowpark:
   ```
   python snowpark/transformations/harmonize_crypto_data.py
   python snowpark/transformations/create_analytics.py
   ```

2. Set up Snowflake tasks for automation (via SQL scripts)

3. Monitor the pipeline execution through Snowflake's UI

## Key Components

### 1. Data Ingestion

The data ingestion process fetches cryptocurrency data from Yahoo Finance APIs, standardizes it, and uploads it to S3 and Snowflake's raw layer.

### 2. Data Harmonization

The harmonization layer standardizes data from different sources, handles duplicates, and ensures data consistency and quality.

### 3. Analytics Layer

The analytics layer calculates key metrics for cryptocurrency analysis:
- Daily, weekly, and monthly returns
- Price volatility metrics
- Moving averages and trends
- Correlations between cryptocurrencies

### 4. Automation

The pipeline is automated using Snowflake tasks and streams:
- Tasks schedule data refreshes
- Streams track changes for incremental processing
- Error handling mechanisms ensure pipeline reliability

## Analytics Examples

The repository includes Jupyter notebooks that demonstrate various cryptocurrency analyses:

1. **Price Trend Analysis**:
   - Historical price movements
   - Logarithmic scale visualizations
   - Trend detection

2. **Volatility Analysis**:
   - 10-day  volatility calculations
   - Volatility comparisons across cryptocurrencies
   - Volatility trends over time

4. **Return Analysis**:
   - Daily, weekly, and monthly return calculations
   - Return distribution analysis
   - Risk-adjusted return metrics

## Contributions

This project was developed as part of Assignment 3 for a Data Engineering course. Team contributions:

- **Sai Priya Veerabomma**: 33 1/3% - Data ingestion and S3 integration
- **Sai Srunith Silvery**: 33 1/3% - Snowflake setup and SQL development
- **Vishal Prasanna**: 33 1/3% - Snowpark transformations and analytics

## References

- [Snowflake Documentation](https://docs.snowflake.com/)
- [Snowpark Python API Reference](https://docs.snowflake.com/en/developer-guide/snowpark/reference/python/index.html)
- [Yahoo Finance API Documentation](https://pypi.org/project/yfinance/)
- [CoinGecko API Documentation](https://www.coingecko.com/en/api/documentation)
- [Lab 1: Data Engineering Pipelines with Snowpark Python](https://quickstarts.snowflake.com/guide/data_engineering_pipelines_with_snowpark_python/)
- [Lab 2: Data Engineering with Notebooks](https://quickstarts.snowflake.com/guide/data_engineering_with_notebooks/)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Snowflake for their data cloud platform
- Yahoo Finance and CoinGecko for providing cryptocurrency data
- The course instructors for guidance on this assignment
