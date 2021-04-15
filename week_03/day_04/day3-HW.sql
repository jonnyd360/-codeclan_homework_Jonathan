/*Question 1.
Are there any pay_details records lacking both a local_account_no and iban number?*/

SELECT
*
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL;

/*Question 2.
Get a table of employees first_name, last_name and country, ordered alphabetically first by country and then by last_name (put any NULLs last).*/

SELECT
last_name,
country,
first_name
FROM employees
ORDER BY country, last_name;

/*Question 3.
Find the details of the top ten highest paid employees in the corporation.*/

SELECT
last_name,
salary
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;

/*Question 4.
Find the first_name, last_name and salary of the lowest paid employee in Hungary*/

SELECT
first_name,
last_name,
salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST;

/*Question 5.
Find all the details of any employees with a 'yahoo' email address?*/

SELECT
first_name,
last_name
FROM employees
WHERE email LIKE '%@yahoo%';

/*Question 6.
Obtain a count by department of the employees who started work with the corporation in 2003.*/

SELECT *
FROM employees;

SELECT 
	department,
	COUNT(id)
FROM employees
WHERE EXTRACT(YEAR FROM start_date) > 2003
GROUP BY department;

/*Question 7.
Obtain a table showing department, fte_hours and the number of employees in each department who work each fte_hours pattern. 
Order the table alphabetically by department, and then in ascending order of fte_hours.*/

SELECT 
	department,
	fte_hours,
	COUNT(id)
FROM employees 
GROUP BY department, fte_hours;

/*
Question 8.
Provide a breakdown of the numbers of employees enrolled, 
not enrolled, and with unknown enrollment status in the corporation pension scheme.*/

SELECT 
	pension_enrol,
	COUNT (id) AS number_of_employees
FROM employees
GROUP BY pension_enrol;

/* Question 9.
What is the maximum salary among those employees in the ‘Engineering’ department who work 1.0 full-time equivalent hours (fte_hours)?*/

SELECT
	salary AS max_salary
FROM employees
WHERE department = 'Engineering'
AND fte_hours = 1
ORDER BY salary DESC
LIMIT 1;

/*Question 10.
Get a table of country, number of employees in that country,
and the average salary of employees in that country for any countries in which more than 30 employees are based. 
Order the table by average salary descending.*/

SELECT
	country,
	COUNT(id) AS number_of_employees,
	ROUND(avg(salary)) AS average_salary
FROM employees
GROUP BY country
ORDER BY ROUND(avg(salary)) DESC 
NULLS LAST;

/*Question 11.
Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), 
salary, and a new column effective_yearly_salary which should contain fte_hours multiplied by salary.*/

SELECT
	first_name,
	last_name,
	fte_hours,
	salary,
	ROUND(fte_hours*salary) AS effective_yearly_salary
FROM employees;

/*Question 12.
Find the first name and last name of all employees who lack a local_tax_code.*/

SELECT 
	e.first_name,
	e.last_name,
	pd.local_tax_code
FROM employees AS e
LEFT JOIN pay_details AS pd
ON e.id = pd.id
WHERE pd.local_tax_code IS NULL;

/*Question 13.
The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
where charge_cost depends upon the team to which the employee belongs. 
Get a table showing expected_profit for each employee.*/

SELECT
	e.first_name,
	e.last_name,
	t.charge_cost,
	e.salary,
	e.fte_hours,
	ROUND ((48 * 35 * cast(t.charge_cost AS INT) - e.salary) * e.fte_hours) AS expected_profits
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id;

/*Question 14.
Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
Order the table in descending order of the number of employees lacking a first name, 
and then in alphabetical order by department.*/

SELECT
	department,
	COUNT(id) AS lacking_first_names
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING COUNT(id) >= 2
ORDER BY COUNT(id) DESC;

/*Question 15.
[Bit Tougher] Return a table of those employee first_names shared by more than one employee, 
together with a count of the number of times each first_name occurs. 
Omit employees without a stored first_name from the table. Order the table descending by count, 
and then alphabetically by first_name.*/

SELECT 
	first_name,
	COUNT(id)
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING COUNT(id) > 1
ORDER BY COUNT(id);

/*Question 16.
[Tough] Find the proportion of employees in each department who are grade 1.*/

WITH total_emp AS(
	SELECT
		department
		COUNT(id) AS total_emp_count
	FROM employees
	GROUP BY department
)
SELECT
	grade,
	e.COUNT(id) AS number_employees,
	ROUND(e.COUNT(id)/te.total_emp_count) AS proportion
FROM employees AS e
LEFT JOIN total_emp AS te
ON e.grade = 
WHERE grade = 1
GROUP BY grade;


---
WITH total_emp AS(
	SELECT
		department,
		COUNT(id) AS total_emp_count
	FROM employees
	GROUP BY department
)
SELECT
	e.department,
	COUNT(id) AS number_employees,
	e.grade,
	te.total_emp_count,
	CAST(COUNT(id) AS REAL)/CAST(te.total_emp_count AS REAL) AS proportion
FROM employees AS e
INNER JOIN total_emp as te
ON e.department = te.department
WHERE grade =1
GROUP BY e.department, grade, te.total_emp_count;