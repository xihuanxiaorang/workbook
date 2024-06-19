-- SQL Schema
Drop table If Exists Triangle;
Create table If Not Exists Triangle
(
    x int,
    y int,
    z int
);
Truncate table Triangle;
insert into Triangle (x, y, z)
values ('13', '15', '30');
insert into Triangle (x, y, z)
values ('10', '20', '15');
# Write your MySQL query statement below
SELECT x, y, z, IF(x + y > z && x + z > y && y + z > x, 'Yes', 'No') AS `triangle`
FROM triangle;