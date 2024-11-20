#Запрос на выборку избранных полей с использованием синонима и сортировкой записей
SELECT p.name AS ProductName, p.price AS ProductPrice FROM product p ORDER BY p.price DESC;

#Запрос с использованием сортировки и группировки
SELECT payment_for_delivery, COUNT(*) AS ShopCount
FROM shop GROUP BY payment_for_delivery ORDER BY ShopCount DESC;

#Запрос с использованием предложения DISTINCT
SELECT DISTINCT client_name FROM `order` ORDER BY client_name ASC;

#Запрос с использованием операций сравнения
SELECT name, price FROM product WHERE price > 1000;

#Запрос с предикатами IN, BETWEEN, LIKE, IS NULL
-- IN
SELECT name, firm FROM product WHERE firm IN ('Apple', 'Samsung');

-- BETWEEN
SELECT name, price FROM product WHERE price BETWEEN 500 AND 1500;

-- LIKE
SELECT client_name, client_phone FROM `order` WHERE client_name LIKE '%Doe%';

-- IS NULL
SELECT name, tech_spec FROM product WHERE tech_spec IS NULL;

#Запросы с использованием агрегатных функций (COUNT, SUM, AVG, MAX, MIN)
-- Количество заказов
SELECT COUNT(*) AS TotalOrders FROM `order`;

-- Суммарная стоимость всех продуктов
SELECT SUM(price) AS TotalProductPrice FROM product;

-- Средняя цена продуктов
SELECT AVG(price) AS AveragePrice FROM product;

-- Максимальная и минимальная цены продуктов
SELECT MAX(price) AS MaxPrice, MIN(price) AS MinPrice FROM product;

#Обобщенная групповая обработка значений полей (используя ключевые фразы GROUP BY и HAVING)
SELECT p.firm, COUNT(p.id_product) AS ProductCount, AVG(p.price) AS AvgPrice
FROM product p
GROUP BY p.firm
HAVING AVG(p.price) > 500;

#Запрос на выборку данных из двух связанных таблиц с сортировкой
SELECT o.id_order, p.name AS ProductName, o.quantity, o.order_date
FROM `order` o
JOIN product p ON o.product_id_product = p.id_product
ORDER BY o.order_date DESC;

#Многотабличный запрос с использованием внутреннего и внешнего соединения
-- INNER JOIN
SELECT d.id_delivery, d.date, d.address, o.client_name, p.name AS ProductName
FROM delivery d
INNER JOIN `order` o ON d.order_id_order = o.id_order
INNER JOIN product p ON o.product_id_product = p.id_product;

-- LEFT JOIN
SELECT o.id_order, p.name AS ProductName, d.courier_name, d.date
FROM `order` o
LEFT JOIN delivery d ON o.id_order = d.order_id_order
LEFT JOIN product p ON o.product_id_product = p.id_product
ORDER BY o.id_order;

-- RIGHT JOIN
SELECT o.id_order, p.name AS ProductName, d.courier_name, d.date
FROM `order` o
RIGHT JOIN delivery d ON o.id_order = d.order_id_order
RIGHT JOIN product p ON o.product_id_product = p.id_product
ORDER BY o.id_order;

#Многотабличный запрос с использованием оператора UNION
SELECT id_order AS ID, client_name AS Name, client_phone AS Contact
FROM `order`
UNION
SELECT id_delivery AS ID, client_name AS Name, NULL AS Contact
FROM `delivery`;