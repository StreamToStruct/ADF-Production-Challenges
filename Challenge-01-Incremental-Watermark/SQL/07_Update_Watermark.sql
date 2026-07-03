UPDATE Pipeline_Metadata
SET
    LastWatermarkValue = (
        SELECT MAX(Last_Modified)
        FROM Customers
    ),
    LastRunStatus = 'SUCCESS'
WHERE TableName = 'Customers';
