-- Create Bitcoin (BTC) table
CREATE TABLE IF NOT EXISTS BTC (
    timestamp TIMESTAMP_NTZ,
    price FLOAT,
    volume FLOAT,
    market_cap FLOAT,
    high_24h FLOAT,
    low_24h FLOAT,
    price_change_24h FLOAT,
    price_change_percentage_24h FLOAT,
    last_updated TIMESTAMP_NTZ,
    PRIMARY KEY (timestamp)
);

-- Create Dogecoin (DOGE) table
-- Note: The table name is corrected from "Dodge" to "DOGE" as that's the standard ticker
CREATE TABLE IF NOT EXISTS DOGE (
    timestamp TIMESTAMP_NTZ,
    price FLOAT,
    volume FLOAT,
    market_cap FLOAT,
    high_24h FLOAT,
    low_24h FLOAT,
    price_change_24h FLOAT,
    price_change_percentage_24h FLOAT,
    last_updated TIMESTAMP_NTZ,
    PRIMARY KEY (timestamp)
);

-- Create Ethereum (ETH) table
CREATE TABLE IF NOT EXISTS ETH (
    timestamp TIMESTAMP_NTZ,
    price FLOAT,
    volume FLOAT,
    market_cap FLOAT,
    high_24h FLOAT,
    low_24h FLOAT,
    price_change_24h FLOAT,
    price_change_percentage_24h FLOAT,
    last_updated TIMESTAMP_NTZ,
    PRIMARY KEY (timestamp)
);