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
VALUES (101, 9001, '2021-10-31 10:00:00', '2021-10-31 10:00:09', 0),
       (102, 9001, '2021-10-31 10:00:00', '2021-10-31 10:00:09', 0),
       (101, 0, '2021-11-01 10:00:00', '2021-11-01 10:00:42', 1),
       (102, 9001, '2021-11-01 10:00:00', '2021-11-01 10:00:09', 0),
       (108, 9001, '2021-11-01 10:00:01', '2021-11-01 10:01:50', 0),
       (108, 9001, '2021-11-02 10:00:01', '2021-11-02 10:01:50', 0),
       (104, 9001, '2021-11-02 10:00:28', '2021-11-02 10:00:50', 0),
       (106, 9001, '2021-11-02 10:00:28', '2021-11-02 10:00:50', 0),
       (108, 9001, '2021-11-03 10:00:01', '2021-11-03 10:01:50', 0),
       (109, 9002, '2021-11-03 11:00:55', '2021-11-03 11:00:59', 0),
       (104, 9003, '2021-11-03 11:00:45', '2021-11-03 11:00:55', 0),
       (105, 9003, '2021-11-03 11:00:53', '2021-11-03 11:00:59', 0),
       (106, 9003, '2021-11-03 11:00:45', '2021-11-03 11:00:55', 0);
# Write your MySQL query statement below
SELECT dt, COUNT(uid) AS `dau`, ROUND(AVG(IF(dt = first_time, 1, 0)), 2) AS `uv_new_ratio`
FROM (SELECT uid, dt, MIN(dt) OVER (PARTITION BY uid ORDER BY dt) AS `first_time`
      FROM (SELECT uid, DATE_FORMAT(in_time, '%Y-%m-%d') AS `dt`
            FROM tb_user_log
            UNION
            SELECT uid, DATE_FORMAT(out_time, '%Y-%m-%d') AS `dt`
            FROM tb_user_log) a) b
GROUP BY dt
ORDER BY dt;