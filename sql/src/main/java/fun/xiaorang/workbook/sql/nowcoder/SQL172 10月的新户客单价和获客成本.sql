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

DROP TABLE IF EXISTS tb_product_info;
CREATE TABLE tb_product_info
(
    id           INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    product_id   INT     NOT NULL COMMENT '商品ID',
    shop_id      INT     NOT NULL COMMENT '店铺ID',
    tag          VARCHAR(12) COMMENT '商品类别标签',
    in_price     DECIMAL NOT NULL COMMENT '进货价格',
    quantity     INT     NOT NULL COMMENT '进货数量',
    release_time datetime COMMENT '上架时间'
) CHARACTER SET utf8
  COLLATE utf8_bin;

DROP TABLE IF EXISTS tb_order_detail;
CREATE TABLE tb_order_detail
(
    id         INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    order_id   INT     NOT NULL COMMENT '订单号',
    product_id INT     NOT NULL COMMENT '商品ID',
    price      DECIMAL NOT NULL COMMENT '商品单价',
    cnt        INT     NOT NULL COMMENT '下单数量'
) CHARACTER SET utf8
  COLLATE utf8_bin;

INSERT INTO tb_product_info(product_id, shop_id, tag, in_price, quantity, release_time)
VALUES (8001, 901, '日用', 60, 1000, '2020-01-01 10:00:00'),
       (8002, 901, '零食', 140, 500, '2020-01-01 10:00:00'),
       (8003, 901, '零食', 160, 500, '2020-01-01 10:00:00'),
       (8004, 902, '零食', 130, 500, '2020-01-01 10:00:00');

INSERT INTO tb_order_overall(order_id, uid, event_time, total_amount, total_cnt, `status`)
VALUES (301002, 102, '2021-10-01 11:00:00', 235, 2, 1),
       (301003, 101, '2021-10-02 10:00:00', 300, 2, 1),
       (301005, 104, '2021-10-03 10:00:00', 160, 1, 1);

INSERT INTO tb_order_detail(order_id, product_id, price, cnt)
VALUES (301002, 8001, 85, 1),
       (301002, 8003, 180, 1),
       (301003, 8004, 140, 1),
       (301003, 8003, 180, 1),
       (301005, 8003, 180, 1);
# Write your MySQL query statement below
SELECT ROUND(SUM(total_amount) / COUNT(too.order_id), 1)                  AS `avg_amount`,
       ROUND(SUM(prodcut_amount - total_amount) / COUNT(too.order_id), 1) AS `avg_cost`
FROM (SELECT order_id,
             total_amount
      FROM tb_order_overall
      WHERE YEAR(event_time) = 2021
        AND MONTH(event_time) = 10
        AND (uid, event_time)
          IN (SELECT uid, MIN(event_time) -- 注意：何为新用户？用户在第一次下单时才算做新用户，而第一次下单的时间不一定在 2021-10 之间
              FROM tb_order_overall
              GROUP BY uid)) too
         INNER JOIN (SELECT order_id, SUM(price * cnt) AS `prodcut_amount`
                     FROM tb_order_detail
                     GROUP BY order_id) tod ON too.order_id = tod.order_id;