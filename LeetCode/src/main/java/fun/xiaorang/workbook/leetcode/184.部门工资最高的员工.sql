-- SQL Schema
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
Create table If Not Exists Employee
(
    id           int,
    name         varchar(255),
    salary       int,
    departmentId int
);
Create table If Not Exists Department
(
    id   int,
    name varchar(255)
);
Truncate table Employee;
insert into Employee (id, name, salary, departmentId)
values ('1', 'Joe', '70000', '1');
insert into Employee (id, name, salary, departmentId)
values ('2', 'Jim', '90000', '1');
insert into Employee (id, name, salary, departmentId)
values ('3', 'Henry', '80000', '2');
insert into Employee (id, name, salary, departmentId)
values ('4', 'Sam', '60000', '2');
insert into Employee (id, name, salary, departmentId)
values ('5', 'Max', '90000', '1');
Truncate table Department;
insert into Department (id, name)
values ('1', 'IT');
insert into Department (id, name)
values ('2', 'Sales');

# Write your MySQL query statement below
SELECT d.name AS `Department`, e.name AS `Employee`, e.salary AS `Salary`
FROM department d
         INNER JOIN employee e ON d.id = e.departmentId
WHERE (e.departmentId, e.salary) IN (SELECT e.departmentId, MAX(e.salary) AS `salary`
                                     FROM employee e
                                     GROUP BY e.departmentId);

SELECT d.name AS `Department`, t.name AS `Employee`, t.salary AS `Salary`
FROM department d
         INNER JOIN (SELECT name,
                            salary,
                            departmentId,
                            DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS `rn`
                     FROM employee) t ON d.id = t.departmentId
WHERE t.rn = 1;
