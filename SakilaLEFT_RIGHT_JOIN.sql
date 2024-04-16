USE Sakila;

/*
1.¿Listar los clientes que no han realizado ningún pago.?
*/
SELECT customer_id, payment_id, amount
FROM customer LEFT JOIN payment USING(customer_id)
WHERE payment_id IS NULL;



/*
2.Listar todos los clientes y sus respectivos alquileres, incluyendo aquellos que no han alquilado ninguna película
*/
SELECT DISTINCT customer_id, rental_id
FROM customer LEFT JOIN rental USING(customer_id);

SELECT DISTINCT customer_id, rental_id
FROM customer LEFT JOIN rental USING(customer_id);

/*
3..Listar todas las tiendas y sus respectivos alquileres, incluyendo aquellas que no han tenido ningún alquiler
*/

SELECT store_id, count(*)
FROM rental JOIN inventory USING(inventory_id) RIGHT JOIN store USING(store_id)
GROUP BY store_id;

/*
4.Listar todas las películas y sus respectivos géneros, incluyendo aquellas que no tienen género asignado.
*/

SELECT film_id, category_id
FROM film LEFT JOIN film_category USING(film_id);

/*
5.Listar todos los clientes y sus respectivos pagos, incluyendo aquellos que no han realizado ningún pago.
*/
SELECT customer_id, payment_id, amount
FROM customer LEFT JOIN payment USING(customer_id);