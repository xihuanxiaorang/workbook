-- SQL Schema
drop table if exists titles_test;
CREATE TABLE titles_test
(
    id        int(11)     not null primary key,
    emp_no    int(11)     NOT NULL,
    title     varchar(50) NOT NULL,
    from_date date        NOT NULL,
    to_date   date DEFAULT NULL
);

insert into titles_test
values ('1', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('2', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('3', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('4', '10004', 'Senior Engineer', '1995-12-03', '9999-01-01'),
       ('5', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
       ('6', '10002', 'Staff', '1996-08-03', '9999-01-01'),
       ('7', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01');

# Write your MySQL query statement below
UPDATE titles_test
SET emp_no = REPLACE(emp_no, '10001', '10005')
WHERE id = 5;