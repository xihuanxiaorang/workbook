-- SQL Schema
DROP TABLE IF EXISTS tb_get_car_record,tb_get_car_order;
CREATE TABLE tb_get_car_record
(
    id         INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    uid        INT         NOT NULL COMMENT '用户ID',
    city       VARCHAR(10) NOT NULL COMMENT '城市',
    event_time datetime COMMENT '打车时间',
    end_time   datetime COMMENT '打车结束时间',
    order_id   INT COMMENT '订单号'
) CHARACTER SET utf8
  COLLATE utf8_bin;

CREATE TABLE tb_get_car_order
(
    id          INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    order_id    INT NOT NULL COMMENT '订单号',
    uid         INT NOT NULL COMMENT '用户ID',
    driver_id   INT NOT NULL COMMENT '司机ID',
    order_time  datetime COMMENT '接单时间',
    start_time  datetime COMMENT '开始计费的上车时间',
    finish_time datetime COMMENT '订单结束时间',
    mileage     FLOAT COMMENT '行驶里程数',
    fare        FLOAT COMMENT '费用',
    grade       TINYINT COMMENT '评分'
) CHARACTER SET utf8
  COLLATE utf8_bin;

INSERT INTO tb_get_car_record(uid, city, event_time, end_time, order_id)
VALUES (107, '北京', '2021-09-20 11:00:00', '2021-09-20 11:00:30', 9017),
       (108, '北京', '2021-09-20 21:00:00', '2021-09-20 21:00:40', 9008),
       (108, '北京', '2021-09-20 18:59:30', '2021-09-20 19:01:00', 9018),
       (102, '北京', '2021-09-21 08:59:00', '2021-09-21 09:01:00', 9002),
       (106, '北京', '2021-09-21 17:58:00', '2021-09-21 18:01:00', 9006),
       (103, '北京', '2021-09-22 07:58:00', '2021-09-22 08:01:00', 9003),
       (104, '北京', '2021-09-23 07:59:00', '2021-09-23 08:01:00', 9004),
       (103, '北京', '2021-09-24 19:59:20', '2021-09-24 20:01:00', 9019),
       (101, '北京', '2021-09-24 08:28:10', '2021-09-24 08:30:00', 9011);

INSERT INTO tb_get_car_order(order_id, uid, driver_id, order_time, start_time, finish_time, mileage, fare, grade)
VALUES (9017, 107, 213, '2021-09-20 11:00:30', '2021-09-20 11:02:10', '2021-09-20 11:31:00', 11, 38, 5),
       (9008, 108, 204, '2021-09-20 21:00:40', '2021-09-20 21:03:00', '2021-09-20 21:31:00', 13.2, 38, 4),
       (9018, 108, 214, '2021-09-20 19:01:00', '2021-09-20 19:04:50', '2021-09-20 19:21:00', 14, 38, 5),
       (9002, 102, 202, '2021-09-21 09:01:00', '2021-09-21 09:06:00', '2021-09-21 09:31:00', 10.0, 41.5, 5),
       (9006, 106, 203, '2021-09-21 18:01:00', '2021-09-21 18:09:00', '2021-09-21 18:31:00', 8.0, 25.5, 4),
       (9007, 107, 203, '2021-09-22 11:01:00', '2021-09-22 11:07:00', '2021-09-22 11:31:00', 9.9, 30, 5),
       (9003, 103, 202, '2021-09-22 08:01:00', '2021-09-22 08:15:00', '2021-09-22 08:31:00', 11.0, 41.5, 4),
       (9004, 104, 202, '2021-09-23 08:01:00', '2021-09-23 08:13:00', '2021-09-23 08:31:00', 7.5, 22, 4),
       (9005, 105, 202, '2021-09-23 10:01:00', '2021-09-23 10:13:00', '2021-09-23 10:31:00', 9, 29, 5),
       (9019, 103, 202, '2021-09-24 20:01:00', '2021-09-24 20:11:00', '2021-09-24 20:51:00', 10, 39, 4),
       (9011, 101, 211, '2021-09-24 08:30:00', '2021-09-24 08:31:00', '2021-09-24 08:54:00', 10, 35, 5);
# Write your MySQL query statement below
SELECT CASE
           WHEN TIME(tgcr.event_time) >= '07:00:00' AND TIME(tgcr.event_time) < '09:00:00' THEN '早高峰'
           WHEN TIME(tgcr.event_time) >= '09:00:00' AND TIME(tgcr.event_time) < '17:00:00' THEN '工作时间'
           WHEN TIME(tgcr.event_time) >= '17:00:00' AND TIME(tgcr.event_time) < '20:00:00' THEN '晚高峰'
           ELSE '休息时间' END                                                     AS `period`,
       COUNT(*)                                                                    AS `get_car_num`,
       ROUND(AVG(TIMESTAMPDIFF(SECOND, tgcr.event_time, tgco.order_time) / 60), 1) AS `avg_wait_time`,
       ROUND(AVG(TIMESTAMPDIFF(SECOND, tgco.order_time, tgco.start_time) / 60), 1) AS `avg_dispatch_time`
FROM tb_get_car_record tgcr
         INNER JOIN tb_get_car_order tgco USING (order_id)
WHERE DAYOFWEEK(tgcr.event_time) BETWEEN 2 AND 6
GROUP BY period
ORDER BY get_car_num;