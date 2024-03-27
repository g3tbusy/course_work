-- -- -- -- Представления на выборку данных из нескольких таблиц с использованием условий отбора по нескольким полям -- -- -- --

-- Представление для просмотра заказов определенного пользователя. В данном случае user_id 1
CREATE VIEW UserOrders AS
SELECT o.order_id, p.product_name, o.order_date, o.order_price
FROM Orders o
         JOIN Products p ON o.product_id = p.product_id
WHERE o.user_id = 12;

-- Представление для просмотра отзывов определенного товара. В данном случае product_id 1
CREATE VIEW ProductSpecificReviews AS
SELECT pr.review_text, pr.review_rating, u.user_name
FROM ProductReviews pr
         JOIN Users u ON pr.user_id = u.user_id
WHERE pr.product_id = 99;

-- Представление для просмотра информации о продуктах определенной категории. В данном случае пылесосы
CREATE VIEW CategoryProducts AS
SELECT p.product_id, p.product_name, p.product_price, p.product_description
FROM Products p
         JOIN Categories c ON p.category_id = c.category_id
WHERE c.category_name = 'Пылесосы';

-- Представление для просмотра средней оценки продуктов в каждой категории.
CREATE VIEW AverageRatingPerCategory AS
SELECT c.category_name, ROUND(AVG(pr.review_rating), 1) AS avg_rating
FROM Categories c
         JOIN Products p ON c.category_id = p.category_id
         LEFT JOIN ProductReviews pr ON p.product_id = pr.product_id
GROUP BY c.category_name;










-- -- -- -- -- -- -- -- -- -- -- -- Представления с использованием расчетных полей -- -- -- -- -- -- -- -- -- -- -- --

-- Представление для просмотра информации о товарах с добавленным расчетным полем для скидки
CREATE VIEW ProductsWithDiscount AS
SELECT p.*,
       CASE
           WHEN p.product_price >= 25000 THEN p.product_price * 0.25
           ELSE 0
           END AS discount_amount
FROM Products p;

-- Представление для просмотра информации о заказах с добавленным расчетным полем для общей стоимости заказа
CREATE VIEW OrderTotalCost AS
SELECT o.*,
       o.order_price + o.order_delivery_price AS total_cost
FROM Orders o;










-- -- -- -- -- -- -- -- -- -- -- -- Представления с использованием оконных функций -- -- -- -- -- -- -- -- -- -- -- --

-- Представление для просмотра суммарной стоимости заказов по дням
CREATE VIEW DailyTotalOrderCost AS
SELECT order_date,
       SUM(order_price + order_delivery_price) OVER (PARTITION BY order_date) AS daily_total_cost
FROM Orders;

-- Представление для просмотра самых активных пользователей по количеству заказов
CREATE VIEW MostActiveUsers AS
SELECT user_id,
       COUNT(*) OVER (PARTITION BY user_id) AS total_orders
FROM Orders;










-- -- -- -- -- -- -- -- -- -- -- -- Представления с использованием групповых операций -- -- -- -- -- -- -- -- -- -- -- --

-- Представление для просмотра общей стоимости заказов в каждой категории
CREATE VIEW TotalOrderCostPerCategory AS
SELECT p.category_name, SUM(o.order_price + o.order_delivery_price) AS total_cost
FROM Orders o
         JOIN Products p ON o.product_id = p.product_id
GROUP BY p.category_name;

-- Представление для просмотра суммарной стоимости заказов для каждого пользователя
CREATE VIEW TotalOrderCostPerUser AS
SELECT user_id, SUM(order_price + order_delivery_price) AS total_cost
FROM Orders
GROUP BY user_id;

-- Представление для просмотра общего количества продуктов в каждой категории
CREATE VIEW TotalProductsPerCategory AS
SELECT p.category_id, c.category_name, COUNT(*) AS total_products
FROM Products p
         JOIN Categories c ON p.category_id = c.category_id
GROUP BY p.category_id, c.category_name;










-- -- -- -- -- -- -- -- Представления с использованием генерируемых столбцов (сохраняемых и не сохраняемых) -- -- -- -- -- -- -- --

-- Представление добавляет столбец total_reviews для просмотра общего количества отзывов для каждого продукта
CREATE VIEW ProductTotalReviews AS
SELECT p.*,
       COALESCE(pr.total_reviews, 0) AS total_reviews
FROM Products p
         LEFT JOIN (SELECT product_id, COUNT(*) AS total_reviews
                    FROM ProductReviews
                    GROUP BY product_id) pr ON p.product_id = pr.product_id;

-- Представление добавляет столбец avg_rating для просмотра среднего рейтинга каждого пользователя на основе отзывов о товарах
CREATE VIEW UserAverageRating AS
SELECT u.user_id, u.user_name, AVG(pr.review_rating) AS avg_rating
FROM Users u
         LEFT JOIN ProductReviews pr ON u.user_id = pr.user_id
GROUP BY u.user_id, u.user_name;