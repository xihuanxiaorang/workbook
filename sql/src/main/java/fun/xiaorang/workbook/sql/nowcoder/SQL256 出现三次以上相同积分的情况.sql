-- SQL Schema
drop table if exists grade;
CREATE TABLE `grade`
(
    `id`     int(4) NOT NULL,
    `number` int(4) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO grade
VALUES (1, 111),
       (2, 333),
       (3, 111),
       (4, 111),
       (5, 333);

# Write your MySQL query statement below
SELECT number
FROM grade
GROUP BY number
HAVING COUNT(*) >= 3
ORDER BY number;