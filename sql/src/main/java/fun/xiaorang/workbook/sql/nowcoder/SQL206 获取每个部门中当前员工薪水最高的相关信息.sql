-- SQL Schema
drop table if exists `dept_emp`;
drop table if exists `salaries`;
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
INSERT INTO dept_emp
VALUES (10001, 'd001', '1986-06-26', '9999-01-01');
INSERT INTO dept_emp
VALUES (10002, 'd001', '1996-08-03', '9999-01-01');
INSERT INTO dept_emp
VALUES (10003, 'd002', '1996-08-03', '9999-01-01');

INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '2001-08-02', '9999-01-01');
INSERT INTO salaries
VALUES (10003, 92527, '2001-08-02', '9999-01-01');
# Write your MySQL query statement below
SELECT dept_no, emp_no, salary AS `maxSalary`
FROM (SELECT de.dept_no, de.emp_no, s.salary, DENSE_RANK() OVER (PARTITION BY de.dept_no ORDER BY s.salary DESC) AS `rn`
      FROM dept_emp de
               INNER JOIN salaries s ON de.emp_no = s.emp_no) t
WHERE rn = 1
ORDER BY dept_no;