-- SQL Schema;
Drop table If Exists Employees;
Create table If Not Exists Employees
(
    employee_id int,
    name        varchar(30),
    salary      int
);
Truncate table Employees;
insert into Employees (employee_id, name, salary)
values ('2', 'Meir', '3000');
insert into Employees (employee_id, name, salary)
values ('3', 'Michael', '3800');
insert into Employees (employee_id, name, salary)
values ('7', 'Addilyn', '7400');
insert into Employees (employee_id, name, salary)
values ('8', 'Juan', '6100');
insert into Employees (employee_id, name, salary)
values ('9', 'Kannon', '7700');
# Write your MySQL query statement below
SELECT employee_id, IF(SUBSTR(name, 1, 1) <> 'M' AND employee_id % 2 = 1, salary, 0) AS `bonus`
FROM employees
ORDER BY employee_id;