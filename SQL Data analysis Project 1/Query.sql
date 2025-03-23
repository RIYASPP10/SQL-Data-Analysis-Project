
SELECT * 
FROM sales_customers;

-- Count total records

SELECT COUNT(*)
FROM sales_customers;

-- Find the total revenue generated from all sales.

SELECT SUM(total_amount) AS Total_Sales_Amount
FROM orders;

-- List all unique product categories

SELECT DISTINCT(category)
FROM products;

-- Find customers who have placed more than 5 orders.

SELECT customer_id, COUNT(order_id) AS Order_count
FROM orders
GROUP BY customer_id
HAVING Order_count > 5;

-- Identify top 5 best-selling products (based on quantity sold).

SELECT p.`name`, SUM(oi.quantity) AS Total_sold
FROM products p 
JOIN order_items oi 
ON p.product_id = oi.product_id
GROUP BY p.`name`
ORDER BY Total_sold DESC
LIMIT 5;

-- Find all orders with missing transaction details.

SELECT o.*
FROM orders o 
JOIN order_items oi 
ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

-- Find the monthly revenue trend for the past 6 months.

SELECT DATE_FORMAT(order_date, '%Y/%m') AS `Month`, SUM(total_amount) AS Revenue
FROM orders
GROUP BY `Month`
ORDER BY `Month` DESC
LIMIT 6;

-- which customer spent the most money

SELECT o.customer_id, SUM(o.total_amount) AS Total_spent
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY Total_spent DESC
LIMIT 1;

-- the most popular product category

SELECT p.category, SUM(oi.quantity) AS Total_sold
FROM order_items oi
JOIN products p
ON oi.product_id = oi.product_id
GROUP BY p.category
ORDER BY Total_sold DESC
LIMIT 1;

-- Find customers who have placed at least 3 orders in different months.

SELECT customer_id, COUNT(DISTINCT DATE_FORMAT(order_date, '%Y/%m')) AS Uneque_month
FROM orders
GROUP BY customer_id
HAVING  Uneque_month >= 3;

-- Find cases where the same product was sold at different prices (which may indicate discounts or errors).

SELECT product_id, COUNT(DISTINCT price_per_unit) AS Uneque_price
FROM order_items
GROUP BY product_id
HAVING Uneque_price > 1;

-- Find the month with the highest total sales and compare it with the lowest sales month.

SELECT DATE_FORMAT(order_date, '%Y/%m') AS `Month`, SUM(total_amount) AS Total_sales
FROM orders
GROUP BY `Month`
ORDER BY Total_sales DESC 
LIMIT 1;

-- Identify customers who haven’t placed an order in the last 3 months.

SELECT customer_id, MAX(order_date) AS Last_order_date
FROM orders
GROUP BY customer_id
HAVING Last_order_date < DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

-- Determine which product categories generate the most revenue.

SELECT p.category, SUM(o.total_amount) AS Total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
GROUP BY p.category
ORDER BY Total_revenue DESC
LIMIT 5;

