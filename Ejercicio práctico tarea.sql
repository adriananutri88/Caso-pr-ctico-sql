--a) Crear la base de datos con el archivo create_restaurant_db.sql
--b) Explorar la tabla “menu_items” para conocer los productos del menú.

select * from menu_items;

--1.- Realizar consultas para contestar las siguientes preguntas:
--Encontrar el número de artículos en el menú.

select item_name from menu_items;
--Resultado 32 artículos en el menú

--¿Cuál es el artículo menos caro y el más caro en el menú?

select item_name, price 
from menu_items
order by price desc;

select item_name, price 
from menu_items
order by price;



--Resultado mas caro Shrimp Scampi 19.95 dolares, el ménos caro Edamame 5 dólares 

	
--¿Cuántos platos americanos hay en el menú?

SELECT *  FROM menu_items
WHERE category IN ('American');

--Resultado 6 
	
--¿Cuál es el precio promedio de los platos?

select round (avg(price), 2)
from menu_items;

--Resultado 13.29


--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.

select * from order_details;

--¿Cuántos pedidos únicos se realizaron en total?

select DISTINCT order_id
from order_details;

--Resultado 1000

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?


select order_id, count(item_id)
from order_details
group by order_id
order by count (item_id) desc
	limit 10

-- Resultado, se incrementó el límite porque hubo mas de 5 pedidos con el máyor número de artículos (14) 


--¿Cuándo se realizó el primer pedido y el último pedido?

select order_date 
from order_details
order by order_date;

select order_date 
from order_details
order by order_date desc;

--Resultado primer pedido 2023-01-01, último pedido 2023-03-31


● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

SELECT *  FROM order_details
WHERE order_date between '2023-01-01' and '2023-01-05';

select count (order_details_id)
from order_details
Where order_date between '2023-01-01' and '2023-01-05';	

--Resultado dice 702, se confunden tantos id

select count (order_id)
from order_details
Where order_date between '2023-01-01' and '2023-01-05';

-- Usar ambas tablas para conocer la reacción de los clientes respecto al menu

--realizar un left join entre order-details y menu_items con el identificador item_id (tabla order_details)y
--menu_item_id (tabla menu_items)


select * 
from order_details as o
left join menu_items as m
on o. item_id=m.menu_item_id

/*Una vez que hayas explorado los datos en las tablas correspondientes y respondido las preguntas planteadas, realiza un 
	análisis adicional utilizando este join entre las tablas. El objetivo es identificar 5 puntos clave que puedan ser de 
	utilidad para los dueños del restaurante en el lanzmiento de su nuevo menú. para ello crea tus propias consultas y 
	utiliza los resultados obtenidos para llegar a estas conclusiones*/


--1.-¿Cuáles fueron los platillos mas pedidos del menu?
select count (o.order_id), m.item_name
from order_details as o
left join menu_items as m
on o. item_id=m.menu_item_id
group by m. item_name

--2.-¿Cuáles son los 10 alimentos más pedidos?

select count (o.order_id), m. item_name
from order_details as o
left join menu_items as m
on o. item_id=m.menu_item_id
group by m. item_name
order by count (o.order_id)desc
limit 10


--3.-¿A qué categoría pertenecen los platillos más pedidos?

select count (o.order_id), m. item_name, category
from menu_items as m
left join order_details as o 
on o. item_id=m.menu_item_id
group by m. item_name, category
order by count (o.order_id)desc
limit 10

--4.-¿En que horarios se venden más las diferentes categorías de comida?
select count (o.order_id), m. item_name, category, order_time
from menu_items as m
left join order_details as o 
on o. item_id=m.menu_item_id
group by m. item_name, category, order_time
order by (order_time)
limit 50

--5.- ¿Cuáles son las categorías mas vendidas en los horarios contemplados entre el desayuno, comida y cena?
SELECT 
    COUNT(o.order_id) AS cantidad_vendida,
    m.item_name, 
    m.category, 
    CASE
        WHEN order_time < '13:00:00' THEN 'Desayuno'
        WHEN order_time >= '13:00:00' AND order_time < '18:00:00' THEN 'Comida'
        WHEN order_time >= '18:00:00' AND order_time < '24:00:00' THEN 'Cena'
    END AS horario_categoria
FROM 
    menu_items AS m
LEFT JOIN 
    order_details AS o
ON 
    o.item_id = m.menu_item_id
GROUP BY 
    m.item_name, 
    m.category, 
    horario_categoria
ORDER BY 
    cantidad_vendida; 



