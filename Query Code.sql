-- Q1: Which country have the most invoices?

SELECT billing_country, COUNT(*) as num_of_inovices
FROM invoice
GROUP BY billing_country
ORDER BY 2 DESC

-- Q2: Who is the most senior employee based on the job title?

SELECT CONCAT(first_name, ' ', last_name) as full_name, title, levels
FROM employee
ORDER BY levels DESC
LIMIT 1

-- Q3: What are the top 3 values for the total invoice?

SELECT ROUND(total::decimal,2)
FROM invoice
ORDER BY 1 DESC
LIMIT 3


-- Q4: Who is the best customer? 
-- The customer who has spent the most money is considered as the best customer.
-- Write a query that returns the full name of that person who has spent the most money.

SELECT c.customer_id, CONCAT(c.first_name,' ', c.last_name) as full_name,
ROUND(SUM(i.total)::decimal, 2) as invoice_total 
FROM customer as c
INNER JOIN invoice as i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY 3 DESC
LIMIT 1

-- Q5: Which city has the best customers?
-- We would like to host a promotional Music Festival in the city where we have the highest profit.
-- Write a query that returns only one city with the highest sum of invoice totals.
-- Return both the city name and the sum of all invoice total.

SELECT billing_city as city, ROUND(SUM(total)::decimal,2) as invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1

-- Q6: Write a query to retrieve customers who have spent more than 100.
-- The result should display the customers' full names along with the amount of money they spent in descending order.

SELECT CONCAT(c.first_name,' ', c.last_name) as full_name, 
ROUND(SUM(i.total)::decimal, 2) as invoice_total 
FROM customer as c
INNER JOIN invoice as i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id
HAVING ROUND(SUM(i.total)::decimal, 2) > 100
ORDER BY 2 DESC

-- Q7: Write a query to return the email, first name, last name, and genre of all Rock music listeners.
-- Return your list ordered alphabetically by email, starting with 'A'.

SELECT DISTINCT c.email, CONCAT(c.first_name,' ', c.last_name) as full_name
FROM customer as c
INNER JOIN invoice as i ON c.customer_id = i.customer_id
INNER JOIN invoice_line as i1 on i.invoice_id = i.invoice_id
WHERE track_id IN (SELECT track_id FROM track WHERE genre_id IN (SELECT genre_id FROM Genre WHERE name = 'Rock'))
ORDER BY c.email

-- Q8: We would like to invite artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

SELECT a.name, COUNT(*) as num_of_songs
FROM artist as a
INNER JOIN album as a1 ON a.artist_id = a1.artist_id
INNER JOIN track as t ON a1.album_id = t.album_id
INNER JOIN genre as g ON t.genre_id = g.genre_id
WHERE g.name LIKE 'Rock'
GROUP BY a.name
ORDER BY 2 DESC
LIMIT 10

-- Q9: Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length, with the longest song listed first.

SELECT t.name, t.milliseconds as song_length
FROM track as t
INNER JOIN album as a ON t.album_id = a.album_id
WHERE t.milliseconds > (SELECT AVG(milliseconds) as average_song_length FROM track)
ORDER BY 2 DESC

-- Q10: Find how much amount is spent by each customer on the best-selling artists.
-- Write a query to return the customer name, artist name, and total amount spent.

WITH best_selling_artist AS (
  SELECT ar.artist_id AS artist_id,
         ar.name AS artist_name,
         SUM(i.unit_price * i.quantity) AS total_sales
  FROM artist AS ar
  INNER JOIN album AS al ON ar.artist_id = al.artist_id
  INNER JOIN track AS t ON al.album_id = t.album_id
  INNER JOIN invoice_line AS i ON t.track_id = i.track_id
  GROUP BY 1
  ORDER BY total_sales DESC
  LIMIT 1
)

SELECT CONCAT(c.first_name,' ', c.last_name) as full_name, 
bsa.artist_name, 
ROUND(SUM(il.unit_price::decimal*il.quantity::decimal),2) as amount_spent
FROM customer as c
INNER JOIN invoice as i ON c.customer_id = i.customer_id
INNER JOIN invoice_line as il ON i.invoice_id = il.invoice_id
INNER JOIN track as t ON il.track_id = t.track_id
INNER JOIN album as al ON t.album_id = al.album_id
INNER JOIN best_selling_artist as bsa ON al.artist_id = bsa.artist_id
GROUP BY 1, 2
ORDER BY amount_spent DESC

---- Q11: We would like to categorise albums based on their sales performance to identify hit albums, popular albums, and normal albums. 
-- We define hit albums as those with the top 10% of total sales, popular albums as those with sales ranking between 10% and 30%, and the remaining albums as normal albums.  
-- Write a query to retrieve a categorised list of albums based on their sales performance, including the album title, genre, total sales, and album category.


WITH sales_summary AS (
  SELECT 
    a.title,
    g.name AS genre,
    ROUND(SUM(il.unit_price::decimal * il.quantity::decimal * i.total::decimal), 2) AS total_sales
  FROM 
    invoice AS i
    INNER JOIN invoice_line AS il ON i.invoice_id = il.invoice_id
    INNER JOIN track AS t ON il.track_id = t.track_id
    INNER JOIN genre AS g ON t.genre_id = g.genre_id
    INNER JOIN album AS a ON a.album_id = t.album_id
  GROUP BY 1, 2
)
SELECT
  title,
  genre,
  total_sales,
  CASE 
    WHEN total_sales >= (SELECT percentile_cont(0.1) WITHIN GROUP(ORDER BY total_sales DESC) FROM sales_summary) THEN 'Hit Album'
    WHEN total_sales >= (SELECT percentile_cont(0.3) WITHIN GROUP(ORDER BY total_sales DESC) FROM sales_summary) THEN 'Popular Album'
    ELSE 'Normal Album'
  END AS album_category
FROM sales_summary
ORDER BY total_sales DESC;


-- Q12: We would like to find out the most popular music genre for each country.
-- We define the most popular genre as the genre with the highest number of purchases.
-- Write a query that retrieves each country along with the top genre.
-- In cases where multiple genres share the maximum number of purchases, include all of them.

WITH the_most_popular_genre AS (
SELECT c.country as country, 
COUNT(il.quantity) as num_of_purchases,
g.name as genre_name,
ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS r
FROM customer as c
INNER JOIN invoice AS i ON c.customer_id = i.customer_id
INNER JOIN invoice_line AS il ON i.invoice_id = il.invoice_id
INNER JOIN track as t ON il.track_id = t.track_id
INNER JOIN genre as g ON t.genre_id = g.genre_id
GROUP BY 1,3)


SELECT country, num_of_purchases, genre_name as genre FROM the_most_popular_genre WHERE r <= 1

-- Q13: Write a query that retrieves the customer spending the most on music for each country and returns the country, the top customer, the genre, and the amount they spent.
-- In cases where multiple customers share the highest amount spent, include all of them.

WITH customer_spent_the_most AS(
SELECT i.billing_country as country, 
	CONCAT(c.first_name,' ', c.last_name) as full_name, 
	COUNT(il.unit_price*il.quantity) AS total_spending,
	g.name as genre,
	ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY COUNT(il.unit_price*il.quantity)DESC) as r
FROM customer as c
INNER JOIN invoice as i ON c.customer_id = i.customer_id
INNER JOIN invoice_line as il ON i.invoice_id = il.invoice_id
INNER JOIN track as t ON il.track_id = t.track_id
INNER JOIN genre as g ON t.genre_id = t.genre_id
GROUP BY 1,2,4)

SELECT country, full_name, total_spending, genre FROM customer_spent_the_most WHERE r <=1

