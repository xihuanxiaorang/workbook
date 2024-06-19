-- SQL Schema
drop table if exists class_grade;
CREATE TABLE class_grade
(
    grade  varchar(32) NOT NULL,
    number int(4)      NOT NULL
);

INSERT INTO class_grade
VALUES ('A', 2),
       ('C', 4),
       ('B', 4),
       ('D', 2);
# Write your MySQL query statement below
SELECT grade
FROM (SELECT grade,
             SUM(number) OVER ()                    AS `total`,
             SUM(number) OVER (ORDER BY grade)      AS `a`,
             SUM(number) OVER (ORDER BY grade DESC) AS `b`
      FROM class_grade
      ORDER BY grade) t
WHERE a >= total / 2
  AND b >= total / 2;
