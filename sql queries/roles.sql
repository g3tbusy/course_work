-- Роль админа
CREATE ROLE admin WITH LOGIN PASSWORD 'admin';
GRANT ALL PRIVILEGES ON Users, Categories, Products, Orders, ProductReviews TO admin;

-- Роль модератора
CREATE ROLE moderator WITH LOGIN PASSWORD 'moderator';
GRANT SELECT, INSERT, UPDATE (user_name, user_email, user_mobile_number) ON Users TO moderator;
GRANT SELECT, INSERT, UPDATE, DELETE ON Orders TO moderator;
GRANT SELECT, INSERT, UPDATE, DELETE ON Products TO moderator;
GRANT SELECT, INSERT, UPDATE, DELETE ON ProductReviews TO moderator;

-- Роль клиента
CREATE ROLE customer;
GRANT SELECT, INSERT, UPDATE ON Users TO customer;
GRANT SELECT, INSERT, UPDATE ON Orders TO customer;
GRANT SELECT, INSERT ON ProductReviews TO customer;
GRANT SELECT ON Products TO customer;
GRANT SELECT ON Categories TO customer;
