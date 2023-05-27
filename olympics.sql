-- 1 Mostrar la lista de los ganadores de medalla de oro en eventos de Futbol, Baloncesto y Golf
-- SQL SERVER
SELECT * FROM olympics.dbo.[event] e 
INNER JOIN olympics.dbo.competitor_event ce
ON e.id = ce.event_id
INNER JOIN olympics.dbo.medal m 
ON m.id = ce.medal_id
WHERE m.medal_name = 'Gold' AND e.event_name IN ('Futbol', 'Baloncesto', 'Golf'); 

-- MYSQL
SELECT * FROM olympics.event e 
INNER JOIN olympics.competitor_event ce
ON e.id = ce.event_id
INNER JOIN olympics.medal m 
ON m.id = ce.medal_id
WHERE m.medal_name = 'Gold' AND e.event_name IN ('Futbol', 'Baloncesto', 'Golf');

-- POSTGRES
SELECT * FROM olympics.event e 
INNER JOIN olympics.competitor_event ce
ON e.id = ce.event_id
INNER JOIN olympics.medal m 
ON m.id = ce.medal_id
WHERE m.medal_name = 'Gold' AND e.event_name IN ('Futbol', 'Baloncesto', 'Golf');

-- ORACLE
SELECT * FROM "EVENT" e 
INNER JOIN competitor_event ce
ON e.id = ce.event_id
INNER JOIN medal m 
ON m.id = ce.medal_id
WHERE m.medal_name = 'Gold' AND e.event_name IN ('Futbol', 'Baloncesto', 'Golf');

-- 2 Cuales son los eventos que se jugaron en el año 2000
-- SQL SERVER
SELECT e.event_name FROM olympics.dbo.games g
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.games_id = g.id 
INNER JOIN olympics.dbo.competitor_event ce
ON ce.competitor_id = gc.id 
INNER JOIN olympics.dbo.[event] e 
ON e.id = ce.event_id
WHERE g.games_year = 2000;

-- MYSQL
SELECT e.event_name FROM olympics.games g
INNER JOIN olympics.games_competitor gc 
ON gc.games_id = g.id 
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id 
INNER JOIN olympics.event e 
ON e.id = ce.event_id
WHERE g.games_year = 2000;

-- POSTGRES
SELECT e.event_name FROM olympics.games g
INNER JOIN olympics.games_competitor gc 
ON gc.games_id = g.id 
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id 
INNER JOIN olympics.event e 
ON e.id = ce.event_id
WHERE g.games_year = 2000;

-- ORACLE
SELECT e.event_name FROM games g
INNER JOIN games_competitor gc 
ON gc.games_id = g.id 
INNER JOIN competitor_event ce
ON ce.competitor_id = gc.id 
INNER JOIN "EVENT" e 
ON e.id = ce.event_id
WHERE g.games_year = 2000;

-- 3 Cuales son las 20 principales ciudades donde se han jugado mas Olimpiadas
-- SQL SERVER
SELECT TOP 20 c.city_name, COUNT(gc.games_id) FROM olympics.dbo.games_city gc 
INNER JOIN olympics.dbo.city c 
ON c.id = gc.city_id 
GROUP BY c.city_name 
ORDER BY COUNT(gc.games_id) DESC;

-- MYSQL
SELECT c.city_name, COUNT(gc.games_id) FROM olympics.games_city gc 
INNER JOIN olympics.city c 
ON c.id = gc.city_id 
GROUP BY c.city_name 
ORDER BY COUNT(gc.games_id) DESC LIMIT 20;

-- POSTGRES
SELECT c.city_name, COUNT(gc.games_id) FROM olympics.games_city gc 
INNER JOIN olympics.city c 
ON c.id = gc.city_id 
GROUP BY c.city_name 
ORDER BY COUNT(gc.games_id) DESC LIMIT 20;

-- ORACLE
SELECT c.city_name, COUNT(gc.games_id) FROM games_city gc 
INNER JOIN city c 
ON c.id = gc.city_id 
GROUP BY c.city_name 
ORDER BY COUNT(gc.games_id) DESC FETCH FIRST 20 ROWS ONLY;

-- 4 Liste los paises no tienen ningun participante en las ultimas 10 olimpiadas
-- SQL SERVER
SELECT TOP 10 nr.region_name FROM olympics.dbo.noc_region nr 
INNER JOIN olympics.dbo.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.dbo.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id  = p.id
LEFT JOIN olympics.dbo.games g
ON g.id = gc.games_id
WHERE g.games_year IS NULL;

-- MYSQL
SELECT nr.region_name FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
LEFT JOIN olympics.games g
ON g.id = gc.games_id
WHERE g.games_year IS NULL LIMIT 10;

-- POSTGRES
SELECT nr.region_name FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
LEFT JOIN olympics.games g
ON g.id = gc.games_id
WHERE g.games_year IS NULL LIMIT 10;

-- ORACLE
SELECT nr.region_name FROM noc_region nr 
INNER JOIN person_region pr 
ON pr.region_id = nr.id 
INNER JOIN person p 
ON p.id = pr.person_id 
INNER JOIN games_competitor gc 
ON gc.person_id  = p.id
LEFT JOIN games g
ON g.id = gc.games_id
WHERE g.games_year IS NULL FETCH FIRST 10 ROWS ONLY;

-- 5 liste los 5 paises que mas ganan medallas de oro, plata y bronce
-- SQL SERVER
SELECT TOP 5 nr.region_name, COUNT(ce.event_id) FROM olympics.dbo.noc_region nr 
INNER JOIN olympics.dbo.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.dbo.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.dbo.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.dbo.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Gold'
GROUP BY nr.region_name ;

SELECT TOP 5 nr.region_name, COUNT(ce.event_id) FROM olympics.dbo.noc_region nr 
INNER JOIN olympics.dbo.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.dbo.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.dbo.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.dbo.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Silver'
GROUP BY nr.region_name ;

SELECT TOP 5 nr.region_name, COUNT(ce.event_id) FROM olympics.dbo.noc_region nr 
INNER JOIN olympics.dbo.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.dbo.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.dbo.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.dbo.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Bronze'
GROUP BY nr.region_name ;

-- MYSQL
SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Gold'
GROUP BY nr.region_name LIMIT 5;

SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Silver'
GROUP BY nr.region_name LIMIT 5;

SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Bronze'
GROUP BY nr.region_name LIMIT 5;

-- POSTGRES
SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Gold'
GROUP BY nr.region_name LIMIT 5;

SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Silver'
GROUP BY nr.region_name LIMIT 5;

SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Bronze'
GROUP BY nr.region_name LIMIT 5;

-- ORACLE
SELECT nr.region_name, COUNT(ce.event_id) FROM noc_region nr 
INNER JOIN person_region pr 
ON pr.region_id = nr.id 
INNER JOIN person p 
ON p.id = pr.person_id 
INNER JOIN games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Gold'
GROUP BY nr.region_name FETCH FIRST 5 ROWS ONLY;

SELECT nr.region_name, COUNT(ce.event_id) FROM noc_region nr 
INNER JOIN person_region pr 
ON pr.region_id = nr.id 
INNER JOIN person p 
ON p.id = pr.person_id 
INNER JOIN games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Silver'
GROUP BY nr.region_name FETCH FIRST 5 ROWS ONLY;

SELECT nr.region_name, COUNT(ce.event_id) FROM noc_region nr 
INNER JOIN person_region pr 
ON pr.region_id = nr.id 
INNER JOIN person p 
ON p.id = pr.person_id 
INNER JOIN games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Bronze'
GROUP BY nr.region_name FETCH FIRST 5 ROWS ONLY;

-- 6 El evento con mayor cantidad de personas participando
-- SQL SERVER
SELECT MAX(e.event_name) FROM olympics.dbo.[event] e 
INNER JOIN olympics.dbo.competitor_event ce 
ON ce.event_id = e.id ;

-- MYSQL
SELECT MAX(e.event_name) FROM olympics.event e 
INNER JOIN olympics.competitor_event ce 
ON ce.event_id = e.id ;

-- POSTGRES
SELECT MAX(e.event_name) FROM olympics.event e 
INNER JOIN olympics.competitor_event ce 
ON ce.event_id = e.id ;

-- ORACLE
SELECT MAX(e.event_name) FROM "EVENT" e 
INNER JOIN olympics.competitor_event ce 
ON ce.event_id = e.id ;

-- IMPOSIBLE
-- 7 Liste los deportes que en todas las olimpiadas siempre se llevan a cabo
SELECT * FROM olympics.dbo.sport s 
INNER JOIN olympics.dbo.event e 
ON e.sport_id = s.id 
INNER JOIN olympics.dbo.competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN olympics.dbo.games g ;

-- 8 Muestre la comparacion de la cantidad de veces entre los dos generos(M,F) que ganado medallas de cualquier tipo
-- SQL SERVER
SELECT m.medal_name, p.gender, COUNT(ce.event_id) FROM olympics.dbo.person p 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.person_id = p.id 
INNER JOIN olympics.dbo.ceompetitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.dbo.medal m 
GROUP BY m.medal_name, p.gender ;

-- MYSQL
SELECT m.medal_name, p.gender, COUNT(ce.event_id) FROM olympics.person p 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id = p.id 
INNER JOIN olympics.ceompetitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
GROUP BY m.medal_name, p.gender ;

-- POSTGRES
SELECT m.medal_name, p.gender, COUNT(ce.event_id) FROM olympics.person p 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id = p.id 
INNER JOIN olympics.ceompetitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
GROUP BY m.medal_name, p.gender ;

-- ORACLE
SELECT m.medal_name, p.gender, COUNT(ce.event_id) FROM person p 
INNER JOIN games_competitor gc 
ON gc.person_id = p.id 
INNER JOIN ceompetitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN medal m 
GROUP BY m.medal_name, p.gender ;

-- 9 Cual es la altura y peso que mas es mas frecuente en los participantes del deporte de Boxeo
-- SQL SERVER
SELECT MAX(p.height) AS altura, MAX(p.weight) AS peso FROM olympics.dbo.sport s 
INNER JOIN olympics.dbo.event e 
ON e.sport_id = s.id 
INNER JOIN olympics.dbo.competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN olympics.dbo.games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN olympics.dbo.person p 
ON gc.person_id = p.id 
WHERE s.sport_name = 'Boxeo';

-- MYSQL
SELECT MAX(p.height) AS altura, MAX(p.weight) AS peso FROM olympics.sport s 
INNER JOIN olympics.event e 
ON e.sport_id = s.id 
INNER JOIN olympics.competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN olympics.games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN olympics.person p 
ON gc.person_id = p.id 
WHERE s.sport_name = 'Boxeo';

-- POSTGRES
SELECT MAX(p.height) AS altura, MAX(p.weight) AS peso FROM olympics.sport s 
INNER JOIN olympics.event e 
ON e.sport_id = s.id 
INNER JOIN olympics.competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN olympics.games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN olympics.person p 
ON gc.person_id = p.id 
WHERE s.sport_name = 'Boxeo';

-- ORACLE
SELECT MAX(p.height) AS altura, MAX(p.weight) AS peso FROM sport s 
INNER JOIN "EVENT" e 
ON e.sport_id = s.id 
INNER JOIN competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN person p 
ON gc.person_id = p.id 
WHERE s.sport_name = 'Boxeo';

-- 10 Muestre los participantes menores de edad que participan en las olimpiadas
-- SQL SERVER
SELECT p.full_name, gc.age FROM olympics.dbo.games_competitor gc 
INNER JOIN olympics.dbo.person p 
ON p.id = gc.person_id 
WHERE gc.age < 18;

-- MYSQL
SELECT p.full_name, gc.age FROM olympics.games_competitor gc 
INNER JOIN olympics.person p 
ON p.id = gc.person_id 
WHERE gc.age < 18;

-- POSTGRES
SELECT p.full_name, gc.age FROM olympics.games_competitor gc 
INNER JOIN olympics.person p 
ON p.id = gc.person_id 
WHERE gc.age < 18;

--ORACLE
SELECT p.full_name, gc.age FROM games_competitor gc 
INNER JOIN person p 
ON p.id = gc.person_id 
WHERE gc.age < 18;
