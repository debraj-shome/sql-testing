02-Filtering-and-Sorting.sql
-- ============================================================
-- 02-Filtering-and-Sorting.sql
-- Purpose: Filtering and Sorting SQL Queries for QA
-- ============================================================


-- 1. Filter using WHERE
SELECT *
FROM employees
WHERE department = 'QA';


-- 2. Filter using AND
SELECT *
FROM employees
WHERE department = 'QA'
  AND status = 'Active';


-- 3. Filter using OR
SELECT *
FROM employees
WHERE department = 'QA'
   OR department = 'Development';


-- 4. NOT condition
SELECT *
FROM employees
WHERE NOT status = 'Inactive';


-- 5. Greater than
SELECT *
FROM employees
WHERE salary > 50000;


-- 6. Greater than or equal to
SELECT *
FROM employees
WHERE salary >= 50000;


-- 7. Less than
SELECT *
FROM employees
WHERE salary < 50000;


-- 8. Less than or equal to
SELECT *
FROM employees
WHERE salary <= 50000;


-- 9. Not equal to
SELECT *
FROM employees
WHERE department <> 'Support';


-- 10. BETWEEN
SELECT *
FROM employees
WHERE salary BETWEEN 40000 AND 70000;


-- 11. IN
SELECT *
FROM employees
WHERE department IN ('QA', 'Development', 'Support');


-- 12. NOT IN
SELECT *
FROM employees
WHERE department NOT IN ('HR', 'Finance');


-- 13. LIKE - starts with
SELECT *
FROM employees
WHERE employee_name LIKE 'A%';


-- 14. LIKE - ends with
SELECT *
FROM employees
WHERE employee_name LIKE '%n';


-- 15. LIKE - contains
SELECT *
FROM employees
WHERE employee_name LIKE '%an%';


-- 16. LIKE - single character wildcard
SELECT *
FROM employees
WHERE employee_name LIKE '_a%';


-- 17. IS NULL
SELECT *
FROM employees
WHERE manager_id IS NULL;


-- 18. IS NOT NULL
SELECT *
FROM employees
WHERE manager_id IS NOT NULL;


-- 19. Multiple filtering conditions
SELECT *
FROM employees
WHERE department = 'QA'
  AND salary > 50000
  AND status = 'Active';


-- 20. Combining AND and OR
SELECT *
FROM employees
WHERE (department = 'QA' OR department = 'Development')
  AND status = 'Active';


-- ============================================================
-- SORTING
-- ============================================================

-- 21. Sort by salary - Ascending
SELECT *
FROM employees
ORDER BY salary ASC;


-- 22. Sort by salary - Descending
SELECT *
FROM employees
ORDER BY salary DESC;


-- 23. Sort by name - Ascending
SELECT *
FROM employees
ORDER BY employee_name ASC;


-- 24. Sort by name - Descending
SELECT *
FROM employees
ORDER BY employee_name DESC;


-- 25. Sort using multiple columns
SELECT *
FROM employees
ORDER BY department ASC, salary DESC;


-- 26. Filter and sort together
SELECT *
FROM employees
WHERE department = 'QA'
ORDER BY salary DESC;


-- 27. Sort by date - Latest first
SELECT *
FROM employees
ORDER BY joining_date DESC;


-- 28. Sort by date - Oldest first
SELECT *
FROM employees
ORDER BY joining_date ASC;


-- ============================================================
-- QA VALIDATION EXAMPLES
-- ============================================================

-- 29. Find active QA employees with salary above 50,000
SELECT employee_id, employee_name, salary
FROM employees
WHERE department = 'QA'
  AND status = 'Active'
  AND salary > 50000
ORDER BY salary DESC;


-- 30. Find employees with missing department data
SELECT employee_id, employee_name, department
FROM employees
WHERE department IS NULL;


-- 31. Find employees with missing manager information
SELECT employee_id, employee_name, manager_id
FROM employees
WHERE manager_id IS NULL;


-- 32. Find potentially duplicate employee names
SELECT employee_name, COUNT(*) AS duplicate_count
FROM employees
GROUP BY employee_name
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- 33. Find employees within a salary range
SELECT employee_id, employee_name, salary
FROM employees
WHERE salary BETWEEN 40000 AND 80000
ORDER BY salary DESC;


-- 34. Find employees from selected departments
SELECT employee_id, employee_name, department
FROM employees
WHERE department IN ('QA', 'Development')
ORDER BY department, employee_name;


-- 35. Find inactive employees and sort by latest joining date
SELECT employee_id, employee_name, status, joining_date
FROM employees
WHERE status = 'Inactive'
ORDER BY joining_date DESC;


-- ============================================================
-- QA CHECK:
-- Always verify:
-- 1. WHERE conditions return the expected records.
-- 2. AND/OR conditions are correctly grouped.
-- 3. NULL values are handled using IS NULL / IS NOT NULL.
-- 4. ORDER BY produces the expected sequence.
-- 5. Boundary values for BETWEEN, >=, and <= are tested.
-- ============================================================
