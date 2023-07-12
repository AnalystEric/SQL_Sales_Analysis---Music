# <p align="center">Music Store Sales Analysis</p> 
# Project Overview
Utilise SQL to assist a music store in enhancing its business growth by providing answers to various questions.

# SQL skills used in this project
* Windows Functions
* Subqueriers
* Inner Join
* Having
* Group by
* Order by
* Limit
* Distinct
* Round
* Concat
* Change datatype
* Create CTE table

# Built with
* Postgre SQL
* PgAdmin4

# About the database
11 CSV files are imported for this project.

# Schema
![Screenshot 2023-07-12 at 19 05 08](https://github.com/AnalystEric/SQL_Sales_Analysis---Music_Store/assets/127030648/588268b0-228e-4b12-a4aa-bef495d6a1cd)

# Query Result
### 1.	Which country has the most invoices?

![Screenshot 2023-07-12 at 20 34 36](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/4e519ff2-35a0-4f84-925b-993f2b3eca90)

### 2.	Who is the most senior employee based on the job title?

![Screenshot 2023-07-12 at 20 36 09](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/ff44ad43-73dd-4c2d-80bf-ccd458f2c0fb)

### 3.	What are the top 3 values for the total invoice?

![Screenshot 2023-07-12 at 20 38 14](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/e9b80218-5865-4ea7-98fb-6e52350c1159)

### 4.	Who is the best customer? 
•	The customer who has spent the most money is considered the best customer.
•	Write a query that returns the full name of the person who has spent the most money.

![Screenshot 2023-07-12 at 20 39 18](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/80071b70-8fc0-4325-acb1-1ad75f02b793)

### 5.	Which city has the best customers?
•	We would like to host a promotional Music Festival in the city where we have the highest profit.
•	Write a query that returns only one city with the highest sum of invoice totals.
•	Return both the city name and the sum of all invoice total.

![Screenshot 2023-07-12 at 20 40 14](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/bf50d786-f3f8-44d9-8e1d-0ce12645d921)

### 6.	Write a query to retrieve customers who have spent more than 100.
•	The result should display the customers' full names along with the amount of money they spent in descending order.
![Screenshot 2023-07-12 at 20 40 59](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/7f263618-e0cd-4a05-be1b-a3591598766f)

### 7.	Write a query to return the email, first name, last name, and genre of all Rock music listeners.
•	Return your list ordered alphabetically by email, starting with 'A'.

![Screenshot 2023-07-12 at 20 55 50](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/56c49c5a-b09b-429f-86f8-c9b78b2caaec)


### 8.	We would like to invite artists who have written the most rock music in our dataset.
•	Write a query that returns the Artist name and total track count of the top 10 rock bands.

![Screenshot 2023-07-12 at 20 45 09](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/3dc8733d-fed7-4e1a-955c-eef714e0eb4d)

### 9.	Return all the track names that have a song length longer than the average song length.
•	Return the Name and Milliseconds for each track. Order by the song length, with the longest song listed first.



### 10.	 Find how much amount is spent by each customer on the best-selling artists.
•	Write a query to return the customer’s name, artist name, and total amount spent.


### 11.	We would like to find out the most popular music genre for each country.
•	We define the most popular genre as the genre with the highest number of purchases.
•	Write a query that retrieves each country along with the top genre.
•	In cases where multiple genres share the maximum number of purchases, include all of them.

![Screenshot 2023-07-12 at 20 51 18](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/7634b980-2040-476b-8b5e-f4b2c48b8711)

### 12.	Write a query that retrieves the customer spending the most on music for each country and returns the country, the top customer, the genre, and the amount they spent.
•	In cases where multiple customers share the highest amount spent, include all of them.

![Screenshot 2023-07-12 at 20 53 09](https://github.com/AnalystEric/SQL_Sales_Analysis---Music/assets/127030648/11408a5f-430b-4e9a-bcf1-c945535b580a)





