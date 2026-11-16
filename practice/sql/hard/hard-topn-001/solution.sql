-- Xom Data · Top 3 products by sales in each category
-- Problem: https://xomdata.com/practice/hard-topn-001
-- Solved: 2026-11-16

SELECT *
FROM (SELECT category, name AS product_name, units_sold, 
    DENSE_RANK() OVER(PARTITION BY category ORDER BY units_sold DESC) AS rank_in_cat
    FROM products
    GROUP BY category, product_name, units_sold)
WHERE rank_in_cat <= 3
ORDER BY category, rank_in_cat, product_name
