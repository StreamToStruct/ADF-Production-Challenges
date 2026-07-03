/*
================================================================================
Project        : Challenge 01 - Incremental Customer Load using Watermark
File           : 01_Create_Customers.sql

Author         : Syed Haseena
Created On     : 03-Jul-2026

================================================================================
BUSINESS REQUIREMENT
--------------------------------------------------------------------------------
The organization maintains a master Customers table that stores the latest
customer information.

Every day, new customer records arrive from the source CRM system.

This table acts as the target table where:

• New customers are inserted
• Existing customers are updated
• Azure Data Factory performs incremental loading using Last_Modified

================================================================================
TABLE DESIGN
--------------------------------------------------------------------------------

CustomerID
-----------
Purpose:
    Unique identifier for every customer.

Why PRIMARY KEY?
    • Prevents duplicate customer records.
    • Enables efficient lookups.
    • Required for MERGE operations.

--------------------------------------------------------------------------------

CustomerName
-------------
Purpose:
    Stores customer's full name.

Why NOT NULL?
    Every customer must have a name.

--------------------------------------------------------------------------------

City
-----
Purpose:
    Stores customer's city.

Why NULL?
    Business may not always receive city information.

Example:

CustomerID   CustomerName     City
---------------------------------------
1004         Sneha Nair       NULL

Later the city may be updated to:

1004         Sneha Nair       Kochi

Allowing NULL makes the system flexible.

--------------------------------------------------------------------------------

Last_Modified
--------------
Purpose:
    Stores when the record was last inserted or updated.

Used For:
    • Incremental Loading
    • Watermarking
    • Auditing
    • Change Tracking

================================================================================
WHY DATETIME2?
--------------------------------------------------------------------------------

SQL Server provides multiple date/time data types.

DATETIME

✔ Older datatype
✔ Precision ≈ 3 milliseconds
✔ Smaller supported date range

DATETIME2

✔ Recommended by Microsoft
✔ Precision up to 7 decimal places
✔ Larger date range
✔ Better storage efficiency
✔ Better for ETL and Data Engineering

Therefore DATETIME2 is preferred.

================================================================================
WHY SYSDATETIME() INSTEAD OF GETDATE()?
--------------------------------------------------------------------------------

GETDATE()

Returns current timestamp as DATETIME.

Example:

2026-07-03 14:20:35.123

Precision:
Approximately 3 milliseconds.

------------------------------------------------------------

SYSDATETIME()

Returns current timestamp as DATETIME2.

Example:

2026-07-03 14:20:35.1234567

Precision:
Up to 100 nanoseconds.

Why choose SYSDATETIME()?

✔ Higher precision
✔ Matches DATETIME2 datatype
✔ Better for incremental ETL pipelines

================================================================================
WHY DEFAULT SYSDATETIME()?
--------------------------------------------------------------------------------

Without DEFAULT:

Every INSERT must provide Last_Modified manually.

Example:

INSERT INTO Customers
VALUES(...,'2026-07-03')

This is error-prone.

With DEFAULT:

INSERT INTO Customers(CustomerID,CustomerName,City)
VALUES(1011,'Arjun Rao','Visakhapatnam');

SQL Server automatically stores:

2026-07-03 14:20:35.1234567

No manual work required.

================================================================================
INTERVIEW QUESTIONS
--------------------------------------------------------------------------------

Q1. Why DATETIME2 instead of DATETIME?

Answer:
Higher precision, larger range, recommended by Microsoft.

------------------------------------------------------------

Q2. Why use DEFAULT SYSDATETIME()?

Answer:
Automatically records insertion time without requiring manual values.

------------------------------------------------------------

Q3. Why keep City nullable?

Answer:
Business data may be incomplete during initial ingestion.

================================================================================
LEARNING OUTCOMES
--------------------------------------------------------------------------------

✔ Primary Key
✔ NULL vs NOT NULL
✔ DATETIME2
✔ SYSDATETIME()
✔ DEFAULT Constraint
✔ Incremental Loading Design

================================================================================
*/

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(100) NULL,
    Last_Modified DATETIME2 DEFAULT SYSDATETIME()
);
