-- SQL script that creates a trigger that decreases the quantity of an item
Drop TRIGGER IF EXISTS decrease_quantity;
DELIMITER $$
CREATE TRIGGER decrease_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	UPDATE items
		SET quantity = quantity - NEW.number
		WHERE name = NEW.item_name;
END$$
DELIMITER ;
