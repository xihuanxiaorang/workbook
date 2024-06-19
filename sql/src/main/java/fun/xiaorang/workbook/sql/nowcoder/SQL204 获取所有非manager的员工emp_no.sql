-- SQL Schema
drop table if exists `dept_manager`;
drop table if exists `employees`;
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
INSERT INTO dept_manager
VALUES ('d001', 10002, '1996-08-03', '9999-01-01');
INSERT INTO dept_manager
VALUES ('d002', 10003, '1990-08-05', '9999-01-01');
INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1985-11-21');
INSERT INTO employees
VALUES (10003, '1959-12-03', 'Parto', 'Bamford', 'M', '1986-08-28');

# Write your MySQL query statement below
SELECT e.emp_no
FROM employees e
         LEFT JOIN dept_manager dm on e.emp_no = dm.emp_no
WHERE dm.dept_no IS NULL;