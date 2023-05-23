-- 1 Realizar una consulta donde pueda obtener los paises donde estan ubicadas cada universidad.
-- SQL SERVER OMAR MEZA 62111372
SELECT u.university_name, c.country_name FROM universities.dbo.university u 
INNER JOIN universities.dbo.country c ON u.country_id = c.id;

-- MYSQL
SELECT u.university_name, c.country_name FROM universities.university u 
INNER JOIN universities.country c ON u.country_id = c.id;

-- POSTGRES
SELECT u.university_name, c.country_name FROM universities.university u 
INNER JOIN universities.country c ON u.country_id = c.id;

-- ORACLE
SELECT u.university_name, c.country_name FROM university u
INNER JOIN country c ON u.country_id = c.id;

-- 2 Conocer cuantas universidades hay en cada pais.
-- SQL SERVER
SELECT COUNT(c.id) AS amount_universities, c.country_name 
FROM universities.dbo.country c 
INNER JOIN universities.dbo.university u 
ON c.id = u.country_id
GROUP BY c.country_name
ORDER BY COUNT(c.id) DESC;

-- MYSQL
SELECT COUNT(c.id) AS amount_universities, c.country_name 
FROM universities.country c 
INNER JOIN universities.university u 
ON c.id = u.country_id 
GROUP BY c.country_name 
ORDER BY COUNT(c.id) DESC;

-- POSTGRES
SELECT COUNT(c.id) AS amount_universities, c.country_name 
FROM universities.country c 
INNER JOIN universities.university u 
ON c.id = u.country_id 
GROUP BY c.country_name 
ORDER BY COUNT(c.id) DESC;

-- ORACLE
SELECT COUNT(c.id) AS amount_universities, c.country_name 
FROM country c 
INNER JOIN university u 
ON c.id = u.country_id 
GROUP BY c.country_name 
ORDER BY COUNT(c.id) DESC;

-- 3 Conocer cuantos paises no tienen universidades en el ranking.
-- SQL SERVER
SELECT COUNT(c.id) AS countries_with_no_ranking_university 
FROM universities.dbo.country c WHERE c.id NOT IN (
	SELECT DISTINCT u.country_id FROM universities.dbo.university u 
	INNER JOIN universities.dbo.university_ranking_year ury 
	ON ury.university_id = u.id
);

-- MYSQL
SELECT COUNT(c.id) AS countries_with_no_ranking_university 
FROM universities.country c WHERE c.id NOT IN (
	SELECT DISTINCT u.country_id FROM universities.university u 
	INNER JOIN universities.university_ranking_year ury 
	ON ury.university_id = u.id
);

-- POSTGRES
SELECT COUNT(c.id) AS countries_with_no_ranking_university 
FROM universities.country c WHERE c.id NOT IN (
	SELECT DISTINCT u.country_id FROM universities.university u 
	INNER JOIN universities.university_ranking_year ury 
	ON ury.university_id = u.id
);

-- ORACLE
SELECT COUNT(c.id) AS countries_with_no_ranking_university 
FROM country c WHERE c.id NOT IN (
	SELECT DISTINCT u.country_id FROM university u 
	INNER JOIN university_ranking_year ury 
	ON ury.university_id = u.id
);

-- 4 Mostrar los criterios de cada tipo de ranking.
-- SQL SERVER
SELECT rs.system_name, rc.criteria_name FROM universities.dbo.ranking_criteria rc 
INNER JOIN universities.dbo.ranking_system rs 
ON rc.ranking_system_id = rs.id;

-- MYSQL
SELECT rs.system_name, rc.criteria_name FROM universities.ranking_criteria rc 
INNER JOIN universities.ranking_system rs 
ON rc.ranking_system_id = rs.id;

-- POSTGRES
SELECT rs.system_name, rc.criteria_name FROM universities.ranking_criteria rc 
INNER JOIN universities.ranking_system rs 
ON rc.ranking_system_id = rs.id;

-- ORACLE
SELECT rs.system_name, rc.criteria_name FROM ranking_criteria rc 
INNER JOIN ranking_system rs 
ON rc.ranking_system_id = rs.id;

-- 5 Conocer el ranking que tiene mas criterios
-- SQL SERVER
SELECT rs.system_name FROM universities.dbo.ranking_system rs WHERE id = (
	SELECT MAX(ranking_system_id) FROM universities.dbo.ranking_criteria rc 
);

-- MYSQL
SELECT rs.system_name FROM universities.ranking_system rs WHERE id = (
	SELECT MAX(ranking_system_id) FROM universities.ranking_criteria rc 
);

-- POSTGRES
SELECT rs.system_name FROM universities.ranking_system rs WHERE id = (
	SELECT MAX(ranking_system_id) FROM universities.ranking_criteria rc 
);

-- ORACLE 
SELECT rs.system_name FROM ranking_system rs WHERE id = (
	SELECT MAX(ranking_system_id) FROM ranking_criteria rc 
);

-- 6 Cual es el top de universidades de forma descendente del ano 2012 por cada criterio
-- SQL SERVER
SELECT u.university_name, rc.criteria_name , ury.[year] FROM universities.dbo.university_ranking_year ury 
INNER JOIN universities.dbo.university u 
ON u.id = ury.university_id 
INNER JOIN universities.dbo.ranking_criteria rc 
ON ury.ranking_criteria_id = rc.id
WHERE ury.[year] <= 2012
ORDER BY ury.[year] DESC;

-- MYSQL
SELECT u.university_name, rc.criteria_name, ury.`year` FROM universities.university_ranking_year ury 
INNER JOIN universities.university u 
ON u.id = ury.university_id 
INNER JOIN universities.ranking_criteria rc 
ON ury.ranking_criteria_id = rc.id
WHERE ury.`year`  <= 2012
ORDER BY ury.`year` DESC;

-- POSTGRES
SELECT u.university_name, rc.criteria_name, ury.`year` FROM universities.university_ranking_year ury 
INNER JOIN universities.university u 
ON u.id = ury.university_id 
INNER JOIN universities.ranking_criteria rc 
ON ury.ranking_criteria_id = rc.id
WHERE ury.`year`  <= 2012
ORDER BY ury.`year` DESC;

-- ORACLE
SELECT u.university_name, rc.criteria_name , ury."YEAR" FROM university_ranking_year ury 
INNER JOIN university u 
ON u.id = ury.university_id 
INNER JOIN ranking_criteria rc 
ON ury.ranking_criteria_id = rc.id
WHERE ury."YEAR" <= 2012
ORDER BY ury."YEAR" DESC;

-- 7 Mostrar las 5 universidad con mas cantidades de score 100 del ranking tipo 'Center for World University Rankings'
-- SQL SERVER
SELECT TOP 5 MAX(u.id), u.university_name, ury.score FROM universities.dbo.university u
INNER JOIN universities.dbo.university_ranking_year ury 
ON u.id = ury.university_id
INNER JOIN universities.dbo.ranking_criteria rc 
ON rc.id = ury.ranking_criteria_id 
INNER JOIN universities.dbo.ranking_system rs 
ON rs.id  = rc.ranking_system_id 
WHERE ury.score = 100 AND rs.system_name = 'Center for World University Rankings'
GROUP BY u.university_name, ury.score 
ORDER BY MAX(u.id) DESC;

-- MYSQL
SELECT MAX(u.id), u.university_name, ury.score FROM universities.university u
INNER JOIN universities.university_ranking_year ury 
ON u.id = ury.university_id
INNER JOIN universities.ranking_criteria rc 
ON rc.id = ury.ranking_criteria_id 
INNER JOIN universities.ranking_system rs 
ON rs.id  = rc.ranking_system_id 
WHERE ury.score = 100 AND rs.system_name = 'Center for World University Rankings'
GROUP BY u.university_name, ury.score 
ORDER BY MAX(u.id) DESC LIMIT 5;

-- POSTGRES 
SELECT MAX(u.id), u.university_name, ury.score FROM universities.university u
INNER JOIN universities.university_ranking_year ury 
ON u.id = ury.university_id
INNER JOIN universities.ranking_criteria rc 
ON rc.id = ury.ranking_criteria_id 
INNER JOIN universities.ranking_system rs 
ON rs.id  = rc.ranking_system_id 
WHERE ury.score = 100 AND rs.system_name = 'Center for World University Rankings'
GROUP BY u.university_name, ury.score 
ORDER BY MAX(u.id) DESC LIMIT 5;

-- ORACLE
SELECT MAX(u.id), u.university_name, ury.score FROM university u
INNER JOIN university_ranking_year ury 
ON u.id = ury.university_id
INNER JOIN ranking_criteria rc 
ON rc.id = ury.ranking_criteria_id 
INNER JOIN ranking_system rs 
ON rs.id  = rc.ranking_system_id 
WHERE ury.score = 100 AND rs.system_name = 'Center for World University Rankings'
GROUP BY u.university_name, ury.score 
ORDER BY MAX(u.id) DESC FETCH FIRST 5 ROWS ONLY;

-- 8 Mostrar que paises se posicionaron con universidades con un score mayor a 90
-- SQL SERVER
SELECT c.country_name FROM universities.dbo.country c 
INNER JOIN universities.dbo.university u 
ON c.id = u.country_id 
INNER JOIN universities.dbo.university_ranking_year ury 
ON u.id = ury.university_id 
WHERE ury.score > 90
GROUP BY c.country_name;

-- MYSQL
SELECT c.country_name FROM universities.country c 
INNER JOIN universities.university u 
ON c.id = u.country_id 
INNER JOIN universities.university_ranking_year ury 
ON u.id = ury.university_id 
WHERE ury.score > 90
GROUP BY c.country_name;

-- POSTGRES
SELECT c.country_name FROM universities.country c 
INNER JOIN universities.university u 
ON c.id = u.country_id 
INNER JOIN universities.university_ranking_year ury 
ON u.id = ury.university_id 
WHERE ury.score > 90
GROUP BY c.country_name;

-- ORACLE
SELECT c.country_name FROM country c 
INNER JOIN university u 
ON c.id = u.country_id 
INNER JOIN university_ranking_year ury 
ON u.id = ury.university_id 
WHERE ury.score > 90
GROUP BY c.country_name;

-- 9 Mostrar las universidades que utilizan los criterios del tipo ranking 'Shangai Ranking'
-- SQL SERVER
SELECT u.university_name FROM universities.dbo.university u 
INNER JOIN universities.dbo.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.dbo.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.dbo.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Shanghai Ranking'
GROUP BY u.university_name;

-- MYSQL
SELECT u.university_name FROM universities.university u 
INNER JOIN universities.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Shanghai Ranking'
GROUP BY u.university_name;

-- POSTGRES
SELECT u.university_name FROM universities.university u 
INNER JOIN universities.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Shanghai Ranking'
GROUP BY u.university_name;

-- ORACLE
SELECT u.university_name FROM university u 
INNER JOIN university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Shanghai Ranking'
GROUP BY u.university_name;


-- 10 Mostrar el top 10 de las peores posiciones del tipo ranking 'Times Higher....'
-- SQL SERVER
SELECT TOP 10 u.university_name, ury.score, rs.system_name FROM universities.dbo.university u 
INNER JOIN universities.dbo.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.dbo.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.dbo.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Times Higher Education World University Ranking' AND ury.score >= 0
ORDER BY ury.score ASC;

-- MYSQL
SELECT u.university_name, ury.score, rs.system_name FROM universities.university u 
INNER JOIN universities.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Times Higher Education World University Ranking' AND ury.score >= 0
ORDER BY ury.score ASC LIMIT 10;

-- POSTGRES
SELECT u.university_name, ury.score, rs.system_name FROM universities.university u 
INNER JOIN universities.university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN universities.ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN universities.ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Times Higher Education World University Ranking' AND ury.score >= 0
ORDER BY ury.score ASC LIMIT 10;

-- ORACLE
SELECT u.university_name, ury.score, rs.system_name FROM university u 
INNER JOIN university_ranking_year ury 
ON ury.university_id = u.id
INNER JOIN ranking_criteria rc 
ON ury.ranking_criteria_id  = rc.id
INNER JOIN ranking_system rs 
ON rc.ranking_system_id = rs.id 
WHERE rs.system_name = 'Times Higher Education World University Ranking' AND ury.score >= 0
ORDER BY ury.score ASC fetch first 10 rows only;

