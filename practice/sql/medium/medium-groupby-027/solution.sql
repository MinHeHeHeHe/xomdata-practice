-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-10-22

WITH rank_by_avg_column AS (
    SELECT subject_name, credits,
        COUNT(g.id) AS student_count,
        ROUND(AVG(final_score), 2) AS avg_score,
        ROUND(COUNT(CASE WHEN final_score >= 5 THEN 1 END) * 100.00 / COUNT(g.id), 2) 
        AS pass_rate
    FROM subjects s
    JOIN grades g ON s.id = g.subject_id
    GROUP BY subject_name, credits
)
SELECT subject_name, credits, student_count,
    avg_score, pass_rate,
    RANK() OVER(ORDER BY avg_score DESC) AS rank_by_avg,
    NTILE(4) OVER (ORDER BY avg_score DESC, subject_name) AS difficulty_quartile 
FROM rank_by_avg_column
ORDER BY rank_by_avg, subject_name
