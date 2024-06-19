-- SQL Schema
DROP TABLE IF EXISTS Person;
Create table If Not Exists Person
(
    Id    int,
    Email varchar(255)
);
Truncate table Person;
insert into Person (id, email)
values ('1', 'john@example.com');
insert into Person (id, email)
values ('2', 'bob@example.com');
insert into Person (id, email)
values ('3', 'john@example.com');

# Write your MySQL query statement below
DELETE p
FROM person p
         INNER JOIN
     (SELECT MIN(id) AS `min_id`, email
      FROM person
      GROUP BY email
      HAVING COUNT(email) > 1) t ON p.email = t.email AND p.id != t.min_id;

DELETE p
FROM person p
WHERE p.id NOT IN (SELECT t.min_id FROM (SELECT MIN(id) AS `min_id` FROM person GROUP BY email) t);

-- 笛卡尔积 ，非等值筛选
DELETE p1
FROM person p1
         INNER JOIN person p2 ON p1.email = p2.email AND p1.id > p2.id;

DELETE p
FROM person p
WHERE id IN (SELECT id
             FROM (SELECT id, ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS `rn`
                   FROM person) t
             WHERE t.rn > 1);