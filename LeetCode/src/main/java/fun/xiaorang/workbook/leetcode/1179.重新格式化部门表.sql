-- SQL Schema
Drop table If Exists Department;
Create table If Not Exists Department
(
    id      int,
    revenue int,
    month   varchar(5)
);
Truncate table Department;
insert into Department (id, revenue, month)
values ('1', '8000', 'Jan');
insert into Department (id, revenue, month)
values ('2', '9000', 'Jan');
insert into Department (id, revenue, month)
values ('3', '10000', 'Feb');
insert into Department (id, revenue, month)
values ('1', '7000', 'Feb');
insert into Department (id, revenue, month)
values ('1', '6000', 'Mar');
# Write your MySQL query statement below
SELECT id,
       SUM(IF(month = 'Jan', revenue, NULL)) `Jan_Revenue`,
       SUM(IF(month = 'Feb', revenue, NULL)) `Feb_Revenue`,
       SUM(IF(month = 'Mar', revenue, NULL)) `Mar_Revenue`,
       SUM(IF(month = 'Apr', revenue, NULL)) `Apr_Revenue`,
       SUM(IF(month = 'May', revenue, NULL)) `May_Revenue`,
       SUM(IF(month = 'Jun', revenue, NULL)) `Jun_Revenue`,
       SUM(IF(month = 'Jul', revenue, NULL)) `Jul_Revenue`,
       SUM(IF(month = 'Aug', revenue, NULL)) `Aug_Revenue`,
       SUM(IF(month = 'Sep', revenue, NULL)) `Sep_Revenue`,
       SUM(IF(month = 'Oct', revenue, NULL)) `Oct_Revenue`,
       SUM(IF(month = 'Nov', revenue, NULL)) `Nov_Revenue`,
       SUM(IF(month = 'Dec', revenue, NULL)) `Dec_Revenue`
FROM department
GROUP BY id;