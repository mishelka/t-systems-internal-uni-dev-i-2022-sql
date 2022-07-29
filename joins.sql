-- SELECT * FROM category CROSS JOIN links
-- WHERE category_id = id;
--
-- SELECT * FROM category c CROSS JOIN links l
-- WHERE c.last_update = l.last_update;
-- SELECT * FROM category, links;

SELECT
	c.customer_id,
	i.customer_id,
	first_name,
	last_name,
	total,
	invoice_date
FROM
	customer as c
INNER JOIN invoice as i
    ON i.customer_id =
       c.customer_id
ORDER BY invoice_date;

SELECT name, title
FROM artist a
    INNER JOIN album al
        ON (a.artist_id = al.artist_id);

SELECT *
FROM artist ar
    INNER JOIN album al
        ON (ar.artist_id = al.artist_id) AND ar.name = 'U2';

SELECT * FROM artist ar, album al
WHERE ar.artist_id = al.artist_id AND ar.name = 'U2';

-- 3
select a.name, b.*from track b,media_type a
where b.media_type_id = a.media_type_id
  and b.media_type_id = 3;

select a.name, b.*
    from track b
    join media_type a
        on b.media_type_id = a.media_type_id
where a.name = 'Protected MPEG-4 video file';
--Protected MPEG-4 video file // media_type_id 3

-- 4
select t.name,
       t.composer,
       t.milliseconds / 1000 as seconds
from playlist_track plt
    INNER JOIN playlist p
        ON plt.playlist_id = p.playlist_id AND p.name = '90’s Music'
    INNER JOIN track t
        ON plt.track_id = t.track_id
WHERE composer IS NOT NULL
ORDER BY t.name;

select t.name, t.composer, t.milliseconds / 1000 as seconds
from playlist_track pt, playlist p, track t
where pt.playlist_id = p.playlist_id
    and p.name = '90’s Music'
    and pt.track_id = t.track_id
    and composer is not null
order by t.name;

select t.name, t.composer, t.milliseconds / 1000 as seconds
from track t, (
    select * from playlist_track pt, playlist p
    where pt.playlist_id = p.playlist_id and p.name = '90’s Music'
) ppt
where ppt.track_id = t.track_id
      and composer is not null
order by t.name;

--5
select distinct a.title, g.name as genre
from album a
    inner join track t
        on a.album_id = t.album_id
    inner join genre g
        on t.genre_id = g.genre_id
where g.name = 'Soundtrack';

--efektivnejsie, vybera najprv len soundtrack a az potom pripaja albumy
select distinct a.title, g.name as genre
from track t
    inner join genre g
        on g.genre_id = t.genre_id
        and g.name = 'Soundtrack'
    inner join album a
        on t.album_id = a.album_id;

select distinct a.title, g.name as genre
from album a, track t, genre g
where a.album_id = t.album_id
    and t.genre_id = g.genre_id
    and g.name = 'Soundtrack';

--Vypíšte objednávku na základe jej id s jej položkami v tvare:
-- *číslo objednávky,
-- *názov skladby,
-- názov jej interpreta (nie skladateľa),
-- *názov albumu,
-- *jednotková cena,
-- *meno zákazníka (v jednom stĺpci kombinácia mena a priezviska)
--6
select
    i.invoice_id,
    t.name,
    artist.name,
    a.title,
    il.unit_price,
    c.first_name || ' ' || c.last_name as full_name
from invoice i
    join customer c
        on c.customer_id = i.customer_id
    join invoice_line il
        on i.invoice_id = il.invoice_id
    join track t
        on t.track_id = il.track_id
    join album a
        on a.album_id = t.album_id
    join artist
        on artist.artist_id = a.artist_id
where i.invoice_id = 5;;

select
    i.invoice_id,
    t.name,
    artist.name,
    a.title,
    il.unit_price,
    c.first_name || ' ' || c.last_name as full_name
from invoice i, customer c, invoice_line il, track t, album a, artist
where c.customer_id = i.customer_id
    and i.invoice_id = il.invoice_id
    and t.track_id = il.track_id
    and a.album_id = t.album_id
    and artist.artist_id = a.artist_id
    and i.invoice_id = 5;

--7
select * from employee e
    where reports_to IS NULL; --toto je ten jeden, ktory nema sefa

select c.* from customer c
    inner join employee e
    on c.city = e.city
    and reports_to IS NULL;

--8
select b.* from employee a
     left join employee b
         on a.employee_id = b.reports_to
where a.reports_to is null;

select * from employee e
    where e.reports_to = 1;

--9 Zistite, ktorí artisti nevydali ani jeden album.
-- Vypíšte ich mená. Pre overenie správnosti vedze, že ich počet je 71.
select
    alb.artist_id,art.artist_id,
    alb.name from artist alb
    left join album art
        on alb.artist_id = art.artist_id
where art.artist_id is null;
--order by b.artist_id nulls first;

--10
-- Vypíšte zoznam všetkých skladieb (ich názvy spolu s názvom skladateľa),
-- ktoré nepatria do playlistu 'Heavy Metal Classic'.
-- Pre overenie správnosti je počet týchto skladieb 3477
-- (všetky skladby - zoznam skladieb playlistu)
-- nespravne riesenie:
-- select distinct t.track_id, t.name, t.composer from track t
--     join playlist_track pt on t.track_id = pt.track_id
--     join playlist p on p.playlist_id = pt.playlist_id
-- WHERE p.name != 'Heavy Metal Classic';

select distinct t2.track_id, t2.name , t2.composer
from track t
inner join playlist_track pt on t.track_id = pt.track_id
inner join playlist p on pt.playlist_id = p.playlist_id and p.name = 'Heavy Metal Classic'
right join track t2 on t.track_id = t2.track_id
where t.track_id is null;

--11
select b.invoice_id, A.* from customer A
    left join invoice B
        on A.customer_id = B.customer_id
            and extract(year from B.invoice_date) = 2012
where invoice_id is null
--order by invoice_id nulls first;
order by a.last_name, a.first_name asc;

insert into customer (customer_id, first_name, last_name, email)
    values (100, 'Michaela', 'Bacikova', 'michaela.bacikova@tuke.sk');

--11
select a.customer_id, a.first_name, a.last_name from customer a
    left join invoice b
        on a.customer_id = b.customer_id
where invoice_id is null;

--13
select a.first_name,
      a.last_name, a.birth_date, b.birth_date
from employee a
        left join employee b on a.birth_date > b.birth_date
where b.employee_id is null;

--14
select b.milliseconds / 1000 as b_seconds, b.* --c.*
from media_type a
        inner join track b
            on a.media_type_id = b.media_type_id
                   and a.name = 'Protected MPEG-4 video file'
        left join track c
            on b.milliseconds < c.milliseconds
where c.track_id is null;

--15
select b.name, a.title, at.name, b.milliseconds/1000 as seconds
from album a
    inner join track b
        on a.album_id = b.album_id
        and a.title = 'War'
    inner join artist at
        on at.artist_id = a.artist_id
        and at.name = 'U2'
    left join track c
        on b.milliseconds < c.milliseconds
        and b.album_id = c.album_id
where c.track_id is null;

--16
select distinct a.name, a.name, a.milliseconds/1000 as seconds
from track a
    inner join album al
        on al.album_id = a.album_id
        and al.title = 'War'
    inner join artist at
        on at.artist_id = al.artist_id
        and at.name = 'U2'
    left join track b on b.milliseconds > a.milliseconds
         and b.album_id = al.album_id
    left join track c ON c.milliseconds < a.milliseconds
         and c.album_id = al.album_id
where c.name is null or b.name is null;