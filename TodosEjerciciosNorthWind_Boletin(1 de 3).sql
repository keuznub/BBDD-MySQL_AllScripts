USE northwind;
/*
Ejercicio 101
Seleccione todos los campos de la tabla cliente, ordenado por nombre del contacto de la compañía,
alfabéticamente.
*/
SELECT *
FROM Customers
ORDER BY CompanyName;

/*
Ejercicio 102
Seleccione todos los campos de la tabla órdenes, ordenados por fecha de la orden,
descendentemente.
*/
SELECT *
FROM orders
ORDER BY orderdate desc;

/*
Ejercicio 103
Seleccione todos los campos de la tabla detalle de la orden, ordenada por cantidad pedida.
Ascendentemente.
*/

SELECT *
FROM orderdetails
ORDER BY quantity;

/*
Ejercicio 104
Obtener todos los productos, cuyo nombre comienzan con la letra P y tienen un precio unitario
comprendido entre 10 y 120.
*/
SELECT *
FROM Products
WHERE ProductName LIKE "P%" AND UnitPrice BETWEEN 10 AND 120;

/*
Ejercicio 105
Obtener todos los clientes de los países de: USA, Francia y UK.
*/

SELECT *
FROM customers
WHERE country IN ("USA","FRANCE","UK");


/*
Ejercicio 105 bis
Contar todos los clientes de los países de: USA, Francia y UK.
*/
SELECT COUNT(*) "Total"
FROM customers
WHERE country IN ("USA","FRANCE","UK");


SELECT Country,COUNT(*)
FROM customers
WHERE country IN ("USA","FRANCE","UK")
GROUP BY country;


/*
Ejercicio 106
Obtener todos los productos descontinuados y sin stock, que pertenecen a la categoria 1, 3, 4 y
7.
*/

SELECT *
FROM products
WHERE Discontinued=1 OR UnitsInStock=0 OR CategoryID IN (1,3,4,7);


/*
Ejercicio 107
Obtener todas las órdenes hechas por el empleado con código: 2, 5 y 7 en el año 1996
*/

SELECT *
FROM orders
WHERE EmployeeID IN (2,5,7) AND YEAR(OrderDate)=1996;

/*
Ejercicio 108
Seleccionar todos los clientes que cuenten con Fax
*/

SELECT *
FROM customers
WHERE Fax IS NOT NULL AND FAX != "";

/*
Ejercicio 109
Seleccionar todos los clientes que no cuenten con FAX, del País de USA
*/
SELECT *
FROM customers
WHERE (FAX IS NULL OR FAX = "") AND  COUNTRY = "USA";

/*
Ejercicio 110
Seleccionar todos los empleados que cuentan con un jefe.
*/

SELECT *
FROM employees
WHERE ReportsTo IS NOT NULL;

/*
Ejercicio 111
Seleccionar todos los campos del cliente, cuya compañía empiecen con letra A hasta la D y
pertenezcan al país USA, ordenarlos por la dirección.
*/
SELECT *
FROM customers
WHERE (CompanyName LIKE "A%" OR CompanyName LIKE "B%" OR CompanyName LIKE "C%" OR CompanyName LIKE "D%") AND Country = "UK";


SELECT *
FROM customers
WHERE (CompanyName BETWEEN "A%" AND "E%") AND Country = "Uk";



/*
Ejercicio 112
Seleccionar todos los campos del cliente, cuya compañía empiece con las letras de la B a la G, y
pertenezcan al país de UK, ordenarlos por nombre de la compañía.
*/

SELECT *
FROM customers
WHERE ASCII(substring(companyName, 1,1)) BETWEEN 66 AND 71;

/*
Ejercicio 113
Seleccionar los productos vigentes cuyos precios unitarios están entre 35 y 250, sin stock en
almacén, pertenecientes a las categorías 1, 3, 6, 7 y 8, que son distribuidos por los proveedores, 2, 4,
6, 7, 8 y 9.
*/

SELECT *
FROM  products
WHERE (UnitPrice BETWEEN 35 AND 250) and UnitsInStock = 0 and CategoryID IN (1,3,6,7,8) and SupplierID IN (2, 4, 6, 7, 8, 9);

/*
Ejercicio 114
Seleccionar todos los campos de los productos, que pertenezcan a los proveedores con códigos: 1,
3, 7, 8 y 9, que tengan stock en almacén, y al mismo tiempo que sus precios unitarios estén entre
39 y 190, ordenados por código de proveedores y precio unitario de manera ascendente.
*/
SELECT *
FROM  products
WHERE (UnitPrice BETWEEN 39 AND 190) OR UnitsInStock > 0 OR CategoryID IN (1,3,6,7,8) OR SupplierID IN (1, 3, 7, 8, 9)
ORDER BY SupplierID, UnitPrice;

/*
Ejercicio 115
Seleccionar los 7 productos con precio más caro, que cuenten con stock en almacén.
*/
SELECT *
FROM products
WHERE UnitsInStock > 0 
ORDER BY UnitPrice DESC LIMIT 7;


/*
Ejercicio 116
Seleccionar los 9 productos, con menos stock en almacén, que pertenezcan a la categoría 3, 5 y 8.
*/
SELECT *
FROM products
WHERE CategoryID IN (3,5,8)
ORDER BY UnitsInStock LIMIT 9;



/*
Ejercicio 117
Seleccionar las órdenes de compra, realizadas por el empleado con código entre el 2 y 5, además
de los clientes con código que comienzan con las letras de la A hasta la G, del 31 de julio de
cualquier año.
*/
SELECT *
FROM orders 
WHERE ((EmployeeID BETWEEN 2 AND 5) AND (ASCII(SUBSTRING(CustomerID,1,1)) BETWEEN 65 AND 71)) AND (MONTH(orderDate)=7 AND DAY(orderDate)=31);

/*
Ejercicio 118
Seleccionar las órdenes de compra, realizadas por el empleado con código 3, de cualquier año pero
solo de los úlimos 5 meses (agosto-Diciembre).
*/
SELECT *
FROM orders
WHERE EmployeeID = 3 AND MONTH(OrderDate) BETWEEN 8 AND 12;

/*
Ejercicio 119
Seleccionar los detalles de las órdenes de compra, que tengan un monto de cantidad pedida entre 10
y 250.
*/
SELECT *
FROM orderdetails
WHERE Quantity BETWEEN 10 AND 250;

/*
Ejercicio 120
Selecciona las líneas de pedido cuyo importe total de la línea estén entre 10 y 100.
*/
SELECT OrderID,Quantity*UnitPrice "Importe total"
FROM orderdetails
WHERE (Quantity*UnitPrice) BETWEEN 10 AND 100;

/*
Ejercicio 121
Muestra un listado con los distintos países de los clientes.
*/
SELECT DISTINCT Country
FROM customers;


SELECT Country
FROM customers
GROUP BY Country;

/*
Ejercicio 201
Realizar una consulta que me muestre todas las columnas de la tabla de productos.
*/
SELECT *
FROM products;

/*
Ejercicio 202
Realizar una consulta que me muestre el código, el nombre y el precio del producto.
*/
SELECT ProductID "ID", ProductName "Name", UnitPrice "Unit Price"
FROM products;



/*
Ejercicio 203
Realizar una consulta que me muestre el código, nombre y la categoría de los productos cuyo precio
que estén entre 18.00 y 20.00.
*/
SELECT ProductID "ID", ProductName "Name", UnitPrice "Unit Price"
FROM products
WHERE UnitPrice BETWEEN 18.00 AND 20.00;

/*
Ejercicio 204
Realiza una consulta que permita presentar la fecha actual mediante una función.
*/
SELECT curdate();
SELECT NOW();

/*
Ejercicio 205
Realiza una consulta que permita presentar los apellidos de los empleados en minúscula.
*/
SELECT lower(LastName), upper(LastName)
FROM employees;

/*
Ejercicio 206
Realiza una consulta que permita presentar el nombre y apellido, y un correo electrónico de los
empleados, éste deberá tener los siguientes datos:
a. La primera letra del nombre, seguida del apellido.
b. El correo deberá presentarse en minúscula.
*/

SELECT FirstName,LastName,LOWER(CONCAT(SUBSTRING(FirstName,1,1),lastName,"@gmail.com"))
FROM employees;

/*
Ejercicio 207
Realiza una consulta que permita presentar el nombre y apellidos de los empleados que tengan más
de 40 años.
*/

SELECT FirstName, LastName, BirthDate, FLOOR(DATEDIFF(now(),BirthDate)/365) "AGE"
FROM employees
WHERE FLOOR(DATEDIFF(now(),BirthDate)/365)>40;


/*
Ejercicio 208
Realiza una consulta que permita presentar el número de fax que tiene cada país.
*/
SELECT Country, fax
FROM customers;

/*
Ejercicio 209
Realiza una consulta que permita presentar el máximo, mínimo y el promedio de años que llevan en
la empresa los empleados.
*/
SELECT MAX(FLOOR(DATEDIFF(now(),HireDate)/365)) "MAX HIRED",MIN(FLOOR(DATEDIFF(now(),HireDate)/365)) "MIN HIRED",AVG(FLOOR(DATEDIFF(now(),HireDate)/365)) "AVG HIRED"
FROM employees;

/*
Ejercicio 210
Realiza una consulta que permita presentar un listado de países que no tienen faxes con su
respectiva cantidad de clientes.
*/
SELECT Country, CustomerID, True "No tiene fax" ,fax
FROM customers
WHERE fax IS NULL OR fax = "";

/*
Ejercicio 210 bis
Realiza una consulta que permita presentar un listado de países que no tienen faxes con su
respectiva cantidad de clientes.
*/
SELECT Country, COUNT(*) "Clientes sin fax"
FROM customers
WHERE fax IS NULL OR fax = ""
GROUP BY COUNTRY;

/*
Ejercicio 211
Realiza una consulta que permita presentar el nombre del cliente, el fax y el país al que pertenece
*/
SELECT ContactName, fax, country
FROM customers;

/*
Ejercicio 212
Realiza una consulta que muestre la mayor edad, la menor edad y la edad promedio de los
empleados. Recuerde que para eso tiene que buscar la diferencia entre la fecha actual y la fecha de
nacimiento.
*/
SELECT MAX(FLOOR(DATEDIFF(now(),BirthDate)/365)) "MAX AGE",MIN(FLOOR(DATEDIFF(now(),BirthDate)/365)) "MIN AGE",AVG(FLOOR(DATEDIFF(now(),BirthDate)/365)) "AVG AGE"
FROM employees;


/*
Ejercicio 213
Realiza una consulta que muestre la cantidad de facturas que se han registrado por cada año (order
date).
*/
SELECT YEAR(orderDate),Count(*)
FROM orders
GROUP BY YEAR(orderDate);


/*
Ejercicio 214
Realiza una consulta que muestre la cantidad de facturas que se han registrado por cada año, mes y
empleado.
*/
SELECT YEAR(orderDate),MONTH(orderDate),EmployeeID,Count(*)
FROM orders
GROUP BY YEAR(orderDate) + MONTH(orderDate) + EmployeeID;

/*
Ejercicio 215
Realiza una consulta que me permita mostrar el número de la factura y el valor por concepto de
envío.
*/
SELECT OrderID, Freight "Gastos envio"
FROM orders;

/*
Ejercicio 216
Realiza una consulta que me permita mostrar el número de la factura y el valor por concepto de
envío pero de aquellos que superen a los 10.
*/
SELECT OrderID, Freight "Gastos envio"
FROM orders
WHERE Freight>10;

/*
Ejercicio 217
Realiza una consulta que muestre el código de la categoría, el total de productos que tiene la
categoría únicamente para las categorías que tengan más de 10 productos. Para esto utilice la
cláusula having.
*/

SELECT CategoryID,COUNT(*)
FROM products
GROUP BY CategoryID
HAVING COUNT(*)>10;

/*
Ejercicio 218
Realizar una consulta que permita presentar el nombre del producto y con su respetiva categoría.
*/
SELECT ProductName, CategoryID
FROM products;

/*
Ejercicio 219
Realizar una búsqueda de los nombres de compañías con las cuales se ha tenido ventas, ordenar por
el código del vendedor.
*/
SELECT a.SupplierID, b.CompanyName, a.UnitsOnOrder
FROM products a JOIN suppliers b ON a.SupplierID = b.SupplierID
WHERE UnitsOnOrder>0
ORDER BY a.SupplierID;

/*
Ejercicio 220
Realiza una consulta que muestre el listado de las facturas de cada cliente. El listado debe tener las
siguientes columnas: nombre del cliente, país del cliente no. De factura fecha de factura ordenado
por nombre del cliente en forma ascendente y luego por la fecha de la factura de forma descendente.
*/

SELECT a.ContactName, a.Country, b.OrderID, b.OrderDate
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID
ORDER BY a.ContactName, b.OrderDate desc;

/*
Ejercicio 221
Búsqueda de los nombres de compañías con las cuales se ha tenido ventas, ordenar por el código del
vendedor.
*/
SELECT a.SupplierID, b.CompanyName, a.UnitsOnOrder
FROM products a JOIN suppliers b ON a.SupplierID = b.SupplierID
WHERE UnitsOnOrder>0
ORDER BY a.SupplierID;

/*
Ejercicio 222
Realiza una consulta que muestre un listado de los clientes y el monto total que nos han comprado
de los 5 clientes que más han comprado. El listado debe tener las siguientes columnas: código del
cliente, nombre del contacto, monto total. Ordenado por el monto total de forma descendente.
*/
SELECT a.CustomerID, a.ContactName, CONCAT(ROUND(SUM(c.Quantity*c.UnitPrice),2),"€") "Monto Total"
FROM customers a JOIN Orders b ON a.CustomerID = b.CustomerID JOIN orderdetails c ON b.OrderID = c.OrderID
GROUP BY a.CustomerID
ORDER BY (ROUND(SUM(c.Quantity*c.UnitPrice),2)) DESC;

/*
Ejercicio 223
Realiza una consulta que muestre un listado de los empleados de la empresa en los diferentes
territorios. El listado debe tener las siguientes columnas: nombre del empleado ,id de la región y
descripción del territorio ordenado por el nombre completo del empleado de forma ascendente
*/
SELECT CONCAT(a.Firstname," ",a.LastName) "Name", c.RegionID "Region ID", d.RegionDescription "Region Decription"
FROM employees a JOIN employeeterritories b ON a.EmployeeID = b.EmployeeID JOIN territories c ON b.TerritoryID = b.TerritoryID JOIN region d ON c.RegionID = d.RegionID
ORDER BY CONCAT(a.Firstname," ",a.LastName);


/*
Ejercicio 301
Obtén los nombres de los clientes que han hecho pedidos después del 1/1/98.
*/
SELECT a.ContactName "Name", b.OrderDate "Fecha"
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID
WHERE b.OrderDate > "1998-01-01"
ORDER BY b.orderDate;

/*
Ejercicio 302
Obtén los nombres de los productos y de las compañías que los suministran. Los productos sin
suministradores asignados y los suministradores sin productos asignados no se incluyen en el
conjunto de resultados.
*/
SELECT a.SupplierID, b.CompanyName, a.ProductName 
FROM products a JOIN suppliers b ON a.SupplierID = b.SupplierID
ORDER BY a.SupplierID;

/*
Ejercicio 303
Realiza una consulta que permita presentar el número de la factura y el código del cliente al cual
ésta pertenece.
*/

SELECT a.OrderID, b.CustomerID
FROM orders a JOIN customers b ON a.CustomerID = b.CustomerID;

/*
Ejercicio 304
Realiza una consulta que muestre el listado de productos en el cual se incluya el precio del
producto, la diferencia entre el precio del producto y el precio promedio de todos los productos.
El listado debe incluir las siguientes columnas: nombre del producto, precio unitario, precio
promedio de todos los productos, deferencia entre el precio promedio y el precio del producto.
*/
SELECT ProductName, UnitPrice, CONCAT(ROUND((SELECT AVG(UnitPrice) FROM products),2),"€") "Precio Medio de todos", CONCAT(ROUND(UnitPrice-(SELECT AVG(UnitPrice) FROM products),2),"€") "Diferencia", UnitPrice*QuantityPerUnit "Prectio producto"
FROM products;

/*
Ejercicio 305
Realiza una consulta que muestre un listado de productos en el cual se incluya el porcentaje que el
producto representa para todo el inventario.
El listado debe incluir las siguientes columnas: nombre del producto, monto del producto, monto
total del inventario, porcentaje que representa el producto para el inventario.
*/

SELECT productName, CONCAT(ROUND(QuantityPerUnit*UnitPrice,2),"€"),  CONCAT(ROUND((SELECT SUM(QuantityPerUnit*UnitPrice) FROM products),2),"€") "Monto total inventario", CONCAT(ROUND(((QuantityPerUnit*UnitPrice)/(SELECT SUM(QuantityPerUnit*UnitPrice) FROM products)*100),2),"%") "Porcentaje para el inventario"
FROM products;

/*
Ejercicio 306
Realiza una consulta que muestre un listado donde se incluya los clientes que han comprado
productos de todas las categorías. Las columnas deberán ser: código del cliente y nombre del
cliente.
*/

SELECT a.CustomerID, a.ContactName, GROUP_CONCAT(DISTINCT d.CategoryID ORDER BY d.CategoryID) "Categorias compradas", SUM(DISTINCT d.CategoryID) "SUMA"
FROM customers a JOIN orders b  ON  a.CustomerID = b.CustomerID JOIN orderdetails c ON b.OrderID = c.OrderID JOIN products d ON d.ProductID = c.ProductID
GROUP BY a.CustomerID
HAVING SUM(DISTINCT d.CategoryID)= 36
ORDER BY a.customerID, d.CategoryID;





/*
Ejercicio 307
Realiza una consulta que muestre el listado de aquellos productos cuyo promedio de unidades en
pedidos sea mayor de 2.
*/
/*No era asi*/
SELECT a.productName, a.ProductID, c.OrderID, COUNT(*)
FROM products a JOIN  orderdetails b ON a.ProductID = b.ProductID JOIN orders c ON b.OrderID = c.OrderID
GROUP BY a.ProductID
HAVING COUNT(*)>2;

/*Era asi*/
SELECT a.productName, a.UnitsOnOrder
FROM products a
WHERE UnitsOnOrder > 2;

/*
Ejercicio 308
Muestra el importe total que ha gastado cada cliente..
*/

SELECT a.CustomerID, CONCAT(ROUND(SUM(c.UnitPrice*c.Quantity),2),"€")
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID JOIN orderdetails c ON b.OrderID = c.OrderID
GROUP BY a.CustomerID
ORDER BY a.CustomerID;


/*
Ejercicio 309
Realiza una consulta que muestre un listado de las Facturas de Cada Cliente.
El listado debe tener las siguientes columnas: Nombre del Cliente, País del Cliente, No. de Factura,
Fecha de Factura ordenado por Nombre del Cliente de forma ascendente y luego por la fecha de la
factura de forma descendente.
*/

SELECT a.ContactName, a.Country, b.OrderID, b.OrderDate
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID
ORDER BY a.ContactName, b.OrderDate;

/*
Ejercicio 310
Realiza una consulta que muestre un listado de los empleados que le han vendido a cada cliente. El
listado debe tener las siguientes columnas: Nombre del Cliente, Nombre completo del Empleado
ordenado por Nombre del Cliente de forma ascendente y luego por el Nombre completo del
empleado de forma ascendente.
*/

SELECT a.ContactName, CONCAT(c.FirstName," ",c.LastName)
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID JOIN  employees c ON b.EmployeeID = c.EmployeeID
ORDER BY 1, 2;

/*
Ejercicio 311
Realiza una consulta que muestre un listado de los clientes y el número de facturas de cada cliente.
El listado debe tener las siguientes columnas: Código Cliente, Nombre Cliente, total de facturas del
Cliente.
*/

SELECT a.CustomerID, a.ContactName, COUNT(*)
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID JOIN orderdetails c ON b.OrderID = c.OrderID
GROUP BY a.CustomerID;


/*
Ejercicio 312
Realiza una consulta que muestre un listado de los clientes y el monto total que nos han comprado
de los 5 clientes que más han comprado. El listado debe tener las siguientes columnas: Código del
Cliente, Nombre Cliente, Monto Total gastado y ordenado por el Monto Total de forma
descendente.
*/

SELECT a.CustomerID, a.ContactName, COUNT(*)
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID
GROUP BY a.CustomerID
ORDER BY COUNT(*) DESC
LIMIT 5;

/*
Ejercicio 313
Realiza una consulta que muestre un listado de las ventas que se han hecho por categoría. El listado
debe tener las siguientes columnas: Nombre Categoría, Monto Total y ordenado por el Monto Total
de Forma ascendente.
*/

SELECT a.CategoryID, a.CategoryName, CONCAT(ROUND((SUM(c.UnitPrice*c.Quantity)*(1-c.Discount)),2),"€")
FROM categories a JOIN products b ON a.CategoryID = b.CategoryID JOIN orderdetails c ON b.ProductID = c.ProductID JOIN orders d ON c.OrderID = d.OrderID
GROUP BY a.CategoryID
ORDER BY 3 asc;

/*
Ejercicio 314
Selecciona los datos de los productos con el nombre de la categoría a la que pertenece.
*/

SELECT a.*, b.CategoryName
FROM products a JOIN categories b ON a.CategoryID = b.CategoryID;

/*
Ejercicio 315
Haz un listado que muestre el importe total de cada pedido.
*/

SELECT a.OrderID, CONCAT(ROUND((b.UnitPrice*b.Quantity *(1-b.Discount)),2),"€") "Importe total"
FROM orders a JOIN  orderdetails b ON a.OrderID = b.OrderID;

/*
Ejercicio 316
Haz un listado que muestre el stock de cada producto y el número de unidades vendidas.
*/

SELECT a.ProductID, a.UnitsInStock, COUNT(*) "Unidades vendidas"
FROM products a JOIN orderdetails b ON a.ProductID = b.ProductID JOIN orders c ON b.OrderID = c.OrderID
GROUP BY a.ProductID;

/*
Ejercicio 317
Modifica el listado anterior para poder filtrar las ventas por mes y año.
*/

SELECT a.ProductID, a.UnitsInStock, COUNT(*) "Unidades vendidas", YEAR(c.OrderDate) "Año", MONTH(c.OrderDate) "Mes"
FROM products a JOIN orderdetails b ON a.ProductID = b.ProductID JOIN orders c ON b.OrderID = c.OrderID
GROUP BY YEAR(c.OrderDate),MONTH(c.OrderDate)
ORDER BY 4,5;

/*
Ejercicio 318
Muestra un listado con las ventas totales que ha tenido cada cliente en cada año.
*/



