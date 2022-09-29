
SELECT dept_no, dept_name 
FROM departments 
WHERE dept_no > 'd005';

SELECT COUNT(*)
FROM salaries;

SELECT COUNT(*)
FROM dept_emp;

SELECT *
FROM departments
WHERE dept_name = 'Human Resources';

SELECT COUNT(*)
FROM salaries
WHERE salary > 100000
AND salary < 200000;

SELECT *
FROM departments
Where dept_name IN ('Sales', 'Marketing');

SELECT *
FROM departments
Where dept_name = 'Sales' OR dept_name = 'Marketing';


SELECT *
FROM departments
Where dept_name LIKE 'Human%';

SELECT *
FROM employees
where first_name LIKE '%Chris%';

SELECT *
FROM employees
where first_name LIKE 'Chris_';

SELECT *
FROM employees;

SELECT *
FROM employees
LIMIT 30;

SELECT COUNT(*) 
FROM employees 
WHERE hire_date > '2012-12-31' AND gender = 'F';

SELECT COUNT(*) 
FROM employees;

SELECT * 
FROM employees 
WHERE first_name = 'Bojan' OR last_name ='Bojan';

SELECT *, YEAR(hire_date), QUARTER(hire_date)
FROM employees
WHERE YEAR(hire_date) > 2006;

SELECT *, CONCAT("Q", QUARTER(hire_date), "-", YEAR(hire_Date))
FROM employees
WHERE YEAR(hire_date) > 2006;

SELECT *
FROM employees
WHERE DATE(hire_date) >= "2006-12-31";

SELECT CURDATE();

SELECT COUNT(first_name)
FROM employees;

--doesn't include nulls when you specify a column--
SELECT COUNT(to_date)
FROM salaries;

SELECT MIN(salary)
FROM salaries;

SELECT emp_no, MAX(salary)
FROM salaries;

--subqueries--
SELECT * FROM salaries
WHERE salary = (SELECT MAX(salary) from salaries);

SELECT COUNT(*)
FROM salaries
WHERE salary > ((SELECT AVG(salary) from salaries) *2) AND to_date IS NOT NULL;

--alias--
SELECT title, COUNT(*) AS N
FROM titles
WHERE to_date IS NULL
GROUP BY title
ORDER BY N DESC;

--order of operations--
--Take into consideration you have to use having here because count only happens after grouping--
-- use WHERE to filter on columns--
-- use HAVING to filter on aggregated columns--
-- how to deal with nulls--

SELECT title, COUNT(*) AS N
FROM titles
WHERE to_date IS NULL 
GROUP BY title
HAVING N>2000;

--or--
--alias subtables --

SELECT subtable.*
FROM  (SELECT title, COUNT(*) AS N
FROM titles
WHERE to_date IS NULL
GROUP BY title) AS subtable
WHERE subtable.N>20000

SELECT COUNT(*)
FROM employees
WHERE first_name = last_name;

SELECT last_name, first_name
FROM employees
WHERE first_name = last_name;

SELECT AVG(salary)
FROM salaries
WHERE to_date IS NULL;

SELECT YEAR(hire_date), COUNT(*)
FROM employees
GROUP BY YEAR(hire_date);

--how many female employees are in each department--
SELECT COUNT(*), dept_name
FROM employees AS e
LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
LEFT JOIN departments AS d ON d.dept_no = de.dept_no
WHERE gender = 'F'
GROUP BY dept_name;

SELECT COUNT(*), dept_name, gender
FROM employees AS e
LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
LEFT JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY dept_name, gender;

SELECT * FROM salaries LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM departments LIMIT 10;

Select avg(salary), gender 
FROM employees 
LEFT JOIN salaries ON salaries.emp_no = employees.emp_no
GROUP BY gender;

Select avg(salary), dept_no
FROM employees 
LEFT JOIN salaries ON salaries.emp_no = employees.emp_no
LEFT JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
GROUP BY dept_no;

Select avg(salary), dept_no, gender
FROM employees 
LEFT JOIN salaries ON salaries.emp_no = employees.emp_no
LEFT JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
GROUP BY dept_no, gender

Select avg(salary), dept_no
FROM employees 
LEFT JOIN salaries ON salaries.emp_no = employees.emp_no
LEFT JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
GROUP BY dept_no;

--What is the average salary when you group by department and only include current employees?--
select avg (salary), dept_name
from salaries
LEFT JOIN employees ON employees.emp_no = salaries.emp_no
Left Join dept_emp on dept_emp.emp_no = employees.emp_no
left join departments on departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date is null
Group by dept_name;

SELECT * FROM employees LIMIT 10;

SELECT * FROM dept_manager LIMIT 10;

SELECT *
FROM employees
LEFT JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.emp_no = employees.emp_no AND dept_manager.to_date IS NULL

SELECT *
FROM employees
LEFT JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.emp_no = employees.emp_no AND dept_manager.to_date IS NOT NULL;

SELECT count(CASE WHEN gender = 'F' THEN 1 END) Female,
       count(CASE WHEN gender = 'M' THEN 1 END) Male,
       count(gender) Total
FROM employees
LEFT JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.emp_no = employees.emp_no AND dept_manager.to_date IS NOT NULL

SELECT gender, COUNT(*)
FROM employees 
RIGHT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no 
WHERE dept_manager.to_date IS NULL
GROUP BY gender;

--find all salaries of all employees by department--
--inner join--

SELECT dept_no, Avg(salary)
from salaries
join dept_emp ON salaries.emp_no = dept_emp.emp_no
group by dept_no
limit 10

--rigth join--
SELECT COUNT(*)
FROM salaries
RIGHT JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no

--What is the average current salary by job title?
SELECT title, avg (salary)
from titles
JOIN salaries on titles.emp_no = salaries.emp_no
GROUP BY title;

--What is the average current salary grouped by gender?
SELECT gender, avg(salary)
from employees
JOIN salaries on employees.emp_no = salaries.emp_no
group by gender;

--What is the average salary grouped by department and gender?
SELECT AVG(salary), gender , dept_name
FROM salaries
JOIN employees on salaries.emp_no = employees.emp_no
join dept_emp on salaries.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
GROUP BY gender , dept_name

--Get the current employees' names and IDs and increase their salary by 5%.
SELECT salaries.emp_no, first_name, last_name, salary, salary * 1.05 salary_inc
FROM salaries
JOIN employees on salaries.emp_no = employees.emp_no
WHERE to_date IS NULL
LIMIT 10


SELECT *
FROM employees
WHERE (first_name = "Breannda" OR first_name ="Brendon") AND gender="F"


