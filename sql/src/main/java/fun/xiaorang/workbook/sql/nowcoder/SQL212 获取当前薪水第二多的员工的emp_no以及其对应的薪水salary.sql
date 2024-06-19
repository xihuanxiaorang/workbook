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
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1985-11-21');
INSERT INTO employees
VALUES (10003, '1959-12-03', 'Parto', 'Bamford', 'M', '1986-08-28');
INSERT INTO employees
VALUES (10004, '1954-05-01', 'Chirstian', 'Koblick', 'M', '1986-12-01');
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '2001-08-02', '9999-01-01');
INSERT INTO salaries
VALUES (10003, 43311, '2001-12-01', '9999-01-01');
INSERT INTO salaries
VALUES (10004, 74057, '2001-11-27', '9999-01-01');
# Write your MySQL query statement below
SELECT e.emp_no, s.salary, e.last_name, e.first_name
FROM employees e
         INNER JOIN salaries s on e.emp_no = s.emp_no
WHERE s.salary = (SELECT MAX(salary)
                  FROM salaries
                  WHERE salary != (SELECT MAX(salary) FROM salaries));

SELECT emp_no, salary, last_name, first_name
FROM (SELECT e.emp_no, s.salary, e.last_name, e.first_name, DENSE_RANK() OVER (ORDER BY s.salary DESC) AS `rnk`
      FROM employees e
               INNER JOIN salaries s on e.emp_no = s.emp_no) t
WHERE rnk = 2;