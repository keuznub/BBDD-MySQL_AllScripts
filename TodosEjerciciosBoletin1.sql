
/*1. Una lista de
todos los detalles de la tabla de empleados.*/

select *
from employees;

/*2. Una lista de los nombres y apellidos de todos
los empleados.*/

select FirstName, LastName
from employees;


/*3. Una lista de todos los nombres de las
ciudades que aparecen en la tabla de empleados.*/

select City
from employees;

/*4. Una lista de los
nobres de productos y precios unitarios.*/

select ProductName, UnitPrice
from products;


/*5. En la tabla de empleados: una lista de los
detalles completos de los empleados que viven en EE.UU.*/

select *
from employees
where Country = "USA";


/*6. A partir de la tabla Pedidos, listar todos
los pedidos que tienen un gasto de envio > 50.*/

select *
from orders
where Freight>50;

/*7. De la tabla de clientes: listar nombre de la
empresa de todos los clientes donde el cargo es igual a Propietario.*/



/*8. A partir de los clientes una lista de todos
donde el nombre del cliente comienza con la letra "A”. (CONSULTAR COMANDO
“LIKE”)*/

select ContactName
from customers
where ContactName like 'A%';

/*9. Una lista de los nombres de clientes donde la
región no está en blanco.*/

select ContactName as "Nombre de Cliente"
from customers
where Region != "";

/*10. Una lista de todos los productos, ordenado
por precio unitario (el más barato primero).*/

select *
from products
order by UnitPrice;

/*11. Una lista de todos los productos, ordenado
por precio unitario (el más caro primero).*/
select *
from products
order by UnitPrice desc;

/*12. El número total de empleados. Nombre de la
columna de salida "TotalEmpleados".*/

select COUNT(EmployeeID) as "TotalEmpleados"
from employees;

/*13. De la tabla de Pedidos, el pedido con el
menor gasto de envió, el gasto de envió promedio y el máximo gasto de envió
(puede estar separado en 3 consultas distintas).*/


select min(Freight) "Pedido con menor gasto de envio", avg(Freight) "Gasto promedio de envio", max(Freight) "Pedido con mayor gasto de envio"
from orders;



/*14. Utilizando la tabla de clientes una lista de
los nombres de ciudades y el número de clientes en cada ciudad.*/

select City, count(ContactName)
from customers
group by city;

/*15. Utilizando la tabla de clientes una lista de
los nombres de ciudades y el número de clientes en cada ciudad. Solo las
ciudades con al menos 2 clientes deben aparecer en la lista.
*/

select City, count(City) as Contaje
from customers
group by City;


