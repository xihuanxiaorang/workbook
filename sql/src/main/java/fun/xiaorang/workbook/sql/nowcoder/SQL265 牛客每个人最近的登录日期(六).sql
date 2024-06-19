-- SQL Schema
drop table if exists login;
drop table if exists passing_number;
drop table if exists user;
drop table if exists client;
CREATE TABLE `login`
(
    `id`        int(4) NOT NULL,
    `user_id`   int(4) NOT NULL,
    `client_id` int(4) NOT NULL,
    `date`      date   NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `passing_number`
(
    `id`      int(4) NOT NULL,
    `user_id` int(4) NOT NULL,
    `number`  int(4) NOT NULL,
    `date`    date   NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user`
(
    `id`   int(4)      NOT NULL,
    `name` varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
);


INSERT INTO login
VALUES (1, 2, 1, '2020-10-12'),
       (2, 3, 2, '2020-10-12'),
       (3, 1, 2, '2020-10-12'),
       (4, 1, 3, '2020-10-13'),
       (5, 3, 2, '2020-10-13');

INSERT INTO passing_number
VALUES (1, 2, 4, '2020-10-12'),
       (2, 3, 1, '2020-10-12'),
       (3, 1, 0, '2020-10-13'),
       (4, 3, 2, '2020-10-13');

INSERT INTO user
VALUES (1, 'tm'),
       (2, 'fh'),
       (3, 'wangchao');
# Write your MySQL query statement below
SELECT u.name                                                                                            AS `u_n`,
       p.date,
       SUM(p.number)
           OVER (PARTITION BY p.user_id ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS `ps_num`
FROM passing_number p
         INNER JOIN user u on p.user_id = u.id
ORDER BY p.date, u.name;