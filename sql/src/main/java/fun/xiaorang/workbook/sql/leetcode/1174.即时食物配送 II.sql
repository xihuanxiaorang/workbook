-- SQL Schema
DROP TABLE IF EXISTS Delivery;
Create table If Not Exists Delivery
(
    delivery_id                 int,
    customer_id                 int,
    order_date                  date,
    customer_pref_delivery_date date
);
Truncate table Delivery;
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values ('1', '1', '2019-08-01', '2019-08-02');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values ('2', '2', '2019-08-02', '2019-08-02');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values ('3', '1', '2019-08-11', '2019-08-12');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values ('4', '3', '2019-08-24', '2019-08-24');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values ('5', '3', '2019-08-21', '2019-08-22');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values ('6', '2', '2019-08-11', '2019-08-13');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
values ('7', '4', '2019-08-09', '2019-08-09');
# Write your MySQL query statement below
SELECT (ROUND(SUM(IF(order_date = customer_pref_delivery_date, 1, 0)) / COUNT(customer_id) * 100,
              2)) AS `immediate_percentage`
FROM (SELECT customer_id,
             MIN(order_date)                  AS `order_date`,
             MIN(customer_pref_delivery_date) AS `customer_pref_delivery_date`
      FROM delivery
      GROUP BY customer_id) t;