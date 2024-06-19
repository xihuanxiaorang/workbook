-- SQL Schema
drop table if exists `employees`;
drop table if exists emp_bonus;
drop table if exists `salaries`;
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
create table emp_bonus
(
    emp_no   int      not null,
    recevied datetime not null,
    btype    smallint not null
);
CREATE TABLE `salaries`
(
    `emp_no`    int(11) NOT NULL,
    `salary`    int(11) NOT NULL,
    `from_date` date    NOT NULL,
    `to_date`   date    NOT NULL,
    PRIMARY KEY (`emp_no`, `from_date`)
);
insert into emp_bonus
values (10001, '2010-01-01', 1),
       (10002, '2010-10-01', 2);
INSERT INTO employees
VALUES (10001, '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
INSERT INTO employees
VALUES (10002, '1964-06-02', 'Bezalel', 'Simmel', 'F', '1985-11-21');

INSERT INTO salaries
VALUES (10001, 60117, '1986-06-26', '1987-06-26');
INSERT INTO salaries
VALUES (10001, 62102, '1987-06-26', '1988-06-25');
INSERT INTO salaries
VALUES (10001, 66074, '1988-06-25', '1989-06-25');
INSERT INTO salaries
VALUES (10001, 66596, '1989-06-25', '1990-06-25');
INSERT INTO salaries
VALUES (10001, 66961, '1990-06-25', '1991-06-25');
INSERT INTO salaries
VALUES (10001, 71046, '1991-06-25', '1992-06-24');
INSERT INTO salaries
VALUES (10001, 74333, '1992-06-24', '1993-06-24');
INSERT INTO salaries
VALUES (10001, 75286, '1993-06-24', '1994-06-24');
INSERT INTO salaries
VALUES (10001, 75994, '1994-06-24', '1995-06-24');
INSERT INTO salaries
VALUES (10001, 76884, '1995-06-24', '1996-06-23');
INSERT INTO salaries
VALUES (10001, 80013, '1996-06-23', '1997-06-23');
INSERT INTO salaries
VALUES (10001, 81025, '1997-06-23', '1998-06-23');
INSERT INTO salaries
VALUES (10001, 81097, '1998-06-23', '1999-06-23');
INSERT INTO salaries
VALUES (10001, 84917, '1999-06-23', '2000-06-22');
INSERT INTO salaries
VALUES (10001, 85112, '2000-06-22', '2001-06-22');
INSERT INTO salaries
VALUES (10001, 85097, '2001-06-22', '2002-06-22');
INSERT INTO salaries
VALUES (10001, 88958, '2002-06-22', '9999-01-01');
INSERT INTO salaries
VALUES (10002, 72527, '1996-08-03', '1997-08-03');
INSERT INTO salaries
VALUES (10002, 72527, '1997-08-03', '1998-08-03');
INSERT INTO salaries
VALUES (10002, 72527, '1998-08-03', '1999-08-03');
INSERT INTO salaries
VALUES (10002, 72527, '1999-08-03', '2000-08-02');
INSERT INTO salaries
VALUES (10002, 72527, '2000-08-02', '2001-08-02');
INSERT INTO salaries
VALUES (10002, 72527, '2001-08-02', '9999-01-01');

# Write your MySQL query statement below
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       eb.btype,
       s.salary,
       ROUND(CASE WHEN btype = 1 THEN salary * 0.1 WHEN btype = 2 THEN salary * 0.2 ELSE salary * 0.3 END, 1) AS `bonus`
FROM employees e
         INNER JOIN emp_bonus eb on e.emp_no = eb.emp_no
         INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
ORDER BY e.emp_no;