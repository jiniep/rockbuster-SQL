/*revenue and number of rents for each film */
SELECT 
  f.film_id, 
  f.title, 
  COUNT(p.rental_id) as number_of_rentals, 
  SUM(p.amount) as revenue, 
  MAX(p.amount) max_rent_price, 
  MIN(p.amount) as min_rent_price
FROM payment p
INNER JOIN rental r on r.rental_id = p.rental_id
INNER JOIN inventory iv ON iv.inventory_id = r.inventory_id
INNER JOIN film f on f.film_id = iv.film_id
GROUP by f.film_id, f.title
ORDER by revenue DESC, number_of_rentals DESC
