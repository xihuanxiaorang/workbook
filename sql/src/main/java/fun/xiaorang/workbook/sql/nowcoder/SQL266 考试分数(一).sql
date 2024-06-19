-- SQL Schema
drop table if exists grade;
CREATE TABLE grade
(
    `id`    int(4)      NOT NULL,
    `job`   varchar(32) NOT NULL,
    `score` int(10)     NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO grade
VALUES (1, 'C++', 11001),
       (2, 'C++', 10000),
       (3, 'C++', 9000),
       (4, 'Java', 12000),
       (5, 'Java', 13000),
       (6, 'JS', 12000),
       (7, 'JS', 11000),
       (8, 'JS', 9999);

# Write your MySQL query statement below
SELECT job, ROUND(AVG(score), 3) AS `avg`
FROM grade
GROUP BY job
ORDER BY avg DESC;