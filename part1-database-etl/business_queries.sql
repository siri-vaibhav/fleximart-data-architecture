-- Business Queries for FlexiMart (OLTP Database)
-- Part 1: SQL Analysis

--------------------------------------------------
-- Query 1: Customer Purchase History
-- Business Question:
-- Retrieve each customer's total number of purchases and total amount spent
--------------------------------------------------

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(s.transaction_id) AS total_orders,
    SUM(s.quantity * s.unit_price) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE s.status = 'Completed'
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC;

--------------------------------------------------
-- Query 2: Product Sales Analysis
-- Business Question:
-- Identify top-selling products by total quantity sold
--------------------------------------------------

SELECT
    p.product_id,
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
WHERE s.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

--------------------------------------------------
-- Query 3: Monthly Sales Trend
-- Business Question:
-- Analyze monthly sales revenue trends
--------------------------------------------------

SELECT
    YEAR(s.transaction_date) AS year,
    MONTH(s.transaction_date) AS month,
    SUM(s.quantity * s.unit_price) AS monthly_revenue
FROM sales s
WHERE s.status = 'Completed'
GROUP BY YEAR(s.transaction_date), MONTH(s.transaction_date)
ORDER BY year, month;