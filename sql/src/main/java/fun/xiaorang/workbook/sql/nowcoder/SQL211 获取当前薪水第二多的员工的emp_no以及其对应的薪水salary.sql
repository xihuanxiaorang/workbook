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

# Write your MySQL query statement below
SELECT emp_no, salary
FROM salaries
WHERE salary = (SELECT salary FROM salaries GROUP BY salary ORDER BY salary DESC LIMIT 1 OFFSET 1)
ORDER BY emp_no;

SELECT emp_no, salary
FROM (SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS `rn`
      FROM salaries) t
WHERE rn = 2
ORDER BY emp_no;