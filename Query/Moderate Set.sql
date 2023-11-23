SELECT
    c.email,
    c.first_name,
    c.last_name,
    g.name AS genre
	FROM
    customer c
JOIN
    invoice i ON c.customer_id = i.customer_id
JOIN
    invoice_line il ON i.invoice_id = il.invoice_id
JOIN
    track t ON il.track_id = t.track_id
JOIN
    genre g ON t.genre_id = g.genre_id
WHERE
    g.name = 'Rock'
ORDER BY
    c.email;

	-- Que 2
	select top 10 artist.name , artist.artist_id , COUNT(artist.artist_id) No_of_songs from artist
join album on album.artist_id = artist.artist_id 
join track on album.album_id = track.album_id
join genre on track.genre_id = genre.genre_id 
where genre.name = 'Rock'
group by artist.artist_id , artist.name
order by No_of_songs DESC

-------------------
WITH RockArtists AS (
    SELECT
        ar.name AS artist_name,
        COUNT(t.track_id) AS track_count
    FROM
        artist ar
    JOIN
        album al ON ar.artist_id = al.artist_id
    JOIN
        track t ON al.album_id = t.album_id
    JOIN
        genre g ON t.genre_id = g.genre_id
    WHERE
        g.name = 'Rock'
    GROUP BY
        ar.artist_id, ar.name
)
SELECT TOP 10
    artist_name,
    track_count
FROM
    RockArtists
ORDER BY
    track_count DESC;


	--Que 3
	WITH TracksWithAvg AS (
    SELECT
        name,
        milliseconds,
        AVG(milliseconds) OVER () AS avg_length
    FROM
        track
)
SELECT
    name,
    milliseconds
FROM
    TracksWithAvg
WHERE
    milliseconds > avg_length
ORDER BY
    milliseconds DESC;
