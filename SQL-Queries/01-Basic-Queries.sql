-- ============================================================
-- 01-Basic-Queries.sql
-- Purpose: Basic SQL queries for QA / Database Testing
-- ============================================================


-- 1. View all records
SELECT *
FROM employees;


-- 2. View specific columns
SELECT employee_id, employee_name, department
FROM employees;


-- 3. Filter records using WHERE
SELECT *
FROM employees
WHERE department = 'QA';


-- 4. Multiple conditions using AND
SELECT *
FROM employees
WHERE department = 'QA'
  AND status = 'Active';


-- 5. Multiple conditions using OR
SELECT *
FROM employees
WHERE department = 'QA'
   OR department = 'Development';


-- 6. Not equal condition
SELECT *
FROM employees
WHERE status <> 'Inactive';


-- 7. Greater than / Less than
SELECT *
FROM employees
WHERE salary > 50000;

SELECT *
FROM employees
WHERE salary < 50000;


-- 8. BETWEEN
SELECT *
FROM employees
WHERE salary BETWEEN 40000 AND 70000;


-- 9. IN operator
SELECT *
FROM employees
WHERE department IN ('QA', 'Development', 'Support');


-- 10. LIKE operator
-- Names starting with 'A'
SELECT *
FROM employees
WHERE employee_name LIKE 'A%';


-- Names ending with 'n'
SELECT *
FROM employees
WHERE employee_name LIKE '%n';


-- Names containing 'an'
SELECT *
FROM employees
WHERE employee_name LIKE '%an%';


-- 11. Check NULL values
SELECT *
FROM employees
WHERE manager_id IS NULL;


-- 12. Check NOT NULL values
SELECT *
FROM employees
WHERE manager_id IS NOT NULL;


-- 13. Sort records - Ascending
SELECT *
FROM employees
ORDER BY salary ASC;


-- 14. Sort records - Descending
SELECT *
FROM employees
ORDER BY salary DESC;


-- 15. Get unique values
SELECT DISTINCT department
FROM employees;


-- 16. Count records
SELECT COUNT(*) AS total_employees
FROM employees;


-- 17. Count records with a condition
SELECT COUNT(*) AS qa_employees
FROM employees
WHERE department = 'QA';


-- 18. Find minimum value
SELECT MIN(salary) AS minimum_salary
FROM employees;


-- 19. Find maximum value
SELECT MAX(salary) AS maximum_salary
FROM employees;


-- 20. Find average value
SELECT AVG(salary) AS average_salary
FROM employees;


-- 21. Find total salary
SELECT SUM(salary) AS total_salary
FROM employees;


-- 22. GROUP BY
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- 23. GROUP BY with HAVING
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;


-- 24. LIMIT records
-- Syntax may vary by database
SELECT *
FROM employees
LIMIT 10;


-- 25. Basic UPDATE
-- Always verify the WHERE condition before updating.
UPDATE employees
SET status = 'Inactive'
WHERE employee_id = 101;


-- 26. Basic DELETE
-- Use carefully in test environments.
DELETE FROM employees
WHERE employee_id = 101;


-- 27. Verify a specific record
SELECT *
FROM employees
WHERE employee_id = 101;


-- 28. Find duplicate employee names
SELECT employee_name, COUNT(*) AS duplicate_count
FROM employees
GROUP BY employee_name
HAVING COUNT(*) > 1;


-- 29. Check records created today
-- Syntax can vary by database.
SELECT *
FROM employees
WHERE DATE(created_date) = CURRENT_DATE;


-- 30. QA Data Validation Example
-- Verify that all active employees have a department.
SELECT *
FROM employees
WHERE status = 'Active'
  AND department IS NULL;
