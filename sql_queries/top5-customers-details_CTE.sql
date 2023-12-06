/* List top 5 customers from top 10 cities in top 10 countries. This was determined by number of customers, followed by revenue */		

WITH top10cities AS (		
	
  /* top 10 cities in top 10 countries by customers and revenue */	
	SELECT top10country.country, c4.city,c4.city_id, COUNT(DISTINCT ct.customer_id) as no_of_customers, SUM(p.amount) as revenue	
	FROM city c4	
	INNER JOIN ( /* find top10 countries by number of customers */	
		SELECT c3.country_id as country_id, c3.country as country
		from customer c
		INNER JOIN address a on a.address_id = c.address_id
		INNER JOIN city c2 on c2.city_id = a.city_id
		INNER JOIN country c3 on c3.country_id = c2.country_id
		GROUP by c3.country_id, c3.country
		ORDER BY COUNT(c.customer_id) DESC
		LIMIT 10
	)as top10country on top10country.country_id = c4.country_id	
	INNER JOIN address ad on ad.city_id = c4.city_id	
	INNER JOIN customer ct on ct.address_id = ad.address_id	
	INNER JOIN payment p on p.customer_id = ct.customer_id	
	GROUP by c4.city, top10country.country, c4.city_id	
	ORDER BY no_of_customers DESC, revenue DESC /* order by number of customers and then revenue */	
	LIMIT 10	
)		
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) as revenue 		
FROM top10cities		
INNER JOIN address a on a.city_id = top10cities.city_id		
INNER JOIN customer c on c.address_id = a.address_id		
INNER JOIN payment p on p.customer_id = c.customer_id		
GROUP BY c.customer_id, c.first_name, c.last_name		
ORDER BY revenue DESC		
LIMIT 5		
