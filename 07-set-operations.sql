select composer artist
from track
union --intersect --except
select name artist
from artist
order by artist nulls first;

SELECT
first_name
FROM
actor
WHERE
actor_id < 40
EXCEPT
SELECT
first_name
FROM
customer
WHERE
customer_id < 40
order by first_name nulls first;