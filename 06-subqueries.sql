-- Zistite meno, priezvisko a dátum narodenia najstaršieho zamestnanca
-- ktorého má obchod. Výsledný dopyt porovnajte s riešením pomocou spojenia tabuliek.
select first_name, last_name, birth_date
from employee
where birth_date = (
    select min(birth_date) from employee
)
group by first_name, last_name,birth_date;

--Zistite najdlhšiu skladbu a najkratšiu skladbu v albume War od U2.
-- Obe skladby vypíšte na samostatný riadok.
select name,
      milliseconds / 1000 as time
from album a
        inner join track t on a.album_id = t.album_id and a.title = 'War'
where milliseconds = (
    select max(milliseconds) from track t
        inner join album a
            on a.album_id = t.album_id
            and a.title = 'War')
  or milliseconds = (
    select min(milliseconds) from track t
        inner join album a
            on a.album_id = t.album_id
            and a.title = 'War');

--Vypíšte názvy všetkých skladieb, ktoré nepatria do playlistu Music Videos.
--Pre overenie správnosti je celkový počet týchto skladieb 3502.
select name from track t
where t.track_id not in (
    select s.playlist_id from playlist_track s
        join playlist p
            on s.playlist_id = p.playlist_id
    where p.name='Music Videos'
);

--Vypíšte zoznam skladieb, ktoré neboli kúpené ani raz.
--Pre overenie správnosti dopytu vedzte, že počet týchto skladieb je 1519.
select count(name) from track
where track_id not in (
    select track_id from invoice_line
);

--to iste cez left join
select count(name) from track t
    left join invoice_line il
        on t.track_id = il.track_id
where il.track_id is null;
--order by il.track_id nulls first;

--to iste cez right join
select count(name) from invoice_line il
    right join track t
        on t.track_id = il.track_id
where il.track_id is null;
--where il.track_id is null;

---DOMACA ULOHA---

-- Vypíšte zoznam skladieb, ktoré boli kúpené aspoň 100x.
-- Pre overenie správnosti dopytu vedzte, že počet týchto skladieb je 0
-- a počet skladieb predaných práve 2x je 256.
select name from track t
where (
    select count(i.track_id) from invoice_line i
    where t.track_id = i.track_id
) >= 100;

--Vypíšte zamestnancov, ktorých vek je menší ako priemerný vek zamestnancov obchodu.
-- Pre overenie správnosti výsledku viete, že počet týchto zamestnancov je 5.
select last_name,
      first_name
from employee
where employee_id in (
    select employee_id from employee
    group by birth_date, employee_id
    having extract(year from current_date) - extract(year from birth_date) < (
        select avg(extract(year from current_date) - extract(year from birth_date))
        from employee
    )
);