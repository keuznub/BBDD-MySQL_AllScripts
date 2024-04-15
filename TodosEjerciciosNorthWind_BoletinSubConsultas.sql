USE northwind;
/*
1. Lista los empleados que han vendido más que el promedio de ventas de todos los
empleados.
*/
SELECT EmployeeID, count(*)
FROM orders 
GROUP BY EmployeeID
HAVING count(*) > (SELECT avg(contaje) as avgContaje FROM (SELECT count(*) AS contaje FROM orders GROUP BY EmployeeID) as subquery);

/*
2. Encuentra los productos que tienen un precio mayor al precio promedio de todos
los productos.
*/

SELECT ProductID,ProductName, UnitPrice, (SELECT avg(UnitPrice) from products) "Precio Medio"
FROM products 
WHERE UnitPrice > (SELECT avg(precio) as avgprecio FROM (SELECT UnitPrice AS precio FROM products) as subquery);

/*
3. Selecciona los clientes que han realizado órdenes por encima del valor promedio
de todas las órdenes.
*/

SELECT a.CustomerID,a.ContactName
FROM customers a JOIN orders b ON a.CustomerID = b.CustomerID JOIN orderdetails c ON b.OrderID = c.OrderID
WHERE c.Quantity*c.UnitPrice > (SELECT AVG(Quantity*UnitPrice) FROM orderdetails)
GROUP BY a.CustomerID;

/*
4. Muestra los proveedores cuyo total de productos suministrados es mayor al
promedio de productos suministrados por todos los proveedores.
*/

SELECT b.SupplierID, a.CompanyName,  count(*) as productosSuministrados
FROM suppliers a JOIN products b ON a.SupplierID=b.SupplierID
GROUP BY b.SupplierID 
HAVING count(*) > avg(productosSuministrados);

/*
5. Encuentra las órdenes que contienen el producto más vendido.
*/
SELECT *
FROM orders
WHERE orderID IN (SELECT OrderID FROM orderdetails WHERE ProductID IN (SELECT ProductID FROM products WHERE UnitsOnOrder = (SELECT MAX(UnitsOnOrder) FROM products)));

/*
6. Lista los empleados que no han realizado ninguna venta.
*/
SELECT *
FROM employees
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM orders);

/*
7. Obtén los clientes que han comprado todos los productos de una categoría
específica.
*/
SELECT *
FROM customers
WHERE CustomerID IN (SELECT CustomerID FROM orders WHERE OrderID IN (SELECT OrderID FROM orderdetails WHERE ProductID IN (SELECT ProductID FROM products WHERE CategoryID=5)));

/*
8. Determina los productos que nunca han sido ordenados.
*/
SELECT *
FROM products
WHERE ProductID NOT IN (SELECT ProductID FROM orderdetails WHERE OrderID IN (SELECT OrderID FROM orders));

SELECT a.ProductID, a.UnitPrice ,count(*)
FROM orderdetails a JOIN orders b ON  a.OrderID = b.OrderID
GROUP BY ProductID;

/*
9. Selecciona las categorías de productos que solo tienen productos con precio
mayor a un valor específico.
*/
SELECT CategoryID
FROM products
WHERE ProductID IN (SELECT ProductID FROM orderdetails WHERE UnitPrice > 96)
GROUP BY CategoryID;

/*
10. Encuentra los clientes que han realizado órdenes en cada cuarto del año.
*/
SELECT *
FROM customers
WHERE CustomerID IN (SELECT CustomerID FROM orders WHERE (SELECT MONTH(orderDate)) IN (1,2,3,4));

SELECT *
FROM customers
WHERE CustomerID IN (SELECT CustomerID FROM orders WHERE (SELECT MONTH(orderDate)) IN (5,6,7,8));

SELECT *
FROM customers
WHERE CustomerID IN (SELECT CustomerID FROM orders WHERE (SELECT MONTH(orderDate)) IN (9,10,11,12));


/*
11. Muestra los productos que han sido comprados en una cantidad total mayor a un
valor específico.
*/
SELECT a.ProductID, count(*) "Ordenes"
FROM products a JOIN orderdetails b ON a.ProductID = b.ProductID JOIN orders c ON b.OrderID = c.OrderID
GROUP BY ProductID
HAVING count(*) > 20;

/*
12. Identifica los empleados que han vendido a más clientes distintos.
*/
SELECT EmployeeID, count(DISTINCT customerID) as Contador, (SELECT AVG(cont) FROM (SELECT count(DISTINCT CustomerID) as cont from orders group by EmployeeID) as subquery) as media
FROM orders
GROUP BY EmployeeID
HAVING contador>media;

/*
13. Selecciona las órdenes realizadas por clientes que nunca han comprado un
producto específico.
*/
SELECT OrderID,CustomerID
FROM orders
WHERE OrderID NOT IN (SELECT OrderID FROM orderdetails WHERE ProductID = 1);

/*
14. Encuentra los proveedores cuyos productos tienen un precio promedio superior al
de otros proveedores.
*/