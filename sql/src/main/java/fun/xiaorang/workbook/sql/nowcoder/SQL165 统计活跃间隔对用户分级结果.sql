-- SQL Schema
DROP TABLE IF EXISTS tb_user_log;
CREATE TABLE tb_user_log
(
    id         INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    uid        INT NOT NULL COMMENT '用户ID',
    artical_id INT NOT NULL COMMENT '视频ID',
    in_time    datetime COMMENT '进入时间',
    out_time   datetime COMMENT '离开时间',
    sign_in    TINYINT DEFAULT 0 COMMENT '是否签到'
) CHARACTER SET utf8
  COLLATE utf8_bin;

INSERT INTO tb_user_log(uid, artical_id, in_time, out_time, sign_in)
VALUES (109, 9001, '2021-08-31 10:00:00', '2021-08-31 10:00:09', 0),
       (109, 9002, '2021-11-04 11:00:55', '2021-11-04 11:00:59', 0),
       (108, 9001, '2021-09-01 10:00:01', '2021-09-01 10:01:50', 0),
       (108, 9001, '2021-11-03 10:00:01', '2021-11-03 10:01:50', 0),
       (104, 9001, '2021-11-02 10:00:28', '2021-11-02 10:00:50', 0),
       (104, 9003, '2021-09-03 11:00:45', '2021-09-03 11:00:55', 0),
       (105, 9003, '2021-11-03 11:00:53', '2021-11-03 11:00:59', 0),
       (102, 9001, '2021-10-30 10:00:00', '2021-10-30 10:00:09', 0),
       (103, 9001, '2021-10-21 10:00:00', '2021-10-21 10:00:09', 0),
       (101, 0, '2021-10-01 10:00:00', '2021-10-01 10:00:42', 1);
# Write your MySQL query statement below
SELECT user_grade, ROUND(COUNT(uid) / (SELECT COUNT(DISTINCT uid) FROM tb_user_log), 2) AS `ratio`
FROM (SELECT uid,
             CASE
                 WHEN 最晚活跃距今天的天数 >= 30 THEN '流失用户'
                 WHEN 最晚活跃距今天的天数 >= 7 THEN '沉睡用户'
                 WHEN 最早活跃距今天的天数 < 7 THEN '新晋用户'
                 ELSE '忠实用户' END AS `user_grade`
      FROM (SELECT uid,
                   DATEDIFF((SELECT MAX(in_time) FROM tb_user_log), MIN(in_time))  AS `最早活跃距今天的天数`,
                   DATEDIFF((SELECT MAX(in_time) FROM tb_user_log), MAX(out_time)) AS `最晚活跃距今天的天数`
            FROM tb_user_log
            GROUP BY uid) a) b
GROUP BY user_grade
ORDER BY ratio DESC;
