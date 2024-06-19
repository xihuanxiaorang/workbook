-- SQL Schema
drop table if exists `employees`;
drop table if exists `salaries`;
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
CREATE TABLE `salaries`
(
    `emp_no`    int(11) NOT NULL,
    `salary`    int(11) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `from_date`)
);
INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '2001-06-22');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1999-08-03');
INSERT INTO salaries
VALUES (10001, 85097, '2001-06-22', '2002-06-22');
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '1999-08-03', '2000-08-02');
INSERT INTO salaries
VALUES (10002, 72527, '2000-08-02', '2001-08-02');
# Write your MySQL query statement below
SELECT a.emp_no, a.salary - b.salary AS `growth`
FROM (SELECT emp_no, salary
      FROM salaries
      WHERE to_date = '9999-01-01') a
         INNER JOIN (SELECT e.emp_no, s.salary
                     FROM salaries s
                              INNER JOIN employees e ON s.from_date = e.hire_date) b ON a.emp_no = b.emp_no
ORDER BY growth;