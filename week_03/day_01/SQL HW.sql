/*MVP*/
/*Q1) Find all the employees who work in the ‘Human Resources’ department.*/

SELECT *
FROM employees 
WHERE department = 'Human Resources';

/*Q2) Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.*/

SELECT
first_name,
last_name,
country
FROM employees 
WHERE department  = 'Legal';

/*Q3) Count the number of employees based in Portugal. */

SELECT
COUNT(*) AS number_of_portugese_employees
FROM employees 
WHERE country = 'Portugal';

/*Q4) Count the number of employees based in either Portugal or Spain. */

SELECT
COUNT(*) AS number_of_portugese_spanish_employees
FROM employees
WHERE country = 'Portugal' or country = 'Spain';

/*Q5) Count the number of pay_details records lacking a local_account_no.*/

SELECT *
FROM pay_details;

SELECT
COUNT(*) record_missing_account_no
FROM pay_details
WHERE local_account_no IS NULL;

/*Q6) Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last). */

SELECT 
first_name,
last_name
FROM employees
ORDER BY last_name NULLS LAST;

/*Q7) How many employees have a first_name beginning with ‘F’? */

SELECT
COUNT(*) first_name_beginning_with_f
FROM employees 
WHERE first_name ilike 'F%';

/*Q8) Count the number of pension enrolled employees not based in either France or Germany. */


SELECT *
FROM employees;

SELECT 
COUNT(*) number_of_pension_enrolled_employees
FROM employees
WHERE pension_enrol is true;


/* Extension Questions */

/*Q9)The corporation wants to make name badges for a forthcoming conference. Return a column badge_label showing employees’ first_name and last_name joined together with their department in the following style: ‘Bob Smith - Legal’. Restrict output to only those employees with stored first_name, last_name and department. */

SELECT
first_name,
last_name,
department,
CONCAT(first_name, ' ', last_name, '-', department) 
FROM employees 
WHERE first_name IS NOT NULL
AND last_name IS NOT NULL
AND department IS NOT NULL;

/*Q10) One of the conference organisers thinks it would be nice to add the year of the employees’ start_date to the badge_label to celebrate long-standing colleagues, in the following style ‘Bob Smith - Legal (joined 1998)’. Further restrict output to only those employees with a stored start_date.*/

SELECT
first_name,
last_name,
department,
CONCAT(first_name, ' ', last_name, '-', department, ' (joined ', start_date, ')') 
FROM employees 
WHERE first_name IS NOT NULL
AND last_name IS NOT NULL
AND department IS NOT NULL
AND start_date IS NOT NULL;


