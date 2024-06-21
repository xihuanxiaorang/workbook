-- SQL Schema
drop table if exists course_tb;
CREATE TABLE course_tb
(
    course_id       int(10)  NOT NULL,
    course_name     char(10) NOT NULL,
    course_datetime char(30) NOT NULL
);

INSERT INTO course_tb
VALUES (1, 'Python', '2021-12-1 19:00-21:00');
INSERT INTO course_tb
VALUES (2, 'SQL', '2021-12-2 19:00-21:00');
INSERT INTO course_tb
VALUES (3, 'R', '2021-12-3 19:00-21:00');

drop table if exists behavior_tb;
CREATE TABLE behavior_tb
(
    user_id   int(10) NOT NULL,
    if_vw     int(10) NOT NULL,
    if_fav    int(10) NOT NULL,
    if_sign   int(10) NOT NULL,
    course_id int(10) NOT NULL
);

INSERT INTO behavior_tb
VALUES (100, 1, 1, 1, 1);
INSERT INTO behavior_tb
VALUES (100, 1, 1, 1, 2);
INSERT INTO behavior_tb
VALUES (100, 1, 1, 1, 3);
INSERT INTO behavior_tb
VALUES (101, 1, 1, 1, 1);
INSERT INTO behavior_tb
VALUES (101, 1, 1, 1, 2);
INSERT INTO behavior_tb
VALUES (101, 1, 0, 0, 3);
INSERT INTO behavior_tb
VALUES (102, 1, 1, 1, 1);
INSERT INTO behavior_tb
VALUES (102, 1, 1, 1, 2);
INSERT INTO behavior_tb
VALUES (102, 1, 1, 1, 3);
INSERT INTO behavior_tb
VALUES (103, 1, 1, 0, 1);
INSERT INTO behavior_tb
VALUES (103, 1, 0, 0, 2);
INSERT INTO behavior_tb
VALUES (103, 1, 0, 0, 3);
INSERT INTO behavior_tb
VALUES (104, 1, 1, 1, 1);
INSERT INTO behavior_tb
VALUES (104, 1, 1, 1, 2);
INSERT INTO behavior_tb
VALUES (104, 1, 1, 0, 3);
INSERT INTO behavior_tb
VALUES (105, 1, 0, 0, 1);
INSERT INTO behavior_tb
VALUES (106, 1, 0, 0, 1);
INSERT INTO behavior_tb
VALUES (107, 1, 0, 0, 1);
INSERT INTO behavior_tb
VALUES (107, 1, 1, 1, 2);
INSERT INTO behavior_tb
VALUES (108, 1, 1, 1, 3);

drop table if exists attend_tb;
CREATE TABLE attend_tb
(
    user_id      int(10)  NOT NULL,
    course_id    int(10)  NOT NULL,
    in_datetime  datetime NOT NULL,
    out_datetime datetime NOT NULL
);
INSERT INTO attend_tb
VALUES (100, 1, '2021-12-1 19:00:00', '2021-12-1 19:28:00');
INSERT INTO attend_tb
VALUES (100, 1, '2021-12-1 19:30:00', '2021-12-1 19:53:00');
INSERT INTO attend_tb
VALUES (101, 1, '2021-12-1 19:00:00', '2021-12-1 20:55:00');
INSERT INTO attend_tb
VALUES (102, 1, '2021-12-1 19:00:00', '2021-12-1 19:05:00');
INSERT INTO attend_tb
VALUES (104, 1, '2021-12-1 19:00:00', '2021-12-1 20:59:00');
INSERT INTO attend_tb
VALUES (101, 2, '2021-12-2 19:05:00', '2021-12-2 20:58:00');
INSERT INTO attend_tb
VALUES (102, 2, '2021-12-2 18:55:00', '2021-12-2 21:00:00');
INSERT INTO attend_tb
VALUES (104, 2, '2021-12-2 18:57:00', '2021-12-2 20:56:00');
INSERT INTO attend_tb
VALUES (107, 2, '2021-12-2 19:10:00', '2021-12-2 19:18:00');
INSERT INTO attend_tb
VALUES (100, 3, '2021-12-3 19:01:00', '2021-12-3 21:00:00');
INSERT INTO attend_tb
VALUES (102, 3, '2021-12-3 18:58:00', '2021-12-3 19:05:00');
INSERT INTO attend_tb
VALUES (108, 3, '2021-12-3 19:01:00', '2021-12-3 19:56:00');
# Write your MySQL query statement below
SELECT course_id, course_name, ROUND((online_num / sign_num) * 100, 2) AS `attend_rate(%)`
FROM (SELECT course_id, SUM(if_sign) AS `sign_num`
      FROM behavior_tb
      GROUP BY course_id) bt
         INNER JOIN (SELECT course_id, COUNT(user_id) AS `online_num`
                     FROM (SELECT user_id, course_id
                           FROM attend_tb
                           GROUP BY user_id, course_id
                           HAVING SUM(TIMESTAMPDIFF(MINUTE, in_datetime, out_datetime)) >= 10) t
                     GROUP BY course_id) at USING (course_id)
         INNER JOIN course_tb USING (course_id)
GROUP BY course_id, course_name
ORDER BY course_id;