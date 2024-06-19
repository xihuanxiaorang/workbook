-- SQL Schema
Drop table If Exists Employees;
Create table If Not Exists Employees
(
    employee_id int,
    name        varchar(20),
    manager_id  int,
    salary      int
);
Truncate table Employees;
insert into Employees (employee_id, name, manager_id, salary)
values ('3', 'Mila', '9', '60301');
insert into Employees (employee_id, name, manager_id, salary)
values ('12', 'Antonella', NULL, '31000');
insert into Employees (employee_id, name, manager_id, salary)
values ('13', 'Emery', NULL, '67084');
insert into Employees (employee_id, name, manager_id, salary)
values ('1', 'Kalel', '11', '21241');
insert into Employees (employee_id, name, manager_id, salary)
values ('9', 'Mikaela', NULL, '50937');
insert into Employees (employee_id, name, manager_id, salary)
values ('11', 'Joziah', '6', '28485');
# Write your MySQL query statement below
SELECT e.employee_id
FROM employees e
         LEFT JOIN employees m ON e.manager_id = m.employee_id
WHERE e.manager_id IS NOT NULL
  AND m.employee_id IS NULL
  AND e.salary < 30000
ORDER BY e.employee_id;