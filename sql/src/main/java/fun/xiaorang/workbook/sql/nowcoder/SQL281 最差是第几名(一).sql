-- SQL Schema
drop table if exists class_grade;
CREATE TABLE class_grade
(
    grade  varchar(32) NOT NULL,
    number int(4)      NOT NULL
);

INSERT INTO class_grade
VALUES ('A', 2),
       ('D', 1),
       ('C', 2),
       ('B', 2);
# Write your MySQL query statement below
SELECT grade, SUM(number) over (ORDER BY grade) AS `t_rank`
FROM class_grade;