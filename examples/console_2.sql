# CRUD
# TINYINT 8 bits
# SMALLINT 16 bits
# MEDIUMBIT 24 bits
# INT - 32 bits -2**32, 2**32
# BIGINT 63 bits

CREATE TABLE ActorSample (
    actor_id SMALLINT unsigned NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(25) NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id)
);

SELECT *
FROM ActorSample
LIMIT 500;

INSERT INTO ActorSample (first_name, last_name, last_update)
VALUES ('Janusz', 'Kowalski', '2025-10-04');

INSERT INTO ActorSample
VALUES (DEFAULT, 'Janusz', 'Kowalski','2025-10-05');

INSERT INTO ActorSample(first_name)
VALUES ('Janusz');

INSERT INTO ActorSample (first_name, last_name, last_update)
VALUES ('Janusz', NULL, DEFAULT);

DROP TABLE ActorSample;

INSERT INTO ActorSample (first_name, last_name)
VALUES ('Janusz', 'Kowalski'),
       ('Jacek', 'S'),
       ('Jarosław', 'K');

INSERT INTO ActorSample (first_name, last_name)
VALUES ('Janusz', 'Kowalski'),
       ('Jacek', 'S'),
       ('Jarosław', 'K');


INSERT INTO ActorSample (first_name, last_name, last_update)
SELECT first_name, last_name, last_update
FROM actor
WHERE first_name = 'KENNETH'

INSERT INTO ActorSample (first_name, last_name, last_update)
SELECT first_name, last_name, last_update
FROM actor;