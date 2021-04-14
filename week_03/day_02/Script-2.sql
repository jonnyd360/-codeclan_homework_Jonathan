/*"“Find the number of employees within each department of the corporation.”*/

SELECT 
department,
COUNT(id) AS num_employees
FROM employees 
GROUP BY department;

/*“How many employees are there in each country?”*/

SELECT 
	country,
	COUNT(id) AS num_employees
FROM employees 
GROUP BY country 
ORDER BY num_employees DESC;

/* “How many employees in each department work either 0.25 or 0.5 FTE hours?”*/

explain analyze 
SELECT
	department,
	COUNT(id) AS num_employees
FROM employees 
WHERE fte_hours IN (0.25,0.5)
GROUP BY department;

/*“Find the longest time served by any one employee in each department.”*/

SELECT 
	department,
	EXTRACT (DAY FROM NOW() - MIN(start_date)) AS days_served,
	ROUND(EXTRACT (DAY FROM NOW() - MIN(start_date))/365) AS years_served
FROM employees
GROUP BY department;

/*"How many employees in each department are enrolled in the pension scheme?”*/

select *
froM employees 

SELECT
	department,
	COUNT(ID) AS number_enrolled_in_pension
FROM employees 
WHERE pension_enrol IS true 
and pension_enrol is not null
GROUP BY department
ORDER BY number_enrolled_in_pension DESC;

/*“Perform a breakdown by country of the number of employees that do not have a stored first name.”*/

SELECT
	country,
	COUNT(ID) AS missing_first_name
FROM employees
WHERE first_name is null
GROUP BY country
ORDER BY missing_first_name desc;

select
	department,
	COUnT(id) AS num_employees
from employees
where fte_hours IN (0.25,.5)
GROUP BY department 
HAVING count(id) >= 40;

select 
	country,
	MIN(salary) AS min_salary
FROM employees 
WHERE pension_enrol = true 
group by country 
HAVING MIN(salary) < 21000;

/*“Show any departments in which the earliest start date amongst grade 1 employees is prior to 1991” */

select *
from employees 

select
	department,
	grade,
	start_date
from employees
group by departments
WHERE grade = 1
having (EXTRACT(YEAR FROM start_date)) < 1991;

SELECT
department,
MIN(start_date) as earliest_start_date
FROM employees 
WHERE grade = 1
GROUP BY department
HAVING MIN(start_date) < '1991-01-01';

/*“Find all the employees in Japan who earn over the company-wide average salary.”*/

select *
from employees 
where country  = 'Japan'
	and salary > (
		select
			AVG(salary)
		FROM employees);

/*Find all the employees in Legal who earn less than the mean salary in that same department.*/
	
select *
from employees 
where department = 'Legal'
	and salary >(
		select 
			avg(salary)
		from employees);
	
/*Write a query to find the most common full-time equivalent hours across the corporation
	Use this in a subequery to find those employees in the United States who work those hours*/
	
Select *
FROM employees 
where country = 'United States'
	and fte_hours >= (
		select 
			avg(fte_hours)
		from employees);

SELECT
	fte_hours,
	COUNT(id) AS num_employees
FROM employees 
GROUP BY fte_hours
ORDER BY count(id) Desc



	
