-- SQL Schema
Drop table If Exists Activities;
Create table If Not Exists Activities
(
    sell_date date,
    product   varchar(20)
);
Truncate table Activities;
insert into Activities (sell_date, product)
values ('2020-05-30', 'Headphone');
insert into Activities (sell_date, product)
values ('2020-06-01', 'Pencil');
insert into Activities (sell_date, product)
values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product)
values ('2020-05-30', 'Basketball');
insert into Activities (sell_date, product)
values ('2020-06-01', 'Bible');
insert into Activities (sell_date, product)
values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product)
values ('2020-05-30', 'T-Shirt');
# Write your MySQL query statement below
SELECT sell_date,
       COUNT(DISTINCT product)                                       AS `num_sold`,
       GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS `products`
FROM activities
GROUP BY sell_date
ORDER BY sell_date;
