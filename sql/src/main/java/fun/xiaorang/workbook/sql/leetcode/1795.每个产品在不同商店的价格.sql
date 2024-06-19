-- SQL Schema;
Drop table If Exists Products;
Create table If Not Exists Products
(
    product_id int,
    store1     int,
    store2     int,
    store3     int
);
Truncate table Products;
insert into Products (product_id, store1, store2, store3)
values ('0', '95', '100', '105');
insert into Products (product_id, store1, store2, store3)
values ('1', '70', NULL, '80');
# Write your MySQL query statement below
SELECT product_id, 'store1' AS `store`, store1 AS `price`
FROM products
WHERE store1 IS NOT NULL
UNION ALL
SELECT product_id, 'store2' AS `store`, store2 AS `price`
FROM products
WHERE store2 IS NOT NULL
UNION ALL
SELECT product_id, 'store3' AS `store`, store3 AS `price`
FROM products
WHERE store3 IS NOT NULL;