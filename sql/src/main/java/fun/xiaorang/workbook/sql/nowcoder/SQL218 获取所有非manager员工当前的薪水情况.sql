-- SQL Schema
drop table if exists `dept_emp`;
drop table if exists `dept_manager`;
drop table if exists `employees`;
drop table if exists `salaries`;
CREATE TABLE `dept_emp`
(
    `emp_no`    int(11) NOT NULL,
    `dept_no`   char(4) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `dept_no`)
);
CREATE TABLE `dept_manager`
(
    `dept_no`   char(4) NOT NULL,
    `emp_no`    int(11) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `dept_no`)
);
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
INSERT INTO dept_emp
VALUES (10001, 'd001', '1986-06-26', '9999-01-01');
INSERT INTO dept_emp
VALUES (10002, 'd001', '1996-08-03', '9999-01-01');
INSERT INTO dept_manager
VALUES ('d001', 10002, '1996-08-03', '9999-01-01');
INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1996-08-03');
INSERT INTO salaries
VALUES (10001, 88958, '1986-06-26', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '1996-08-03', '9999-01-01');
# Write your MySQL query statement below
SELECT de.dept_no, e.emp_no, s.salary
FROM employees e
         LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
         LEFT JOIN salaries s on e.emp_no = s.emp_no
LEFT JOIN dept_manager dm on de.emp_no = dm.emp_no
WHERE dm.emp_no IS NULL;

