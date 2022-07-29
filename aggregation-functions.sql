-- Aká bola tržba z objednávok v máji 2013?
-- Pre overenie správnosti bola táto tržba $37.62.
select sum(i.total)
from invoice i
where EXTRACT(MONTH from i.invoice_date) = 5
    and EXTRACT(YEAR from i.invoice_date) = 2013;

select sum(i.total)
from invoice i
where i.invoice_date BETWEEN '2013-05-01' AND '2013-05-31';

-- Vypíšte prehľadovo, koľkých zákazníkov má obchod
-- z jednotlivých krajín.
-- Výsledok usporiadajte od krajiny s najväčším počtom
-- registrovaných zákazníkov po krajinu s najmenším počtom zákazníkov.
-- Pre overenie správnosti dopytu viete, že najviac zákazníkov
-- pochádza z USA
select max(counts.c) from (
    select country, count(*) as c
                    from customer
                    group by country
                    order by count(*) desc
) as counts;

-- Koľko skladieb sa nachádza v albume War?
-- Pre overenie správnosti ich je 10
select count(*) from track t, album a
where t.album_id = a.album_id
    and a.title = 'War';

-- Zistite celkový čas prehrávania albumu “War” od “U2” v
-- minútach a sekundách.
-- Pre kontrolu správnosti, je celkový čas albumu 42 minút a 9 sekúnd.
select
    sum(t.milliseconds / 1000.0 / 60) as minutes,
    mod(sum(t.milliseconds) / 1000.0, 60) as seconds
from track t
join album a on t.album_id = a.album_id
    and a.title = 'War'
join artist at on at.artist_id = a.artist_id
    and at.name = 'U2';

--1 Vypíšte sumárne zisky z predaja po jednotlivých rokoch.
-- Pre overenie správnosti dopytu viete, že celkový zisk z predaja v roku 2009 bol $449.46.  Zisk je stĺpec total.
select extract(year from invoice_date) as year,
       sum(total)
from invoice
group by extract(year from invoice_date)
order by year;

select extract(year from i.invoice_date) AS year,
      sum(il.unit_price * il.quantity) AS sum
from invoice i
    inner join invoice_line il
        on i.invoice_id = il.invoice_id
group by extract(year from i.invoice_date)
order by year;

--2 Vypíšte sumárne, koľko skladieb sa nachádza v jednotlivých playlistoch.
-- Pre overenie správnosti vedzte, že v playliste TV Shows sa nachádza 213 skladieb
-- a v playliste  Audiobooks sa nenachádza žiadna skladba (počet je 0).
-- Výsledný zoznam usporiadajte vzostupne podľa názvu playlistu.
select p.name, count(pt.track_id)
from playlist p
    left join playlist_track pt
        on p.playlist_id = pt.playlist_id
group by p.playlist_id, p.name
order by count(pt.track_id) desc;

--3 Zistite čas v sekundách najdlhšej skladby, najkratšej skladby a priemerný
-- čas skladieb albumu War od U2.
select min(t.milliseconds) / 1000.0 as min_sec,
      max(milliseconds) / 1000.0 as max_sec,
      avg(milliseconds) / 1000.0 as avg_sec
from album al
    inner join track t on al.album_id = t.album_id
        and al.title = 'War'
    inner join artist at on al.artist_id = at.artist_id
        and at.name = 'U2';

--4 Zistite, koľko bolo spolu predaných skladieb z albumu War od U2.
select sum(quantity)
from invoice_line il
    join track t on il.track_id = t.track_id
    join album a on a.album_id = t.album_id
        and a.title = 'War'
where composer = 'U2';

--5 Vypíšte zisky z predaja podľa jednotlivých krajín za rok 2012.
-- Zoznam zoraďte podľa zisku od najvyšších po najnižšie.
-- Pre overenie správnosti najvyššie zisky v roku 2012 boli dosiahnuté predajom
-- v USA a najnižšie v Holandsku.
select billing_country,
      sum(total) Zisk
from invoice i
where extract(year from i.invoice_date) = 2012
group by billing_country
order by Zisk desc, billing_country;

--6 Koľko už minul dokopy nakupovaním Wyatt Girard?
-- Pre overenie správnosti vedzte, že Wyatt Girard minul nakupovaním $39.62.
select last_name,
      first_name,
      sum(quantity * t.unit_price) minul
from track t
    inner join invoice_line il on t.track_id = il.track_id
    inner join invoice i on il.invoice_id = i.invoice_id
    inner join customer c on i.customer_id = c.customer_id
        and c.last_name = 'Girard'
        and c.first_name = 'Wyatt'
group by last_name, first_name;

select last_name,
      first_name,
      sum(total) minul
from customer c
    inner join invoice i on c.customer_id = i.customer_id
        and c.last_name = 'Girard'
        and c.first_name = 'Wyatt'
group by last_name, first_name;

select last_name,
      first_name,
      sum(total) minul
from customer c, invoice i
    where c.customer_id = i.customer_id
        and c.last_name = 'Girard'
        and c.first_name = 'Wyatt'
group by last_name, first_name;
