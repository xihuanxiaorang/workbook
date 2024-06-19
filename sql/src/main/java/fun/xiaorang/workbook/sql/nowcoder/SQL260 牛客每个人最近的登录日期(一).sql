-- SQL Schema
drop table if exists login;
drop table if exists user;
drop table if exists client;
CREATE TABLE login
(
    id        int(4) NOT NULL,
    user_id   int(4) NOT NULL,
    client_id int(4) NOT NULL,
    date      date   NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE user
(
    id   int(4)      NOT NULL,
    name varchar(32) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE client
(
    id   int(4)      NOT NULL,
    name varchar(32) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO login
VALUES (1, 2, 1, '2020-10-12'),
       (2, 3, 2, '2020-10-12'),
       (3, 2, 2, '2020-10-13'),
       (4, 3, 2, '2020-10-13');

INSERT INTO user
VALUES (1, 'tm'),
       (2, 'fh'),
       (3, 'wangchao');

INSERT INTO client
VALUES (1, 'pc'),
       (2, 'ios'),
       (3, 'anroid'),
       (4, 'h5');

# Write your MySQL query statement below
SELECT user_id, MAX(date) AS `id`
FROM login
GROUP BY user_id
ORDER BY user_id;