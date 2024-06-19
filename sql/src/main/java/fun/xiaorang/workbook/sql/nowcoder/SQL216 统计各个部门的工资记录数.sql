-- SQL Schema
drop table if exists `departments`;
drop table if exists `dept_emp`;
drop table if exists `salaries`;
CREATE TABLE `departments`
(
    `dept_no`   char(4)     NOT NULL,
    `dept_name` varchar(40) NOT NULL,
    PRIMARY KEY (`dept_no`)
);
CREATE TABLE `dept_emp`
(
    `emp_no`    int(11) NOT NULL,
    `dept_no`   char(4) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `dept_no`)
);
CREATE TABLE `salaries`
(
    `emp_no`    int(11) NOT NULL,
    `salary`    int(11) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `from_date`)
);
INSERT INTO departments
VALUES ('d001', 'Marketing');
INSERT INTO departments
VALUES ('d002', 'Finance');
INSERT INTO dept_emp
VALUES (10001, 'd001', '2001-06-22', '9999-01-01');
INSERT INTO dept_emp
VALUES (10002, 'd001', '1996-08-03', '9999-01-01');
INSERT INTO dept_emp
VALUES (10003, 'd002', '1996-08-03', '9999-01-01');
INSERT INTO salaries
VALUES (10001, 85097, '2001-06-22', '2002-06-22');
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '1996-08-03', '9999-01-01');
INSERT INTO salaries
VALUES (10003, 32323, '1996-08-03', '9999-01-01');
# Write your MySQL query statement below
SELECT d.dept_no, d.dept_name, COUNT(*) AS `sum`
FROM departments d
         INNER JOIN dept_emp de on d.dept_no = de.dept_no
         INNER JOIN salaries s on de.emp_no = s.emp_no
GROUP BY d.dept_no, d.dept_name
ORDER BY d.dept_no;