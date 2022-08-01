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

--Vypíšte zoznam všetkých skladieb (ich názvy spolu s názvom skladateľa),
-- ktoré nepatria do playlistu 'Heavy Metal Classic'.
-- Pre overenie správnosti je počet týchto skladieb 3477.
--najprv except, potom left join s track, aby sme ziskali aj mena

select t.name, composer from track t
where t.track_id not in (
    select t1.track_id from track t1
    intersect
    select pt.track_id from playlist_track pt
        join playlist p on pt.playlist_id = p.playlist_id
        and p.name = 'Heavy Metal Classic'
);

SELECT name, composer, track_id
FROM track
EXCEPT
SELECT t.name, composer, t.track_id
FROM track t
JOIN playlist_track pt
    ON t.track_id=pt.track_id
JOIN playlist p
    ON pt.playlist_id=p.playlist_id
WHERE p.name LIKE 'Heavy Metal Classic';