-- function
CREATE FUNCTION update_order_price()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE Orders
    SET order_price = NEW.product_price + NEW.order_delivery_price
    WHERE Orders.product_id = NEW.product_id;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- trigger
CREATE TRIGGER update_order_price_trigger
AFTER UPDATE OF product_price ON Products
FOR EACH ROW
EXECUTE FUNCTION update_order_price();