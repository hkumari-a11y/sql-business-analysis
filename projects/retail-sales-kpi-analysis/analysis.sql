-- Revenue is the sum of item quantities multiplied by recorded unit prices.
WITH order_totals AS (
  SELECT o.order_id, o.customer_id, o.order_date,
         SUM(oi.quantity * oi.unit_price) AS order_revenue
  FROM demo_orders o
  JOIN demo_order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id, o.customer_id, o.order_date
)
SELECT DATE_TRUNC('month', order_date)::date AS month,
       COUNT(*) AS orders,
       ROUND(SUM(order_revenue), 2) AS revenue,
       ROUND(AVG(order_revenue), 2) AS average_order_value
FROM order_totals
GROUP BY 1 ORDER BY 1;

-- Repeat customers: customers with at least two orders.
SELECT c.customer_id, c.customer_name, COUNT(*) AS order_count
FROM demo_customers c
JOIN demo_orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(*) >= 2
ORDER BY order_count DESC, c.customer_id;

-- Product revenue.
SELECT p.product_name, SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM demo_products p
JOIN demo_order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC, p.product_name;
