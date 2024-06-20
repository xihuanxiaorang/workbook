-- SQL Schema
DROP TABLE IF EXISTS tb_order_overall;
CREATE TABLE tb_order_overall
(
    id           INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    order_id     INT     NOT NULL COMMENT '订单号',
    uid          INT     NOT NULL COMMENT '用户ID',
    event_time   datetime COMMENT '下单时间',
    total_amount DECIMAL NOT NULL COMMENT '订单总金额',
    total_cnt    INT     NOT NULL COMMENT '订单商品总件数',
    `status`     TINYINT NOT NULL COMMENT '订单状态'
) CHARACTER SET utf8
  COLLATE utf8_bin;

INSERT INTO tb_order_overall(order_id, uid, event_time, total_amount, total_cnt, `status`)
VALUES (301001, 101, '2021-10-01 10:00:00', 15900, 2, 1),
       (301002, 101, '2021-10-01 11:00:00', 15900, 2, 1),
       (301003, 102, '2021-10-02 10:00:00', 34500, 8, 0),
       (301004, 103, '2021-10-12 10:00:00', 43500, 9, 1),
       (301005, 105, '2021-11-01 10:00:00', 31900, 7, 1),
       (301006, 102, '2021-11-02 10:00:00', 24500, 6, 1),
       (391007, 102, '2021-11-03 10:00:00', -24500, 6, 2),
       (301008, 104, '2021-11-04 10:00:00', 55500, 12, 0);

# Write your MySQL query statement below
SELECT DATE_FORMAT(event_time, '%Y-%m') AS `month`, SUM(IF(status != 2, total_amount, 0)) AS `GMV`
FROM tb_order_overall
WHERE YEAR(event_time) = 2021
GROUP BY month
HAVING GMV > 100000
ORDER BY GMV;