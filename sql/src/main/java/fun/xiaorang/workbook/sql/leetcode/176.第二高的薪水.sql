-- SQL Schema
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee
(
    id     int,
    salary int
);
Truncate table Employee;
insert into Employee (id, salary)
values ('1', '100');
insert into Employee (id, salary)
values ('2', '200');
insert into Employee (id, salary)
values ('3', '300');

# Write your MySQL query statement below
SELECT IFNULL((SELECT DISTINCT salary FROM employee ORDER BY salary DESC LIMIT 1 OFFSET 1),
              NULL) AS 'SecondHighestSalary';