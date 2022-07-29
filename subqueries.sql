-- Zistite meno, priezvisko a dátum narodenia najstaršieho zamestnanca
-- ktorého má obchod. Výsledný dopyt porovnajte s riešením pomocou spojenia tabuliek.
SELECT first_name, last_name, birth_date
FROM employee
WHERE birth_date = (
    SELECT min(birth_date) FROM employee
)
GROUP BY first_name, last_name,birth_date;

--Zistite najdlhšiu skladbu a najkratšiu skladbu v albume War od U2.
-- Obe skladby vypíšte na samostatný riadok.
select name,
      milliseconds / 1000 as time
from album a
        inner join track t on a.album_id = t.album_id and a.title = 'War'
where milliseconds = (select max(milliseconds)
                     from track t
                              inner join album a on a.album_id = t.album_id and a.title = 'War')
  or milliseconds = (select min(milliseconds)
                     from track t
                              inner join album a on a.album_id = t.album_id and a.title = 'War');

--Vypíšte názvy všetkých skladieb, ktoré nepatria do playlistu Music Videos.
--Pre overenie správnosti je celkový počet týchto skladieb 3502.
SELECT name FROM track t
WHERE t.track_id NOT IN (
    SELECT s.playlist_id from playlist_track s
    JOIN playlist p on s.playlist_id = p.playlist_id
    WHERE p.name='Music Videos'
);

--Vypíšte zoznam skladieb, ktoré neboli kúpené ani raz.
--Pre overenie správnosti dopytu vedzte, že počet týchto skladieb je 1519.
SELECT name FROM track
WHERE track_id NOT IN (
    SELECT track_id from invoice_line
);