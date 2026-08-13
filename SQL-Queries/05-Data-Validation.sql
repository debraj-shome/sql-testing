-- ============================================================
-- 06-Data-Validation.sql
-- Purpose: SQL Data Validation for Manual QA / Database Testing
-- ============================================================


-- ============================================================
-- 1. Check total number of records
-- ============================================================

SELECT COUNT(*) AS total_employees
FROM employees;


-- ============================================================
-- 2. Check mandatory fields for NULL
-- Example: Employee name should not be NULL
-- ============================================================

SELECT *
FROM employees
WHERE employee_name IS NULL;


-- ============================================================
-- 3. Check multiple mandatory fields
-- ============================================================

SELECT *
FROM employees
WHERE employee_name IS NULL
   OR department IS NULL
   OR status IS NULL
   OR salary IS NULL;


-- ============================================================
-- 4. Check for duplicate employee IDs
-- Employee ID should normally be unique
-- ============================================================

SELECT employee_id, COUNT(*) AS duplicate_count
FROM employees
GROUP BY employee_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 5. Check for duplicate employee names
-- Names may legitimately repeat, so investigate rather than
-- automatically treating them as defects.
-- ============================================================

SELECT employee_name, COUNT(*) AS duplicate_count
FROM employees
GROUP BY employee_name
HAVING COUNT(*) > 1;


-- ============================================================
-- 6. Check invalid salary values
-- Salary should not be zero or negative
-- ============================================================

SELECT *
FROM employees
WHERE salary <= 0;


-- ============================================================
-- 7. Check NULL salary
-- ============================================================

SELECT *
FROM employees
WHERE salary IS NULL;


-- ============================================================
-- 8. Check invalid employee status
-- Expected values: Active / Inactive
-- ============================================================

SELECT *
FROM employees
WHERE status NOT IN ('Active', 'Inactive');


-- ============================================================
-- 9. Check NULL status
-- ============================================================

SELECT *
FROM employees
WHERE status IS NULL;


-- ============================================================
-- 10. Check invalid departments
-- ============================================================

SELECT *
FROM employees
WHERE department NOT IN (
    'QA',
    'Development',
    'Support',
    'HR',
    'Finance'
);


-- ============================================================
-- 11. Check employees without a manager
-- Use this only if manager_id is mandatory according to
-- the business requirement.
-- ============================================================

SELECT *
FROM employees
WHERE manager_id IS NULL;


-- ============================================================
-- 12. Check orphan manager IDs
-- Find employees whose manager_id does not match an employee
-- ============================================================

SELECT e.*
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id
WHERE e.manager_id IS NOT NULL
  AND m.employee_id IS NULL;


-- ============================================================
-- 13. Check orphan department IDs
-- Requires a departments table
-- ============================================================

SELECT e.*
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL
  AND d.department_id IS NULL;


-- ============================================================
-- 14. Check employees belonging to inactive status
-- Example business-rule validation
-- ============================================================

SELECT *
FROM employees
WHERE status = 'Inactive'
  AND salary > 0;


-- ============================================================
-- 15. Check salary range
-- Example: salary should be between 20,000 and 200,000
-- Adjust according to the actual requirement.
-- ============================================================

SELECT *
FROM employees
WHERE salary < 20000
   OR salary > 200000;


-- ============================================================
-- 16. Check employee names with unexpected blank values
-- ============================================================

SELECT *
FROM employees
WHERE TRIM(employee_name) = '';


-- ============================================================
-- 17. Check employee names containing unexpected spaces
-- Useful for detecting leading/trailing spaces
-- ============================================================

SELECT *
FROM employees
WHERE employee_name <> TRIM(employee_name);


-- ============================================================
-- 18. Check duplicate records based on multiple columns
-- Example: same name + department + salary
-- ============================================================

SELECT employee_name,
       department,
       salary,
       COUNT(*) AS duplicate_count
FROM employees
GROUP BY employee_name, department, salary
HAVING COUNT(*) > 1;


-- ============================================================
-- 19. Check employees created in the future
-- Created date should not normally be greater than today.
-- ============================================================

SELECT *
FROM employees
WHERE created_date > CURRENT_DATE;


-- ============================================================
-- 20. Check records created today
-- ============================================================

SELECT *
FROM employees
WHERE DATE(created_date) = CURRENT_DATE;


-- ============================================================
-- 21. Check records created within a date range
-- Example: August 1 to August 31, 2026
-- ============================================================

SELECT *
FROM employees
WHERE created_date >= '2026-08-01'
  AND created_date < '2026-09-01';


-- ============================================================
-- 22. Check active employees without a department
-- Business-rule validation
-- ============================================================

SELECT *
FROM employees
WHERE status = 'Active'
  AND department IS NULL;


-- ============================================================
-- 23. Check inactive employees with an active flag
-- Example of business-rule validation
-- ============================================================

SELECT *
FROM employees
WHERE status = 'Inactive'
  AND active_flag = 'Y';


-- ============================================================
-- 24. Compare expected record count with actual record count
-- Example: UI/API says there should be 100 employees.
-- ============================================================

SELECT COUNT(*) AS actual_count
FROM employees;


-- ============================================================
-- 25. Verify a specific employee
-- Useful after creating/updating data through the application
-- ============================================================

SELECT *
FROM employees
WHERE employee_id = 101;


-- ============================================================
-- 26. Verify multiple employees
-- ============================================================

SELECT *
FROM employees
WHERE employee_id IN (101, 102, 103);


-- ============================================================
-- 27. Verify data after UPDATE
-- ============================================================

SELECT employee_id,
       employee_name,
       status
FROM employees
WHERE employee_id = 101;


-- ============================================================
-- 28. Verify data after INSERT
-- ============================================================

SELECT *
FROM employees
WHERE employee_id = 201;


-- ============================================================
-- 29. Verify data after DELETE
-- The query should return zero records if deletion succeeded.
-- ============================================================

SELECT *
FROM employees
WHERE employee_id = 201;


-- ============================================================
-- 30. Compare database values with expected values
-- Example validation for employee 101
-- ============================================================

SELECT employee_id,
       employee_name,
       department,
       status,
       salary
FROM employees
WHERE employee_id = 101;


-- ============================================================
-- 31. Find departments with zero employees
-- Useful for business/data validation
-- ============================================================

SELECT d.department_id,
       d.department_name
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;


-- ============================================================
-- 32. Check employee count by department
-- Useful for comparing with UI/report values
-- ============================================================

SELECT department,
       COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 33. Check average salary by department
-- Useful for validating reports/dashboards
-- ============================================================

SELECT department,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY department;


-- ============================================================
-- 34. Check for NULL manager references
-- Display employees who have no manager
-- ============================================================

SELECT employee_id,
       employee_name,
       manager_id
FROM employees
WHERE manager_id IS NULL;


-- ============================================================
-- 35. General data-quality check
-- Find records with multiple potential problems
-- ============================================================

SELECT *
FROM employees
WHERE employee_name IS NULL
   OR TRIM(employee_name) = ''
   OR department IS NULL
   OR status IS NULL
   OR salary IS NULL
   OR salary <= 0
   OR status NOT IN ('Active', 'Inactive');


-- ============================================================
-- QA REMINDER
-- ============================================================
-- A validation query should answer a testing question.
--
-- Examples:
--
-- "Are there duplicate IDs?"
-- "Are mandatory fields missing?"
-- "Are there invalid statuses?"
-- "Are there orphan records?"
-- "Does the database contain the value shown in the UI?"
-- "Did the INSERT/UPDATE/DELETE actually happen?"
-- "Does the database match the expected business rule?"
--
-- IMPORTANT:
-- Not every NULL, duplicate, or unusual value is automatically
-- a defect. Always compare the result against the requirement.
