-- SQL Schema
Drop table If Exists orders;
Create table If Not Exists orders
(
    order_number    int,
    customer_number int
);
Truncate table orders;
insert into orders (order_number, customer_number)
values ('1', '1');
insert into orders (order_number, customer_number)
values ('2', '2');
insert into orders (order_number, customer_number)
values ('3', '3');
insert into orders (order_number, customer_number)
values ('4', '3');
# Write your MySQL query statement below
SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT customer_number
FROM (SELECT customer_number, DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS `rn`
      FROM orders
      GROUP BY customer_number) t
WHERE rn = 1;

