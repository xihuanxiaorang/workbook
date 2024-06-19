-- SQL Schema
drop table if exists `salaries`;
CREATE TABLE `salaries`
(
    `emp_no`    int(11) NOT NULL,
    `salary`    int(11) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `from_date`)
);
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '2001-08-02', '9999-01-01');
INSERT INTO salaries
VALUES (10003, 43311, '2001-12-01', '9999-01-01');
INSERT INTO salaries
VALUES (10004, 72527, '2001-12-01', '9999-01-01');
# Write your MySQL query statement below
-- 排名窗口函数
SELECT emp_no, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS `t_rank`
FROM salaries
ORDER BY t_rank, emp_no;

-- 自连接
SELECT s1.emp_no, s1.salary, COUNT(DISTINCT s2.salary) AS `t_rank`
FROM salaries s1
         INNER JOIN salaries s2 ON s1.salary <= s2.salary
GROUP BY s1.emp_no, s1.salary
ORDER BY s1.salary DESC, s1.emp_no;