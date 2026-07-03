MERGE INTO Customers AS c
USING Temp_Customers AS t
ON c.CustomerID = t.CustomerID

WHEN MATCHED
AND (
    ISNULL(c.CustomerName, '') <> ISNULL(t.CustomerName, '')
    OR ISNULL(c.City, '') <> ISNULL(t.City, '')
)
THEN
UPDATE SET
    c.CustomerName = t.CustomerName,
    c.City = t.City,
    c.Last_Modified = SYSDATETIME()

WHEN NOT MATCHED BY TARGET
THEN
INSERT
(
    CustomerID,
    CustomerName,
    City,
    Last_Modified
)
VALUES
(
    t.CustomerID,
    t.CustomerName,
    t.City,
    SYSDATETIME()
);
