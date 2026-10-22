-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-10-22

SELECT full_name, email, application_date, queue_position,
    ROUND((PERCENT_RANK() OVER (ORDER BY application_date) * 100)::numeric, 2) AS older_than_pct 
FROM (SELECT full_name, email, application_date,
            RANK() OVER(ORDER BY application_date, full_name) AS queue_position
    FROM candidates c
    LEFT JOIN interviews i ON c.id = i.candidate_id
    WHERE i.candidate_id IS NULL) t
