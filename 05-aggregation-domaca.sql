--7 Aký skladateľ (composer) je najobľúbenejší u zákazníka Wyatta Girarda?
-- (najobľúbenejší - kupoval ho najčastejšie).
-- Pre overenie vedzte, že skladby od trojice Mike Bordin, Billy Gould,
-- Mike Patton si kúpil najviackrát (3x).
select composer, count(composer) from invoice i
    inner join customer c
        on i.customer_id = c.customer_id
        and c.first_name = 'Wyatt'
        and c.last_name = 'Girard'
    inner join invoice_line il
        on i.invoice_id = il.invoice_id
    inner join track t
        on t.track_id = il.track_id
        and t.composer is not null
group by t.composer
order by sum(quantity) desc;

--8 Vypíšte sumárne zisky z predaja za jednotlivé mesiace a roky.
-- Pre overenie správnosti dopytu viete, že v apríli 2011 bol celkový zisk
-- z predaja $51.62.
select extract(year from invoice_date) rok,
       extract(month from invoice_date) mesiac,
       sum(total)
from invoice
group by rok, mesiac
order by rok, mesiac;

--11 Vypíšte všetky objednávky smerujúce do Veľkej Británie v mesiaci máj
-- 2013, ktoré boli vyššie ako $2.
-- O objednávke vypíšte len jej dátum a celkovú sumu.
-- Pre overenie správnosti vedzte, že v danom mesiaci boli len 2 objednávky.

select extract(year from invoice_date) as year,
       extract(month from invoice_date) as month,
       invoice_date,
       sum(quantity * unit_price)
from invoice
    inner join invoice_line il
    on invoice.invoice_id = il.invoice_id
where extract(year from invoice_date) = 2013
    and extract(month from invoice_date) = 5
    and billing_country = 'United Kingdom'
    and total > 2
group by invoice_date, year, month
order by year, month;

--12 Koľko jedinečných audio záznamov (a nie video)
-- bolo kúpených nemeckými zákazníkmi? A aký veľký obrat urobili?
-- Aby ste si overili svoj výsledok, tak nemeckí zákazníci spolu kúpili
-- 146 jedinečných skladieb za 144.54.

select count(i.invoice_id),
       sum(t.unit_price),
       c.country
from customer c
    inner join invoice i
        on c.customer_id = i.customer_id
        and country like 'Germany'
    inner join invoice_line il
        on i.invoice_id = il.invoice_id
    inner join track t
        on il.track_id = t.track_id
    inner join media_type mt
        on t.media_type_id = mt.media_type_id
        and mt.name like '%audio%'
group by c.country;

select count(i.invoice_id),
       sum(t.unit_price),
       c.country
from customer c, invoice i, invoice_line il, track t, media_type mt
    where c.customer_id = i.customer_id
    and i.invoice_id = il.invoice_id
    and il.track_id = t.track_id
    and t.media_type_id = mt.media_type_id
    and country like 'Germany'
    and mt.name like '%audio%'
group by c.country;

--13 Niektoré skladby v zozname všetkých skladieb majú rovnaké mená.
-- Zistite, ktoré to sú (počet výskytov skladieb s rovnakým menom
-- je väčší ako 1) a vypíšte o nich nasledovné informácie:
--   a. názov skladby
--   b. počet výskytov skladby
-- Výsledný zoznam usporiadajte v poradí od skladieb s najčastejším výskytom názvu po najmenej.
select t.name,
       count(t.name) as count
from track t
group by t.name
having count(t.name) > 1
order by count;