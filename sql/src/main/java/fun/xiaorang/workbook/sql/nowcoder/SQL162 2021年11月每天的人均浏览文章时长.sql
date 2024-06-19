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
VALUES (101, 9001, '2021-11-01 10:00:00', '2021-11-01 10:00:31', 0),
       (102, 9001, '2021-11-01 10:00:00', '2021-11-01 10:00:24', 0),
       (102, 9002, '2021-11-01 11:00:00', '2021-11-01 11:00:11', 0),
       (101, 9001, '2021-11-02 10:00:00', '2021-11-02 10:00:50', 0),
       (102, 9002, '2021-11-02 11:00:01', '2021-11-02 11:00:24', 0);
# Write your MySQL query statement below
SELECT DATE_FORMAT(in_time, '%Y-%m-%d')                                              AS `dt`,
       ROUND(SUM(TIMESTAMPDIFF(SECOND, in_time, out_time)) / COUNT(DISTINCT uid), 1) AS `avg_viiew_len_sec`
FROM tb_user_log
WHERE YEAR(in_time) = 2021
  AND MONTH(in_time) = 11
  AND artical_id <> 0
GROUP BY dt
ORDER BY avg_viiew_len_sec;