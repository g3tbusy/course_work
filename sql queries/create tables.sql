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
    product_name        VARCHAR(100)                             NOT NULL,
    product_model       VARCHAR(60),
    product_description VARCHAR(300),
    product_price       NUMERIC(7, 2) CHECK (product_price >= 0) NOT NULL,
    category_name       VARCHAR(50)                              NOT NULL,
    category_id         INT                                      NOT NULL,
    FOREIGN KEY (category_name) REFERENCES Categories (category_name),
    FOREIGN KEY (category_id) REFERENCES Categories (category_id)
);

CREATE TABLE Orders
(
    order_id             SERIAL PRIMARY KEY,
    user_id              INT           NOT NULL,
    order_status         VARCHAR(30)   NOT NULL,
    order_date           DATE      DEFAULT CURRENT_DATE,
    order_time           TIME      DEFAULT CURRENT_TIMESTAMP,
    product_id           INT           NOT NULL,
    product_name         VARCHAR(100)  NOT NULL,
    delivery_address     VARCHAR(100)  NOT NULL,
    order_price          NUMERIC(7, 2) NOT NULL,
    order_delivery_price INT           NOT NULL,
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