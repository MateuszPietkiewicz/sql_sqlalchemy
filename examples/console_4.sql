CREATE TABLE ActorSample (
    actor_id SMALLINT unsigned NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(25) NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id));

INSERT INTO ActorSample (first_name, last_name, last_update)
SELECT first_name, last_name, last_update
FROM actor;

DELETE
FROM ActorSample
WHERE actor_id = 1;

