SELECT *
FROM animals
INNER JOIN diets
ON diets.id = animals.diet_id;

SELECT 
	animals.*,
	diets.diet_type
FROM animals
INNER JOIN diets
ON diets.id = animals.diet_id;

SELECT 
	a.*,
	d.diet_type
FROM animals As a
INNER JOIN diets AS d
ON d.id = a.diet_id
WHERE a.age > 4;

SELECT
	d.diet_type,
	COUNT(a.id)
FROM animals AS a
INNER JOIN diets AS d
ON d.id = a.diet_id
GROUP BY d.diet_type;


SELECT
	a.*,
	d.diet_type
FROM animals AS a
INNER JOIN diets AS d
ON d.id = a.diet_id
WHERE  d.diet_type = 'herbivore';

SELECT
	*
FROM animals AS a 
LEFT JOIN diets AS d
ON d.id = a.diet_id;


SELECT
	*
FROM animals AS a 
RIGHT JOIN diets AS d
ON d.id = a.diet_id;


SELECT 
	d.diet_type,
	COUNT(a.id)
FROM diets AS d
LEFT JOIN animals AS a
ON d.id = a.diet_id
GROUP BY d.diet_type ;

SELECT 
		d.diet_type,
		COUNT(a.id)
FROM animals AS a
LEFT JOIN diets AS d
ON d.id = a.diet_id
GROUP BY d.diet_type ;

SELECT
*
FROM animals AS a 
FULL OUTER JOIN diets AS d 
ON a.diet_id = d.id;


/*Two step joint*/

SELECT *
FROM animals AS a 
INNER JOIN care_schedule AS cs
ON a.id = cs.animal_id;

SELECT *
FROM (animals AS a 
INNER JOIN care_schedule AS cs
ON a.id = cs.animal_id)
INNER JOIN keepers AS K
ON cs.keeper_id = k.id
WHERE a.name = 'Ernest';

SELECT *
FROM animals AS a
INNER JOIN animals_tours AS at
ON a.id = at.animal_id;


SELECT 
	a.name AS animal_name,
	a.species,
	t.name AS tour_name,
	at.start_date,
	at.end_date
FROM 
	(animals AS a
	INNER JOIN animals_tours AS at
	ON a.id = at.animal_id)
LEFT JOIN tours as t
ON at.tour_id = t.id
WHERE at.start_date <= NOW() AND 
	(at.end_date IS NULL OR at.end_date >= NOW())
ORDER BY t.name, a.name;