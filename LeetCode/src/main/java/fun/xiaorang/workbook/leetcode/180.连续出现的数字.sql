-- SQL Schema
Drop table If Exists Logs;
Create table If Not Exists Logs
(
    id  int,
    num int
);
Truncate table Logs;
insert into Logs (id, num)
values ('1', '1');
insert into Logs (id, num)
values ('2', '1');
insert into Logs (id, num)
values ('3', '1');
insert into Logs (id, num)
values ('4', '2');
insert into Logs (id, num)
values ('5', '1');
insert into Logs (id, num)
values ('6', '2');
insert into Logs (id, num)
values ('7', '2');

# Write your MySQL query statement below
SELECT DISTINCT num AS ConsecutiveNums
FROM (SELECT num,
             id - CAST(ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS SIGNED) AS `diff`
      FROM Logs) t
GROUP BY num, diff
HAVING COUNT(*) >= 3;

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
         INNER JOIN Logs l2 ON l1.id = l2.id - 1 AND l1.num = l2.num
         INNER JOIN Logs l3 ON l2.id = l3.id - 1 AND l2.num = l3.num;

SELECT DISTINCT num AS ConsecutiveNums
FROM (SELECT num,
             LAG(num, 1, NULL) OVER (ORDER BY id)  AS num1,
             LEAD(num, 1, NULL) OVER (ORDER BY id) AS num2
      FROM Logs) t
WHERE num = num1
  AND num = num2;
