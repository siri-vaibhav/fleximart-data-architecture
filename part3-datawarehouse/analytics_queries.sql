-- Query 1: Monthly Sales Drill-Down
-- Business Scenario: Analyze sales trends by year and month

SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.total_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- Query 2: Top 10 Products by Revenue
-- Business Scenario: Identify top products contributing to revenue

SELECT
    p.product_name,
    SUM(f.total_amount) AS product_revenue,
    ROUND(
        (SUM(f.total_amount) / 
        (SELECT SUM(total_amount) FROM fact_sales)) * 100, 2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY product_revenue DESC
LIMIT 10;

-- Query 3: Customer Segmentation
-- Business Scenario: Segment customers based on spending behavior

SELECT
    c.customer_name,
    SUM(f.total_amount) AS total_spent,
    CASE
        WHEN SUM(f.total_amount) >= 70000 THEN 'High Value'
        WHEN SUM(f.total_amount) BETWEEN 30000 AND 69999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_name
ORDER BY total_spent DESC;