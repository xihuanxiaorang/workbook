-- SQL Schema
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee
(
    id         int,
    name       varchar(255),
    department varchar(255),
    managerId  int
);
Truncate table Employee;
insert into Employee (id, name, department, managerId)
values ('101', 'John', 'A', NULL);
insert into Employee (id, name, department, managerId)
values ('102', 'Dan', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('103', 'James', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('104', 'Amy', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('105', 'Anne', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('106', 'Ron', 'B', '101');
# Write your MySQL query statement below
SELECT name
FROM employee
WHERE id IN (SELECT managerId
             FROM employee
             WHERE managerId IS NOT NULL
             GROUP BY managerId
             HAVING COUNT(*) >= 5);
