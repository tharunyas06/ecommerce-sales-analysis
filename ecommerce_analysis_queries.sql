SELECT COUNT(*)
FROM ecommerce_sales_34500;
SELECT *
FROM ecommerce_sales_34500
LIMIT 10;
PRAGMA table_info(ecommerce_sales_34500);
SELECT SUM(total_amount) AS total_revenue
FROM ecommerce_sales_34500;
SELECT
    category,
    SUM(total_amount) AS revenue
FROM ecommerce_sales_34500
GROUP BY category
ORDER BY revenue DESC;
SELECT
    region,
    SUM(total_amount) AS revenue
FROM ecommerce_sales_34500
GROUP BY region
ORDER BY revenue DESC;
SELECT
    payment_method,
    SUM(total_amount) AS revenue
FROM ecommerce_sales_34500
GROUP BY payment_method
ORDER BY revenue DESC;
SELECT
    category,
    COUNT(*) AS returned_orders
FROM ecommerce_sales_34500
WHERE returned = 'Yes'
GROUP BY category
ORDER BY returned_orders DESC;
SELECT
    category,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales_34500
GROUP BY category
ORDER BY average_order_value DESC;



-- 1. Profit margin by category
SELECT
    category,
    ROUND(AVG(profit_margin), 4) AS average_profit_margin,
    COUNT(*) AS total_orders
FROM ecommerce_sales_34500
GROUP BY category
ORDER BY average_profit_margin DESC;

-- 2. Loss-making orders

SELECT
    COUNT(*) AS loss_making_orders
FROM ecommerce_sales_34500
WHERE profit_margin < 0;

-- 3. Discount impact

SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.05 THEN 'Low Discount'
        WHEN discount <= 0.10 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_group,
    COUNT(*) AS total_orders,
    ROUND(AVG(profit_margin), 4) AS average_profit_margin
FROM ecommerce_sales_34500
GROUP BY discount_group
ORDER BY average_profit_margin DESC;

-- 4. Customer age group analysis

SELECT
    CASE
        WHEN customer_age < 25 THEN 'Under 25'
        WHEN customer_age BETWEEN 25 AND 34 THEN '25-34'
        WHEN customer_age BETWEEN 35 AND 44 THEN '35-44'
        WHEN customer_age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END AS age_group,
    COUNT(*) AS total_orders,
    ROUND(AVG(total_amount), 2) AS average_order_value,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM ecommerce_sales_34500
GROUP BY age_group
ORDER BY total_revenue DESC;

-- 5. Delivery time and returns

SELECT
    returned,
    COUNT(*) AS total_orders,
    ROUND(AVG(delivery_time_days), 2) AS average_delivery_days
FROM ecommerce_sales_34500
GROUP BY returned;

-- 6. Return rate by category

SELECT
    category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        100.0 * SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS return_rate_percentage
FROM ecommerce_sales_34500
GROUP BY category
ORDER BY return_rate_percentage DESC;