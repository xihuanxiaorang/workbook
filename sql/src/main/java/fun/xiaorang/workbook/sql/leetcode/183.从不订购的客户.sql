-- SQL Schema
Drop table If Exists Customers;
Drop table If Exists Orders;
Create table If Not Exists Customers
(
    id   int,
    name varchar(255)
);
Create table If Not Exists Orders
(
    id         int,
    customerId int
);
Truncate table Customers;
insert into Customers (id, name)
values ('1', 'Joe');
insert into Customers (id, name)
values ('2', 'Henry');
insert into Customers (id, name)
values ('3', 'Sam');
insert into Customers (id, name)
values ('4', 'Max');
Truncate table Orders;
insert into Orders (id, customerId)
values ('1', '3');
insert into Orders (id, customerId)
values ('2', '1');

# Write your MySQL query statement below
SELECT c.name AS `Customers`
FROM customers c
         LEFT JOIN orders o ON c.id = o.customerId
WHERE o.id IS NULL;

SELECT c.name AS `Customers`
FROM customers c
WHERE c.id NOT IN (SELECT customerId FROM orders);