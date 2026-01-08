"""
ETL Pipeline for FlexiMart
Part 1 – OLTP Database
"""

import pandas as pd
import re

# -------------------------
# Helper Functions
# -------------------------

def standardize_phone(phone):
    if pd.isna(phone):
        return None
    phone = re.sub(r'\D', '', phone)   # remove non-numeric
    if phone.startswith('91') and len(phone) > 10:
        phone = phone[-10:]
    if phone.startswith('0'):
        phone = phone[1:]
    return phone

def parse_date(date_val):
    try:
        return pd.to_datetime(date_val, dayfirst=True).date()
    except Exception:
        return None

# -------------------------
# EXTRACT
# -------------------------

customers = pd.read_csv("data/customers_raw.csv")
products = pd.read_csv("data/products_raw.csv")
sales = pd.read_csv("data/sales_raw.csv")

# -------------------------
# TRANSFORM – CUSTOMERS
# -------------------------

# Remove duplicates
customers = customers.drop_duplicates(subset="customer_id")

# Handle missing emails
customers["email"] = customers["email"].fillna("not_provided@fleximart.com")

# Standardize phone numbers
customers["phone"] = customers["phone"].apply(standardize_phone)

# Standardize city names
customers["city"] = customers["city"].str.strip().str.title()

# Fix date formats
customers["registration_date"] = customers["registration_date"].apply(parse_date)

# -------------------------
# TRANSFORM – PRODUCTS
# -------------------------

# Clean product names
products["product_name"] = products["product_name"].str.strip()

# Standardize categories
products["category"] = products["category"].str.strip().str.title()

# Handle missing prices (replace with category average)
products["price"] = products.groupby("category")["price"].transform(
    lambda x: x.fillna(x.mean())
)

# Handle missing stock
products["stock_quantity"] = products["stock_quantity"].fillna(0).astype(int)

# -------------------------
# TRANSFORM – SALES
# -------------------------

# Remove duplicate transactions
sales = sales.drop_duplicates(subset="transaction_id")

# Drop rows with missing customer_id or product_id
sales = sales.dropna(subset=["customer_id", "product_id"])

# Fix date formats
sales["transaction_date"] = sales["transaction_date"].apply(parse_date)

# Keep only completed transactions
sales = sales[sales["status"] == "Completed"]

# -------------------------
# LOAD (SIMULATED)
# -------------------------

# In a real system, this section would insert data into a database
# For assignment purposes, we export cleaned data to CSV

customers.to_csv("customers_cleaned.csv", index=False)
products.to_csv("products_cleaned.csv", index=False)
sales.to_csv("sales_cleaned.csv", index=False)

print("ETL Pipeline completed successfully.")