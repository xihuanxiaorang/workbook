-- SQL Schema;
Drop table If Exists Employees;
Create table If Not Exists Employees
(
    employee_id int,
    name        varchar(20),
    reports_to  int,
    age         int
);
Truncate table Employees;
insert into Employees (employee_id, name, reports_to, age)
values ('9', 'Hercy', NULL, '43');
insert into Employees (employee_id, name, reports_to, age)
values ('6', 'Alice', '9', '41');
insert into Employees (employee_id, name, reports_to, age)
values ('4', 'Bob', '9', '36');
insert into Employees (employee_id, name, reports_to, age)
values ('2', 'Winston', NULL, '37');
# Write your MySQL query statement below
SELECT m.employee_id, m.name, COUNT(e.employee_id) AS `reports_count`, round(AVG(e.age), 0) AS `average_age`
FROM employees m
         LEFT JOIN employees e ON m.employee_id = e.reports_to
WHERE e.employee_id IS NOT NULL
GROUP BY m.employee_id, m.name
ORDER BY m.employee_id;
