# FlexiMart Data Architecture Project

**Student Name:** Manepally Siri Venkata Vaibhav
**Student ID:** bitsom_ba_2507193
**Email:** msvv2004@gmail.com
**Date:** 8 Jan 2026  

---

## Project Overview

This project showcases the design and implementation of a comprehensive data architecture for FlexiMart. It features a star schema-based data warehouse and analytical SQL queries to facilitate business intelligence and decision-making.

The solution allows for time-based analysis, tracking product performance, and segmenting customers through OLAP principles.

The project is divided into three sections:
- Section 1: OLTP database design, ETL pipeline, and business SQL queries
- Section 2: NoSQL database analysis and MongoDB operations
- Section 3: Data warehouse design and analytical queries
---

## Repository Structure

```
fleximart-data-architecture/
├── README.md
├── data/
│   ├── customers_raw.csv
│   ├── products_raw.csv
│   └── sales_raw.csv
├── part1-database-etl/
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   └── business_queries.sql
├── part2-nosql/
│   ├── nosql_analysis.md
│   └── mongodb_operations.js
└── part3-datawarehouse/
    ├── star_schema_design.md
    ├── warehouse_schema.sql
    ├── warehouse_data.sql
    └── analytics_queries.sql
```
    

## Setup Instructions

### Database Setup

#### Step 1: Create the database
Run the following SQL commands in MySQL:

```sql
CREATE DATABASE fleximart_dw;
USE fleximart_dw;

Step 2: Create tables
in terminal
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql

Step 3: Insert data
in terminal
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql

Step 4: Run analytics queries
in terminal
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql

## Challenges Faced

1. Designing accurate relationships between fact and dimension tables  
   **Solution:** Ensured that all dimension tables were populated prior to inserting fact records to prevent foreign key conflicts.

2. Writing analytical queries that align with business scenarios  
   **Solution:** Utilized GROUP BY, CASE statements, and aggregate functions to apply drill-down and segmentation logic.

