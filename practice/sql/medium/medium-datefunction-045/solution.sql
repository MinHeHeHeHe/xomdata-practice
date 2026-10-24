-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-10-24


SELECT month, transaction_count, total_amount,
    (total_amount - LAG(total_amount, 1, NULL) OVER(ORDER BY month)) AS mom_delta
FROM (  SELECT TO_CHAR(transaction_date::date , 'YYYY-MM') AS month,
        COUNT(id) AS transaction_count,
        SUM(amount) AS total_amount
        FROM transactions
        GROUP BY month)
ORDER BY month;
