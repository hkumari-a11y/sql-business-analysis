-- PostgreSQL. First run ../retail-sales-kpi-analysis/schema_and_sample_data.sql
-- Cohort retention by month since first purchase.
WITH customer_months AS (
  SELECT DISTINCT customer_id,
         DATE_TRUNC('month', order_date)::date AS purchase_month
  FROM demo_orders
), first_purchase AS (
  SELECT customer_id, MIN(purchase_month) AS cohort_month
  FROM customer_months
  GROUP BY customer_id
), activity AS (
  SELECT f.cohort_month,
         (EXTRACT(YEAR FROM AGE(c.purchase_month, f.cohort_month))::int * 12
          + EXTRACT(MONTH FROM AGE(c.purchase_month, f.cohort_month))::int) AS months_since_first,
         c.customer_id
  FROM customer_months c
  JOIN first_purchase f USING (customer_id)
), cohort_size AS (
  SELECT cohort_month, COUNT(*) AS starting_customers
  FROM first_purchase GROUP BY cohort_month
)
SELECT a.cohort_month, a.months_since_first,
       COUNT(DISTINCT a.customer_id) AS active_customers,
       s.starting_customers,
       ROUND(100.0 * COUNT(DISTINCT a.customer_id) / NULLIF(s.starting_customers,0), 1) AS retention_pct
FROM activity a
JOIN cohort_size s USING (cohort_month)
GROUP BY a.cohort_month, a.months_since_first, s.starting_customers
ORDER BY a.cohort_month, a.months_since_first;
