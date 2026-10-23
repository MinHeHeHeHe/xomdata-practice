-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-10-23

SELECT store_name, reputation_score, order_count, rank_by_orders,
    SUM(order_count) OVER(ORDER BY order_count DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_orders
FROM (SELECT store_name, reputation_score,
        COUNT(o.id) AS order_count,
        DENSE_RANK() OVER(ORDER BY COUNT(o.id) DESC) AS rank_by_orders
        FROM sellers s
        JOIN orders o ON s.id = o.seller_id
        WHERE reputation_score >= 4.5
        GROUP BY store_name, reputation_score
        HAVING COUNT(o.id) >= 3) t
ORDER BY rank_by_orders, store_name
