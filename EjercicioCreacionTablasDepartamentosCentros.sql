USE bdempresasabc;

SELECT *,21 as IVA, precioCompra*0.21+precioCompra 
as Precio_Con_IVA FROM productos;

SELECT *, precioVenta*cantidad as Importe from lineaspedido; 


SELECT nombre, datediff(now(),fecContrato) as DiasTrabajados, 
 round(datediff(now(),fecNacimiento)/365) as Años from empleados;
 
 SELECT * from clientes 
 order by codRepresentante;
 
 