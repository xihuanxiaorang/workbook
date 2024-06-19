-- SQL Schema
Drop Table If Exists Insurance;
Create Table If Not Exists Insurance
(
    pid      int,
    tiv_2015 float,
    tiv_2016 float,
    lat      float,
    lon      float
);
Truncate table Insurance;
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('1', '10', '5', '10', '10');
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('2', '20', '20', '20', '20');
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('3', '10', '30', '20', '20');
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('4', '10', '40', '40', '40');
# Write your MySQL query statement below
SELECT ROUND(SUM(tiv_2016), 2) AS `tiv_2016`
FROM insurance
WHERE tiv_2015 IN (SELECT tiv_2015
                   FROM insurance
                   GROUP BY tiv_2015
                   HAVING COUNT(*) > 1)
  AND (lat, lon) IN (SELECT lat, lon
                     FROM insurance
                     GROUP BY lat, lon
                     HAVING COUNT(*) = 1);

