# OLTP Schema Documentation – FlexiMart

## Overview

This document describes the normalized relational database schema used to store cleaned transactional data for FlexiMart. The schema is designed following Third Normal Form (3NF) to ensure data integrity, reduce redundancy, and support efficient transactional operations.

---

## Tables Description

### 1. customers

Stores cleaned customer information.

| Column Name | Data Type | Description |
|------------|----------|-------------|
| customer_id | VARCHAR(10) (PK) | Unique customer identifier |
| first_name | VARCHAR(50) | Customer first name |
| last_name | VARCHAR(50) | Customer last name |
| email | VARCHAR(100) | Customer email (nullable) |
| phone | VARCHAR(15) | Standardized phone number |
| city | VARCHAR(50) | Customer city |
| registration_date | DATE | Registration date |

---

### 2. products

Stores product master data.

| Column Name | Data Type | Description |
|------------|----------|-------------|
| product_id | VARCHAR(10) (PK) | Unique product identifier |
| product_name | VARCHAR(100) | Product name |
| category | VARCHAR(50) | Standardized product category |
| price | DECIMAL(10,2) | Product price |
| stock_quantity | INT | Available stock |

---

### 3. sales

Stores sales transaction data.

| Column Name | Data Type | Description |
|------------|----------|-------------|
| transaction_id | VARCHAR(10) (PK) | Unique transaction ID |
| customer_id | VARCHAR(10) (FK) | References customers |
| product_id | VARCHAR(10) (FK) | References products |
| quantity | INT | Quantity purchased |
| unit_price | DECIMAL(10,2) | Price per unit |
| transaction_date | DATE | Date of transaction |
| status | VARCHAR(20) | Order status |

---

## Normalization (3NF Explanation)

The schema follows Third Normal Form (3NF). Each table contains atomic attributes and has a primary key that uniquely identifies each record. Non-key attributes depend only on the primary key and not on other non-key attributes.

Customer details are stored separately from sales transactions to avoid duplication of customer information across multiple transactions. Similarly, product details are maintained in a separate products table. The sales table only stores foreign keys referencing customers and products, ensuring referential integrity and eliminating update anomalies.

This normalization improves data consistency, reduces redundancy, and supports scalable transactional processing.