--# write your SQL SELECT statement here: you are given a table 'numbers' with column 'number', return a table with column 'number' and your result in a column named 'is_even'.
SELECT number,
  CASE
    WHEN number % 2 = 0 THEN 'Even'
    ELSE 'Odd'
    END as is_even
FROM numbers;


-- # write your SQL statement here: you are given a table 'removeexclamationmarks' with column 's', return a table with column 's' and your result in a column named 'res'.
SELECT s , REPLACE(s,'!', '') as res
FROM removeexclamationmarks

-- # write your SQL statement here:
-- you are given a table 'fraction' with columns 'numerator' (int) and 'denominator' (int)
-- return a query with columns 'numerator', 'denominator', 'reduced_numerator' (int) and 'reduced_denominator' (int)
-- sort results by column 'numerator' ascending, then by 'denominator' ascending

SELECT numerator,
  denominator,
  numerator / GCD(numerator, denominator) as reduced_numerator,
  denominator / GCD(numerator, denominator) as reduced_denominator
FROM fraction
ORDER BY 1 , 2

-- Substitute with your SQL
SELECT
  employee_id,
  full_name,
  team,
  birth_date
FROM (SELECT
      employee_id,
      full_name,
      team,
      birth_date,
      ROW_NUMBER() OVER (PARTITION BY team ORDER BY birth_date DESC) as rn
     FROM employees
     ) as t
WHERE rn = 1
ORDER BY team