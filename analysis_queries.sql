-- ===============================
-- Ebay Q4 Growth Audit Analysis
-- Author: Dinesh Jathar
-- ===============================

-- 1. December Revenue
SELECT 
    SUM(total_revenue) AS december_revenue
FROM ebay_transactions
WHERE date BETWEEN '2023-12-01' AND '2023-12-31';


-- 2. Units Sold by Category
SELECT 
    p.category,
    SUM(t.quantity) AS total_units
FROM ebay_transactions t
JOIN ebay_products p 
ON t.product_id = p.product_id
GROUP BY p.category
ORDER BY total_units DESC;


-- 3. Net Profit by Category
SELECT 
    p.category,
    SUM(t.total_revenue - (p.cost_price * t.quantity)) AS net_profit
FROM ebay_transactions t
JOIN ebay_products p
ON t.product_id = p.product_id
GROUP BY p.category
ORDER BY net_profit DESC;


-- 4. AOV by Region
SELECT 
    c.region,
    AVG(t.total_revenue) AS avg_order_value
FROM ebay_transactions t
JOIN ebay_customers c
ON t.customer_id = c.customer_id
GROUP BY c.region
ORDER BY avg_order_value DESC;


-- 5. Loyal Customers (Oct & Dec)
SELECT COUNT(DISTINCT t1.customer_id) AS loyal_customers
FROM ebay_transactions t1
JOIN ebay_transactions t2
ON t1.customer_id = t2.customer_id
WHERE t1.date BETWEEN '2023-10-01' AND '2023-10-31'
  AND t2.date BETWEEN '2023-12-01' AND '2023-12-31';


-- 6. Top 3 Products by Revenue
SELECT 
    p.product_name,
    SUM(t.total_revenue) AS total_revenue
FROM ebay_transactions t
JOIN ebay_products p
ON t.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 3;
