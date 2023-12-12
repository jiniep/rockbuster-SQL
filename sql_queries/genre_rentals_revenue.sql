/*revenue and number of rents for each category */
SELECT 
  c.name, 
  COUNT(DISTINCT f.film_id) as number_of_films, 
  COUNT(p.rental_id) as number_of_rentals, SUM(p.amount) as revenue, 
  COUNT(DISTINCT r.customer_id) as number_of_customers, 
  MAX(p.amount) max_rent_price, 
  MIN(p.amount) as min_rent_price, 
  avg (p.amount) as avg_price, 
  AVG(f.rental_rate) as avg_rental_rate, 
  AVG(f.rental_duration) avg_rental_duration
FROM payment p
RIGHT JOIN rental r on r.rental_id = p.rental_id
RIGHT JOIN inventory iv ON iv.inventory_id = r.inventory_id
RIGHT JOIN film f on f.film_id = iv.film_id
RIGHT JOIN film_category fc ON fc.film_id = f.film_id
RIGHT JOIN category c on c.category_id = fc.category_id
GROUP by c.name
ORDER by revenue DESC, number_of_rentals DESC
