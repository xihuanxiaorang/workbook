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
VALUES (101, 9001, '2021-11-01 10:00:00', '2021-11-01 10:00:11', 0),
       (102, 9001, '2021-11-01 10:00:09', '2021-11-01 10:00:38', 0),
       (103, 9001, '2021-11-01 10:00:28', '2021-11-01 10:00:58', 0),
       (104, 9002, '2021-11-01 11:00:45', '2021-11-01 11:01:11', 0),
       (105, 9001, '2021-11-01 10:00:51', '2021-11-01 10:00:59', 0),
       (106, 9002, '2021-11-01 11:00:55', '2021-11-01 11:01:24', 0),
       (107, 9001, '2021-11-01 10:00:01', '2021-11-01 10:01:50', 0);
# Write your MySQL query statement below
SELECT artical_id, MAX(uv_cnt) AS `max_uv`
FROM (SELECT artical_id, SUM(uv) OVER (PARTITION BY artical_id ORDER BY time, uv DESC ) AS `uv_cnt`
      FROM (SELECT artical_id, in_time AS `time`, 1 AS `uv`
            FROM tb_user_log
            WHERE artical_id <> 0
            UNION ALL
            SELECT artical_id, out_time AS `time`, -1 AS `uv`
            FROM tb_user_log
            WHERE artical_id <> 0) a) b
GROUP BY artical_id
ORDER BY max_uv DESC;