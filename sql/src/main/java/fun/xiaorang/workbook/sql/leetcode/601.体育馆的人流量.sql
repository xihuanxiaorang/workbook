-- SQL Schema
Drop table If Exists Stadium;
Create table If Not Exists Stadium
(
    id         int,
    visit_date DATE NULL,
    people     int
);
Truncate table Stadium;
insert into Stadium (id, visit_date, people)
values ('1', '2017-01-01', '10');
insert into Stadium (id, visit_date, people)
values ('2', '2017-01-02', '109');
insert into Stadium (id, visit_date, people)
values ('3', '2017-01-03', '150');
insert into Stadium (id, visit_date, people)
values ('4', '2017-01-04', '99');
insert into Stadium (id, visit_date, people)
values ('5', '2017-01-05', '145');
insert into Stadium (id, visit_date, people)
values ('6', '2017-01-06', '1455');
insert into Stadium (id, visit_date, people)
values ('7', '2017-01-07', '199');
insert into Stadium (id, visit_date, people)
values ('8', '2017-01-09', '188');
# Write your MySQL query statement below
SELECT DISTINCT s1.*
FROM stadium s1,
     stadium s2,
     stadium s3
WHERE s1.people >= 100
  AND s2.people >= 100
  AND s3.people >= 100
  AND (
    s2.id = s1.id + 1 AND s3.id = s1.id + 2 OR #其后两行都大于等于100
    s2.id = s1.id + 1 AND s3.id = s1.id - 1 OR #其前一行和后一行都大于等于100
    s2.id = s1.id - 1 AND s3.id = s1.id - 2 #其前两行都大于等于100
    )
ORDER BY s1.visit_date;

-- 先找出人数大于等于100的 创建一列序号参考列 用原表id与序号列相减，连续id会得到相同的值，在聚合计算个数大于3的
SELECT id, visit_date, people
FROM (SELECT id, visit_date, people, COUNT(*) OVER (PARTITION BY id - rn) AS `cnt`
      FROM (SELECT id, visit_date, people, ROW_NUMBER() OVER (ORDER BY id) `rn`
            FROM stadium
            WHERE people >= 100) a) b
WHERE cnt >= 3
ORDER BY visit_date;

SELECT id, visit_date, people
FROM (SELECT LAG(id, 2) OVER (ORDER BY visit_date)  `pre2`,
             LAG(id, 1) OVER (ORDER BY visit_date)  `pre1`,
             id,
             LEAD(id, 1) OVER (ORDER BY visit_date) `next1`,
             LEAD(id, 2) OVER (ORDER BY visit_date) `next2`,
             visit_date,
             people
      FROM stadium
      WHERE people >= 100) t
WHERE (pre2 = id - 2 AND pre1 = id - 1)
   OR (pre1 = id - 1 AND next1 = id + 1)
   OR (next1 = id + 1 AND next2 = id + 2)
ORDER BY visit_date;