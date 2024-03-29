-- Индекс для ускорения поиска продуктов по категории
CREATE INDEX idx_category_id ON Products (category_id);

-- Индекс для ускорения поиска отзывов по продукту
CREATE INDEX idx_product_id ON ProductReviews (product_id);

-- Индекс для ускорения поиска заказов по пользователю
CREATE INDEX idx_user_id ON Orders (user_id);

-- Статистика и мониторинг
EXPLAIN SELECT * FROM Orders WHERE user_id = 68;

ANALYZE orders;

SELECT * FROM pg_stat_user_tables WHERE relname = 'orders';

SELECT * FROM pg_stat_activity;

SELECT * FROM pg_stat_user_tables;

SELECT * FROM pg_stat_user_indexes;