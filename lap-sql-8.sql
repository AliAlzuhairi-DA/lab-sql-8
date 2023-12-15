-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output
SELECT title, length, rank() over (order by length) as 'rank'
from film
where length is not null and length > 0;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

SELECT title, length, rating, rank() over (partition by rating order by length) as 'rank'
from film
where length is not null and length > 0;

-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

SELECT c.name AS category, COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

SELECT a.last_name as actor, count(*) as film_count
from actor a
join film_actor fc on a.actor_id = fc.actor_id
group by a.last_name;

-- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id 
-- for each customer.

SELECT c.customer_id, c.first_name, c.last_name, count(*) as rental_count
from rental r
join customer c on r.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name
order by rental_count desc
limit 1;


-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries 
-- with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental 
-- ids for each film.

SELECT f.film_id, f.title AS most_rented_film, COUNT(*) AS rental_count
FROM rental r
JOIN inventory iv ON r.inventory_id = iv.inventory_id
JOIN film f ON iv.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 1;
