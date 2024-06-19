-- SQL Schema
Drop table If Exists MyNumbers;
Create table If Not Exists MyNumbers
(
    num int
);
Truncate table MyNumbers;
insert into MyNumbers (num)
values ('8');
insert into MyNumbers (num)
values ('8');
insert into MyNumbers (num)
values ('3');
insert into MyNumbers (num)
values ('3');
insert into MyNumbers (num)
values ('1');
insert into MyNumbers (num)
values ('4');
insert into MyNumbers (num)
values ('5');
insert into MyNumbers (num)
values ('6');
# Write your MySQL query statement below
SELECT MAX(num) AS `num`
FROM (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(*) = 1) t;