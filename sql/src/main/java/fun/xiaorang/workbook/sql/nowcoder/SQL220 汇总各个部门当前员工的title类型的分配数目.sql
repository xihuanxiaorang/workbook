-- SQL Schema
drop table if exists `departments`;
drop table if exists `dept_emp`;
drop table if exists titles;
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
CREATE TABLE titles
(
    `emp_no`    int(11)     NOT NULL,
    `title`     varchar(50) NOT NULL,
    `from_date` date        NOT NULL,
    `to_date`   date DEFAULT NULL
);
INSERT INTO departments
VALUES ('d001', 'Marketing');
INSERT INTO departments
VALUES ('d002', 'Finance');
INSERT INTO dept_emp
VALUES (10001, 'd001', '1986-06-26', '9999-01-01');
INSERT INTO dept_emp
VALUES (10002, 'd001', '1996-08-03', '9999-01-01');
INSERT INTO dept_emp
VALUES (10003, 'd002', '1995-12-03', '9999-01-01');
INSERT INTO titles
VALUES (10001, 'Senior Engineer', '1986-06-26', '9999-01-01');
INSERT INTO titles
VALUES (10002, 'Staff', '1996-08-03', '9999-01-01');
INSERT INTO titles
VALUES (10003, 'Senior Engineer', '1995-12-03', '9999-01-01');
# Write your MySQL query statement below
SELECT d.dept_no, d.dept_name, t.title, COUNT(*) AS `count`
FROM departments d
         INNER JOIN dept_emp de on d.dept_no = de.dept_no
         INNER JOIN titles t on de.emp_no = t.emp_no
GROUP BY d.dept_no, d.dept_name, t.title
ORDER BY d.dept_no, t.title;