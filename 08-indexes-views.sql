create or replace view savings as(
select t.track_id, t.name, t.album_id, t.media_type_id, t.genre_id, t.composer, t.milliseconds, t.bytes, trunc(t.unit_price*0.9,2) as unit_price
from track t
inner join album al on t.album_id = al.album_id
inner join artist a on a.artist_id = al.artist_id
where a.name = 'U2');

drop view savings;

create index idx_track_composer
ON track(composer asc);

select name, composer from track
where composer = 'U2';

-- drop index if exists idx_track_composer;