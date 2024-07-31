-- Provide  a report for the top 10 customers

select CONCAT(customers.first_name, ' ' ,customers.last_name) AS fullname, 
SUM(orders.sales_amount) AS sales_amount 
from customers
join orders
on customers.customer_id = orders.customer_id
GROUP BY CONCAT(customers.first_name, ' ' ,customers.last_name)
ORDER BY  SUM(orders.sales_amount) desc
limit 10;

--provide a list of all customers full names and the total of cars purchsed, sort by purchased desc 

select CONCAT(customers.first_name, ' ' ,customers.last_name) AS fullname,
sum (orders.quantity_sold) AS qty
from  customers
left join orders
on customers.customer_id = orders.customer_id
group by fullname
order by qty desc;


--provide a list of car model and their respective revenue generated sort by revenue desc

select cars.car_model,
sum(orders.sales_amount)AS rev
from orders
right join cars
on orders.car_id = cars.car_id
group by cars.car_model
order by rev desc;


--check if there are customers with the same fullname

select CONCAT(customers.first_name, ' ' ,customers.last_name) AS fullname,
count (CONCAT(customers.first_name, ' ' ,customers.last_name)) AS count
from customers
group by CONCAT(customers.first_name, ' ' ,customers.last_name)
order by count desc;

--what month generated the most sales

select to_char(order_date, 'Month') AS months,
sum (sales_amount) AS sales
from orders
group by to_char(order_date, 'Month')
order by sales desc
limit 1;

--what city generated the highest revenue

select city,
sum(orders.sales_amount) AS sales
from customers
left join orders on customers.customer_id =orders.customer_id
group by city
order by sales desc
limit 1;

--provide a report of sales generated per month in chronological order

select  to_char(order_date, 'Month') AS month_name,
sum(sales_amount) AS sales
from orders
group by  
	to_char(order_date, 'Month'), 
	to_char(order_date,'MM') 
order by to_char(order_date,'MM');

--provide a list of all car brand and total quantity sold

select cars.car_brand, 
sum(quantity_sold) AS qty_sold
from cars
full join orders
on orders.car_id =cars.car_id
group by cars.car_brand;

--Provide the total unit price for cars with colors white and black.

select car_color, 
sum(unit_price) AS qty_sold
from cars
where car_color = 'White' OR car_color = 'Black'
group by car_color;

--Provide the full names of customers whose first name starts with ‘A’.

select CONCAT(first_name, ' ' ,last_name) AS fullname
From customers
Where first_name Like 'A%';

--Return a list of all customers and the amount spent so far, customers with no transaction should be replaced with 0

SELECT customers.customer_id, COALESCE(SUM (sales_amount),0)
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id
ORDER BY SUM(sales_amount) DESC;

/*Provide the number of customers in the following category, group each transaction based on the following conditions.
sales amount 0-99999 = Low Budget 
100000-200000 = Normal Budget
200000-400000 = High Budget all returned columns should be text data type*/

SELECT category, CAST(COUNT(category) AS TEXT)
FROM
    (SELECT sales_amount, CASE
                                WHEN sales_amount < 100000 THEN 'Low'
                                WHEN sales_amount BETWEEN 1 AND 200000 THEN 'Normal'
                                ELSE 'High'
                          END AS category
    FROM Orders)
GROUP BY category;


/*Provide the total revenue based on the following
age group of customers Ages 0-18 (Children), Ages 19-40 (Youth), Above 40 Adult.*/

SELECT age_group, SUM(sales_amount)
FROM
          (SELECT customers.customer_id,
                  orders.sales_amount,
                  customers,age,
                  CASE
	                  WHEN age < 19 THEN 'Children'
	                  WHEN age < 41 THEN 'Youth'
                      ELSE 'Adult'
                  END AS age_group
           FROM orders
	       JOIN customers
           ON customers.customer_id = orders.customer_id)
GROUP BY 1


/*Retrieve a list of all orders made by customer replace NULL with 'Yet to purchase’.*/
	
SELECT customers.customer_id, COALESCE(CAST(order_id AS TEXT),'Yet to purchase') AS orders
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id
ORDER BY 2 DESC;







	
                       