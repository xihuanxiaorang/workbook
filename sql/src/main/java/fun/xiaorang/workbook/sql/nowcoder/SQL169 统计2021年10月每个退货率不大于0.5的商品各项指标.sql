-- SQL Schema
DROP TABLE IF EXISTS tb_user_event;
CREATE TABLE tb_user_event
(
    id         INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    uid        INT NOT NULL COMMENT '用户ID',
    product_id INT NOT NULL COMMENT '商品ID',
    event_time datetime COMMENT '行为时间',
    if_click   TINYINT COMMENT '是否点击',
    if_cart    TINYINT COMMENT '是否加购物车',
    if_payment TINYINT COMMENT '是否付款',
    if_refund  TINYINT COMMENT '是否退货退款'
) CHARACTER SET utf8
  COLLATE utf8_bin;

INSERT INTO tb_user_event(uid, product_id, event_time, if_click, if_cart, if_payment, if_refund)
VALUES (101, 8001, '2021-10-01 10:00:00', 0, 0, 0, 0),
       (102, 8001, '2021-10-01 10:00:00', 1, 0, 0, 0),
       (103, 8001, '2021-10-01 10:00:00', 1, 1, 0, 0),
       (104, 8001, '2021-10-02 10:00:00', 1, 1, 1, 0),
       (105, 8001, '2021-10-02 10:00:00', 1, 1, 1, 0),
       (101, 8002, '2021-10-03 10:00:00', 1, 1, 1, 0),
       (109, 8001, '2021-10-04 10:00:00', 1, 1, 1, 1);
# Write your MySQL query statement below
SELECT product_id,
       ROUND(SUM(if_click) / COUNT(*), 3)                    AS `ctr`,
       ROUND(IFNULL(SUM(if_cart) / SUM(if_click), 0), 3)     AS `cart_rate`,
       ROUND(IFNULL(SUM(if_payment) / SUM(if_cart), 0), 3)   AS `payment_rate`,
       ROUND(IFNULL(SUM(if_refund) / SUM(if_payment), 0), 3) AS `refund_rate`
FROM tb_user_event
WHERE YEAR(event_time) = 2021
  AND MONTH(event_time) = 10
GROUP BY product_id
HAVING refund_rate <= 0.5
ORDER BY product_id;