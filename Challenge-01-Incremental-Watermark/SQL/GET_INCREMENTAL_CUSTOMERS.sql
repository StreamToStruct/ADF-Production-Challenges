SELECT *
FROM Customers
WHERE Last_Modified > @WatermarkValue;
