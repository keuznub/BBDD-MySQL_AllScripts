/*1-    Realizar una consulta que me muestre toda las
columnas de la tabla de productos
*/

select *
from products;

/*
2-    Realizar una consulta que me muestre el código, el
nombre y el precio del producto
*/


select ProductID,ProductName, UnitPrice
from products;


/*
3-    Realizar una consulta que me muestre el código,
nombre y la categoría de los productos que estén entre 18.00 y 20.00
*/
select ProductID,ProductName, UnitPrice
from products
where UnitPrice BETWEEN 18 and 20;



/*
4-    Realiza una consulta que permita presentar la fecha
actual mediante una función
*/

select now();

/*
5-    Realiza una consulta que permita presentar los
apellidos de los empleados en minúscula
*/

select lcase(LastName) 
from employees;

/*
6-    Realiza una consulta que permita presentar los
apellidos de los empleados en mayúscula
*/


select ucase(LastName) 
from employees;

/*
7-    Realiza una consulta que permita presentar las tres
primeras letras del nombre de los empleados
*/

select mid(LastName,1,3)
from employees;

/*
8-    Realiza una consulta que permita presentar el nombre
y apellido, y un correo electrónico de los empleados, éste deberá tener los
siguientes datos:


a.     La primera letra del nombre, seguida del apellido


b.     El correo deberá presentarse en minúscula

/*
9-    Realiza una consulta que permita presentar el nombre
y apellidos de los empleados que tengan más de 40 años
*/
select Nombre, Edad
From
(
select FirstName as Nombre, datediff(now(),BirthDate)/360 as Edad
from employees
) as SubConsulta
where Edad>70;


/*
10- Realiza una consulta que permita presentar el número
de fax que tiene cada país
*/

/*
11- Realiza una consulta que permita presentar el
máximo, mínimo y el promedio de años que llevan en la empresa los empleados
*/


select MIn(DATEDIFF(curdate(),hiredate)/365) as Mínimo, MAX(DATEDIFF(curdate(),hiredate)/365) as Máximo
from employees;


/*
12- Realiza
una consulta que permita presentar un listado de países que no tienen faxes con
su respectiva cantidad
*/


/*
13- Realiza
una consulta que permita presentar el nombre del cliente, el fax y el país al
que pertenece


14- Realiza
una consulta que muestre la mayor edad, la menor edad y la edad promedio de los
empleados. Recuerde que para eso tiene que buscar la diferencia entre la fecha
actual y la fecha de nacimiento.
*/

select max(BirthDate) as Mayor, min(BirthDate) as Menor, FirstName as nombre
from employees;

/*15- Realiza
una media del precio de los productos con funcion y sin funcion
*/

select  sum(UnitPrice)/count(unitPrice) "Media de productos Manual", avg(unitPrice) "Media de productos Funcion"
from products;


/*Realiza
Nombre n @ email.com*/

select FirstName, concat("n",FirstName,"@gmail.com")
from employees;