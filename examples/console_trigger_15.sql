# zdarzenia, triggers

SELECT *
FROM language
LIMIT 500;

CREATE TABLE audit_language(
    language_id tinyint,
    name char(20),
    last_update TIMESTAMP,
    row_value char(20)
);
DROP TABLE audit_language;

SELECT *
FROM audit_language
LIMIT 500;

DELIMITER //

CREATE TRIGGER language_after_update
    AFTER UPDATE
    ON language
    FOR EACH ROW

BEGIN
    INSERT INTO audit_language (language_id, name, last_update, row_value)
    VALUES (OLD.language_id, OLD.name, OLD.last_update, 'before update');

    INSERT INTO audit_language (language_id, name, last_update, row_value)
    VALUES (NEW.language_id, NEW.name, NEW.last_update, 'after update');

END //

DELIMITER ;

SELECT *
FROM language;

UPDATE language
SET name='SQL'
WHERE language_id = 6;

SELECT *
FROM audit_language;

DELIMITER //
CREATE TRIGGER language_before_insert
    BEFORE INSERT
    ON language
    FOR EACH ROW
BEGIN
    SET NEW.name = CONCAT(UPPER(SUBSTRING(NEW.name, 1, 1)), LOWEr(substring(NEW.name FROM 2)));
end //

DELIMITER ;

DELIMITER //
CREATE TRIGGER language_before_update
    BEFORE UPDATE
    ON language
    FOR EACH ROW
BEGIN
    SET NEW.name = CONCAT(UPPER(SUBSTRING(NEW.name, 1, 1)), LOWEr(substring(NEW.name FROM 2)));
end //

DELIMITER ;

# 0.99 $
DELIMITER //
CREATE TRIGGER validate_rental_rate
    BEFORE UPDATE ON film
    FOR EACH ROW
BEGIN
    IF NEW.rental_rate < 0.99 THEN
        SET NEW.rental_rate = 0.99;
    end if;
end //

DELIMITER ;

SELECT *
FROM rental
LIMIT 500;

SELECT *
FROM customer
LIMIT 500;

DELIMITER //
CREATE TRIGGER activate_customer_on_rental
    AFTER INSERT
    ON rental
    FOR EACH ROW

    BEGIN
        UPDATE customer
            SET active  = 1
        WHERE customer_id = NEW.customer_id
        AND active = 0;
    end //

DELIMITER ;