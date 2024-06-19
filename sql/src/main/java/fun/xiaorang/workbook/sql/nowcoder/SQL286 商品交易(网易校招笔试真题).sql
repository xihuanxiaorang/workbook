-- SQL Schema
CREATE TABLE `goods`
(
    `id`     int(11) NOT NULL,
    `name`   varchar(10) DEFAULT NULL,
    `weight` int(11) NOT NULL,
    PRIMARY KEY (`id`)
);
CREATE TABLE `trans`
(
    `id`       int(11) NOT NULL,
    `goods_id` int(11) NOT NULL,
    `count`    int(11) NOT NULL,
    PRIMARY KEY (`id`)
);
insert into goods
values (1, 'A1', 100);
insert into goods
values (2, 'A2', 20);
insert into goods
values (3, 'B3', 29);
insert into goods
values (4, 'T1', 60);
insert into goods
values (5, 'G2', 33);
insert into goods
values (6, 'C0', 55);
insert into trans
values (1, 3, 10);
insert into trans
values (2, 1, 44);
insert into trans
values (3, 6, 9);
insert into trans
values (4, 1, 2);
insert into trans
values (5, 2, 65);
insert into trans
values (6, 5, 23);
insert into trans
values (7, 3, 20);
insert into trans
values (8, 2, 16);
insert into trans
values (9, 4, 5);
insert into trans
values (10, 1, 3);

# Write your MySQL query statement below
SELECT *
FROM (SELECT DISTINCT g.*, SUM(t.count) OVER (PARTITION BY t.goods_id) AS `total`
      FROM goods g
               LEFT JOIN trans t on g.id = t.goods_id
      WHERE g.weight < 50) t
WHERE total > 20
ORDER BY id;