use tienda;
/*
1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
*/
select *
from producto;

select *
from fabricante;

SELECT *
FROM producto
WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Lenovo");

/*
2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro
del fabricante Lenovo. (Sin utilizar INNER JOIN).
*/

SELECT *
FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Lenovo"));

/*
3. Lista el nombre del producto más caro del fabricante Lenovo.
*/

SELECT nombre, precio
FROM producto
WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Lenovo")
ORDER BY precio DESC LIMIT 1;

/*
4. Lista el nombre del producto más barato del fabricante Hewlett-Packard.
*/
SELECT nombre, CONCAT(precio,"€")
FROM producto
WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Hewlett-Packard")
ORDER BY precio ASC LIMIT 1;

/*
5. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al
producto más caro del fabricante Lenovo.
*/
SELECT *
FROM producto
WHERE precio >= (SELECT MAX(precio) FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Lenovo"));

/*
6. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de
todos sus productos.
*/
SELECT *
FROM producto
WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Asus") AND precio > (SELECT AVG(precio) FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Asus"));

/*
8. Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER
BY ni LIMIT.
*/

SELECT *
FROM producto
WHERE precio >= ALL(SELECT precio from producto);

/*
9. Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER
BY ni LIMIT.
*/
SELECT *
FROM producto
WHERE precio <= ALL(SELECT precio from producto);

/*
10. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
*/
SELECT nombre
FROM fabricante
WHERE id = ANY (SELECT id_fabricante FROM producto);

/*
11. Devuelve los nombres de los fabricantes que no tienen productos asociados.
(Utilizando ALL o ANY).
*/

SELECT nombre
FROM fabricante
WHERE id != ALL (SELECT id_fabricante FROM producto);

/*
12. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT
IN).
*/

SELECT nombre
FROM fabricante
WHERE id IN(SELECT id_fabricante FROM producto);

/*
13. Devuelve los nombres de los fabricantes que no tienen productos asociados.
(Utilizando IN o NOT IN).
*/
SELECT nombre
FROM fabricante
WHERE id NOT IN(SELECT id_fabricante FROM producto);

/*
14. Devuelve los nombres de los fabricantes que tienen productos asociados.
(Utilizando EXISTS o NOT EXISTS).
*/

SELECT nombre
FROM fabricante
WHERE EXISTS (SELECT 1 FROM producto WHERE fabricante.id = producto.id_fabricante);


/*
15. Devuelve los nombres de los fabricantes que no tienen productos asociados.
(Utilizando EXISTS o NOT EXISTS).
*/

SELECT nombre
FROM fabricante
WHERE NOT EXISTS (SELECT 1 FROM producto WHERE fabricante.id = producto.id_fabricante);

/*
16. Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
*/
SELECT nombre, (SELECT MAX(precio) FROM producto WHERE id_fabricante=a.id) "Precio Producto mas caro"
FROM fabricante a;

/*
17. Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de
todos los productos de su mismo fabricante. 
*/
SELECT *
FROM producto a
WHERE precio >= (SELECT AVG(precio) as preciomedia FROM producto b WHERE a.id_fabricante = b.id_fabricante);

/*
18. Lista el nombre del producto más caro del fabricante Lenovo.
*/

SELECT *
FROM producto
WHERE precio >= ALL(SELECT precio FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Lenovo")) AND id_fabricante = (SELECT id FROM fabricante WHERE nombre="Lenovo");

/*
19. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de
productos que el fabricante Lenovo.
*/

SELECT id_fabricante, (SELECT nombre FROM fabricante WHERE id_fabricante=id),COUNT(*) "Numero de productos"
FROM producto a
GROUP BY id_fabricante
HAVING COUNT(*) = (SELECT COUNT(*) FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre="Lenovo")) AND NOT (id_fabricante = (SELECT id FROM fabricante WHERE nombre ="Lenovo"));
