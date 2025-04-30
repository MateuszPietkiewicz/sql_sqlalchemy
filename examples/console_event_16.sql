SHOW VARIABLES LIKE 'event_scheduler';

SET GLOBAL event_scheduler = ON;

CREATE TABLE event_audit (
    id INT NOT NULL AUTO_INCREMENT,
    last_update TIMESTAMP,
    PRIMARY KEY (id)
);

SELECT *
FROM event_audit
LIMIT 500;

DELIMITER //

CREATE EVENT one_time_event
    ON SCHEDULE AT NOW() + INTERVAL 1 MINUTE
    DO
    BEGIN
        INSERT INTO event_audit (last_update)
        VALUES (NOW());
    end //

DELIMITER ;

SELECT NOW();

DROP EVENT one_time_event;

SELECT *
FROM event_audit
LIMIT 500;

# zmień status wszystkim nieaktywnym użytkownikom (nic nie wypożyczyli od 20 lat)

DELIMITER //

CREATE EVENT deactivate_old_customers
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 8 HOUR
    DO
    BEGIN
        UPDATE customer
        SET active = 0
        WHERE customer_id IN (SELECT cust.customer_id
                              FROM customer cust
                              LEFT JOIN rental ren ON cust.customer_id = ren.customer_id
                              WHERE ren.return_date IS NULL
                              OR ren.rental_date < NOW() - INTERVAL 20 YEAR);
    end //

DELIMITER ;

# codzienna archiwizacja starych płatności

SELECT *
FROM payment
LIMIT 500;

CREATE TABLE payment_archive LIKE payment;

SELECT *
FROM payment_archive
LIMIT 500;


DELIMITER //

CREATE EVENT archive_old_payments
    ON SCHEDULE EVERY 1 DAY
        STARTS TIMESTAMP(CURRENT_DATE + INTERVAL 1 DAY, '21:37:00')
    DO
    BEGIN
        INSERT INTO payment_archive
        SELECT *
        FROM payment
        WHERE payment_date < NOW() - INTERVAL 2 YEAR;
    END //

DELIMITER ;