-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-10-22


SELECT full_name, order_count, total_spending, avg_order_value,
    ROW_NUMBER() OVER(ORDER BY total_spending DESC) AS spending_rank 
FROM (SELECT full_name, COUNT(DISTINCT o.id) AS order_count,
        SUM(total_amount) AS total_spending, 
        AVG(total_amount) AS avg_order_value
    FROM customers c
    JOIN orders o ON c.id = o.customer_id
    GROUP BY full_name) t
