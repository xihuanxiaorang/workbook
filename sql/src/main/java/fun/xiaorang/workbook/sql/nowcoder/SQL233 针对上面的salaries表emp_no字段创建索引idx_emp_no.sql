-- SQL Schema
drop table if exists salaries;
CREATE TABLE `salaries`
(
    `emp_no`    int(11) NOT NULL,
    `salary`    int(11) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `from_date`)
);
create index idx_emp_no on salaries (emp_no);
INSERT INTO salaries
VALUES (10005, 78228, '1989-09-12', '1990-09-12');
INSERT INTO salaries
VALUES (10005, 94692, '2001-09-09', '9999-01-01');

# Write your MySQL query statement below
SELECT *
FROM salaries FORCE INDEX (idx_emp_no)
WHERE emp_no = 10005;