-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-10-23

SELECT full_name, student_code, avg_score,
    (CASE
        WHEN avg_score >= 9 THEN 'Excellent'
        WHEN avg_score >= 8 AND avg_score < 9 THEN 'Good'
        WHEN avg_score >= 7 AND avg_score < 8 THEN 'Fair'
        WHEN avg_score >= 5 AND avg_score < 7 THEN 'Average'
        ELSE 'Poor'
    END) AS grade,
    DENSE_RANK() OVER(ORDER BY avg_score DESC) AS class_rank
FROM (  SELECT full_name, student_code, 
            ROUND(AVG(final_score), 2) AS avg_score
        FROM students s
        JOIN scores c ON s.id = c.student_id
        GROUP BY full_name, student_code)
ORDER BY avg_score DESC, student_code
LIMIT 20
