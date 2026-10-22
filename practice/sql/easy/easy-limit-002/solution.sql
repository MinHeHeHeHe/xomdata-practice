-- Xom Data · Top 3 highest-value orders
-- Problem: https://xomdata.com/practice/easy-limit-002
-- Solved: 2026-10-22

SELECT order_code, customers, total_amount
FROM orders
ORDER BY 3 DESC
LIMIT 3
