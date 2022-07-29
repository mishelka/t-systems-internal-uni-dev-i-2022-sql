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
