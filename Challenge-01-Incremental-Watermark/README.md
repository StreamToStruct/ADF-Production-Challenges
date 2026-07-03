# Challenge 01 - Incremental Customer Load using Watermark

## Business Problem

A CRM system sends customer records every day. The incoming data may contain:

- New customers
- Updates to existing customers

The objective is to build an incremental ETL pipeline that:

- Inserts new customers
- Updates existing customers
- Copies only new or modified records
- Maintains a watermark for future incremental loads
- Stores the output as a CSV file in Azure Blob Storage

---

## Architecture

```
Temp_Customers
        │
        ▼
MERGE
        │
        ▼
Customers
        │
        ▼
Lookup Watermark
        │
        ▼
Copy Incremental Records
        │
        ▼
Update Watermark
        │
        ▼
Clear Temp_Customers
```

---

## Tech Stack

- Azure Data Factory
- Azure SQL Database
- Azure Blob Storage
- SQL

---

## Database Tables

### Customers

Stores the latest customer data.

### Temp_Customers

Stores the daily incoming customer records.

### Pipeline_Metadata

Stores the watermark used for incremental loading.

---

## Pipeline Activities

| Activity | Purpose |
|----------|---------|
| SCR_Merge_Customers | Merge staging data into the Customers table |
| LKP_Get_Watermark | Read the last successful watermark |
| CPY_Incremental_Customers | Copy only changed records to Blob Storage |
| SCR_Update_Watermark | Update the watermark after a successful copy |
| SCR_Clear_Temp | Clear the staging table |

---

## Incremental Logic

```sql
SELECT *
FROM Customers
WHERE Last_Modified > LastWatermarkValue
```

---

## Test Scenario

### Initial Data

10 customers were loaded into the Customers table.

### Daily Changes

- Updated existing customers
- Added new customers

### Expected Result

- Existing customers updated
- New customers inserted
- Only changed records copied to Blob Storage
- Watermark updated
- Temp_Customers cleared

---

## Project Structure

```
Challenge-01-Incremental-Watermark
│
├── SQL
├── Results
├── Architecture
└── README.md
```

---

## Learning Outcomes

- Watermark-based Incremental Loading
- SQL MERGE
- Azure Data Factory Lookup Activity
- Copy Activity
- Script Activity
- Azure Blob Storage
- Metadata-driven ETL Design

---

## Future Improvements

- Parameterize the pipeline
- Process multiple tables using ForEach
- Add email notifications
- Implement retry and error handling



## Screenshots

### Pipeline

![Pipeline](Results/pipeline.png)

### Successful Pipeline Run

![Run](Results/pipeline_success.png)

### Blob Output

![Blob](Results/blob_output.png)

### Metadata Table

![Metadata](Results/metadata_after.png)
