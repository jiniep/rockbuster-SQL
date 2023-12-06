---FILM TABLE DATA CHECKS, CLEAN & SUMMARIZE ----

SELECT * from film

--checking for duplicates
SELECT title,
       release_year,
       language_id, 
	   COUNT(*)
FROM film
GROUP BY title,
         release_year,
         language_id
HAVING COUNT(*) >1;

CREATE VIEW film_unique AS 
SELECT * from film
WHERE film_id IN 
	(
		SELECT film_id
		FROM film
		GROUP BY title,
				 release_year,
				 language_id,
				 rental_duration
		HAVING COUNT(*) =1
	)

--check for missing values
SELECT * from film where title IS NULL or title = '';
SELECT * from film where description IS NULL or description = '';
SELECT * from film where release_year IS NULL;
SELECT * from film where language_id IS NULL;
SELECT * from film where rental_duration IS NULL;
SELECT * from film where rental_rate IS NULL;
SELECT * from film where length IS NULL;
SELECT * from film where replacement_cost IS NULL;
SELECT * from film where rating IS NULL;
SELECT * from film where last_update IS NULL;
SELECT * from film where special_features IS NULL;
SELECT * from film where fulltext IS NULL or fulltext = '';


--checking for incorrect values
SELECT release_year, COUNT(*) FROM film GROUP BY release_year;
SELECT language_id, COUNT(*) FROM film GROUP BY language_id;
SELECT rental_duration FROM film GROUP BY rental_duration;
SELECT rental_rate, COUNT(*) FROM film GROUP BY rental_rate;
SELECT length, COUNT(*) FROM film GROUP BY length order by length;
SELECT replacement_cost, COUNT(*) FROM film GROUP BY replacement_cost
order by replacement_cost;
SELECT rating, COUNT(*) FROM film GROUP BY  rating;

--Summarize 

--release_year
SELECT 
	MIN(release_year) as min_year, 
	MAX(release_year) as max_year, 
	MODE() WITHIN GROUP (ORDER BY release_year)
       AS mode_value
FROM film

-- rental_duration
SELECT 
	MIN(rental_duration) as min_rental_duration, 
	MAX(rental_duration) as max_rental_duration, 
	avg(rental_duration) as avg_rental_duration,
	MODE() WITHIN GROUP (ORDER BY rental_duration)
       AS mode_rental_duration
FROM film

--rental_rate
SELECT 
	MIN(rental_rate) as min_rental_rate, 
	MAX(rental_rate) as max_rental_rate, 
	avg(rental_rate) as avg_rental_rate,
	MODE() WITHIN GROUP (ORDER BY rental_rate)
       AS mode_rental_rate
FROM film

--length
SELECT 
	MIN(f.length) as min_length, 
	MAX(f.length) as max_length, 
	avg(f.length) as avg_length,
	MODE() WITHIN GROUP (ORDER BY f.length)
       AS mode_length
FROM film f

--replacement_cost
SELECT 
	MIN(f.replacement_cost) as min_replacement_cost, 
	MAX(f.replacement_cost) as max_replacement_cost, 
	avg(f.replacement_cost) as avg_replacement_cost,
	MODE() WITHIN GROUP (ORDER BY f.replacement_cost)
       AS mode_replacement_cost
FROM film f

--rating
SELECT 
	MODE() WITHIN GROUP (ORDER BY rating)
       AS mode_rating
FROM film
