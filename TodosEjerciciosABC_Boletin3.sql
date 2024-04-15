/*
1) ¿Cuál es el sueldo medio y el sueldo total de todos los empleados?
*/

SELECT CONCAT(ROUND(AVG(sueldo),2),"€") "Sueldo Medio €", CONCAT(ROUND(SUM(sueldo),2),"€") "Suma de todos los sueldos €"
FROM empleados;


/*
2) Hallar el importe medio de pedidos, el importe total de pedidos y el precio medio de venta.
*/

SELECT CONCAT(ROUND(AVG(precioVenta*cantidad),2),"€") "Importe medio €", CONCAT(ROUND(SUM(precioVenta*cantidad),2),"€") "Importe TOTAL €", CONCAT(ROUND(AVG(precioVenta),2),"€") "Precio Venta medio €"
FROM lineaspedido;

/*Importe de cada pedido*/
SELECT codPedido, SUM(precioVenta*cantidad) "Importe €"
FROM lineaspedido
GROUP BY codPedido;


SELECT SUM(precioVenta*cantidad)
FROM lineasPedido
GROUP BY codPedido;



/*
3) Hallar el precio medio de los productos del fabricante ACI.
*/

SELECT idFabricante, CONCAT(ROUND(AVG(precioCompra),2),"€") "Precio medio productos €"
FROM productos
WHERE idFabricante IN ("aci");

/*
4) Hallar el precio medio de los productos del fabricante ACI, BIC, QSA e IMM.
*/

SELECT idFabricante, CONCAT(ROUND(AVG(precioCompra),2),"€") "Precio medio productos €"
FROM productos
WHERE idFabricante IN ("aci","bic","qsa","imm")
GROUP BY idFabricante;

/*
5) Hallar el precio medio de los productos del fabricante ACI, BIC, QSA e IMM únicamente si el
precio medio supera los 13 €.
*/

SELECT idFabricante, TRUNCATE(AVG(precioCompra),2) "Precio medio productos €"
FROM productos
WHERE idFabricante IN ("aci","bic","qsa","imm")
GROUP BY idFabricante
HAVING TRUNCATE(AVG(precioCompra),2)>13;

/*
6) ¿Cuál es el importe total de los pedidos realizados por el empleado 'Vázquez Lopez, Jose Luis'?
*/
SELECT SUM(precioVenta*cantidad) FROM lineaspedido WHERE codPedido in (SELECT codPedido FROM pedidos WHERE codRepresentante = (SELECT codEmpleado
FROM empleados
WHERE nombre LIKE "Vázquez Lopez%"));

/*
7) Hallar en qué fecha se realizó el primer pedido (suponiendo que en la tabla de pedidos tenemos
todos los pedidos realizados hasta la fecha).
*/

SELECT MIN(fechaPedido) "Primer pedido fecha"
FROM pedidos;

/*
9) Listar cuántos empleados están asignados a cada oficina, indicar el número de oficina y cuántos
hay asignados.
*/

SELECT oficina "Numero oficina", COUNT(*) "Numero empleados"
FROM empleados
GROUP BY oficina;

/*
10) Para cada empleado, obtener su número, nombre, e importe vendido por ese empleado a cada
cliente indicando el número y nombre del cliente.
*/

     
SELECT a.codEmpleado "Codigo Empleado", a.nombre "Nombre Empleado", CONCAT(ROUND(SUM(c.cantidad+c.precioVenta),2),"€") "Importe Vendido", d.codCliente "Codigo cliente", d.nombre "Nombre Cliente"
FROM empleados a JOIN pedidos b ON a.codEmpleado=b.codRepresentante JOIN lineaspedido c ON b.codPedido=c.codPedido JOIN clientes d ON b.codCliente = d.codCliente
GROUP BY a.codEmpleado, d.codCliente;

/*
11) Para cada empleado cuyos pedidos suman más de 100.000 €, hallar su importe medio de
pedidos. En el resultado indicar el número de empleado y su importe medio de pedidos.
*/

 SELECT e.codEmpleado,e.nombre,(AVG(lp.cantidad * lp.precioVenta))
 FROM empleados e JOIN pedidos p ON e.codEmpleado = p.codRepresentante JOIN lineaspedido lp USING (codPedido)
 GROUP BY e.codempleado
 HAVING SUM(lp.cantidad * lp.precioVenta) > 100000;

/*
12) Listar de cada producto, su descripción, precio y cantidad total pedida, incluyendo sólo los
productos cuya cantidad total pedida sea superior al 75% del stock; y ordenado por cantidad
total pedida.
*/

SELECT p.idProducto, p.descripcion, lp.precioVenta, lp.cantidad, p.existencias
FROM productos p JOIN lineaspedido lp ON p.idProducto = lp.producto
GROUP BY p.idProducto
HAVING SUM(lp.cantidad) > (p.existencias*0.75)
ORDER BY 4 desc;


/*
13) Listar las pedidos superiores a 10.000 €, incluyendo el nombre del empleado que tomó el pedido
y el nombre del cliente que lo solicitó.
*/

SELECT pd.codPedido, SUM(lp.cantidad*lp.precioVenta), e.codEmpleado,e.nombre,c.codCliente,c.nombre
FROM pedidos pd JOIN empleados e ON pd.codRepresentante = e.codEmpleado JOIN clientes c ON c.codCliente = pd.codCliente JOIN lineaspedido lp ON lp.codPedido = pd.codPedido
GROUP BY pd.codPedido
HAVING SUM(lp.cantidad*lp.precioVenta) > 10000;

/*
14) Listar los 5 pedidos con mayor importe indicando el nombre del cliente del producto y del
representante.
*/

SELECT pd.codPedido, SUM(lp.cantidad*lp.precioVenta), c.nombre, e.nombre
FROM pedidos pd JOIN lineaspedido lp USING(codPedido) JOIN empleados e ON pd.codRepresentante = e.codEmpleado JOIN clientes c ON c.codCliente= pd.codCliente
GROUP BY pd.codPedido
ORDER BY SUM(lp.cantidad*lp.precioVenta) DESC
LIMIT 5;


/*
15) Listar ordenadamente por el importe vendido por cada empleado, indicando su nombre.
*/

SELECT e.codEmpleado, e.nombre, SUM(lp.cantidad*lp.precioVenta) "Importe vendido"
FROM empleados e JOIN pedidos pd ON e.codEmpleado = pd.codRepresentante JOIN lineaspedido lp ON lp.codPedido= pd.codPedido 
GROUP BY e.codEmpleado
ORDER BY 3;

/*
16) Obtener el nombre de todos los empleados cuyas ventas no han llegado a cubrir el objetivo que
tenían, además se deberá listar también cual es la cantidad y el porcentaje que representa.
*/

SELECT e.codEmpleado, e.nombre, SUM(lp.cantidad*lp.precioVenta) "Importe vendido", e.objetivo
FROM empleados e JOIN pedidos pd ON e.codEmpleado = pd.codRepresentante JOIN lineaspedido lp ON lp.codPedido= pd.codPedido 
GROUP BY e.codEmpleado
HAVING SUM(lp.cantidad*lp.precioVenta)<e.objetivo;

/*
17) Calcular el total vendido a cada cliente
*/

SELECT SUM(lp.cantidad * lp.precioVenta) "Total Gastado", c.nombre
FROM lineaspedido lp JOIN pedidos pd USING(codPedido) JOIN clientes c ON c.codCliente = pd.codCliente
GROUP BY c.codCliente;

/*
18) Calcular el total vendido a cada cliente de cada producto
*/

SELECT SUM(lp.cantidad * lp.precioVenta) "Total Gastado", c.nombre, p.idProducto
FROM lineaspedido lp JOIN pedidos pd USING(codPedido) JOIN clientes c ON c.codCliente = pd.codCliente JOIN productos p ON p.idProducto = lp.producto
GROUP BY c.codCliente, p.idProducto;

/*
19) Calcular el total de cada pedido, indicando el nombre del cliente, la fecha del pedido
*/

SELECT CONCAT(TRUNCATE(SUM(lp.cantidad * lp.precioVenta),2),"€") "Total de pedido", c.nombre, pd.fechaPedido
FROM pedidos pd JOIN lineaspedido lp ON pd.codPedido = lp.codPedido JOIN clientes c ON c.codCliente = pd.codCliente
GROUP BY pd.codPedido;

/*
20) Calcular el total vendido cada mes
*/

SELECT CONCAT(TRUNCATE(SUM(lp.cantidad * lp.precioVenta),2),"€") "Total Vendido", month(pd.fechaPedido) "Mes"
FROM pedidos pd JOIN lineaspedido lp ON pd.codPedido = lp.codPedido JOIN clientes c ON c.codCliente = pd.codCliente
GROUP BY 2;

/*
21) Seleccionar para cada fabricante el precio medio de sus productos
*/

SELECT p.idFabricante, CONCAT(TRUNCATE(AVG(p.precioCompra),2),"€") "Precio Medio €"
FROM productos p 
GROUP BY p.idFabricante;


/*
22) Indicar cuál es el producto del que se han vendidos más unidades,
*/
SELECT producto, SUM(cantidad)
FROM lineaspedido
GROUP BY producto
ORDER BY SUM(cantidad) DESC LIMIT 1;

/*
23) Calcular para cada producto el beneficio (Ingresos – gastos), indicando el producto, el total
vendido y el total comprado.
*/

SELECT p.idProducto,p.descripcion, CONCAT(TRUNCATE((p.existencias*p.precioCompra),2),"€") "Gastos", CONCAT(TRUNCATE(SUM(lp.cantidad*lp.precioVenta),2),"€") "Ingresos"
FROM productos p JOIN lineaspedido lp ON p.idProducto = lp.producto
GROUP BY p.idProducto;

/*
24) Listar ordenadamente por el importe vendido por cada empleado, indicando su nombre.
*/

SELECT e.nombre, SUM(lp.precioVenta*lp.cantidad)
FROM empleados e JOIN pedidos p ON e.codEmpleado = p.codRepresentante JOIN lineaspedido lp ON lp.codPedido = p.codPedido
GROUP BY e.codEmpleado
ORDER BY 2;

/*
25) Obtener las ventas mensuales de los empleados. Hay que diseñar una consulta sumaria
calculando la suma de los importes de los pedidos agrupando por empleado y mes de la venta.
*/

SELECT e.nombre, SUM(lp.precioVenta*lp.cantidad), MONTH(p.fechaPedido)
FROM empleados e JOIN pedidos p ON e.codEmpleado = p.codRepresentante JOIN lineaspedido lp ON lp.codPedido = p.codPedido
GROUP BY e.codEmpleado, 3
ORDER BY 1,3;

/*
26) Igual que la anterior pero sólo nos interesan los meses de febrero, mayo y diciembre.
*/

SELECT e.nombre, SUM(lp.precioVenta*lp.cantidad), MONTH(p.fechaPedido)
FROM empleados e JOIN pedidos p ON e.codEmpleado = p.codRepresentante JOIN lineaspedido lp ON lp.codPedido = p.codPedido
WHERE MONTH(p.fechaPedido) IN (2,5,12)
GROUP BY e.codEmpleado, 3;

/*
27) Igual que la anterior pero sólo nos interesan los meses de febrero, mayo y diciembre y la suma de
los pedidos sea mayor que 60000.
*/

SELECT e.nombre, SUM(lp.precioVenta*lp.cantidad), MONTH(p.fechaPedido)
FROM empleados e JOIN pedidos p ON e.codEmpleado = p.codRepresentante JOIN lineaspedido lp ON lp.codPedido = p.codPedido
WHERE (MONTH(p.fechaPedido) IN (2,5,12)) 
GROUP BY e.codEmpleado, MONTH(p.fechaPedido)
HAVING (SUM(lp.precioVenta*lp.cantidad))>60000;

/*
28) Obtener para cada empleado cuánto ha vendido en total y cuál ha sido el importe mayor vendido
en un pedido.
*/

SELECT e.nombre, SUM(lp.cantidad*lp.precioVenta) "Vendido Total", (SELECT MAX(lp.precioVenta*lp.cantidad)) "Importe mayor en 1 pedido"
FROM empleados e JOIN pedidos pd ON e.codEmpleado = pd.codRepresentante JOIN lineaspedido lp ON pd.codPedido = lp.codPedido
GROUP BY e.codEmpleado;



/*
OPCIONAL) ME SACAIS LOS SUELDOS QUE GANAN LOS TRABAJADORES Y CUAL ES EL SUELDO MAS HABITUAL
*/

SELECT sueldo, COUNT(*)
FROM empleados
GROUP BY sueldo order by 2 desc;

/*
OPCIONAL) DIRECTOR DE OFICINA CON MAS VENTAS
*/

SELECT MAX(a.ventas), c.nombre
FROM oficinas a JOIN directores b ON a.codOficina = b.codOficina JOIN empleados c ON c.codEmpleado = b.codDirector;



