/*
1.Listar las oficinas de Galicia indicando para cada una de ellas su número, ciudad, códigos y
nombres de sus empleados. Hacer una versión en la que aparecen sólo las que tienen empleados,
y hacer otra en las que aparezcan las oficinas de Galicia que no tienen empleados.
*/

SELECT a.codOficina "Código Oficina", a.ciudad "Ciudad Oficina", b.nombre "Nombre empleado", region "Region Oficina"
FROM oficinas a JOIN empleados b ON a.codOficina=b.oficina
WHERE region="Galicia" 
ORDER BY codOficina;

/*
2.Listar los pedidos mostrando su número, fecha del pedido, nombre del cliente, y el límite de
crédito del cliente correspondiente (todos los pedidos tienen cliente y representante).
*/

SELECT a.codPedido "Numero pedido", a.fechaPedido "Fecha Pedido", b.nombre "Nombre cliente", b.limiteCredito "Limite Credito"
FROM pedidos a, clientes b;

/*
3.Listar los datos de cada uno de los empleados, la ciudad y región en donde trabaja.
*/
SELECT a.*, b.region "Region", b.ciudad "Ciudad" 
FROM empleados a, oficinas b;


/*
Listar las oficinas con objetivo superior a 3.500€ indicando para cada una de ellas el nombre de
su director.
*/
SELECT a.*
FROM oficinas a, directores b,
WHERE a.objetivo > 3500;


SELECT *
FROM 


