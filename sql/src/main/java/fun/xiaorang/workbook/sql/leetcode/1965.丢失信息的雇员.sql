-- SQL Schema
Drop table If Exists Employees;
Drop table If Exists Salaries;
Create table If Not Exists Employees
(
    employee_id int,
    name        varchar(30)
);
Create table If Not Exists Salaries
(
    employee_id int,
    salary      int
);
Truncate table Employees;
insert into Employees (employee_id, name)
values ('2', 'Crew');
insert into Employees (employee_id, name)
values ('4', 'Haven');
insert into Employees (employee_id, name)
values ('5', 'Kristian');
Truncate table Salaries;
insert into Salaries (employee_id, salary)
values ('5', '76071');
insert into Salaries (employee_id, salary)
values ('1', '22517');
insert into Salaries (employee_id, salary)
values ('4', '63539');
# Write your MySQL query statement below
SELECT e.employee_id
FROM employees e
         LEFT JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.salary IS NULL
UNION
SELECT s.employee_id
FROM salaries s
         LEFT JOIN employees e ON s.employee_id = e.employee_id
WHERE e.name IS NULL
ORDER BY employee_id;