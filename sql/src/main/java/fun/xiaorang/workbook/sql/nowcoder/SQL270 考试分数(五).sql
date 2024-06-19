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
SELECT id, job, score, b AS `t_rank`
FROM (SELECT *,
             COUNT(*) OVER (PARTITION BY job)                   AS `total`,
             RANK() OVER (PARTITION BY job ORDER BY score)      AS `a`,
             RANK() OVER (PARTITION BY job ORDER BY score DESC) AS `b`
      FROM grade) t
WHERE a >= total / 2
  AND b >= total / 2
ORDER BY id;