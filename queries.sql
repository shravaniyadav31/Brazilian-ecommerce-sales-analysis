-- ============================================================================
-- Brazilian E-Commerce Sales Analysis
-- Dataset: Olist Public Brazilian E-Commerce Dataset (2016-2018)
-- Engine:  MySQL
-- ============================================================================

USE ecommerce;

-- ----------------------------------------------------------------------------
-- 1. Total Customers
-- ----------------------------------------------------------------------------
SELECT COUNT(*) AS customers
FROM olist_customers_dataset;


-- ----------------------------------------------------------------------------
-- 2. Total Revenue
-- ----------------------------------------------------------------------------
SELECT ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_order_payments_dataset;


-- ----------------------------------------------------------------------------
-- 3. Total Orders
-- ----------------------------------------------------------------------------
SELECT COUNT(*) AS total_orders
FROM olist_orders_dataset;


-- ----------------------------------------------------------------------------
-- 4. Average Order Value
-- ----------------------------------------------------------------------------
SELECT ROUND(AVG(payment_value),2) AS avg_order_value
FROM olist_order_payments_dataset;


-- ----------------------------------------------------------------------------
-- 5. Revenue by Payment Type
-- ----------------------------------------------------------------------------
SELECT
    payment_type,
    ROUND(SUM(payment_value),2) revenue
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY revenue DESC;


-- ----------------------------------------------------------------------------
-- 6. Top 10 States by Revenue
-- ----------------------------------------------------------------------------
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
  ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
  ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;


-- ----------------------------------------------------------------------------
-- 7. Top 10 Customers by Spending
-- ----------------------------------------------------------------------------
SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value),2) spending
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
  ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
  ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY spending DESC
LIMIT 10;


-- ----------------------------------------------------------------------------
-- 8. Top Product Categories by Revenue
-- ----------------------------------------------------------------------------
SELECT
    pr.product_category_name,
    ROUND(SUM(oi.price),2) revenue
FROM olist_products_dataset pr
JOIN olist_order_items_dataset oi
  ON pr.product_id = oi.product_id
GROUP BY pr.product_category_name
ORDER BY revenue DESC
LIMIT 10;


-- ----------------------------------------------------------------------------
-- 9. Top Sellers by Revenue
-- ----------------------------------------------------------------------------
SELECT
    seller_id,
    ROUND(SUM(price),2) revenue
FROM olist_order_items_dataset
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 10;


-- ----------------------------------------------------------------------------
-- 10. Orders by Status
-- ----------------------------------------------------------------------------
SELECT
    order_status,
    COUNT(*) total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;
