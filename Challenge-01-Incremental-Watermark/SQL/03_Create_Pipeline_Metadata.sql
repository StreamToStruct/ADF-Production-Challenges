CREATE TABLE Pipeline_Metadata
(
    TableName VARCHAR(100) PRIMARY KEY,
    WatermarkColumn VARCHAR(100) NOT NULL,
    LastWatermarkValue DATETIME2 NOT NULL,
    LastRunStatus VARCHAR(20) NOT NULL
);

INSERT INTO Pipeline_Metadata
(
    TableName,
    WatermarkColumn,
    LastWatermarkValue,
    LastRunStatus
)
VALUES
(
    'Customers',
    'Last_Modified',
    '1900-01-01',
    'SUCCESS'
);
