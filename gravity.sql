-- 1 Mostrar una lista de los libros con el autor e idiomas del libro
-- SQL SERVER
SELECT * FROM gravity_books.dbo.book b 
INNER JOIN gravity_books.dbo.book_author ba 
ON b.book_id = ba.book_id 
INNER JOIN gravity_books.dbo.book_language bl 
ON bl.language_id = b.language_id ;

-- MYSQL
SELECT * FROM gravity_books.book b 
INNER JOIN gravity_books.book_author ba 
ON b.book_id = ba.book_id 
INNER JOIN gravity_books.book_language bl 
ON bl.language_id = b.language_id ;

-- POSTGRES
SELECT * FROM gravity_books.book b 
INNER JOIN gravity_books.book_author ba 
ON b.book_id = ba.book_id 
INNER JOIN gravity_books.book_language bl 
ON bl.language_id = b.language_id ;

-- ORACLE
SELECT * FROM book b 
INNER JOIN book_author ba 
ON b.book_id = ba.book_id 
INNER JOIN book_language bl 
ON bl.language_id = b.language_id ;

-- 2 Obtener la cantidad de compras que ha realizado un cliente
-- SQL SERVER
SELECT c.customer_id, c.first_name, COUNT(co.order_id) AS compras FROM gravity_books.dbo.customer c 
INNER JOIN gravity_books.dbo.cust_order co 
ON c.customer_id = co.customer_id 
GROUP BY c.customer_id, c.first_name ;

-- MYSQL
SELECT c.customer_id, c.first_name, COUNT(co.order_id) AS compras FROM gravity_books.customer c 
INNER JOIN gravity_books.cust_order co 
ON c.customer_id = co.customer_id 
GROUP BY c.customer_id, c.first_name ;

-- POSTGRES
SELECT c.customer_id, c.first_name, COUNT(co.order_id) AS compras FROM gravity_books.customer c 
INNER JOIN gravity_books.cust_order co 
ON c.customer_id = co.customer_id 
GROUP BY c.customer_id, c.first_name ;

-- ORACLE
SELECT c.customer_id, c.first_name, COUNT(co.order_id) AS compras FROM customer c 
INNER JOIN cust_order co 
ON c.customer_id = co.customer_id 
GROUP BY c.customer_id, c.first_name ;

-- 3 Listar los 5 libros mas vendidos
-- SQL SERVER
SELECT TOP 5 b.title, COUNT(ol.order_id) FROM gravity_books.dbo.order_line ol 
INNER JOIN gravity_books.dbo.book b 
ON b.book_id = ol.book_id 
GROUP BY b.title
ORDER BY COUNT(ol.order_id) DESC;

-- MYSQL
SELECT b.title, COUNT(ol.order_id) FROM gravity_books.order_line ol 
INNER JOIN gravity_books.book b 
ON b.book_id = ol.book_id 
GROUP BY b.title
ORDER BY COUNT(ol.order_id) DESC LIMIT 5;

-- POSTGRES
SELECT b.title, COUNT(ol.order_id) FROM gravity_books.order_line ol 
INNER JOIN gravity_books.book b 
ON b.book_id = ol.book_id 
GROUP BY b.title
ORDER BY COUNT(ol.order_id) DESC LIMIT 5;

-- ORACLE
SELECT b.title, COUNT(ol.order_id) FROM order_line ol 
INNER JOIN book b 
ON b.book_id = ol.book_id 
GROUP BY b.title
ORDER BY COUNT(ol.order_id) DESC FETCH FIRST 5 ROWS ONLY;

-- 4 Mostrar los paises donde se ha utilizado el tipo de envio Express
-- SQL SERVER
SELECT * FROM gravity_books.dbo.cust_order co 
INNER JOIN gravity_books.dbo.shipping_method sm 
ON sm.method_id = co.shipping_method_id 
WHERE sm.method_name = 'Express'

-- MYSQL
SELECT * FROM gravity_books.cust_order co 
INNER JOIN gravity_books.shipping_method sm 
ON sm.method_id = co.shipping_method_id 
WHERE sm.method_name = 'Express'

-- POSTGRES
SELECT * FROM gravity_books.cust_order co 
INNER JOIN gravity_books.shipping_method sm 
ON sm.method_id = co.shipping_method_id 
WHERE sm.method_name = 'Express'

-- ORACLE
SELECT * FROM cust_order co 
INNER JOIN shipping_method sm 
ON sm.method_id = co.shipping_method_id 
WHERE sm.method_name = 'Express'

-- 5 Mostrar los libros que sus ordenes se han cancelado
-- SQL SERVER
SELECT * FROM gravity_books.dbo.order_history oh 
INNER JOIN gravity_books.dbo.order_status os 
ON oh.status_id = os.status_id 
WHERE os.status_value = 'Cancelled';

-- MYSQL
SELECT * FROM gravity_books.order_history oh 
INNER JOIN gravity_books.order_status os 
ON oh.status_id = os.status_id 
WHERE os.status_value = 'Cancelled';

-- POSTGRES
SELECT * FROM gravity_books.order_history oh 
INNER JOIN gravity_books.order_status os 
ON oh.status_id = os.status_id 
WHERE os.status_value = 'Cancelled';

-- ORACLE
SELECT * FROM order_history oh 
INNER JOIN order_status os 
ON oh.status_id = os.status_id 
WHERE os.status_value = 'Cancelled';

-- 6 Mostrar el pais donde tiene mas influencia cada autor de libro
-- SQL SERVER
SELECT a.author_name, c.country_name, COUNT(ol.order_id) FROM gravity_books.dbo.order_line ol 
INNER JOIN gravity_books.dbo.cust_order co 
ON co.order_id  = ol.order_id 
INNER JOIN gravity_books.dbo.book b 
ON b.book_id = ol.book_id 
INNER JOIN gravity_books.dbo.book_author ba 
ON ba.book_id = b.book_id 
INNER JOIN gravity_books.dbo.author a 
ON a.author_id = ba.author_id 
INNER JOIN gravity_books.dbo.customer_address ca 
ON ca.customer_id = co.customer_id 
INNER JOIN gravity_books.dbo.address a2 
ON ca.address_id = a2.address_id 
INNER JOIN gravity_books.dbo.country c 
ON c.country_id = a2.country_id 
GROUP BY a.author_name, c.country_name 
ORDER BY COUNT(ol.order_id) DESC;

-- MYSQL
SELECT a.author_name, c.country_name, COUNT(ol.order_id) FROM gravity_books.order_line ol 
INNER JOIN gravity_books.cust_order co 
ON co.order_id  = ol.order_id 
INNER JOIN gravity_books.book b 
ON b.book_id = ol.book_id 
INNER JOIN gravity_books.book_author ba 
ON ba.book_id = b.book_id 
INNER JOIN gravity_books.author a 
ON a.author_id = ba.author_id 
INNER JOIN gravity_books.customer_address ca 
ON ca.customer_id = co.customer_id 
INNER JOIN gravity_books.address a2 
ON ca.address_id = a2.address_id 
INNER JOIN gravity_books.country c 
ON c.country_id = a2.country_id 
GROUP BY a.author_name, c.country_name 
ORDER BY COUNT(ol.order_id) DESC;

-- POSTGRES
SELECT a.author_name, c.country_name, COUNT(ol.order_id) FROM gravity_books.order_line ol 
INNER JOIN gravity_books.cust_order co 
ON co.order_id  = ol.order_id 
INNER JOIN gravity_books.book b 
ON b.book_id = ol.book_id 
INNER JOIN gravity_books.book_author ba 
ON ba.book_id = b.book_id 
INNER JOIN gravity_books.author a 
ON a.author_id = ba.author_id 
INNER JOIN gravity_books.customer_address ca 
ON ca.customer_id = co.customer_id 
INNER JOIN gravity_books.address a2 
ON ca.address_id = a2.address_id 
INNER JOIN gravity_books.country c 
ON c.country_id = a2.country_id 
GROUP BY a.author_name, c.country_name 
ORDER BY COUNT(ol.order_id) DESC;

-- ORACLE
SELECT a.author_name, c.country_name, COUNT(ol.order_id) FROM order_line ol 
INNER JOIN cust_order co 
ON co.order_id  = ol.order_id 
INNER JOIN book b 
ON b.book_id = ol.book_id 
INNER JOIN book_author ba 
ON ba.book_id = b.book_id 
INNER JOIN author a 
ON a.author_id = ba.author_id 
INNER JOIN customer_address ca 
ON ca.customer_id = co.customer_id 
INNER JOIN "ADDRESS" a2 
ON ca.address_id = a2.address_id 
INNER JOIN country c 
ON c.country_id = a2.country_id 
GROUP BY a.author_name, c.country_name 
ORDER BY COUNT(ol.order_id) DESC;

-- 7 Mostrar los clientes que han retornado o devuelto libros
-- SQL SERVER
SELECT c.customer_id, c.first_name, c.last_name, c.email FROM gravity_books.dbo.order_history oh 
INNER JOIN gravity_books.dbo.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.dbo.cust_order co 
ON co.order_id = oh.order_id 
INNER JOIN gravity_books.dbo.customer c 
ON c.customer_id = co.customer_id 
WHERE os.status_value = 'Returned';

-- MYSQL
SELECT c.customer_id, c.first_name, c.last_name, c.email FROM gravity_books.order_history oh 
INNER JOIN gravity_books.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.cust_order co 
ON co.order_id = oh.order_id 
INNER JOIN gravity_books.customer c 
ON c.customer_id = co.customer_id 
WHERE os.status_value = 'Returned';

-- POSTGRES
SELECT c.customer_id, c.first_name, c.last_name, c.email FROM gravity_books.order_history oh 
INNER JOIN gravity_books.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.cust_order co 
ON co.order_id = oh.order_id 
INNER JOIN gravity_books.customer c 
ON c.customer_id = co.customer_id 
WHERE os.status_value = 'Returned';

-- ORACLE
SELECT c.customer_id, c.first_name, c.last_name, c.email FROM order_history oh 
INNER JOIN order_status os 
ON oh.status_id = os.status_id 
INNER JOIN cust_order co 
ON co.order_id = oh.order_id 
INNER JOIN customer c 
ON c.customer_id = co.customer_id 
WHERE os.status_value = 'Returned';

-- 8 Mostrar la cantidad de libros y el titulo del libro que se han entregado satisfactoriamente
-- SQL SERVER
SELECT b.title, COUNT(oh.history_id) FROM gravity_books.dbo.order_history oh 
INNER JOIN gravity_books.dbo.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.dbo.order_line ol 
ON ol.order_id = oh.order_id 
INNER JOIN gravity_books.dbo.book b 
ON b.book_id = ol.book_id 
WHERE os.status_value = 'Delivered'
GROUP BY b.title ;

-- MYSQL
SELECT b.title, COUNT(oh.history_id) FROM gravity_books.order_history oh 
INNER JOIN gravity_books.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.order_line ol 
ON ol.order_id = oh.order_id 
INNER JOIN gravity_books.book b 
ON b.book_id = ol.book_id 
WHERE os.status_value = 'Delivered'
GROUP BY b.title ;

-- POSTGRES
SELECT b.title, COUNT(oh.history_id) FROM gravity_books.order_history oh 
INNER JOIN gravity_books.order_status os 
ON oh.status_id = os.status_id 
INNER JOIN gravity_books.order_line ol 
ON ol.order_id = oh.order_id 
INNER JOIN gravity_books.book b 
ON b.book_id = ol.book_id 
WHERE os.status_value = 'Delivered'
GROUP BY b.title ;

-- ORACLE
SELECT b.title, COUNT(oh.history_id) FROM order_history oh 
INNER JOIN order_status os 
ON oh.status_id = os.status_id 
INNER JOIN order_line ol 
ON ol.order_id = oh.order_id 
INNER JOIN book b 
ON b.book_id = ol.book_id 
WHERE os.status_value = 'Delivered'
GROUP BY b.title ;

-- 9 Mostrar la lista de los clientes mas frecuentes
-- SQL SERVER
SELECT c.customer_id, c.first_name, COUNT(co.order_id) FROM gravity_books.dbo.cust_order co 
INNER JOIN gravity_books.dbo.customer c 
ON co.customer_id = c.customer_id 
GROUP BY c.customer_id, c.first_name 
ORDER BY COUNT(co.order_id) DESC;

-- MYSQL
SELECT c.customer_id, c.first_name, COUNT(co.order_id) FROM gravity_books.cust_order co 
INNER JOIN gravity_books.customer c 
ON co.customer_id = c.customer_id 
GROUP BY c.customer_id, c.first_name 
ORDER BY COUNT(co.order_id) DESC;

-- POSTGRES
SELECT c.customer_id, c.first_name, COUNT(co.order_id) FROM gravity_books.cust_order co 
INNER JOIN gravity_books.customer c 
ON co.customer_id = c.customer_id 
GROUP BY c.customer_id, c.first_name 
ORDER BY COUNT(co.order_id) DESC;

-- ORACLE
SELECT c.customer_id, c.first_name, COUNT(co.order_id) FROM cust_order co 
INNER JOIN customer c 
ON co.customer_id = c.customer_id 
GROUP BY c.customer_id, c.first_name 
ORDER BY COUNT(co.order_id) DESC;

-- 10 Mostrar el mes en el que mas pedidos de libros se realizan
-- SQL SERVER
SELECT TOP 1 MONTH(co.order_date) as Mes, COUNT(co.order_id) FROM gravity_books.dbo.cust_order co 
GROUP BY MONTH(co.order_date)
ORDER BY COUNT(co.order_id) DESC;

-- MYSQL
SELECT MONTH(co.order_date) as Mes, COUNT(co.order_id) FROM gravity_books.cust_order co 
GROUP BY MONTH(co.order_date)
ORDER BY COUNT(co.order_id) DESC LIMIT 1;

-- POSTGRES
SELECT MONTH(co.order_date) as Mes, COUNT(co.order_id) FROM gravity_books.cust_order co 
GROUP BY MONTH(co.order_date)
ORDER BY COUNT(co.order_id) DESC LIMIT 1;

-- ORACLE
SELECT MONTH(co.order_date) as Mes, COUNT(co.order_id) FROM cust_order co 
GROUP BY MONTH(co.order_date)
ORDER BY COUNT(co.order_id) DESC FETCH FIRST 1 ROW ONLY;
