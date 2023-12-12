/* show all countries rental, customers, films & 
revenue totals */
SELECT 
  c4.country_id, 
  c4.country, 
  COUNT(r.rental_id) as number_of_rentals,
  COUNT(DISTINCT c.customer_id) as number_of_customers,
  COUNT(iv.film_id) as number_of_films,
  SUM(p.amount) as total_revenue,
  (SUM(p.amount) / 61312 *100) AS revenue_percent
FROM rental r
INNER JOIN customer c on r.customer_id = c.customer_id
INNER JOIN address a ON a.address_id = c.address_id
INNER JOIN city c3 on c3.city_id = a.city_id
INNER JOIN country c4 on c4.country_id = c3.country_id
INNER JOIN inventory iv ON iv.inventory_id = r.inventory_id
INNER JOIN payment p on r.rental_id = p.rental_id
GROUP BY c4.country_id, c4.country
ORDER BY total_revenue DESC
