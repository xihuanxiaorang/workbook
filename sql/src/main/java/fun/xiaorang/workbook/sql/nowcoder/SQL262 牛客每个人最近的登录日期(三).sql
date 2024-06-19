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
       (5, 4, 1, '2020-10-13'),
       (6, 1, 2, '2020-10-13'),
       (7, 1, 2, '2020-10-14');

# Write your MySQL query statement below
SELECT ROUND(AVG(IF(l2.user_id IS NOT NULL, 1, 0)), 3) AS `p`
FROM (SELECT user_id, MIN(date) AS `date` FROM login GROUP BY user_id) l1
         LEFT JOIN login l2 ON l1.user_id = l2.user_id AND DATEDIFF(l2.date, l1.date) = 1;

SELECT ROUND(AVG(IF(DATEDIFF(second, date) = 1, 1, 0)), 3) AS `p`
FROM (SELECT date,
             RANK() OVER (PARTITION BY user_id ORDER BY date)     AS `rn`,
             LEAD(date) OVER (PARTITION BY user_id ORDER BY date) AS `second`
      FROM login) t
WHERE rn = 1;