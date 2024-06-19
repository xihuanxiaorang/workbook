-- SQL Schema
drop table if exists `departments`;
drop table if exists `dept_emp`;
drop table if exists `employees`;
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
INSERT INTO departments
VALUES ('d001', 'Marketing');
INSERT INTO departments
VALUES ('d002', 'Finance');
INSERT INTO departments
VALUES ('d003', 'Human Resources');
INSERT INTO dept_emp
VALUES (10001, 'd001', '1986-06-26', '9999-01-01');
INSERT INTO dept_emp
VALUES (10002, 'd001', '1996-08-03', '9999-01-01');
INSERT INTO dept_emp
VALUES (10003, 'd002', '1990-08-05', '9999-01-01');
INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1985-11-21');
INSERT INTO employees
VALUES (10003, '1959-12-03', 'Parto', 'Bamford', 'M', '1986-08-28');
INSERT INTO employees
VALUES (10004, '1954-05-01', 'Chirstian', 'Koblick', 'M', '1986-12-01');
# Write your MySQL query statement below
SELECT e.last_name, e.first_name, d.dept_name
FROM employees e
         LEFT JOIN dept_emp de on e.emp_no = de.emp_no
         LEFT JOIN departments d on de.dept_no = d.dept_no;