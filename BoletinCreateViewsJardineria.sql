USE jardineria;

/*
1. Escriba una vista que se llame listado_pagos_clientes que muestre un listado donde aparezcan
todos los clientes y los pagos que ha realizado cada uno de ellos. La vista deberá tener las siguientes co‐
lumnas: nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago, total del pago,
id de la transacción
*/

CREATE OR REPLACE VIEW listado_pagos_clientes  AS 
SELECT CONCAT(nombre_cliente, ' ',apellido_contacto) AS nombre_cliente, telefono, ciudad, pais, fecha_pago, total, id_transaccion
FROM cliente JOIN pago USING(codigo_cliente);

SELECT *
FROM listado_pagos_clientes;

/*
2. Escriba una vista que se llame listado_pedidos_clientes que muestre un listado donde aparez‐
can todos los clientes y los pedidos que ha realizado cada uno de ellos. La vista deberá tener las siguientes
columnas: código del cliente, nombre y apellidos del cliente concatendados, teléfono, ciudad, pais, códi‐
go del pedido, fecha del pedido, fecha esperada, fecha de entrega y la cantidad total del pedido, que será
la suma del producto de todas las cantidades por el precio de cada unidad, que aparecen en cada línea
de pedido.
*/
CREATE OR REPLACE VIEW listado_pedidos_clientes AS
SELECT CONCAT(nombre_cliente, ' ',apellido_contacto) AS nombre_cliente, telefono, ciudad, pais, codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, SUM(cantidad*precio_unidad) AS cantidad_total
FROM cliente JOIN pedido USING(codigo_cliente) JOIN detalle_pedido USING(codigo_pedido)
GROUP BY codigo_pedido;

SELECT *
FROM listado_pedidos_clientes;


/*
3. Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes de la ciudad
de Madrid que han realizado pagos.
*/

SELECT *
FROM listado_pagos_clientes
WHERE ciudad = "Madrid";



/*
4. Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes que todavía
no han recibido su pedido.
*/

SELECT *
FROM listado_pedidos_clientes
WHERE fecha_entrega IS NULL;

/*
5. Utilice las vistas que ha creado en los pasos anteriores para calcular el número de pedidos que se ha
realizado cada uno de los clientes.
*/

SELECT nombre_cliente,COUNT(*)
FROM listado_pedidos_clientes
GROUP BY nombre_cliente;


/*
6. Utilice las vistas que ha creado en los pasos anteriores para calcular el valor del pedido máximo y mínimo
que ha realizado cada cliente.
*/

SELECT nombre_cliente,MAX(cantidad_total), MIN(cantidad_total)
FROM listado_pedidos_clientes
GROUP BY nombre_cliente;

/*
7. Modifique el nombre de las vistalistado_pagos_clientesy asígnele el nombrelistado_de_pagos
. Una vez que haya modificado el nombre de la vista ejecute una consulta utilizando el nuevo nombre de
la vista para comprobar que sigue funcionando correctamente.
*/

RENAME TABLE listado_pagos_clientes TO listado_de_pagos;
SELECT *
FROM listado_de_pagos;
RENAME TABLE listado_de_pagos TO listado_pagos_clientes;

/*
8. Elimine las vistas que ha creado en los pasos anteriores.
*/

DROP VIEW IF EXISTS listado_pagos_clientes;
