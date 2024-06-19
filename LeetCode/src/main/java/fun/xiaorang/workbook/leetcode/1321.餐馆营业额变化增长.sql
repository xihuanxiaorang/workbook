-- SQL Schema
DROP TABLE IF EXISTS Customer;
Create table If Not Exists Customer
(
    customer_id int,
    name        varchar(20),
    visited_on  date,
    amount      int
);
Truncate table Customer;
insert into Customer (customer_id, name, visited_on, amount)
values ('1', 'Jhon', '2019-01-01', '100');
insert into Customer (customer_id, name, visited_on, amount)
values ('2', 'Daniel', '2019-01-02', '110');
insert into Customer (customer_id, name, visited_on, amount)
values ('3', 'Jade', '2019-01-03', '120');
insert into Customer (customer_id, name, visited_on, amount)
values ('4', 'Khaled', '2019-01-04', '130');
insert into Customer (customer_id, name, visited_on, amount)
values ('5', 'Winston', '2019-01-05', '110');
insert into Customer (customer_id, name, visited_on, amount)
values ('6', 'Elvis', '2019-01-06', '140');
insert into Customer (customer_id, name, visited_on, amount)
values ('7', 'Anna', '2019-01-07', '150');
insert into Customer (customer_id, name, visited_on, amount)
values ('8', 'Maria', '2019-01-08', '80');
insert into Customer (customer_id, name, visited_on, amount)
values ('9', 'Jaze', '2019-01-09', '110');
insert into Customer (customer_id, name, visited_on, amount)
values ('1', 'Jhon', '2019-01-10', '130');
insert into Customer (customer_id, name, visited_on, amount)
values ('3', 'Jade', '2019-01-10', '150');
# Write your MySQL query statement below
SELECT *
FROM (SELECT visited_on,
             SUM(sum_amount) OVER (ORDER BY visited_on RANGE INTERVAL 6 DAY PRECEDING)                  `amount`,
             ROUND(SUM(sum_amount) OVER (ORDER BY visited_on RANGE INTERVAL 6 DAY PRECEDING) / 7, 2) AS `average_amount`
      FROM (SELECT visited_on, SUM(amount) AS `sum_amount`
            FROM customer
            GROUP BY visited_on) a) b
WHERE visited_on >= (SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY) FROM customer);