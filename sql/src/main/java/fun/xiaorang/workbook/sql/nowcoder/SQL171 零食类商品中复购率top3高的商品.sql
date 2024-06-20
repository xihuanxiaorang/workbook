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
VALUES (8001, 901, '零食', 60, 1000, '2020-01-01 10:00:00'),
       (8002, 901, '零食', 140, 500, '2020-01-01 10:00:00'),
       (8003, 901, '零食', 160, 500, '2020-01-01 10:00:00');

INSERT INTO tb_order_overall(order_id, uid, event_time, total_amount, total_cnt, `status`)
VALUES (301001, 101, '2021-09-30 10:00:00', 140, 1, 1),
       (301002, 102, '2021-10-01 11:00:00', 235, 2, 1),
       (301011, 102, '2021-10-31 11:00:00', 250, 2, 1),
       (301003, 101, '2021-11-02 10:00:00', 300, 2, 1),
       (301013, 105, '2021-11-02 10:00:00', 300, 2, 1),
       (301005, 104, '2021-11-03 10:00:00', 170, 1, 1);

INSERT INTO tb_order_detail(order_id, product_id, price, cnt)
VALUES (301001, 8002, 150, 1),
       (301011, 8003, 200, 1),
       (301011, 8001, 80, 1),
       (301002, 8001, 85, 1),
       (301002, 8003, 180, 1),
       (301003, 8002, 140, 1),
       (301003, 8003, 180, 1),
       (301013, 8002, 140, 2),
       (301005, 8003, 180, 1);
# Write your MySQL query statement below
WITH tmp AS (SELECT tpi.product_id, too.uid
             FROM tb_product_info tpi
                      INNER JOIN tb_order_detail tod on tpi.product_id = tod.product_id
                      INNER JOIN tb_order_overall too on tod.order_id = too.order_id
             WHERE tpi.tag = '零食'
               AND DATEDIFF((SELECT MAX(event_time) FROM tb_order_overall), too.event_time) <= 89
               AND too.status = 1)
SELECT product_id, ROUND(SUM(IF(cnt >= 2, 1, 0)) / COUNT(DISTINCT uid), 3) AS `repurchase_rate`
FROM (SELECT product_id, uid, COUNT(*) AS `cnt`
      FROM tmp
      GROUP BY product_id, uid) t
GROUP BY product_id
ORDER BY repurchase_rate DESC, product_id
LIMIT 3;