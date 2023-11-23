SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM
    customer c
JOIN
    invoice i ON c.customer_id = i.customer_id
JOIN
    invoice_line il ON i.invoice_id = il.invoice_id
JOIN
    track t ON il.track_id = t.track_id
JOIN
    album al ON t.album_id = al.album_id
JOIN
    artist ar ON al.artist_id = ar.artist_id
GROUP BY
    c.customer_id, CONCAT(c.first_name, ' ', c.last_name), ar.name
ORDER BY
    c.customer_id, total_spent DESC;


	--Que 2
	WITH CountryTopCustomer AS (
    SELECT
        c.country,
        CONCAT(c.first_name, ' ', c.last_name) AS top_customer,
        SUM(i.total) AS total_spent,
        RANK() OVER (PARTITION BY c.country ORDER BY SUM(i.total) DESC) AS customer_rank
    FROM
        customer c
    JOIN
        invoice i ON c.customer_id = i.customer_id
    GROUP BY
        c.country, c.customer_id, CONCAT(c.first_name, ' ', c.last_name)
)
SELECT
    country,
    top_customer,
    total_spent
FROM
    CountryTopCustomer
WHERE
    customer_rank = 1;


	--Que 3
	WITH CountryTopGenre AS (
    SELECT
        c.country,
        g.name AS top_genre,
        RANK() OVER (PARTITION BY c.country ORDER BY COUNT(g.genre_id) DESC) AS genre_rank
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
    GROUP BY
        c.country, g.name
)
SELECT
    country,
    top_genre
FROM
    CountryTopGenre
WHERE
    genre_rank = 1;
