-- SQL Schema
Drop table If Exists Products;
Create table If Not Exists Products
(
    product_id  int,
    new_price   int,
    change_date date
);
Truncate table Products;
insert into Products (product_id, new_price, change_date)
values ('1', '20', '2019-08-14');
insert into Products (product_id, new_price, change_date)
values ('2', '50', '2019-08-14');
insert into Products (product_id, new_price, change_date)
values ('1', '30', '2019-08-15');
insert into Products (product_id, new_price, change_date)
values ('1', '35', '2019-08-16');
insert into Products (product_id, new_price, change_date)
values ('2', '65', '2019-08-17');
insert into Products (product_id, new_price, change_date)
values ('3', '20', '2019-08-18');
# Write your MySQL query statement below
SELECT t1.product_id, IFNULL(t2.new_price, 10) AS `price`
FROM (SELECT product_id FROM products GROUP BY product_id) t1
         LEFT JOIN (SELECT product_id,
                           new_price,
                           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS `rn`
                    FROM products
                    WHERE change_date <= '2019-08-16') t2 ON t1.product_id = t2.product_id AND t2.rn = 1;

SELECT DISTINCT product_id,
                FIRST_VALUE(IF(change_date <= '2019-08-16', new_price, 10))
                            OVER (PARTITION BY product_id ORDER BY IF(change_date <= '2019-08-16', change_date, 0) DESC) AS `price`
FROM products;