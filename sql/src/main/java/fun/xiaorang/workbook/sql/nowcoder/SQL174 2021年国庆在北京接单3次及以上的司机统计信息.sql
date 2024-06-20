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
    mileage     DOUBLE COMMENT '行驶里程数',
    fare        DOUBLE COMMENT '费用',
    grade       TINYINT COMMENT '评分'
) CHARACTER SET utf8
  COLLATE utf8_bin;

INSERT INTO tb_get_car_record(uid, city, event_time, end_time, order_id)
VALUES (101, '北京', '2021-10-01 07:00:00', '2021-10-01 07:02:00', null),
       (102, '北京', '2021-10-01 09:00:30', '2021-10-01 09:01:00', 9001),
       (101, '北京', '2021-10-01 08:28:10', '2021-10-01 08:30:00', 9002),
       (103, '北京', '2021-10-02 07:59:00', '2021-10-02 08:01:00', 9003),
       (104, '北京', '2021-10-03 07:59:20', '2021-10-03 08:01:00', 9004),
       (105, '北京', '2021-10-01 08:00:00', '2021-10-01 08:02:10', 9005),
       (106, '北京', '2021-10-01 17:58:00', '2021-10-01 18:01:00', 9006),
       (107, '北京', '2021-10-02 11:00:00', '2021-10-02 11:01:00', 9007),
       (108, '北京', '2021-10-02 21:00:00', '2021-10-02 21:01:00', 9008);

INSERT INTO tb_get_car_order(order_id, uid, driver_id, order_time, start_time, finish_time, mileage, fare, grade)
VALUES (9002, 101, 201, '2021-10-01 08:30:00', null, '2021-10-01 08:31:00', null, null, null),
       (9001, 102, 202, '2021-10-01 09:01:00', '2021-10-01 09:06:00', '2021-10-01 09:31:00', 10.0, 41.5, 5),
       (9003, 103, 202, '2021-10-02 08:01:00', '2021-10-02 08:15:00', '2021-10-02 08:31:00', 11.0, 41.5, 4),
       (9004, 104, 202, '2021-10-03 08:01:00', '2021-10-03 08:13:00', '2021-10-03 08:31:00', 7.5, 22, 4),
       (9005, 105, 203, '2021-10-01 08:02:10', '2021-10-01 08:18:00', '2021-10-01 08:31:00', 15.0, 44, 5),
       (9006, 106, 203, '2021-10-01 18:01:00', '2021-10-01 18:09:00', '2021-10-01 18:31:00', 8.0, 25, 5),
       (9007, 107, 203, '2021-10-02 11:01:00', '2021-10-02 11:07:00', '2021-10-02 11:31:00', 9.9, 30, 5),
       (9008, 108, 203, '2021-10-02 21:01:00', '2021-10-02 21:10:00', '2021-10-02 21:31:00', 13.2, 38, 4);
# Write your MySQL query statement below
SELECT '北京' AS `city`, ROUND(AVG(order_num), 3) AS `avg_order_num`, ROUND(AVG(total_fare), 3) AS `avg_income`
FROM (SELECT IFNULL(SUM(fare), 0) AS `total_fare`, COUNT(order_id) AS `order_num`
      FROM tb_get_car_record tgcr
               LEFT JOIN tb_get_car_order tgco USING (order_id)
      WHERE DATE(order_time) BETWEEN '2021-10-01' AND '2021-10-07'
        AND tgcr.city = '北京'
      GROUP BY driver_id
      HAVING order_num >= 3) t;