# Customer Retention and Cohort Analysis (SQL)

An independent educational SQL portfolio exercise using fictional customer orders.

## Business question
Of customers who made their first purchase in a given month, what percentage purchased again in later months?

## Deliverables
- [PostgreSQL queries](cohort_analysis.sql)
- Uses the fictional order data from [Retail Sales KPI Analysis](../retail-sales-kpi-analysis/README.md).

## Method
1. Find each customer's first purchase month.
2. Assign every order a month offset from that cohort.
3. Count distinct active customers by cohort and offset.
4. Calculate retention against each cohort's original customer count.

## Notes
This is an original illustrative extension, not a real employer or client dataset. Retention is based on purchase activity, not subscriptions.
