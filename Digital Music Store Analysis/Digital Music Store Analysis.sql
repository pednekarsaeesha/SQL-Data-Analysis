#1.What is the average number of tracks in a playlist?

with table1 as (
SELECT 
    t.track_id,
    t.name,
    pt.playlist_id,
    COUNT(*) AS number_of_tracks
FROM
    playlist_track pt
        JOIN
    track t ON pt.track_id = t.track_id
GROUP BY pt.playlist_id)
SELECT 
    AVG(number_of_tracks) AS average_no_of_tracks
FROM
    table1
;

#2.Which artist has the highest number of tracks in the database?
SELECT 
    a.*, COUNT(*) highest_no_of_tracks
FROM
    artist a
        JOIN
    album al ON a.artist_id = al.artist_id
        JOIN
    track t ON al.album_id = t.album_id
GROUP BY a.artist_id
ORDER BY highest_no_of_tracks DESC
LIMIT 1;

#3.What is the average length of a track by genre?
SELECT 
    t.name AS track_name,
    ROUND(AVG(t.milliseconds) / 60000, 2) AS avg_track_length_min,
    g.name AS genre_name
FROM
    track t
        JOIN
    genre g ON t.genre_id = g.genre_id
GROUP BY g.genre_id;


#4.What is the most popular track among customers who have purchased rock music?

SELECT 
    t.track_id,
    t.name,
    g.name,
    i.invoice_date,
    COUNT(*) AS most_popular_track_among_customer
FROM
    genre g
        JOIN
    track t ON g.genre_id = t.genre_id
        JOIN
    invoice_line il ON t.track_id = il.track_id
        JOIN
    invoice i ON il.invoice_id = i.invoice_id
WHERE
    g.name = 'Rock'
GROUP BY t.track_id
ORDER BY COUNT(*) DESC
LIMIT 1
;


#5.What is the most popular genre among customers who have spent over $100 in the store?

SELECT 
    g.name AS genre_name,
    g.genre_id,
    i.customer_id,
    SUM(i.total)
FROM
    genre g
        JOIN
    track t ON g.genre_id = t.genre_id
        JOIN
    invoice_line il ON t.track_id = il.track_id
        JOIN
    invoice i ON il.invoice_id = i.invoice_id
GROUP BY g.name
HAVING SUM(i.total) > 100
ORDER BY SUM(i.total) DESC
;




#6.Which customer has spent the most money in the store?
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(i.total) AS spent_money
FROM
    invoice i
        JOIN
    customer c ON i.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY spent_money DESC
LIMIT 1;


#7.What is the average revenue per customer?

with table7 as (
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(i.total) AS spent_money
FROM
    invoice i
        JOIN
    customer c ON i.customer_id = c.customer_id
GROUP BY c.customer_id )

select avg(spent_money) from table7
;


#8. How many customers have made purchases from each country in the database?

SELECT 
    c.country, COUNT(DISTINCT c.customer_id) AS customers
FROM
    customer c
        JOIN
    invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY customers DESC;




#9.What is the most popular genre among customers from the United States?
SELECT 
    g.genre_id, g.name, COUNT(*) AS most_popular_genre
FROM
    genre g
        JOIN
    track t ON g.genre_id = t.genre_id
        JOIN
    invoice_line il ON t.track_id = il.track_id
        JOIN
    invoice i ON il.invoice_id = i.invoice_id
        JOIN
    customer c ON i.customer_id = c.customer_id
WHERE
    c.country = 'USA'
GROUP BY g.genre_id
ORDER BY COUNT(*) DESC
LIMIT 1;


#10.What is the most popular artist among customers who have purchased jazz music?

SELECT 
    a.artist_id,
    a.name,
    COUNT(*) AS most_popular_artist_among_customer
FROM
    track t
        JOIN
    invoice_line il ON t.track_id = il.track_id
        JOIN
    genre g ON t.genre_id = g.genre_id
        JOIN
    album al ON t.album_id = al.album_id
        JOIN
    artist a ON al.artist_id = a.artist_id
WHERE
    g.Name = 'Jazz'
GROUP BY a.artist_id
ORDER BY COUNT(*) DESC
LIMIT 1;

#11.How many customers have made purchases in each month of the year?

SELECT 
    COUNT(DISTINCT c.customer_id) AS customers_purchased,
    SUBSTRING(i.invoice_date, 6, 2) AS month
FROM
    invoice i
        JOIN
    customer c ON i.customer_id = c.customer_id
GROUP BY month;

#12.Which genre has the highest average number of tracks per album?


with table12 as (
SELECT 
    g.genre_id,
    g.name,
    t.track_id,
    al.album_id,
    COUNT(DISTINCT t.track_id) AS count_of_tracks
FROM
    genre g
        JOIN
    track t ON g.genre_id = t.track_id
        JOIN
    album al ON t.album_id = al.album_id
GROUP BY al.album_id)

SELECT 
    name, AVG(count_of_tracks) AS highest_avg_no_of_tracks
FROM
    table12
GROUP BY genre_id
ORDER BY highest_avg_no_of_tracks DESC
LIMIT 1  ;
