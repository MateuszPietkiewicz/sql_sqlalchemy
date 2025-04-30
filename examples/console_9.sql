

CREATE VIEW dml_operation_2
AS
SELECT language_id, last_update
FROM language;

SELECT *
FROM dml_operation_2
LIMIT 500;

INSERT INTO dml_operation_2 (name, last_update)
VALUES ('Polish',  '2025-04-13 11:14');


UPDATE dml_operation_2
set last_update = '2025=04-13 11:14'
WHERE language_id = 6;

CREATE VIEW dml_operation_3
AS
SELECT *
FROM language
WHERE YEAR(last_update) < 2010;

SELECT *
FROM dml_operation_3


CREATE VIEW dml_operation_4
AS
SELECT *
FROM language
WHERE YEAR(last_update) < 2010;