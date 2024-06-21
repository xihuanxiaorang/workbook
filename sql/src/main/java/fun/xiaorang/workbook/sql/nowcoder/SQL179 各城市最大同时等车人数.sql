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
VALUES (108, '北京', '2021-10-20 08:00:00', '2021-10-20 08:00:40', 9008),
       (108, '北京', '2021-10-20 08:00:10', '2021-10-20 08:00:45', 9018),
       (102, '北京', '2021-10-20 08:00:30', '2021-10-20 08:00:50', 9002),
       (106, '北京', '2021-10-20 08:05:41', '2021-10-20 08:06:00', 9006),
       (103, '北京', '2021-10-20 08:05:50', '2021-10-20 08:07:10', 9003),
       (104, '北京', '2021-10-20 08:01:01', '2021-10-20 08:01:20', 9004),
       (103, '北京', '2021-10-20 08:01:15', '2021-10-20 08:01:30', 9019),
       (101, '北京', '2021-10-20 08:28:10', '2021-10-20 08:30:00', 9011);

INSERT INTO tb_get_car_order(order_id, uid, driver_id, order_time, start_time, finish_time, mileage, fare, grade)
VALUES (9008, 108, 204, '2021-10-20 08:00:40', '2021-10-20 08:03:00', '2021-10-20 08:31:00', 13.2, 38, 4),
       (9018, 108, 214, '2021-10-20 08:00:45', '2021-10-20 08:04:50', '2021-10-20 08:21:00', 14, 38, 5),
       (9002, 102, 202, '2021-10-20 08:00:50', '2021-10-20 08:06:00', '2021-10-20 08:31:00', 10.0, 41.5, 5),
       (9006, 106, 203, '2021-10-20 08:06:00', '2021-10-20 08:09:00', '2021-10-20 08:31:00', 8.0, 25.5, 4),
       (9003, 103, 202, '2021-10-20 08:07:10', '2021-10-20 08:15:00', '2021-10-20 08:31:00', 11.0, 41.5, 4),
       (9004, 104, 202, '2021-10-20 08:01:20', '2021-10-20 08:13:00', '2021-10-20 08:31:00', 7.5, 22, 4),
       (9019, 103, 202, '2021-10-20 08:01:30', '2021-10-20 08:11:00', '2021-10-20 08:51:00', 10, 39, 4),
       (9011, 101, 211, '2021-10-20 08:30:00', '2021-10-20 08:31:00', '2021-10-20 08:54:00', 10, 35, 5);
# Write your MySQL query statement below
SELECT city, MAX(max_wait_uv) AS `max_wait_uv`
FROM (SELECT city, MAX(uv_cnt) AS `max_wait_uv`
      FROM (SELECT city,
                   DATE(uv_time)                                                             AS `dt`,
                   SUM(uv) OVER (PARTITION BY city, DATE(uv_time) ORDER BY uv_time, uv DESC) AS `uv_cnt`
            FROM (
                     -- 用户开始打车，记录打车时间为event_time，打车人数+1
                     SELECT city, event_time AS `uv_time`, +1 AS `uv`
                     FROM tb_get_car_record
                     UNION ALL
                     -- 若一直无司机接单、超时或中途用户主动取消打车，则记录打车结束时间，order_id为空
                     SELECT city, end_time AS `uv_time`, -1 AS `uv`
                     FROM tb_get_car_record
                     WHERE order_id IS NULL
                     UNION ALL
                     -- 若乘客上车前，乘客或司机点击取消订单，则上车时间start_time为空，记录订单完成时间-finish_time为取消时间
                     -- 用户正常上车，则记录上车时间start_time
                     SELECT tgcr.city, IFNULL(tgco.start_time, tgco.finish_time) AS `uv_time`, -1 AS `uv`
                     FROM tb_get_car_record tgcr
                              INNER JOIN tb_get_car_order tgco USING (order_id)) a
            WHERE YEAR(uv_time) = 2021
              AND MONTH(uv_time) = 10) b
      GROUP BY city, dt) c
GROUP BY city
ORDER BY max_wait_uv, city;
