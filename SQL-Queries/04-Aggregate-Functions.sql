# 04-Aggregate-Functions.sql

```sql id="k2v7qm"
-- ============================================================
-- 04-Aggregate-Functions.sql
-- Purpose: Aggregate Functions for QA / Database Testing
--
-- Main Aggregate Functions:
--   COUNT()
--   SUM()
--   AVG()
--   MIN()
--   MAX()
-- ============================================================


-- ============================================================
-- 1. COUNT() - Count all records
-- ============================================================

SELECT COUNT(*) AS total_employees
FROM employees;


-- ============================================================
-- 2. COUNT(column) - Count non-NULL values
-- ============================================================

SELECT COUNT(manager_id) AS employees_with_manager
FROM employees;


-- ============================================================
-- 3. COUNT(DISTINCT) - Count unique values
-- ============================================================

SELECT COUNT(DISTINCT department_id) AS total_departments
FROM employees;


-- ============================================================
-- 4. COUNT with WHERE
-- Count active employees.
-- ============================================================

SELECT COUNT(*) AS active_employees
FROM employees
WHERE status = 'Active';


-- ============================================================
-- 5. SUM() - Calculate total salary
-- ============================================================

SELECT SUM(salary) AS total_salary
FROM employees;


-- ============================================================
-- 6. SUM() with WHERE
-- Calculate total salary of active employees.
-- ============================================================

SELECT SUM(salary) AS active_employee_salary
FROM employees
WHERE status = 'Active';


-- ============================================================
-- 7. AVG() - Calculate average salary
-- ============================================================

SELECT AVG(salary) AS average_salary
FROM employees;


-- ============================================================
-- 8. AVG() with WHERE
-- Average salary of QA employees.
-- ============================================================

SELECT AVG(salary) AS average_qa_salary
FROM employees
WHERE department_id = 10;


-- ============================================================
-- 9. MIN() - Find minimum salary
-- ============================================================

SELECT MIN(salary) AS minimum_salary
FROM employees;


-- ============================================================
-- 10. MAX() - Find maximum salary
-- ============================================================

SELECT MAX(salary) AS maximum_salary
FROM employees;


-- ============================================================
-- 11. MIN() and MAX() together
-- ============================================================

SELECT
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;


-- ============================================================
-- 12. Multiple aggregate functions
-- ============================================================

SELECT
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;


-- ============================================================
-- GROUP BY
-- ============================================================

-- 13. Count employees by department
-- ============================================================

SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;


-- ============================================================
-- 14. Average salary by department
-- ============================================================

SELECT
    department_id,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;


-- ============================================================
-- 15. Total salary by department
-- ============================================================

SELECT
    department_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;


-- ============================================================
-- 16. Minimum salary by department
-- ============================================================

SELECT
    department_id,
    MIN(salary) AS minimum_salary
FROM employees
GROUP BY department_id;


-- ============================================================
-- 17. Maximum salary by department
-- ============================================================

SELECT
    department_id,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY department_id;


-- ============================================================
-- 18. Multiple aggregates with GROUP BY
-- ============================================================

SELECT
    department_id,
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY department_id;


-- ============================================================
-- HAVING
-- ============================================================

-- 19. Departments having more than 5 employees
-- ============================================================

SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;


-- ============================================================
-- 20. Departments with average salary greater than 60,000
-- ============================================================

SELECT
    department_id,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 60000;


-- ============================================================
-- 21. Departments with total salary greater than 500,000
-- ============================================================

SELECT
    department_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 500000;


-- ============================================================
-- GROUP BY + ORDER BY
-- ============================================================

-- 22. Departments sorted by employee count
-- ============================================================

SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;


-- ============================================================
-- 23. Departments sorted by average salary
-- ============================================================

SELECT
    department_id,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
ORDER BY average_salary DESC;


-- ============================================================
-- AGGREGATES WITH JOINS
-- ============================================================

-- 24. Employee count by department name
-- ============================================================

SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;


-- ============================================================
-- 25. Average salary by department name
-- ============================================================

SELECT
    d.department_name,
    AVG(e.salary) AS average_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;


-- ============================================================
-- 26. Total salary by department name
-- ============================================================

SELECT
    d.department_name,
    SUM(e.salary) AS total_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;


-- ============================================================
-- 27. Complete department-level summary
-- ============================================================

SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS average_salary,
    MIN(e.salary) AS minimum_salary,
    MAX(e.salary) AS maximum_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;


-- ============================================================
-- QA VALIDATION QUERIES
-- ============================================================

-- 28. Check total number of employees
-- ============================================================

SELECT COUNT(*) AS total_employees
FROM employees;


-- ============================================================
-- 29. Check active vs inactive employee counts
-- ============================================================

SELECT
    status,
    COUNT(*) AS employee_count
FROM employees
GROUP BY status;


-- ============================================================
-- 30. Check employee count by department and status
-- ============================================================

SELECT
    department_id,
    status,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id, status
ORDER BY department_id, status;


-- ============================================================
-- 31. Find departments with no employees
-- ============================================================

SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name
HAVING COUNT(e.employee_id) = 0;


-- ============================================================
-- 32. Find departments with more than 10 active employees
-- ============================================================

SELECT
    department_id,
    COUNT(*) AS active_employee_count
FROM employees
WHERE status = 'Active'
GROUP BY department_id
HAVING COUNT(*) > 10;


-- ============================================================
-- 33. Find departments where the highest salary exceeds 100,000
-- ============================================================

SELECT
    department_id,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 100000;


-- ============================================================
-- 34. NULL validation using aggregate functions
-- Check how many employees have NULL salary.
-- ============================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(salary) AS records_with_salary,
    COUNT(*) - COUNT(salary) AS records_with_null_salary
FROM employees;


-- ============================================================
-- 35. QA Data Reconciliation Example
-- Compare expected employee count with actual employee count.
--
-- Replace 100 with the expected count from your test case.
-- ============================================================

SELECT
    COUNT(*) AS actual_count,
    100 AS expected_count,
    CASE
        WHEN COUNT(*) = 100 THEN 'PASS'
        ELSE 'FAIL'
    END AS validation_result
FROM employees;


-- ============================================================
-- KEY QA CONCEPTS
--
-- COUNT() -> Number of records / non-NULL values
-- SUM()   -> Total numeric value
-- AVG()   -> Average numeric value
-- MIN()   -> Smallest value
-- MAX()   -> Largest value
--
-- GROUP BY:
--   Groups records before applying aggregate functions.
--
-- HAVING:
--   Filters grouped/aggregated results.
--
-- WHERE:
--   Filters individual rows before aggregation.
--
-- QA uses aggregate functions to:
--   1. Verify record counts.
--   2. Validate totals.
--   3. Compare expected vs actual data.
--   4. Identify NULL/missing data.
--   5. Validate grouped business rules.
--   6. Perform database reconciliation.
-- ============================================================
```

