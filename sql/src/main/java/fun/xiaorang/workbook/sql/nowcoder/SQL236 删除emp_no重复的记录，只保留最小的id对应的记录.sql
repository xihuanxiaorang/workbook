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
DELETE
FROM titles_test
WHERE id IN (SELECT *
             FROM (SELECT a.id
                   FROM titles_test a
                            INNER JOIN (SELECT emp_no, MIN(id) AS `min_id`
                                        FROM titles_test
                                        GROUP BY emp_no
                                        HAVING COUNT(*) > 1) b ON a.emp_no = b.emp_no AND a.id > b.min_id) c);

DELETE
FROM titles_test
WHERE id NOT IN (SELECT *
                 FROM (SELECT MIN(id)
                       FROM titles_test
                       GROUP BY emp_no) a);