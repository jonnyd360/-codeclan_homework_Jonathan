/*Q10
a). Find the first name, last name and team name of employees who are members of teams.*/

SELECT 
	e.first_name,
	e.last_name,
	t.name
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id; 

/*b)Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.*/

SELECT 
	e.first_name,
	e.last_name,
	t.name
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE e.pension_enrol = TRUE;

/*c). Find the first name, last name and team name of employees who are members of teams, 
 where their team has a charge cost greater than 80.*/

SELECT 
	e.first_name,
	e.last_name,
	t.name
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE CAST(t.charge_cost AS INT) > 80
GROUP BY t.name, e.first_name, e.last_name;

/*a). Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.*/

SELECT 
	e.*,
	p.local_account_no,
	p.local_sort_code
FROM employees AS e
LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;

/*). Amend your query above to also return the name of the team that each employee belongs to.*/

SELECT
	e.first_name,
	e.last_name,
	t.name,
	p.local_account_no,
	p.local_sort_code
FROM 
	(employees AS e
	INNER JOIN teams AS t
	ON e.team_id = t.id)
LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;


/*Q3 a) Make a table, which has each employee id along with the team that employee belongs to.*/

SELECT 
	e.id AS employee_id,
	t.name
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id;

/*(b). Breakdown the number of employees in each of the teams.*/

Select
	t.name,
	count(e.id)	
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name;

/*Order the table above by so that the teams with the least employees come first.*/

Select
	t.name,
	count(e.id) AS number_of_employees
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name
ORDER BY number_of_employees DESC;

/*Q4) a). Create a table with the team id, team name and the count of the number of employees in each team.*/

SELECT
	e.team_id,
	t.name,
	COUNT(e.id) as total_employees
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY e.team_id, t.name;

/*(b). The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. 
 * Calculate the total_day_charge for each team.*/

SELECT
	e.team_id,
	t.name,
	t.charge_cost,
	COUNT(e.id) AS total_employees,
	CAST(t.charge_cost AS INT) * COUNT(e.id) AS total_day_charge
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY e.team_id, t.name, t.charge_cost;

/*c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000?*/
SELECT *
FROM (SELECT
	e.team_id,
	t.name,
	t.charge_cost,
	COUNT(e.id) AS total_employees,
	CAST(t.charge_cost AS INT) * COUNT(e.id) AS total_cost
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY e.team_id, t.name, t.charge_cost) AS tc
WHERE tc.total_cost > 5000;

/*Q5) How many of the employees serve on one or more committees?*/

SELECT * 
	
