-- SQL Schema
drop table if exists emp_bonus;
drop table if exists `salaries`;
create table emp_bonus
(
    emp_no int      not null,
    btype  smallint not null
);
CREATE TABLE `salaries`
(
    `emp_no`    int(11) NOT NULL,
    `salary`    float(11, 1) default NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `from_date`)
);
insert into emp_bonus
values (10001, 1);
INSERT INTO salaries
VALUES (10001, 85097, '2001-06-22', '2002-06-22');
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
# Write your MySQL query statement below
UPDATE salaries
SET salary = salary * 1.1
WHERE to_date = '9999-01-01'
  AND emp_no IN (SELECT emp_no
                 FROM emp_bonus);

UPDATE salaries s INNER JOIN emp_bonus eb on s.emp_no = eb.emp_no
SET salary = salary * 1.1
WHERE s.to_date = '9999-01-01';