-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-10-23

SELECT genre_name, book_count, avg_price, min_price, max_price,
    price_range,
    RANK() OVER(ORDER BY book_count DESC) AS coverage_rank,
    NTILE(3) OVER(ORDER BY book_count DESC, genre_name) AS library_focus
FROM (  SELECT genre_name, 
            COALESCE(COUNT(b.id), 0) AS book_count,
            COALESCE(ROUND(AVG(price), 0), 0) AS avg_price,
            COALESCE(MIN(price), 0) AS min_price,
            COALESCE(MAX(price), 0) AS max_price,
            COALESCE(MAX(price) - MIN(price), 0) AS price_range
        FROM genres g
        LEFT JOIN books b ON g.id = b.genre_id
        GROUP BY genre_name)
ORDER BY coverage_rank,genre_name
