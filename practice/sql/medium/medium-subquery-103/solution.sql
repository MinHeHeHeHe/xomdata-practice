-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-10-23

SELECT product_name, category, price, diff_from_avg,
    (ROUND((diff_from_avg * 100/ avg_price), 2)) AS pct_above
FROM (  SELECT product_name, category, price, avg_price,
        ROUND((price - avg_price), 0) AS diff_from_avg
        FROM (  SELECT product_name, category, price,
                AVG(price) OVER(PARTITION BY category) AS avg_price
                FROM products)
        )
WHERE diff_from_avg > 0
ORDER BY pct_above DESC, product_name
