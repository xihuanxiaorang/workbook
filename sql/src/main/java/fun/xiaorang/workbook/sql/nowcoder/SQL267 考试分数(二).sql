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
       (8, 'JS', 9999),
       (9, 'Java', 12500);

# Write your MySQL query statement below
SELECT g.*
FROM grade g
         INNER JOIN (SELECT job, AVG(score) AS `avg_score`
                     FROM grade
                     GROUP BY job) t
WHERE g.job = t.job
  AND g.score > t.avg_score
ORDER BY id;