-- creates a trigger that resets the attribute valid_email only when email changes
DROP TRIGGER IF EXISTS resets_attribute;
DELIMITER $$
CREATE TRIGGER resets_attribute
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
	IF OLD.email != NEW.email THEN
		SET NEW.valid_email = 0;
	ELSE
		SET NEW.email = NEW.valid_email;
	END IF;
END $$
DELIMITER ;
