-- SQL Schema
drop table if exists email;
drop table if exists user;
CREATE TABLE `email`
(
    `id`         int(4)      NOT NULL,
    `send_id`    int(4)      NOT NULL,
    `receive_id` int(4)      NOT NULL,
    `type`       varchar(32) NOT NULL,
    `date`       date        NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user`
(
    `id`           int(4) NOT NULL,
    `is_blacklist` int(4) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO email
VALUES (1, 2, 3, 'completed', '2020-01-11'),
       (2, 1, 3, 'completed', '2020-01-11'),
       (3, 1, 4, 'no_completed', '2020-01-11'),
       (4, 3, 1, 'completed', '2020-01-12'),
       (5, 3, 4, 'completed', '2020-01-12'),
       (6, 4, 1, 'completed', '2020-01-12');

INSERT INTO user
VALUES (1, 0),
       (2, 1),
       (3, 0),
       (4, 0);
# Write your MySQL query statement below
SELECT e.date, ROUND(AVG(IF(e.type = 'no_completed', 1, 0)), 3) AS `p`
FROM email e
         INNER JOIN user u1 ON e.send_id = u1.id AND u1.is_blacklist = 0
         INNER JOIN user u2 ON e.receive_id = u2.id AND u2.is_blacklist = 0
GROUP BY e.date
ORDER BY e.date;