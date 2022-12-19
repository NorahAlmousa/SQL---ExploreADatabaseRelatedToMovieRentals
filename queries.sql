/* QUERY 1 -query used for first insight */
SELECT 
table1.name,
SUM (table1.fcount)
FROM
 (SELECT DISTINCT
        f.film_id,
        f.title,
        c.name,
        COUNT(r.rental_id) OVER ( Partition by f.title) AS fcount
       FROM film f 
       JOIN film_category fc
       ON f.film_id=fc.film_id
       JOIN category c
       ON fc.category_id=c.category_id
JOIN inventory inv
ON fc.film_id=inv.film_id
JOIN rental r
ON inv.inventory_id=r.inventory_id
WHERE c.name IN('Animation', 'Children', 'Classics', 'Comedy','Family', 'Music') ) table1
GROUP BY table1.name
ORDER BY 1;





/* QUERY 2 -query used for second insight */


SELECT 
duration_name.name,
duration_name.Standard_quartile,
COUNT(Standard_quartile) AS "count"
FROM 
      (SELECT 
       f.title,
       f.rental_duration,
       c.name ,
       NTILE(4) OVER (ORDER BY f.rental_duration) AS Standard_quartile
       FROM film f 
       JOIN film_category fc
       ON f.film_id=fc.film_id
       JOIN category c
       ON fc.category_id=c.category_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy','Family', 'Music'))AS duration_name
GROUP BY 1,2 
ORDER BY 1,2;                 
              





/* QUERY 3 -query used for third insight */

SELECT 
DATE_PART('month',r.rental_date) AS Rental_Month ,
DATE_PART('year',r.rental_date) AS Rental_Year,
sr.store_id AS Store_ID,
COUNT(*) AS Count_Rental
FROM store sr
JOIN staff sf
ON sr.manager_staff_id=sf.staff_id
JOIN rental r
ON sf.staff_id=r.staff_id
GROUP BY 1,2,3
ORDER BY Count_Rental DESC;



/* QUERY 4 -query used for fourth insight */

SELECT 
c.customer_id,
sum(p.amount) AS total_amount
FROM customer c
JOIN payment p
ON c.customer_id=p.customer_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;















       
       






