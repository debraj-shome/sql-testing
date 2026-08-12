03-Joins.sql
-- ============================================================
-- 03-Joins.sql
-- Purpose: SQL JOIN queries for QA / Database Testing
--
-- Example Tables:
--   employees
--   departments
--   projects
-- ============================================================


-- ============================================================
-- 1. INNER JOIN
-- Returns only records that have matching values in both tables.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- 2. LEFT JOIN
-- Returns all employees, even if they do not have
-- a matching department.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- 3. RIGHT JOIN
-- Returns all departments, even if they have
-- no matching employees.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
RIGHT JOIN departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- 4. FULL OUTER JOIN
-- Returns all records from both tables.
-- Matching records are combined.
-- Non-matching records contain NULL values.
--
-- Note: MySQL does not directly support FULL OUTER JOIN.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
FULL OUTER JOIN departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- 5. JOIN with WHERE condition
-- Find active employees and their departments.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.status
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.status = 'Active';


-- ============================================================
-- 6. JOIN with multiple conditions
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
   AND d.status = 'Active';


-- ============================================================
-- 7. JOIN with ORDER BY
-- Display employees sorted by department and name.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
ORDER BY d.department_name ASC,
         e.employee_name ASC;


-- ============================================================
-- 8. JOIN with GROUP BY
-- Count employees in each department.
-- ============================================================

SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;


-- ============================================================
-- 9. JOIN with HAVING
-- Find departments having more than 5 employees.
-- ============================================================

SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 5;


-- ============================================================
-- 10. Find employees without a department
-- Useful QA data-integrity check.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    e.department_id
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;


-- ============================================================
-- 11. Find departments without employees
-- Useful QA data-validation check.
-- ============================================================

SELECT
    d.department_id,
    d.department_name
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;


-- ============================================================
-- 12. SELF JOIN
-- Find each employee and their manager.
-- Assumes employees.manager_id references employees.employee_id.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;


-- ============================================================
-- 13. SELF JOIN - Find employees without managers
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id
WHERE m.employee_id IS NULL;


-- ============================================================
-- 14. JOIN THREE TABLES
-- Employees -> Departments -> Projects
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    p.project_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
INNER JOIN projects p
    ON e.project_id = p.project_id;


-- ============================================================
-- 15. LEFT JOIN with THREE TABLES
-- Show all employees, including those without a project.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    p.project_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN projects p
    ON e.project_id = p.project_id;


-- ============================================================
-- 16. JOIN with salary validation
-- Find employees whose salary is above 50,000.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    e.salary,
    d.department_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary > 50000
ORDER BY e.salary DESC;


-- ============================================================
-- 17. Find duplicate department relationships
-- Useful for identifying unexpected data relationships.
-- ============================================================

SELECT
    e.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
GROUP BY
    e.department_id,
    d.department_name
ORDER BY employee_count DESC;


-- ============================================================
-- 18. QA: Verify foreign-key relationships
-- Find employees whose department_id does not exist
-- in the departments table.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    e.department_id
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL
  AND d.department_id IS NULL;


-- ============================================================
-- 19. QA: Compare employee count with department count
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
ORDER BY d.department_id;


-- ============================================================
-- 20. QA DATA VALIDATION
-- Verify that every active employee has a valid department.
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    e.status,
    e.department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE e.status = 'Active'
  AND (
        e.department_id IS NULL
        OR d.department_id IS NULL
      );


-- ============================================================
-- KEY QA CONCEPTS TO PRACTICE
--
-- INNER JOIN  -> Matching records only
-- LEFT JOIN   -> All records from left table
-- RIGHT JOIN  -> All records from right table
-- FULL JOIN   -> All records from both tables
-- SELF JOIN   -> Table joined with itself
--
-- QA uses JOINs to:
-- 1. Validate relationships between tables.
-- 2. Verify foreign-key data.
-- 3. Compare application data with database data.
-- 4. Find missing or orphan records.
-- 5. Validate data across multiple tables.
-- 6. Investigate defects and data inconsistencies.
-- ============================================================
