CREATE TABLE Users
(
    user_id            SERIAL PRIMARY KEY NOT NULL,
    user_name          VARCHAR(20)        NOT NULL,
    user_email         VARCHAR(50)        NOT NULL UNIQUE,
    user_password      CHAR(50)           NOT NULL,
    user_mobile_number VARCHAR(11)        NOT NULL CHECK (LENGTH(user_mobile_number) = 11) UNIQUE
);

CREATE TABLE Categories
(
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Products
(
    product_id          SERIAL PRIMARY KEY,
    product_name        VARCHAR(50)                              NOT NULL,
    product_model       VARCHAR(15),
    product_description VARCHAR(300),
    product_price       NUMERIC(7, 2) CHECK (product_price >= 0) NOT NULL,
    category_name       VARCHAR(50)                              NOT NULL,
    category_id         INT                                      NOT NULL,
    FOREIGN KEY (category_name) REFERENCES Categories (category_name),
    FOREIGN KEY (category_id) REFERENCES Categories (category_id)
);

CREATE TABLE Orders
(
    order_id               SERIAL PRIMARY KEY,
    user_id                INT           NOT NULL,
    order_status           VARCHAR(30)   NOT NULL,
    order_product_quantity INT,
    order_date             DATE      DEFAULT CURRENT_DATE,
    order_time             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    product_id             INT           NOT NULL,
    product_name           VARCHAR(50)   NOT NULL,
    product_model          VARCHAR(15),
    delivery_address       VARCHAR(100)  NOT NULL,
    order_total_price      NUMERIC(7, 2) NOT NULL CHECK (order_total_price >= 0),
    FOREIGN KEY (user_id) REFERENCES Users (user_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

CREATE TABLE ProductReviews
(
    review_id     SERIAL PRIMARY KEY,
    user_id       INT NOT NULL,
    product_id    INT NOT NULL,
    review_text   VARCHAR(500),
    review_rating NUMERIC(2, 1) CHECK (review_rating >= 1 AND review_rating <= 5),
    review_date   DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (user_id) REFERENCES Users (user_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);
-- -- -- -- -- -- -- -- -- -- -- -- --
INSERT INTO Users (user_id, user_name, user_email, user_password, user_mobile_number)
VALUES (1, 'Джон Доу', 'johndoe@example.com', '********', '12345678901'),
       (2, 'Джейн Смит', 'janesmith@example.com', '********', '98765432109'),
       (3, 'Боб Джонсон', 'bob@example.com', '********', '45678901234'),
       (4, 'Алиса Чан', 'alice@example.com', '********', '78901234567'),
       (5, 'Дэвид Ли', 'david@example.com', '********', '56789012345');

INSERT INTO Categories (category_id, category_name)
VALUES (1, 'Холодильники'),
       (2, 'Стиральные машины'),
       (3, 'Телевизоры'),
       (4, 'Микроволновые печи'),
       (5, 'Посудомоечные машины');

INSERT INTO Products (product_id, product_name, product_model, product_description, product_price, category_name,
                      category_id)
VALUES (1, 'Холодильник Samsung', 'FRG123', 'Большой объем, энергоэффективный', 1200.00, 'Холодильники', 1),
       (2, 'Стиральная машина LG', 'WSH456', 'Фронтальная загрузка, 8 кг', 699.99, 'Стиральные машины', 2),
       (3, 'Телевизор Sony 4K', 'TVS789', '65 дюймов, смарт-телевизор', 1500.00, 'Телевизоры', 3),
       (4, 'Микроволновая печь Panasonic', 'MCR012', '1000 Вт, 1.2 куб.фут.', 129.99, 'Микроволновые печи', 4),
       (5, 'Посудомоечная машина Bosch', 'DIS345', 'Нержавеющая сталь, 14 комплектов посуды', 899.00,
        'Посудомоечные машины', 5);

INSERT INTO Orders (order_id, user_id, order_status, order_product_quantity, order_date, order_time, product_id,
                    product_name, product_model, delivery_address, order_total_price)
VALUES (1, 2, 'Доставлен', 1, '2024-03-20', '2024-03-20 10:15:00', 3, 'Телевизор Sony 4K', 'TVS789',
        '123 Главная улица', 1500.00),
       (2, 4, 'Обработка', 2, '2024-03-21', '2024-03-21 14:30:00', 1, 'Холодильник Samsung', 'FRG123', '456 Улица Элм',
        2400.00),
       (3, 1, 'Доставлен', 1, '2024-03-22', '2024-03-22 16:45:00', 5, 'Посудомоечная машина Bosch', 'DIS345',
        '789 Улица Дуб', 899.00),
       (4, 3, 'Доставлен', 1, '2024-03-23', '2024-03-23 09:00:00', 4, 'Микроволновая печь Panasonic', 'MCR012',
        '101 Улица Пайн', 129.99),
       (5, 5, 'Обработка', 3, '2024-03-24', '2024-03-24 12:00:00', 2, 'Стиральная машина LG', 'WSH456',
        '202 Улица Клён', 2099.97);

INSERT INTO ProductReviews (review_id, user_id, product_id, review_text, review_rating, review_date)
VALUES (1, 1, 1, 'Просторный и энергоэффективный', 4.5, '2024-03-20'),
       (2, 2, 3, 'Отличное качество изображения', 5.0, '2024-03-21'),
       (3, 3, 4, 'Легко использовать', 4.0, '2024-03-22'),
       (4, 4, 5, 'Эффективно моет посуду', 4.5, '2024-03-23'),
       (5, 5, 2, 'Работает тихо', 4.2, '2024-03-24');
