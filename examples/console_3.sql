UPDATE ActorSample
SET first_name = 'Janusz'
WHERE actor_id = 1;

SELECT *
FROM ActorSample;

UPDATE ActorSample
SET first_name = 'Jarosław'
WHERE actor_id IN (2, 5, 8);

UPDATE ActorSample
SET first_name = 'Jacek', last_name = 'S'
WHERE actor_id = 3;

SELECT *
FROM film_actor
WHERE film_id =1

UPDATE ActorSample
SET first_name = 'Andrzej'
WHERE actor_id IN (SELECT film_actor.actor_id
                    FROM film_actor
                    WHERE film_id =1)

DROP TABLE ActorSample