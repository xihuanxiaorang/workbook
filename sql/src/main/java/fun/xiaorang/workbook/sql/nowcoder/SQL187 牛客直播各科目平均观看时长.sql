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
SELECT ct.course_name, ROUND(AVG(TIMESTAMPDIFF(MINUTE, at.in_datetime, at.out_datetime)), 2) AS `avg_Len`
FROM attend_tb at
         INNER JOIN course_tb ct USING (course_id)
GROUP BY ct.course_name
ORDER BY avg_Len DESC;