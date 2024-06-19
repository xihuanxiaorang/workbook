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
       (6, 'B', 12000),
       (7, 'B', 11000),
       (8, 'B', 9999);

# Write your MySQL query statement below
SELECT job, FLOOR((COUNT(*) + 1) / 2) AS `start`, CEILING((COUNT(*) + 1) / 2) AS `end`
FROM grade
GROUP BY job
ORDER BY job;