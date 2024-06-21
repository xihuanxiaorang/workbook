-- SQL Schema
drop table if exists product_tb;
CREATE TABLE product_tb
(
    item_id   char(10) NOT NULL,
    style_id  char(10) NOT NULL,
    tag_price int(10)  NOT NULL,
    inventory int(10)  NOT NULL
);
INSERT INTO product_tb
VALUES ('A001', 'A', 100, 20);
INSERT INTO product_tb
VALUES ('A002', 'A', 120, 30);
INSERT INTO product_tb
VALUES ('A003', 'A', 200, 15);
INSERT INTO product_tb
VALUES ('B001', 'B', 130, 18);
INSERT INTO product_tb
VALUES ('B002', 'B', 150, 22);
INSERT INTO product_tb
VALUES ('B003', 'B', 125, 10);
INSERT INTO product_tb
VALUES ('B004', 'B', 155, 12);
INSERT INTO product_tb
VALUES ('C001', 'C', 260, 25);
INSERT INTO product_tb
VALUES ('C002', 'C', 280, 18);

drop table if exists sales_tb;
CREATE TABLE sales_tb
(
    sales_date  date     NOT NULL,
    user_id     int(10)  NOT NULL,
    item_id     char(10) NOT NULL,
    sales_num   int(10)  NOT NULL,
    sales_price int(10)  NOT NULL
);

INSERT INTO sales_tb
VALUES ('2021-11-1', 1, 'A001', 1, 90);
INSERT INTO sales_tb
VALUES ('2021-11-1', 2, 'A002', 2, 220);
INSERT INTO sales_tb
VALUES ('2021-11-1', 2, 'B001', 1, 120);
INSERT INTO sales_tb
VALUES ('2021-11-2', 3, 'C001', 2, 500);
INSERT INTO sales_tb
VALUES ('2021-11-2', 4, 'B001', 1, 120);
INSERT INTO sales_tb
VALUES ('2021-11-3', 5, 'C001', 1, 240);
INSERT INTO sales_tb
VALUES ('2021-11-3', 6, 'C002', 1, 270);
INSERT INTO sales_tb
VALUES ('2021-11-4', 7, 'A003', 1, 180);
INSERT INTO sales_tb
VALUES ('2021-11-4', 8, 'B002', 1, 140);
INSERT INTO sales_tb
VALUES ('2021-11-4', 9, 'B001', 1, 125);
INSERT INTO sales_tb
VALUES ('2021-11-5', 10, 'B003', 1, 120);
INSERT INTO sales_tb
VALUES ('2021-11-5', 10, 'B004', 1, 150);
INSERT INTO sales_tb
VALUES ('2021-11-5', 10, 'A003', 1, 180);
INSERT INTO sales_tb
VALUES ('2021-11-6', 11, 'B003', 1, 120);
INSERT INTO sales_tb
VALUES ('2021-11-6', 10, 'B004', 1, 150);
# Write your MySQL query statement below
SELECT pt.style_id,
       ROUND(SUM(st.item_sales_num) / SUM(pt.inventory - st.item_sales_num) * 100, 2) AS `pin_rate(%)`,
       ROUND(SUM(item_GMV) / SUM(pt.tag_price * pt.inventory) * 100, 2)               AS `sell-through_rate(%)`
FROM (SELECT item_id, SUM(sales_num) AS `item_sales_num`, SUM(sales_price) AS `item_GMV`
      FROM sales_tb
      GROUP BY item_id) st
         INNER JOIN product_tb pt USING (item_id)
GROUP BY pt.style_id
ORDER BY pt.style_id;