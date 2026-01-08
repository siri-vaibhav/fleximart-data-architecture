# Star Schema Design – FlexiMart Data Warehouse

## Fact Table: fact_sales

Grain: One row per product per order line item  
Business Process: Sales transactions

Measures (Numeric Facts):
- quantity_sold: Number of units sold
- unit_price: Price per unit at the time of sale
- discount_amount: Discount applied on the sale
- total_amount: Final sales amount (quantity × unit_price − discount)

Foreign Keys:
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

---

## Dimension Table: dim_date

Purpose: Enables time-based analysis such as daily, monthly, quarterly, and yearly sales trends.  
Type: Conformed time dimension.

Attributes:
- date_key (PK): Surrogate key in YYYYMMDD format
- full_date: Actual calendar date
- day_of_week: Name of the day
- day_of_month: Day number within the month
- month: Month number (1–12)
- month_name: Month name
- quarter: Quarter of the year (Q1–Q4)
- year: Calendar year
- is_weekend: Indicates whether the date is a weekend

---

## Dimension Table: dim_product

Purpose: Stores product-related descriptive information for sales analysis.

Attributes:
- product_key (PK): Surrogate key
- product_id: Original product identifier from source system
- product_name: Name of the product
- category: Product category
- subcategory: Product subcategory
- unit_price: Standard unit price of the product

---

## Dimension Table: dim_customer

Purpose: Stores customer demographic and segmentation data.

Attributes:
- customer_key (PK): Surrogate key
- customer_id: Original customer identifier
- customer_name: Customer full name
- city: City of residence
- state: State of residence
- customer_segment: Customer classification segment

---

## Design Decisions

The fact table is designed at the transaction line-item level to ensure maximum analytical flexibility. This level of granularity allows analysis of individual products, customers, and dates while still supporting aggregation for monthly, quarterly, and yearly reporting.

Surrogate keys are used instead of natural keys to improve query performance and maintain historical accuracy. Natural keys from source systems may change over time, whereas surrogate keys remain stable and simplify joins between fact and dimension tables.

The star schema structure supports OLAP operations such as drill-down and roll-up. Users can drill down from year to quarter to month using the date dimension hierarchy or roll up detailed sales data into summarized insights.

---

## Sample Data Flow

Source Transaction:  
Order #101, Customer "John Doe", Product "Laptop", Quantity: 2, Unit Price: 50000

Data Warehouse Representation:

fact_sales:
- date_key: 20240115
- product_key: 5
- customer_key: 12
- quantity_sold: 2
- unit_price: 50000
- total_amount: 100000

dim_date:
- date_key: 20240115
- month: January
- quarter: Q1
- year: 2024

dim_product:
- product_key: 5
- product_name: Laptop
- category: Electronics

dim_customer:
- customer_key: 12
- customer_name: John Doe
- city: Mumbai