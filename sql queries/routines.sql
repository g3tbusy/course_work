-- -- -- -- -- Процедуры на каскадное обновление -- -- -- -- --
-- 1. Процедура «update_product_price» обновляет цену продукта в таблице Products и все связанные данные в таблице Orders.
CREATE PROCEDURE update_product_price(
    IN p_product_id INT,
    IN p_new_price NUMERIC(7, 2)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE Products
    SET product_price = p_new_price
    WHERE product_id = p_product_id;

    UPDATE Orders
    SET order_price = p_new_price
    WHERE product_id = p_product_id;
END;
$$;
CALL update_product_price(1, 999.99);

-- 2. Каскадная процедура на обновление данных для таблицы Products, которая также обновляет связанные данные в таблице Orders.
CREATE PROCEDURE update_product_and_orders(
    IN p_product_id INT,
    IN p_product_name VARCHAR(100),
    IN p_product_model VARCHAR(60),
    IN p_product_description VARCHAR(300),
    IN p_product_price NUMERIC(7, 2)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE Products
    SET product_name        = p_product_name,
        product_model       = p_product_model,
        product_description = p_product_description,
        product_price       = p_product_price
    WHERE product_id = p_product_id;
    UPDATE Orders
    SET product_name = p_product_name
    WHERE product_id = p_product_id;
END;
$$;
CALL update_product_and_orders(102, 'New Product Name', 'New Model', 'New Description', 99.99);

-- 3. Каскадная процедура на обновление данных для таблицы Users, которая также обновляет связанные данные в таблице Orders.
CREATE PROCEDURE update_user_and_orders(
    p_user_id INT,
    p_user_name VARCHAR,
    p_user_email VARCHAR,
    p_user_password CHAR(50),
    p_user_mobile_number VARCHAR,
    p_delivery_address VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE Users
    SET user_name          = p_user_name,
        user_email         = p_user_email,
        user_password      = p_user_password,
        user_mobile_number = p_user_mobile_number
    WHERE user_id = p_user_id;
    UPDATE Orders
    SET delivery_address = p_delivery_address
    WHERE user_id = p_user_id;
END;
$$;

CALL update_user_and_orders(89, 'newname', 'newemail2@example.com', 'newpassword', '79749766551','new delivery address');


-- -- -- -- -- Процедуры на каскадное удаление -- -- -- -- --
-- 1. Процедура «Delete_User» удаляет пользователя из таблицы Users и все связанные с ним заказы и отзывы о продуктах.
CREATE PROCEDURE Delete_User(
    IN p_user_id INT
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    DELETE
    FROM ProductReviews
    WHERE user_id = p_user_id;
    DELETE
    FROM Orders
    WHERE user_id = p_user_id;
    DELETE
    FROM Users
    WHERE user_id = p_user_id;
END;
$$;

CALL Delete_User(11);

-- 2. Процедура предназначена для удаления продукта и связанных с ним отзывов и заказов из базы данных.
CREATE PROCEDURE delete_product_and_reviews(p_product_id INT)
    LANGUAGE plpgsql
AS
$$
BEGIN
    DELETE FROM Orders WHERE product_id = p_product_id;
    DELETE FROM ProductReviews WHERE product_id = p_product_id;
    DELETE FROM Products WHERE product_id = p_product_id;
END;
$$;

CALL delete_product_and_reviews(89);

-- 3.
CREATE PROCEDURE delete_category_products_orders_categories_reviews(IN category_id_to_delete INT)
    LANGUAGE plpgsql
AS
$$
DECLARE
    product_ids INT[];
BEGIN
    SELECT array_agg(product_id) INTO product_ids FROM Products WHERE category_id = category_id_to_delete;
    DELETE FROM ProductReviews WHERE product_id = ANY (product_ids);
    DELETE FROM Orders WHERE product_id = ANY (product_ids);
    DELETE FROM Products WHERE category_id = category_id_to_delete;
    DELETE FROM Categories WHERE category_id = category_id_to_delete;
END;
$$;

CALL delete_category_products_orders_categories_reviews(1);
