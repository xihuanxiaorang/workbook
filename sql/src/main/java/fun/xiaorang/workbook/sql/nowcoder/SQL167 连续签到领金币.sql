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
VALUES (101, 0, '2021-07-07 10:00:00', '2021-07-07 10:00:09', 1),
       (101, 0, '2021-07-08 10:00:00', '2021-07-08 10:00:09', 1),
       (101, 0, '2021-07-09 10:00:00', '2021-07-09 10:00:42', 1),
       (101, 0, '2021-07-10 10:00:00', '2021-07-10 10:00:09', 1),
       (101, 0, '2021-07-11 23:59:55', '2021-07-11 23:59:59', 1),
       (101, 0, '2021-07-12 10:00:28', '2021-07-12 10:00:50', 1),
       (101, 0, '2021-07-13 10:00:28', '2021-07-13 10:00:50', 1),
       (102, 0, '2021-10-01 10:00:28', '2021-10-01 10:00:50', 1),
       (102, 0, '2021-10-02 10:00:01', '2021-10-02 10:01:50', 1),
       (102, 0, '2021-10-03 11:00:55', '2021-10-03 11:00:59', 1),
       (102, 0, '2021-10-04 11:00:45', '2021-10-04 11:00:55', 0),
       (102, 0, '2021-10-05 11:00:53', '2021-10-05 11:00:59', 1),
       (102, 0, '2021-10-06 11:00:45', '2021-10-06 11:00:55', 1);
# Write your MySQL query statement below
WITH t1 AS (SELECT DISTINCT uid,                                                             -- 为了防止一天有多次签到活动，使用 DISTINCT 去重
                            DATE(in_time) AS                                            `dt`,
                            DENSE_RANK() OVER (PARTITION BY uid ORDER BY DATE(in_time)) `rn` -- 按照用户分组，日期升序进行编号
            FROM tb_user_log
            WHERE DATE(in_time) BETWEEN '2021-07-07' AND '2021-10-31'
              AND artical_id = 0
              AND sign_in = 1),
     t2 AS (SELECT uid,
                   dt,
                   rn,
                   -- 如果用户是连续签到的话，则每天日期-编号所得到的日期（差值）应该是相等的，如果不是连续（即中间有断签的情况）的话，则差值不相等
                   DATE_SUB(dt, INTERVAL rn DAY)                                                   AS `dt_tmp`,
                   -- 按照用户和相减所得到的日期进行分组，日期升序进行编号，如果用户中间有断签，就不会分到同一组，也就会重新编号
                   ROW_NUMBER() OVER (PARTITION BY uid, DATE_SUB(dt, INTERVAL rn DAY) ORDER BY dt) AS `连续签到的第几天`,
                   -- 计算用户当天签到时应该获得的金币数
                   CASE ROW_NUMBER() OVER (PARTITION BY uid, DATE_SUB(dt, INTERVAL rn DAY) ORDER BY dt) % 7
                       WHEN 3 THEN 3
                       WHEN 0 THEN 7
                       ELSE 1 END                                                                  AS `day_coin` -- 用户当天签到时应该获得的金币数
            FROM t1)
SELECT uid, DATE_FORMAT(dt, '%Y%m') AS `month`, SUM(day_coin) AS `coin`
FROM t2
GROUP BY 1, 2
ORDER BY 2, 1;

