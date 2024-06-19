-- SQL Schema
drop table if exists login;
CREATE TABLE `login`
(
    `id`        int(4) NOT NULL,
    `user_id`   int(4) NOT NULL,
    `client_id` int(4) NOT NULL,
    `date`      date   NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO login
VALUES (1, 2, 1, '2020-10-12'),
       (2, 3, 2, '2020-10-12'),
       (3, 1, 2, '2020-10-12'),
       (4, 2, 2, '2020-10-13'),
       (5, 1, 2, '2020-10-13'),
       (6, 3, 1, '2020-10-14'),
       (7, 4, 1, '2020-10-14'),
       (8, 4, 1, '2020-10-15');

# Write your MySQL query statement below
SELECT date, SUM(IF(rn = 1, 1, 0)) AS `new`
FROM (SELECT *, RANK() OVER (PARTITION BY user_id ORDER BY date ) AS `rn`
      FROM login) t
GROUP BY date
ORDER BY date;