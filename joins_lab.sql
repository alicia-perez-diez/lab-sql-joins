-- List the number of films per category.
SELECT c.name AS category_name, COUNT(fc.film_id) AS number_of_films
FROM sakila.film_category AS fc
JOIN sakila.category AS c
ON c.category_id = fc.category_id
GROUP BY category_name;

-- Retrieve the store ID, city, and country for each store.
SELECT s.store_id AS store_ID, c.city as city_name, co.country as country_name
FROM sakila.store AS s
JOIN sakila.address AS a
ON s.address_id = a.address_id
JOIN sakila.city as c
ON c.city_id = a.city_id
JOIN sakila.country as co
ON co.country_id = c.country_id;

-- Calculate the total revenue generated by each store in dollars.
SELECT s.store_id AS store_ID, SUM(p.amount) AS revenue_in_dollars
FROM sakila.store AS s
JOIN sakila.staff AS st
ON s.store_id = st.store_id
JOIN sakila.payment as p
ON st.staff_id = p.staff_id
GROUP BY store_ID;

-- Determine the average running time of films for each category.
SELECT c.name AS category_name, ROUND(AVG(f.length)) AS avg_length
FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON fc.film_id = f.film_id
GROUP BY category_name;

-- Identify the film categories with the longest average running time.
SELECT c.name AS category_name, ROUND(AVG(f.length)) AS avg_length
FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON fc.film_id = f.film_id
GROUP BY category_name
ORDER BY avg_length DESC
LIMIT 1;

-- Display the top 10 most frequently rented movies in descending order.
SELECT f.title AS film_name, COUNT(r.rental_id) AS times_rented
FROM sakila.film AS f
JOIN sakila.inventory AS i
ON f.film_id = i.film_id
JOIN sakila.rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY film_name
ORDER BY times_rented DESC
LIMIT 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT f.title AS title, i.store_id AS available_in_store_id
FROM sakila.film AS f
JOIN sakila.inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Academy Dinosaur" AND i.store_id = 1;

	-- Sí, puede ser alquilada, ya que hay 4 unidades en la tienda 1
    
-- Provide a list of all distinct film titles, along with their availability status in the inventory.
-- Include a column indicating whether each title is 'Available' or 'NOT available.'
-- Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."

SELECT f.title AS film_titles, COUNT(i.film_id) AS number_of_copies,
	CASE
		WHEN ISNULL(i.film_id) THEN 'Not Available'
		ELSE 'Available'
	END AS availability
FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i
ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY f.film_id ASC;