-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-10-24

WITH type_quantity AS (
    SELECT 'Complaint' AS type, COUNT(id) AS quantity
    FROM complaints
    WHERE status = 'Pending'
    UNION 
    SELECT 'Cancelled Order', COUNT(id) 
    FROM orders
    WHERE status = 'Cancelled'
    UNION 
    SELECT 'Out of Stock Product', COUNT(id) 
    FROM products
    WHERE status = 'Out of Stock'
),
add_pct_of_total_rank_pos AS (
    SELECT type, quantity,
        (quantity * 100.00 / NULLIF(SUM(quantity) OVER(), 0)) AS pct_of_total,
        RANK() OVER(ORDER BY quantity DESC) AS rank_pos
    FROM type_quantity
)
SELECT type, quantity, ROUND(pct_of_total, 2) AS pct_of_total, rank_pos,
    (ROUND(SUM(pct_of_total) OVER(ORDER BY rank_pos, type), 2)) AS cumulative_pct
FROM add_pct_of_total_rank_pos
ORDER BY rank_pos, type
