-- SQL Schema;
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee
(
    employee_id   int,
    department_id int,
    primary_flag  ENUM ('Y','N')
);
Truncate table Employee;
insert into Employee (employee_id, department_id, primary_flag)
values ('1', '1', 'N');
insert into Employee (employee_id, department_id, primary_flag)
values ('2', '1', 'Y');
insert into Employee (employee_id, department_id, primary_flag)
values ('2', '2', 'N');
insert into Employee (employee_id, department_id, primary_flag)
values ('3', '3', 'N');
insert into Employee (employee_id, department_id, primary_flag)
values ('4', '2', 'N');
insert into Employee (employee_id, department_id, primary_flag)
values ('4', '3', 'Y');
insert into Employee (employee_id, department_id, primary_flag)
values ('4', '4', 'N');
# Write your MySQL query statement below
SELECT employee_id, department_id
FROM (SELECT employee_id, department_id, primary_flag, COUNT(*) OVER (PARTITION BY employee_id) AS `cnt`
      FROM employee) t
WHERE cnt = 1
   OR primary_flag = 'Y';

SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y'
   OR employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(*) = 1);