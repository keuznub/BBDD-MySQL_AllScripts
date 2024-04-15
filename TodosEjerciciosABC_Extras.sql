USE bdempresasabc;
SELECT a.codEmpleado, a.codJefe,b.idDirector
FROM empleados a JOIN directores b ON a.codEmpleado = b.codDirector;

SELECT a.codEmpleado, a.codJefe,b.idDirector
FROM empleados a JOIN directores b ON a.codEmpleado = b.codDirector;

SELECT a.codPedido, b.idProducto, b.descripcion
FROM lineaspedido a JOIN productos b ON a.producto= b.idProducto
ORDER BY 1;

SELECT*
FROM lineaspedido;

SELECT *
FROM productos;
