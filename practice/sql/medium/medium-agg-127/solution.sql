-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-11-16

WITH employee_salary  AS (
    SELECT e.id, full_name, employee_code, department_name, SUM(net_salary) AS   total_received_salary
    FROM employees e
    JOIN departments d ON e.department_id  = d.id
    JOIN payroll p ON e.id = p.employee_id
    GROUP BY e.id, full_name, employee_code, department_name
),
top10_salary AS (
    SELECT
    *,
    ROUND((total_received_salary - AVG(total_received_salary)
        OVER(PARTITION BY department_name)) * 100.00 / AVG(total_received_salary)
        OVER(PARTITION BY department_name), 2) AS pct_above_dept_avg
    FROM employee_salary
)
SELECT full_name, employee_code, department_name, total_received_salary,
     COUNT(CASE WHEN status = 'approved' THEN 1 END) AS leave_count, 
     pct_above_dept_avg
FROM top10_salary t
LEFT JOIN leaves l ON t.id = l.employee_id
GROUP BY full_name, employee_code, department_name, total_received_salary, pct_above_dept_avg
ORDER BY total_received_salary DESC
LIMIT 10
