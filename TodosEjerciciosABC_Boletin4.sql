/*
1) Listar los nombres de los clientes que tienen asignado el representante García Gómez, Luis
Antonio (suponiendo que no pueden haber representantes con el mismo nombre).
*/

SELECT nombre
FROM clientes 
WHERE codRepresentante = (SELECT codEmpleado FROM empleados WHERE nombre LIKE "García Gómez%");

/*
2) Listar los vendedores (codEmpleado, nombre, y no de oficina) que trabajan en oficinas "buenas"
(las que tienen ventas superiores a su objetivo).
*/

SELECT codEmpleado, nombre, oficina
FROM empleados
WHERE oficina IN (SELECT codOficina FROM oficinas WHERE ventas>objetivo);

/*
3) Listar los vendedores que no trabajan en oficinas dirigidas por el empleado 108.
*/

SELECT codEmpleado, nombre, oficina
FROM empleados
WHERE oficina NOT IN (SELECT codOficina FROM directores WHERE codDirector = 108);

/*
4) Listar los productos (idfabricante, idproducto y descripción) para los cuales no se ha recibido
ningún pedido de 500 € o más.
*/

SELECT idFabricante, idProducto, descripcion
FROM productos
WHERE idProducto IN (SELECT idProducto FROM lineaspedido WHERE precioVenta*cantidad<500);

/*
5) Listar los clientes asignados a García Gómez, Luis Antonio que no han remitido un pedido
superior a 5.000 €.
*/

SELECT *
FROM clientes
WHERE codRepresentante = (SELECT codEmpleado FROM empleados WHERE nombre LIKE "García Gómez%") AND codCliente IN 
(SELECT codCliente FROM pedidos WHERE codPedido IN (SELECT codPedido FROM lineaspedido WHERE cantidad*precioVenta < 5000));




/*
6) Listar las oficinas en donde haya un vendedor cuyas ventas representen más del 55% del objetivo
de su oficina.
*/

SELECT SUM(lp.cantidad*PrecioVenta),e.oficina,(SELECT objetivo FROM oficinas WHERE codOficina=e.oficina)
FROM pedidos p JOIN lineasPedido lp USING(codPedido) JOIN empleados e ON p.codRepresentante=e.codEmpleado
GROUP BY e.oficina
HAVING SUM(lp.cantidad*PrecioVenta)>(SELECT objetivo FROM oficinas WHERE codOficina=e.oficina)*0.55;

/*
7) Listar las oficinas en donde todos los vendedores tienen sueldos que superan al 50% del objetivo
de la oficina.
*/

SELECT  *
FROM oficinas o
WHERE o.codOficina IN (SELECT oficina FROM empleados WHERE sueldo > o.objetivo*0.5 )
ORDER BY o.codOficina;


