-- 1 Mostrar la lista de todas las peliculas indicando si esta en Idioma español o no
-- SQL SERVER
SELECT m.title, CASE WHEN l.language_code = 'es' THEN 'si' ELSE 'no' END AS español FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_languages ml 
ON ml.movie_id = m.movie_id 
INNER JOIN movies.dbo.[language] l 
ON l.language_id = ml.language_id ;

-- MYSQL
SELECT m.title, CASE WHEN l.language_code = 'es' THEN 'si' ELSE 'no' END AS español FROM movies.movie m 
INNER JOIN movies.movie_languages ml 
ON ml.movie_id = m.movie_id 
INNER JOIN movies.`language` l 
ON l.language_id = ml.language_id ;

-- POSTGRES
SELECT m.title, CASE WHEN l.language_code = 'es' THEN 'si' ELSE 'no' END AS español FROM movies.movie m 
INNER JOIN movies.movie_languages ml 
ON ml.movie_id = m.movie_id 
INNER JOIN movies.`language` l 
ON l.language_id = ml.language_id ;

-- ORACLE
SELECT m.title, CASE WHEN l.language_code = 'es' THEN 'si' ELSE 'no' END AS español FROM movie m 
INNER JOIN movie_languages ml 
ON ml.movie_id = m.movie_id 
INNER JOIN "LANGUAGE" l 
ON l.language_id = ml.language_id ;

--2 Mostrar el genero(drama, accion, terror, etc) de cada pelicula
-- SQL SERVER
SELECT m.title, g.genre_name FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.dbo.genre g 
ON g.genre_id = mg.genre_id ;

-- MYSQL
SELECT m.title, g.genre_name FROM movies.movie m 
INNER JOIN movies.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.genre g 
ON g.genre_id = mg.genre_id ;

-- POSTGRES
SELECT m.title, g.genre_name FROM movies.movie m 
INNER JOIN movies.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.genre g 
ON g.genre_id = mg.genre_id ;

-- ORACLE
SELECT m.title, g.genre_name FROM movie m 
INNER JOIN movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN genre g 
ON g.genre_id = mg.genre_id ;

-- 3 Cuales son las 5 compañias productoras de peliculas que tiene mayor aceptacion (votos)
-- SQL SERVER
SELECT TOP 5 SUM(m.vote_count), pc.company_name FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_company mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.dbo.production_company pc 
ON pc.company_id = mc.company_id 
GROUP BY pc.company_name 
ORDER BY SUM(m.vote_count) DESC;

-- MYSQL
SELECT SUM(m.vote_count), pc.company_name FROM movies.movie m 
INNER JOIN movies.movie_company mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.production_company pc 
ON pc.company_id = mc.company_id 
GROUP BY pc.company_name 
ORDER BY SUM(m.vote_count) DESC LIMIT 5;

-- POSTGRES
SELECT SUM(m.vote_count), pc.company_name FROM movies.movie m 
INNER JOIN movies.movie_company mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.production_company pc 
ON pc.company_id = mc.company_id 
GROUP BY pc.company_name 
ORDER BY SUM(m.vote_count) DESC LIMIT 5;

-- ORACLE
SELECT SUM(m.vote_count), pc.company_name FROM movie m 
INNER JOIN movie_company mc 
ON mc.movie_id = m.movie_id 
INNER JOIN production_company pc 
ON pc.company_id = mc.company_id 
GROUP BY pc.company_name 
ORDER BY SUM(m.vote_count) DESC FETCH FIRST 5 ROWS ONLY;

-- 4 Mostrar una lista de las personas que participan en cada pelicula
-- SQL SERVER
SELECT m.title, p.person_name  FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.dbo.person p 
ON p.person_id = mc.person_id ;

-- MYSQL
SELECT m.title, p.person_name  FROM movies.movie m 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.person p 
ON p.person_id = mc.person_id ;

-- POSTGRES
SELECT m.title, p.person_name  FROM movies.movie m 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.person p 
ON p.person_id = mc.person_id ;

-- ORACLE
SELECT m.title, p.person_name  FROM movie m 
INNER JOIN movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN person p 
ON p.person_id = mc.person_id ;

-- 5 Mostrar una lista con la cantidad de personas por departamento que cuenta cada compañia productora
-- SQL SERVER
SELECT d.department_name, COUNT(mc.movie_id) FROM movies.dbo.department d 
INNER JOIN movies.dbo.movie_crew mc 
ON d.department_id = mc.department_id 
GROUP BY d.department_name ;

-- MYSQL
SELECT d.department_name, COUNT(mc.movie_id) FROM movies.department d 
INNER JOIN movies.movie_crew mc 
ON d.department_id = mc.department_id 
GROUP BY d.department_name ;

-- POSTGRES
SELECT d.department_name, COUNT(mc.movie_id) FROM movies.department d 
INNER JOIN movies.movie_crew mc 
ON d.department_id = mc.department_id 
GROUP BY d.department_name ;

-- ORACLE
SELECT d.department_name, COUNT(mc.movie_id) FROM department d 
INNER JOIN movie_crew mc 
ON d.department_id = mc.department_id 
GROUP BY d.department_name ;

-- 6 Mostrar las peliculas en las que ha participado las personas como parte del movie_cast
-- SQL SERVER
SELECT m.title FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_cast mc 
ON mc.movie_id = m.movie_id
GROUP BY m.title ;

-- MYSQL
SELECT m.title FROM movies.movie m 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id
GROUP BY m.title ;

-- POSTGRES
SELECT m.title FROM movies.movie m 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id
GROUP BY m.title ;

-- ORACLE
SELECT m.title FROM movie m 
INNER JOIN movie_cast mc 
ON mc.movie_id = m.movie_id
GROUP BY m.title ;

-- 7 Listar los paises donde estan ubicas las compañias productoras
-- SQL SERVER
SELECT pc2.company_name, c.country_name  FROM movies.dbo.movie m 
INNER JOIN movies.dbo.production_country pc 
ON pc.movie_id = m.movie_id 
INNER JOIN movies.dbo.country c 
ON pc.country_id = c.country_id 
INNER JOIN movies.dbo.movie_company mc 
ON m.movie_id = mc.movie_id 
INNER JOIN movies.dbo.production_company pc2 
ON mc.company_id = pc2.company_id ;

-- MYSQL
SELECT pc2.company_name, c.country_name  FROM movies.movie m 
INNER JOIN movies.production_country pc 
ON pc.movie_id = m.movie_id 
INNER JOIN movies.country c 
ON pc.country_id = c.country_id 
INNER JOIN movies.movie_company mc 
ON m.movie_id = mc.movie_id 
INNER JOIN movies.production_company pc2 
ON mc.company_id = pc2.company_id ;

-- POSTGRES
SELECT pc2.company_name, c.country_name  FROM movies.movie m 
INNER JOIN movies.production_country pc 
ON pc.movie_id = m.movie_id 
INNER JOIN movies.country c 
ON pc.country_id = c.country_id 
INNER JOIN movies.movie_company mc 
ON m.movie_id = mc.movie_id 
INNER JOIN movies.production_company pc2 
ON mc.company_id = pc2.company_id ;

-- ORACLE
SELECT pc2.company_name, c.country_name  FROM movie m 
INNER JOIN production_country pc 
ON pc.movie_id = m.movie_id 
INNER JOIN country c 
ON pc.country_id = c.country_id 
INNER JOIN movie_company mc 
ON m.movie_id = mc.movie_id 
INNER JOIN production_company pc2 
ON mc.company_id = pc2.company_id ;

-- 8 Mostrar de la lista de elencos cuantas mujeres participan en una pelicula de drama
-- SQL SERVER
SELECT COUNT(g2.gender_id) AS cantidad_mujeres FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.dbo.genre g 
ON g.genre_id = mg.genre_id 
INNER JOIN movies.dbo.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.dbo.gender g2 
ON mc.gender_id = g2.gender_id 
WHERE g2.gender = 'Female' AND g.genre_name = 'Drama';

-- MYSQL
SELECT COUNT(g2.gender_id) AS cantidad_mujeres FROM movies.movie m 
INNER JOIN movies.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.genre g 
ON g.genre_id = mg.genre_id 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.gender g2 
ON mc.gender_id = g2.gender_id 
WHERE g2.gender = 'Female' AND g.genre_name = 'Drama';

-- POSTGRES
SELECT COUNT(g2.gender_id) AS cantidad_mujeres FROM movies.movie m 
INNER JOIN movies.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.genre g 
ON g.genre_id = mg.genre_id 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.gender g2 
ON mc.gender_id = g2.gender_id 
WHERE g2.gender = 'Female' AND g.genre_name = 'Drama';

-- ORACLE
SELECT COUNT(g2.gender_id) AS cantidad_mujeres FROM movie m 
INNER JOIN movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN genre g 
ON g.genre_id = mg.genre_id 
INNER JOIN movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN gender g2 
ON mc.gender_id = g2.gender_id 
WHERE g2.gender = 'Female' AND g.genre_name = 'Drama';

-- 9 Mostrar la cantidad de idiomas en los que se dobla cada pelicula
-- SQL SERVER
SELECT m.title, COUNT(ml.movie_id) FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_languages ml 
ON ml.movie_id = m.movie_id 
GROUP BY m.title;

-- MYSQL
SELECT m.title, COUNT(ml.movie_id) FROM movies.movie m 
INNER JOIN movies.movie_languages ml 
ON ml.movie_id = m.movie_id 
GROUP BY m.title;

-- POSTGRES
SELECT m.title, COUNT(ml.movie_id) FROM movies.movie m 
INNER JOIN movies.movie_languages ml 
ON ml.movie_id = m.movie_id 
GROUP BY m.title;

-- ORACLE
SELECT m.title, COUNT(ml.movie_id) FROM movie m 
INNER JOIN movie_languages ml 
ON ml.movie_id = m.movie_id 
GROUP BY m.title;

-- 10 Mostrar las 8 palabras claves mas utilizadas en las peliculas
-- SQL SERVER
SELECT TOP 8 k.keyword_name, COUNT(m.movie_id) FROM movies.dbo.movie m 
INNER JOIN movies.dbo.movie_keywords mk 
ON mk.movie_id = m.movie_id 
INNER JOIN movies.dbo.keyword k 
ON k.keyword_id = mk.keyword_id 
GROUP BY k.keyword_name 
ORDER BY COUNT(m.movie_id) DESC;

-- MYSQL
SELECT k.keyword_name, COUNT(m.movie_id) FROM movies.movie m 
INNER JOIN movies.movie_keywords mk 
ON mk.movie_id = m.movie_id 
INNER JOIN movies.keyword k 
ON k.keyword_id = mk.keyword_id 
GROUP BY k.keyword_name 
ORDER BY COUNT(m.movie_id) DESC LIMIT 8;

-- POSTGRES
SELECT k.keyword_name, COUNT(m.movie_id) FROM movies.movie m 
INNER JOIN movies.movie_keywords mk 
ON mk.movie_id = m.movie_id 
INNER JOIN movies.keyword k 
ON k.keyword_id = mk.keyword_id 
GROUP BY k.keyword_name 
ORDER BY COUNT(m.movie_id) DESC LIMIT 8;

-- ORACLE
SELECT k.keyword_name, COUNT(m.movie_id) FROM movies.movie m 
INNER JOIN movies.movie_keywords mk 
ON mk.movie_id = m.movie_id 
INNER JOIN movies.keyword k 
ON k.keyword_id = mk.keyword_id 
GROUP BY k.keyword_name 
ORDER BY COUNT(m.movie_id) DESC FETCH FIRST 8 ROW ONLY;
