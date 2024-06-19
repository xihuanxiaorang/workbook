-- SQL Schema
DROP TABLE IF EXISTS Tree;
Create table If Not Exists Tree
(
    id   int,
    p_id int
);
Truncate table Tree;
insert into Tree (id, p_id)
values ('1', NULL);
insert into Tree (id, p_id)
values ('2', '1');
insert into Tree (id, p_id)
values ('3', '1');
insert into Tree (id, p_id)
values ('4', '2');
insert into Tree (id, p_id)
values ('5', '2');
# Write your MySQL query statement below
SELECT t1.id, IF(COUNT(t1.p_id) = 0, 'Root', IF(COUNT(t2.id) = 0, 'Leaf', 'Inner')) AS `type`
FROM tree t1
         LEFT JOIN tree t2 ON t1.id = t2.p_id
GROUP BY t1.id;

SELECT id, IF(p_id IS NULL, 'Root', IF(id IN (SELECT p_id FROM tree), 'Inner', 'Leaf')) AS `type`
FROM tree;
