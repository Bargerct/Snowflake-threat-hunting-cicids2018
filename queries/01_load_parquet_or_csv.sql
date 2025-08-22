-- Stage and load dataset (Parquet example)
-- If your dataset is CSV, adjust FILE_FORMAT TYPE to CSV

-- Create a stage for files
CREATE STAGE IF NOT EXISTS IDS2018_STAGE FILE_FORMAT = (TYPE = PARQUET);

-- Verify files uploaded (upload via Snowflake UI "+ Files" to this stage)
LIST @SECURITY_ANALYTICS.CIC_IDS2018.IDS2018_STAGE;

-- Create table directly from Parquet
CREATE OR REPLACE TABLE RAW_TRAFFIC AS
SELECT *
FROM TABLE(
  READ_PARQUET(
    LOCATION => '@SECURITY_ANALYTICS.CIC_IDS2018.IDS2018_STAGE/Infil1-Wednesday-28-02-2018_TrafficForML_CICFlowMeter.parquet'
  )
);

-- Verify table
DESCRIBE TABLE RAW_TRAFFIC;
SELECT COUNT(*) AS row_count FROM RAW_TRAFFIC;
SELECT DISTINCT "Label" FROM RAW_TRAFFIC ORDER BY 1;
