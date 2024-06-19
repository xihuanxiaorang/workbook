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
VALUES (101, 0, '2021-11-01 10:00:00', '2021-11-01 10:00:42', 1),
       (102, 9001, '2021-11-01 10:00:00', '2021-11-01 10:00:09', 0),
       (103, 9001, '2021-11-01 10:00:01', '2021-11-01 10:01:50', 0),
       (101, 9002, '2021-11-02 10:00:09', '2021-11-02 10:00:28', 0),
       (103, 9002, '2021-11-02 10:00:51', '2021-11-02 10:00:59', 0),
       (104, 9001, '2021-11-02 10:00:28', '2021-11-02 10:00:50', 0),
       (101, 9003, '2021-11-03 11:00:55', '2021-11-03 11:01:24', 0),
       (104, 9003, '2021-11-03 11:00:45', '2021-11-03 11:00:55', 0),
       (105, 9003, '2021-11-03 11:00:53', '2021-11-03 11:00:59', 0),
       (101, 9002, '2021-11-04 11:00:55', '2021-11-04 11:00:59', 0);
# Write your MySQL query statement below
SELECT DATE_FORMAT(in_time, '%Y-%m-%d')    AS `dt`,
       SUM(IF(first_time = in_time, 1, 0)) AS `new_user_cnt`,
       SUM(IF((DATEDIFF(next_time, in_time) = 1 OR DATEDIFF(out_time, in_time) = 1) AND first_time = in_time, 1,
              0))                          AS `new_user_next_day_login_cnt`
FROM (SELECT *,
             MIN(in_time) OVER (PARTITION BY uid ORDER BY in_time)     AS `first_time`,
             LEAD(in_time, 1) OVER (PARTITION BY uid ORDER BY in_time) AS `next_time`
      FROM tb_user_log) t
WHERE YEAR(in_time) = 2021
  AND MONTH(in_time) = 11
GROUP BY dt
HAVING new_user_cnt > 0
ORDER BY dt;

SELECT DATE_FORMAT(in_time, '%Y-%m-%d')                           AS `dt`,
       ROUND(SUM(IF((DATEDIFF(next_time, in_time) = 1 OR DATEDIFF(out_time, in_time) = 1) AND first_time = in_time, 1,
                    0)) / SUM(IF(first_time = in_time, 1, 0)), 2) AS `uv_left_rate`
FROM (SELECT *,
             MIN(in_time) OVER (PARTITION BY uid ORDER BY in_time)     AS `first_time`,
             LEAD(in_time, 1) OVER (PARTITION BY uid ORDER BY in_time) AS `next_time`
      FROM tb_user_log) t
WHERE YEAR(in_time) = 2021
  AND MONTH(in_time) = 11
GROUP BY dt
HAVING SUM(IF(first_time = in_time, 1, 0)) > 0
ORDER BY dt;