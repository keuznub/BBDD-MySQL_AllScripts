USE Sakila;

/*
1.¿Dónde vive 'JUDY GRAY'?
*/
SELECT first_name,last_name,city_id,country_id,city,country
FROM customer c JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
WHERE first_name = "JUDY" AND last_name="GRAY";

/*
2.¿En cuántos países viven nuestros clientes? (países distintos)
*/
SELECT COUNT(DISTINCT country)
FROM customer c JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id);

/*
3.¿Cuántos clientes viven en Egipto?
*/
SELECT COUNT(customer_id)
FROM customer c JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
WHERE country = "Egypt";

/*
4.¿En qué ciudades de Egipto viven nuestros clientes?
*/
SELECT city_id, count(c.customer_id)
FROM customer c JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
WHERE country = "Egypt"
GROUP BY city_id;

/*
5.¿Cuántos clientes viven fuera de Estados Unidos? (UNITED STATES)
*/
SELECT COUNT(customer_id)
FROM customer c JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
WHERE country != "UNITED STATES";

/*
6.¿Cuántas películas duran 90 o menos minutos?
*/
SELECT COUNT(film_id)
FROM film
WHERE length > 90;

/*
7.¿Cuántas películas van de astronautas?
*/
SELECT COUNT(film_id)
FROM film
WHERE description LIKE "%Astronaut%";

/*
8.Lista todas las películas que duren como mucho 90 minutos y sean de astronautas.
*/
SELECT COUNT(film_id)
FROM film
WHERE description LIKE "%Astronaut%" AND length>90;

/*
9.Los títulos de todas las películas, ordenadas por duración, de forma descendente.
*/
SELECT title
FROM film
ORDER BY length DESC;

/*
10.Visualiza los 10 actores que han participado en más películas.
*/
SELECT actor_id, COUNT(film_id)
FROM film_actor
GROUP BY actor_id
ORDER BY 2 desc limit 10;

/*
11.Visualiza los clientes de países que empiezan por S.
*/
SELECT customer_id, country
FROM customer c JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
WHERE country LIKE "S%";

/*
12.Visualiza el top-10 de países con más clientes.
*/
SELECT country, COUNT(customer_id) "Clientes"
FROM customer c JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
GROUP BY country_id
ORDER BY 2 DESC LIMIT 10;

/*
13.Saca las 10 primeras películas alfabéticamente y el número de copias que se disponen de cada una
de ellas.
*/
SELECT f.*,COUNT(i.film_id) "Numero de copias"
FROM film f JOIN inventory i USING(film_id)
GROUP BY (f.film_id);

/*
14.Saca todas las películas que ha alquilado el cliente Deborah Walker.
*/
SELECT customer_id, first_name,film_id, title
FROM film JOIN inventory USING(film_id) JOIN rental USING(inventory_id) JOIN customer USING (customer_id)
WHERE first_name = "Deborah" AND last_name = "Walker";

/*
15.Visualiza los 10 mejores clientes.
*/
SELECT customer_id, first_name, COUNT(film_id)
FROM film JOIN inventory USING(film_id) JOIN rental USING(inventory_id) JOIN customer USING (customer_id)
GROUP BY customer_id
ORDER BY 3 DESC limit 10;

/*
16.Averigua la popularidad de las categorías cinematográficas entre los clientes españoles.
*/
SELECT c.name, COUNT(customer_id), country
FROM film f JOIN inventory USING(film_id) JOIN rental USING(inventory_id) JOIN customer USING (customer_id) JOIN film_category USING(film_id) JOIN category c USING(category_id)  JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
WHERE country = "Spain"
GROUP BY c.category_id
ORDER BY 2 DESC;

/*
17.Selecciona los 10 actores más populares en Argentina.
*/
USE SAKILA;
SELECT actor_id, a.first_name, COUNT(country) 
FROM actor a JOIN film_actor USING(actor_id) JOIN film USING(film_id) JOIN inventory USING(film_id) JOIN rental USING(inventory_id) JOIN customer USING (customer_id) JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id)
WHERE country = "Argentina"
GROUP BY actor_id
ORDER BY 3 DESC LIMIT 10; 

/*
18.Averigua cuál es la película más alquilada de entre las que trabaja Sandra Kilmer (Aunque hay dos
películas, con mostrar cualquiera de las dos sería suficiente).
*/
SELECT film_id,title,actor_id, a.first_name, COUNT(rental_id) as contaje
FROM actor a JOIN film_actor USING(actor_id) JOIN film USING(film_id) JOIN inventory USING(film_id) JOIN rental USING(inventory_id)
WHERE a.first_name = "Sandra" AND a.last_name = "Kilmer"
GROUP BY film_id
ORDER BY 5 desc
LIMIT 2;

/*
19.Averigua cuál es la duración media de las películas que están ahora mismo alquiladas.
*/
SELECT AVG(length) "Duracion media entre todas la peliculas alquiladas"
FROM film JOIN inventory USING(film_id) JOIN rental USING(inventory_id);

/*
20.¿Cómo lo has hecho? ¿Te has planteado tener en cuenta que una misma película puede estar
alquilada varias veces? Podrías entonces re-calcular la media contando cada película una vez,
sabiendo que en este caso no hay dos películas con la misma duración?
*/
SELECT (AVG(DISTINCT length)) "Duracion media entre todas las peliculas alquiladas"
FROM film JOIN inventory USING(film_id) JOIN rental USING(inventory_id);


/*
21.Calcula la tienda que más alquileres de películas del género infantil (Children) realizó entre agosto
y septiembre de 2005.
*/
SELECT s.store_id, COUNT(c.category_id)
FROM store s JOIN customer USING(store_id) JOIN rental USING(customer_id) JOIN inventory USING(inventory_id) JOIN film USING(film_id) JOIN film_category USING(film_id) JOIN category c USING(category_id)
WHERE c.name = "Children" AND MONTH(rental_date) IN (8,9) AND YEAR(rental_date) IN (2005)
GROUP BY s.store_id
ORDER BY 2 DESC
LIMIT 1;

/*
22.Visualiza los trabajadores que trabajan en la misma ciudad donde residen.
*/
SELECT city_id, GROUP_CONCAT(address), COUNT(staff_id)
FROM staff JOIN address USING(address_id)
GROUP BY city_id;

/*
23.Averigua los 10 clientes que más dinero han gastado.
*/
SELECT c.customer_id, SUM(amount)
FROM customer c JOIN rental USING (customer_id) JOIN payment USING(rental_id)
GROUP BY c.customer_id
ORDER BY 2 DESC
LIMIT 10;

/*
24.Calcula ahora las 10 películas que más dinero han generado a la empresa.
*/
SELECT f.film_id, SUM(amount)
FROM rental JOIN inventory USING(inventory_id) JOIN film f USING(film_id) JOIN payment USING(rental_id)
GROUP BY f.film_id
ORDER BY 2 DESC
LIMIT 10;

/*
25.Averigua el nombre completo y dirección de correo electrónico de los clientes que han alquilado
películas de acción.
*/

SELECT first_name, last_name, email,film_id, rental_date,name
FROM customer JOIN rental USING(customer_id) JOIN inventory USING(inventory_id) JOIN film USING(film_id) JOIN film_category USING(film_id) JOIN category USING(category_id)
WHERE name = "Action"
ORDER BY rental_date DESC;

/*
26.Muestra el nombre de cada película, su categoría y el número total de películas de dicha categoría.
(Pista: Se pueden hacer JOINS con subconsultas).
*/


SELECT film_id, name as NombreCategoria,(
	SELECT COUNT(f.film_id) 
	FROM category JOIN film_category USING(category_id) JOIN film f USING(film_id) 
    WHERE name= NombreCategoria GROUP BY name) "Numero de peliculas total de dicha categoria"
FROM category JOIN film_category USING(category_id) JOIN film f USING(film_id)
GROUP BY f.film_id;

/*
27.Calcula el importe medio de los pagos de cada usuario. (Sin subconsulta).
*/

SELECT customer_id, CONCAT(TRUNCATE(AVG(amount),2),"€")
FROM customer JOIN payment USING(customer_id)
group by customer_id
ORDER BY 2 DESC;

/*
28.Encuentra los pagos que superan la media de cada usuario, así como el total de pagos que superan la
media.
*/

SELECT customer_id as id,payment_id, amount, (SELECT avg(amount) as contaje FROM customer JOIN payment USING(customer_id) WHERE customer_id=id) as media,
(SELECT count(*)
FROM
(SELECT customer_id as id,payment_id, amount, (SELECT avg(amount) as contaje FROM customer JOIN payment USING(customer_id) WHERE customer_id=id) as media
FROM customer JOIN payment USING(customer_id)
WHERE amount>5) as subconsulta) "Numero total de pagos mayores que media"
FROM customer JOIN payment USING(customer_id)
WHERE amount>5;

/*
29.