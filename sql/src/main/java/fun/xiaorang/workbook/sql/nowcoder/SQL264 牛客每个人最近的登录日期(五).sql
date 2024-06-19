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
SELECT l.date,
       IFNULL(ROUND(SUM(IF(DATEDIFF(l2.date, l.date) = 1 AND t.first = l.date, 1, 0)) /
                    SUM(IF(t.first = l.date, 1, 0)),
                    3), 0) AS `p`
FROM login l
         LEFT JOIN login l2 ON l.user_id = l2.user_id AND DATEDIFF(l2.date, l.date) = 1
         LEFT JOIN (SELECT user_id, MIN(date) AS `first`
                    FROM login
                    GROUP BY user_id) t ON l.user_id = t.user_id AND l.date = t.first
GROUP BY l.date
ORDER BY l.date;

SELECT date,
       IFNULL(ROUND(SUM(IF(date = min_date AND DATEDIFF(next_date, date) = 1, 1, 0)) / SUM(IF(date = min_date, 1, 0)),
                    3), 0) AS `p`
FROM (SELECT user_id,
             date,
             MIN(date) OVER (PARTITION BY user_id)                   AS min_date,
             LEAD(date, 1) OVER (PARTITION BY user_id ORDER BY date) AS next_date
      FROM login) t
GROUP BY date
ORDER BY date;