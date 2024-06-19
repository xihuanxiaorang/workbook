-- SQL Schema
drop table if exists passing_number;
CREATE TABLE `passing_number`
(
    `id`     int(4) NOT NULL,
    `number` int(4) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO passing_number
VALUES (1, 4),
       (2, 3),
       (3, 3),
       (4, 2),
       (6, 4),
       (5, 5);
# Write your MySQL query statement below
SELECT *, DENSE_RANK() OVER (ORDER BY number DESC) AS `t_rank`
FROM passing_number
ORDER BY t_rank, id;