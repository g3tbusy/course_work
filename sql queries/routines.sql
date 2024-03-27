-- Процедура для обновления названия категории в таблице Products
CREATE OR REPLACE PROCEDURE update_product_category_name(
    IN old_category_name VARCHAR(50),
    IN new_category_name VARCHAR(50)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE Products
    SET category_name = new_category_name
    WHERE category_name = old_category_name;
END;
$$;


-- Процедура для обновления названия категории в таблице Orders
CREATE OR REPLACE PROCEDURE update_order_category_name(
    IN old_category_name VARCHAR(50),
    IN new_category_name VARCHAR(50)
)
    LANGUAGE plpgsql
AS
$$
    BEGIN
UPDATE Orders
SET product_name = new_category_name
WHERE product_id IN (SELECT product_id FROM Products WHERE category_name = old_category_name);
END;
$$;


-- Процедура для обновления названия категории в таблице ProductReviews
CREATE OR REPLACE PROCEDURE update_productreviews_category_name(
    IN old_category_name VARCHAR(50),
    IN new_category_name VARCHAR(50)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE ProductReviews
    SET product_id = (SELECT product_id
                      FROM Products
                      WHERE category_name = new_category_name)
    WHERE product_id IN (SELECT product_id
                         FROM Products
                         WHERE category_name = old_category_name);
END;
$$;
