-- Xom Data · Revenue from delivered orders
-- Problem: https://xomdata.com/practice/easy-sum-001
-- Solved: 2026-10-22

SELECT SUM(total_amount) AS total_revenue
FROm orders
WHERE status = 'Delivered'
