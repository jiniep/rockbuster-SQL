/* List number of top 5 customers that are based within each top 10 country */
SELECT 
  top5customers.country, 
  all_customers_count, 
  COUNT(top5customers.customer_id) AS top_customer_count 
FROM 
  (
    -- count customers in all countries
    SELECT 
      c2.country_id, 
      COUNT(DISTINCT c.customer_id) as all_customers_count 
    FROM 
      customer c 
      JOIN address a on a.address_id = c.address_id 
      JOIN city c2 on c2.city_id = a.city_id 
    GROUP BY 
      c2.country_id
  ) all_customers 
  JOIN (
    --find top 5 customers within each counrty
    SELECT 
      ct.customer_id, 
      c.country_id, 
      c2.country, 
      SUM(p.amount) as total_amount 
    from 
      customer ct 
      INNER JOIN payment p ON ct.customer_id = p.customer_id 
      INNER JOIN address a on ct.address_id = a.address_id 
      INNER JOIN city c on c.city_id = a.city_id 
      INNER JOIN country c2 on c2.country_id = c.country_id 
    WHERE 
      c2.country IN (
        'India', 'China', 'United States', 
        'Japan', 'Mexico', 'Brazil', 'Russian Federation', 
        'Philippines', 'Turkey', 'Indonesia'
      ) 
    GROUP by 
      ct.customer_id, 
      c.country_id, 
      c2.country 
    ORDER BY 
      total_amount DESC 
    LIMIT 
      5
  ) top5customers on top5customers.country_id = all_customers.country_id 
GROUP by 
  top5customers.country, 
  all_customers_count
