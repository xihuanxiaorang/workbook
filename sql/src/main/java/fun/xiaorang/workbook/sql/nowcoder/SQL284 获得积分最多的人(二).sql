-- SQL Schema
drop table if exists user;
drop table if exists grade_info;

CREATE TABLE user
(
    id   int(4)      NOT NULL,
    name varchar(32) NOT NULL
);

CREATE TABLE grade_info
(
    user_id   int(4)      NOT NULL,
    grade_num int(4)      NOT NULL,
    type      varchar(32) NOT NULL
);

INSERT INTO user
VALUES (1, 'tm'),
       (2, 'wwy'),
       (3, 'zk'),
       (4, 'qq'),
       (5, 'lm');

INSERT INTO grade_info
VALUES (1, 3, 'add'),
       (2, 3, 'add'),
       (1, 1, 'add'),
       (3, 3, 'add'),
       (4, 3, 'add'),
       (5, 3, 'add'),
       (3, 1, 'add');
# Write your MySQL query statement below
SELECT id, name, grade_num
FROM (SELECT u.id, u.name, a.grade_num, DENSE_RANK() OVER (ORDER BY a.grade_num DESC) AS `rn`
      FROM (SELECT user_id, SUM(grade_num) AS `grade_num`
            FROM grade_info
            GROUP BY user_id) a
               INNER JOIN user u ON u.id = a.user_id) b
WHERE rn = 1;