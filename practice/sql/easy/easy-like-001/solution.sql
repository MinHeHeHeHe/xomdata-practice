-- Xom Data · Basic-plan subscribers
-- Problem: https://xomdata.com/practice/easy-like-001
-- Solved: 2026-10-22

SELECT phone_number, full_name, plans
FROM subscribers
WHERE UPPER(plans) LIKE '%BASIC%'
ORDER BY 2
