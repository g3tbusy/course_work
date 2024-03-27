-- Процедура для добавления нового пользователя
CREATE OR REPLACE PROCEDURE add_new_user(
    p_user_name VARCHAR(20),
    p_user_email VARCHAR(50),
    p_user_password CHAR(50),
    p_user_mobile_number VARCHAR(11)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO Users (user_name, user_email, user_password, user_mobile_number)
    VALUES (p_user_name, p_user_email, p_user_password, p_user_mobile_number);
END;
$$;

CALL add_new_user('new user', 'email@example.com', 'password123', '12345678901');

-- Процедура для добавления нового товара
CREATE OR REPLACE PROCEDURE add_new_product(
    p_product_name VARCHAR(100),
    p_product_model VARCHAR(60),
    p_product_description VARCHAR(300),
    p_product_price NUMERIC(7, 2),
    p_category_name VARCHAR(50),
    p_category_id INT
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO Products (product_name, product_model, product_description, product_price, category_name, category_id)
    VALUES (p_product_name, p_product_model, p_product_description, p_product_price, p_category_name, p_category_id);
END;
$$;

CALL add_new_product('new product', 'model X', 'description', 1000.00, 'Холодильники', 1);


-- Процедура для добавления нового заказа
CREATE OR REPLACE PROCEDURE add_new_order(
    p_order_id INT,
    p_user_id INT,
    p_order_status VARCHAR(30),
    p_product_id INT,
    p_product_name VARCHAR(100),
    p_delivery_address VARCHAR(100),
    p_order_price NUMERIC(7, 2),
    p_order_delivery_price INT
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO Orders (order_id, user_id, order_status, product_id, product_name, delivery_address, order_price,
                        order_delivery_price)
    VALUES (p_order_id, p_user_id, p_order_status, p_product_id, p_product_name, p_delivery_address, p_order_price,
            p_order_delivery_price);
END;
$$;

CALL add_new_order(112,5, 'В обработке', 103, 'new product', 'new address', 1000.00, 50);
