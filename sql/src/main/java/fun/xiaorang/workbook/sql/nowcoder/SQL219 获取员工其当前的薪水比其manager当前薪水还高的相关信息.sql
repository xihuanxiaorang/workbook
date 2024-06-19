-- SQL Schema
drop table if exists `dept_emp`;
drop table if exists `dept_manager`;
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
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '1996-08-03', '9999-01-01');
# Write your MySQL query statement below
SELECT de.emp_no, dm.emp_no AS `manager_no`, s.salary AS `emp_salary`, s2.salary AS `manager_salary`
FROM dept_emp de
         LEFT JOIN dept_manager dm on de.dept_no = dm.dept_no
         LEFT JOIN salaries s on de.emp_no = s.emp_no
         LEFT JOIN salaries s2 ON dm.emp_no = s2.emp_no
WHERE s.salary > s2.salary
  AND de.emp_no <> dm.emp_no;
