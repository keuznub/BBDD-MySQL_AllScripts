/*
Ejercicios Base de Datos EmpresasABC
Ejercicios. Las consultas simples
La lista de selección
1) Obtener una lista de todos los productos indicando para cada uno su idfabricante, idproducto,
descripción, precio de compra, IVA y precio con I.V.A. incluido (es el precio anterior aumentado en
un 21%).
*/

select idFabricante "ID Fabricante", idProducto "ID Producto", descripcion "Descripcion", precioCompra "Precio", precioCompra*0.21 "IVA",precioCompra*0.21+precioCompra "Precio Con IVA"
from productos;


/*
2) De cada lineapedido queremos saber su número de pedido, fabricante, producto, cantidad, precio
de venta y el importe.
*/

select codPedido "Cod Pedido", fabricante "Fabricante", producto "Producto", cantidad "Cantidad", precioVenta "Precio", precioVenta*cantidad "Importe"
from lineaspedido;

/*
3) Listar de cada empleado su nombre, no de días que lleva trabajando en la empresa y su edad
(suponiendo que este año ya ha cumplido años).
Ordenación de filas.
*/

select nombre "Nombre Empleado", datediff(now(),fecContrato) "Dias Trabajados", Round((datediff(now(),fecNacimiento)/365),0) "Edad"
from empleados;

/*
4) Obtener la lista de los clientes agrupados por código de representante asignado, visualizar todas
las columnas de la tabla.
*/

select *
from clientes
group by codCliente;

/*
5) Obtener las oficinas ordenadas por orden alfabético de región y dentro de cada región por ciudad,
si hay más de una oficina en la misma ciudad, aparecerá primero la que tenga el número de oficina
mayor.
*/

select *
from oficinas 
order by region, ciudad, codOficina;


/*
6) Obtener los pedidos ordenados por fecha de pedido.
Selección de filas.
*/


select *
from pedidos
order by fechaPedido;

/*

7) Listar las ocho líneas de pedido más caras (las de mayor importe).
*/

select *
from lineaspedido
order by cantidad*precioVenta desc limit 8;

/*
8) Obtener las mismas columnas que en el ejercicio anterior pero sacando únicamente las 5 líneas de
pedido de menor precio unitario.
*/

select *
from lineaspedido
order by precioVenta asc limit 5;



/*
9) Listar toda la información de los pedidos de marzo del último año.
*/

select *
from pedidos
where month(fechaPedido)="3" && year(fechaPedido)=(SELECT MAX(YEAR(fechaPedido)) FROM pedidos);

/*
10) Listar los pedidos del mes pasado.
*/

select *
from pedidos
where month(fechaPedido) = (select month(max(fechaPedido)-1) from pedidos) 
	&& year(fechaPedido) = (select year(max(fechaPedido)) from pedidos);

/*
11) Listar los números de los empleados que tienen una oficina asignada.
*/

select codEmpleado
from empleados
where oficina is not null;

/*
12) Listar los nombres de los empleados que no tienen asignada una oficina.
*/

select nombre
from empleados
where oficina is null;


/*
13) Listar los datos de las oficinas de las regiones del Galicia y Euzkadi (tienen que aparecer primero las
del Euzkadi y después las de Galicia).
*/

select *
from oficinas
where region="Galicia" || region="Euzkadi"
ORDER BY CAST(region as CHAR);

select *
from oficinas
where region="Galicia" || region="Euzkadi"
ORDER BY CONCAT(REGION);

select *
from oficinas
where region IN ("Galicia", "Euzkadi")
ORDER BY CONCAT(REGION);

/*
14) .Listar los clientes de nombre Julia.
*/

select *
from clientes
where nombre like "Julia %";


select *
from clientes
where nombre like "_a_m%"; /* Todos los nombres que tengan una 'a' en la segunda posicion y 'm' en la cuarta y despues lo que sea

/*
15) Listar los productos cuyo idproducto acabe en x.
*/
select *
from productos
where idProducto like "%x";
/*
16) Obtener toda la información de los empleados cuya edad este comprendida entre 40 y 60 años.
*/

select nombre, (datediff(now(),fecNacimiento)/365) as Años
from empleados
where floor(datediff(now(),fecNacimiento)/365) BETWEEN 40 and 60 ;

/*
17) Obtener todos los clientes cuyos representantes tengan los códigos 102, 104 y 109.
*/

select *
from clientes
where codRepresentante in (102,104,109) ;



/*
18) Obtener un listado de todos los productos ordenados alfabéticamente por fabricante y después de
mayor a menor precio.
*/

select *
from productos
order by idFabricante,precioCompra desc;

/*
19) Listar todos los empleados que lleven trabajando más de 25 años en la empresa.
*/

select *, floor(datediff(now(), fecContrato)/365) as AñosContratados
from empleados
where datediff(now(), fecContrato)/365 > 25;

/*
20) Listar todas las oficinas que no tengan marcado ningún objetivo.
*/

select *
from oficinas
where objetivo is null OR objetivo="";

/*
21) Obtener el nombre de todos los empleados cuyo salario acumulado hasta la fecha actual no han
llegado a cubrir el objetivo que tenían, además se deberá calcular el importe que les falta.
*/

select nombre, floor((TIMESTAMPDIFF(MONTH,fecContrato,CurDate())*sueldo)) as "Salario Acumulado", 
objetivo - floor((TIMESTAMPDIFF(MONTH,fecContrato,CurDate())*sueldo)) as  "Respecto a Objetivo"
from empleados
where objetivo - floor((TIMESTAMPDIFF(MONTH,fecContrato,CurDate())*sueldo))>0;

/*
22) Obtener el nombre del empleado, sueldo, comisión, sueldo bruto (sueldo + comisión), el importe
de las retenciones tanto del IRPF como de la S.S., y el sueldo neto (sueldo bruto – las retenciones).
*/

select nombre "Nombre", sueldo "Sueldo", comision "Comisión", 
	sueldo+comision "Sueldo Bruto", (sueldo+comision)*retencionesIRPF "Retencion IRP",
    (sueldo+comision)*retencionesSS "Retenciones SS", 
    (sueldo+comision)-((sueldo+comision)*retencionesIRPF + (sueldo+comision)*retencionesSS)"Sueldo Neto"
from empleados;




#FUNCION DE AGREGACION O DE GRUPO MAX COUNT MIN AVG...
select COUNT(sueldo),
MAX(sueldo), MIN(sueldo), AVG(sueldo), SUM(sueldo)
from empleados;
