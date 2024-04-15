#A partir de los clientes una lista de todos donde el nombre del cliente comienza con la letra "A”. (CONSULTAR COMANDO “LIKE”)
select *
from customers
where ContactName like 'A%';