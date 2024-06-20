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
       (8003, 901, '零食', 160, 500, '2020-01-01 10:00:00');

INSERT INTO tb_order_overall(order_id, uid, event_time, total_amount, total_cnt, `status`)
VALUES (301004, 102, '2021-09-30 10:00:00', 170, 1, 1),
       (301005, 104, '2021-10-01 10:00:00', 160, 1, 1),
       (301003, 101, '2021-10-02 10:00:00', 300, 2, 1),
       (301002, 102, '2021-10-03 11:00:00', 235, 2, 1);

INSERT INTO tb_order_detail(order_id, product_id, price, cnt)
VALUES (301004, 8002, 180, 1),
       (301005, 8002, 170, 1),
       (301002, 8001, 85, 1),
       (301002, 8003, 180, 1),
       (301003, 8002, 150, 1),
       (301003, 8003, 180, 1);
# Write your MySQL query statement below
SELECT t1.dt,
       ROUND(COUNT(DISTINCT t2.product_id) /
             (SELECT COUNT(product_id) FROM tb_product_info WHERE shop_id = '901'), 3)     AS `sale_rate`,
       1 - ROUND(COUNT(DISTINCT t2.product_id) /
                 (SELECT COUNT(product_id) FROM tb_product_info WHERE shop_id = '901'), 3) AS `unsale_rate`
FROM (SELECT DISTINCT DATE(event_time) AS `dt`
      FROM tb_order_overall
      WHERE DATE(event_time) BETWEEN '2021-10-01' AND '2021-10-03'
        AND status = 1) t1
         LEFT JOIN (SELECT DATE(too.event_time) AS `dt`,
                           tod.product_id
                    FROM tb_order_overall too
                             INNER JOIN tb_order_detail tod on too.order_id = tod.order_id
                             INNER JOIN tb_product_info tpi on tod.product_id = tpi.product_id
                    WHERE tpi.shop_id = '901'
                      AND too.status = 1) t2
                   ON TIMESTAMPDIFF(DAY, t2.dt, t1.dt) BETWEEN 0 AND 6
GROUP BY t1.dt
ORDER BY t1.dt;