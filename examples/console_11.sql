SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER  //

CREATE FUNCTION get_language(lang_id INT)
    RETURNS VARCHAR(20)
    DETERMINISTIC
    READS SQL DATA
BEGIN
   DECLARE lang_name VARCHAR(20);

   SELECT name
   INTO lang_name
   FROM language lan
   WHERE lan.language_id = lang_id
   LIMIT 1;

   RETURN lang_name;

END //

DELIMITER ;

SELECT get_language(2);

DROP FUNCTION get_language;


SELECT title, get_language(language_id) as lang
FROM film
LIMIT 500;

SELECT *
FROM film
WHERE language_id != 1
LIMIT 500;

# ile wypożyczeń miał klient

DELIMITER $$

CREATE FUNCTION count_rentals(customer_id INT)
    RETURNS SMALLINT UNSIGNED
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE rental_count SMALLINT UNSIGNED;

    SELECT COUNT(*)
    INTO rental_count
    FROM rental ren
    WHERE ren.customer_id = customer_id;

    RETURN rental_count;

END $$

DELIMITER ;

DROP FUNCTION count_rentals;

SELECT cust.first_name, cust.last_name, count_rentals(cust.customer_id) AS TotalMovieRented
FROM customer cust
ORDER BY TotalMovieRented DESC
LIMIT 500;


# get film title with category name(Dinosaur Academy (Drama))

SELECT f.title, c.name
FROM film as f JOIN film_category as fc ON f.film_id = fc.film_id JOIN category AS c ON c.category_id = fc.category_id = c.category_id
LIMIT 500;


DELIMITER //

CREATE FUNCTION get_film_title(film_id INT)
    RETURNS VARCHAR(255)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE film_name VARCHAR(255);

    SELECT CONCAT(fl.title, '(',c.name, ')')
    INTO film_name
    FROM film fl
    INNER JOIN film_category fc ON fl.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
    WHERE fl.film_id = film_id
    LIMIT 500;

    RETURN film_name;

END //

DELIMITER ;

SELECT get_film_title(2);


# customer full name

DELIMITER //

CREATE FUNCTION cutomer_fullname(customer_id INT)
    RETURNS VARCHAR(255)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE full_name VARCHAR(255);

    SELECT CONCAT(c.first_name,' ',c.last_name)
    INTO full_name
    FROM customer c
    WHERE c.customer_id = customer_id
    LIMIT 500;

    RETURN full_name;

END //

DELIMITER ;

SELECT cutomer_fullname(customer_id), rental.rental_date
FROM rental;

# get_rental_days

SELECT rental.return_date - rental.rental_date, rental.rental_id
FROM rental
WHERE rental_id =3;


DELIMITER //

CREATE FUNCTION calc_rental_days(rental_id INT)
    RETURNS SMALLINT UNSIGNED
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE days SMALLINT UNSIGNED ;

    SELECT DATEDIFF(rental_date, return_date)
    INTO days
    FROM rental ren
    WHERE ren.rental_id = rental_id
    LIMIt 1;

    RETURN days;

END //

DELIMITER ;

SELECT calc_rental_days(2);

SELECT *
FROM payment
LIMIT 500;

DELIMITER //

CREATE FUNCTION avg_pyment_for_customer(customer_id INT)
    RETURNS DECIMAL(6, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE avg_payment DECIMAL(6,2) ;

    SELECT IFNULL(AVG(pay.amount), 0)
    INTO avg_payment
    FROM payment pay
    WHERE pay.customer_id = customer_id
    LIMIt 1;

    RETURN avg_payment;

END //

DELIMITER ;

SELECT first_name, last_name, avg_pyment_for_customer(customer_id)
FROM customer;


DELIMITER //

CREATE FUNCTION stddev_payment_for_customer(customer_id INT)
    RETURNS DECIMAL(6, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE stddev_payment DECIMAL(6,2) ;

    SELECT IFNULL(STDDEV(pay.amount), 0)
    INTO stddev_payment
    FROM payment pay
    WHERE pay.customer_id = customer_id
    LIMIt 1;

    RETURN stddev_payment;

END //

DELIMITER ;


SELECT first_name, last_name, stddev_payment_for_customer(customer_id)
FROM customer;


# median

DELIMITER //

CREATE FUNCTION median_payment_for_customer(customer_id INT)
    RETURNS DECIMAL(6, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE count_payments SMALLINT UNSIGNED;
    DECLARE median_value DECIMAL(6, 2);
    DECLARE offset_value SMALLINT UNSIGNED;

    SELECT COUNT(*)
    INTO count_payments
    FROM payment pay
    WHERE pay.customer_id = customer_id
    LIMIT 1;

    IF count_payments = 0 THEN
        RETURN NULL;
    END IF;

    IF MOD(count_payments, 2) = 1 THEN
        SET offset_value = FLOOR(count_payments / 2);

        SELECT pay.amount
        INTO median_value
        FROM payment pay
        WHERE pay.customer_id = customer_id
        ORDER BY pay.amount
        LIMIT 1 OFFSET offset_value;
    ELSE
        SET offset_value = FLOOR(count_payments / 2) - 1;

        SELECT AVG(mid_values.amount)
        INTO median_value
        FROM (SELECT pay.amount
              FROM payment pay
              WHERE pay.customer_id = customer_id
              ORDER BY pay.amount
              LIMIT 2 OFFSET offset_value) AS mid_values;
    END IF;

    RETURN median_value;

END //

DELIMITER ;

DROP FUNCTION median_payment_for_customer;









