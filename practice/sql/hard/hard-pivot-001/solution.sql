-- Xom Data · Revenue pivoted by product type
-- Problem: https://xomdata.com/practice/hard-pivot-001
-- Solved: 2026-11-16


SELECT
    TO_CHAR(sale_date::date, 'YYYY-MM') AS month,
    COALESCE(SUM(amount) FILTER (WHERE category = 'Electronics'), 0) AS electronics,
    COALESCE(SUM(amount) FILTER (WHERE category = 'Clothing'), 0) AS clothing,
    COALESCE(SUM(amount) FILTER (WHERE category = 'Food'), 0) AS food,
    SUM(amount) AS total
FROM sales
GROUP BY 1
ORDER BY 1;
