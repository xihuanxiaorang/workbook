-- SQL Schema
Drop table If Exists Sales;
Drop table If Exists Product;
Create table If Not Exists Sales
(
    sale_id    int,
    product_id int,
    year       int,
    quantity   int,
    price      int
);
Create table If Not Exists Product
(
    product_id   int,
    product_name varchar(10)
);
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price)
values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price)
values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price)
values ('7', '200', '2011', '15', '9000');
Truncate table Product;
insert into Product (product_id, product_name)
values ('100', 'Nokia');
insert into Product (product_id, product_name)
values ('200', 'Apple');
insert into Product (product_id, product_name)
values ('300', 'Samsung');
# Write your MySQL query statement below
SELECT product_id, year AS `first_year`, quantity, price
FROM (SELECT product_id, RANK() OVER (PARTITION BY product_id ORDER BY year) AS `rn`, year, quantity, price
      FROM sales) t
WHERE rn = 1;

SELECT product_id, year AS `first_year`, quantity, price
FROM sales
WHERE (product_id, year) IN (SELECT product_id, MIN(year)
                             FROM sales
                             GROUP BY product_id);
