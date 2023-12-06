---CUSTOMER TABLE DATA CHECKS & SUMMARY ----

SELECT * from customer;

--check for duplicates by email and addressid
SELECT 
	c.email,
	c.address_id,
	COUNT(*)
FROM customer c
GROUP BY 
	c.email,
	c.address_id
HAVING COUNT(*) > 1


--check for duplicates customers using first, last name and email address
SELECT 
	c.first_name,
	c.last_name,
	c.email,
	COUNT(*)
FROM customer c
GROUP BY 
	c.first_name,
	c.last_name,
	c.email
HAVING COUNT(*) > 1

-- create view of unique customers
CREATE VIEW unique_customers AS
	SELECT 
	DISTINCT c.first_name, c.last_name, c.email, c.address_id
	FROM customer c


--checking for missing values
SELECT * from customer where first_name IS NULL or first_name = '';
SELECT * from customer where last_name IS NULL or last_name = '';
SELECT * from customer where email IS NULL or email = '';
SELECT * from customer where address_id IS NULL;
SELECT * from customer where activebool IS NULL;
SELECT * from customer where active IS NULL;


--checking for incorrect values
SELECT * from customer where email LIKE '%@%.';
SELECT * from customer where address_id < 1;
SELECT activebool, COUNT(*) from customer group by activebool;
SELECT active, COUNT(*) FROM customer group by active;

--Summerize data

--common address_id of customers
SELECT MODE() WITHIN GROUP (order by address_id) 
from customer

--common active status of customers and total customers
SELECT COUNT(customer_id)AS number_of_customers, MODE() WITHIN GROUP (order by active) as mode_active
from customer

-- customer count by active status
SELECT active, COUNT (*) as customers
from customer group by active order by active

-- checking if customers with c.active=0 have rented in the past
SELECT c.customer_id, COUNT(p.payment_id) as number_of_payments
from customer c
INNER JOIN payment p on p.customer_id = c.customer_id
where c.active = 0 and c.activebool = true
GROUP by c.customer_id

--count number of active customers using activebool
SELECT activebool, COUNT(*) as customers 
from customer 
GROUP BY activebool

