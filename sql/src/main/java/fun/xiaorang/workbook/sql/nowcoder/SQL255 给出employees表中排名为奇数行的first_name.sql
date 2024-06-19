-- SQL Schema
drop table if exists `employees`;
CREATE TABLE `employees`
(
    `emp_no`     int(11)     NOT NULL,
    `birth_date` date        NOT NULL,
    `first_name` varchar(14) NOT NULL,
    `last_name`  varchar(16) NOT NULL,
    `gender`     char(1)     NOT NULL,
    `hire_date`  date        NOT NULL,
    PRIMARY KEY (`emp_no`)
);
INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1985-11-21');
INSERT INTO employees
VALUES (10005, '1955-01-21', 'Kyoichi', 'Maliniak', 'M', '1989-09-12');
INSERT INTO employees
VALUES (10006, '1953-04-20', 'Anneke', 'Preusig', 'F', '1989-06-02');


# Write your MySQL query statement below
SELECT e.first_name AS `first`
FROM employees e
         INNER JOIN
     (SELECT first_name, ROW_NUMBER() OVER (ORDER BY first_name) AS `rn`
      FROM employees) t ON e.first_name = t.first_name
WHERE rn % 2 = 1;