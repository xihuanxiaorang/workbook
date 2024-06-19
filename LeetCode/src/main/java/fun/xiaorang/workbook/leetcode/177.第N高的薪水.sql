-- SQL Schema
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee
(
    Id     int,
    Salary int
);
Truncate table Employee;
insert into Employee (id, salary)
values ('1', '100');
insert into Employee (id, salary)
values ('2', '200');
insert into Employee (id, salary)
values ('3', '300');

SET GLOBAL log_bin_trust_function_creators = TRUE;

DROP FUNCTION IF EXISTS getNthHighestSalary;
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    DECLARE M INT;
    SET M = N - 1;
    RETURN (
        # Write your MySQL query statement below.
        SELECT IFNULL((SELECT DISTINCT Salary
                       FROM employee
                       ORDER BY Salary DESC
                       LIMIT 1 OFFSET M), NULL));
END;

SELECT getNthHighestSalary(2);