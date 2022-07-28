-- SELECT last_name, first_name
-- 	FROM customer
-- 	WHERE first_name IN('Luís', 'James');

-- SELECT last_name, first_name
--     FROM customer
--     WHERE first_name LIKE 'A%'
--       AND LENGTH(first_name) BETWEEN 3 AND 5;

-- SELECT
--     first_name || ' ' || last_name AS name_and_surname,
--     email
-- FROM customer;

-- SELECT customer_id AS id,
--        first_name, last_name
-- FROM customer
-- ORDER BY
-- 	first_name ASC,
-- 	last_name DESC NULLS LAST
--     LIMIT 4 OFFSET 3;

-- select * from customer;

select first_name, last_name, city, phone
    from customer
    where phone like '+55%' and city like 'São%';