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
VALUES (301001, 101, '2021-10-01 10:00:00', 30000, 3, 1),
       (301002, 102, '2021-10-01 11:00:00', 23900, 2, 1),
       (301003, 103, '2021-10-02 10:00:00', 31000, 2, 1);

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
VALUES (8001, 901, '家电', 6000, 100, '2020-01-01 10:00:00'),
       (8002, 902, '家电', 12000, 50, '2020-01-01 10:00:00'),
       (8003, 901, '3C数码', 12000, 50, '2020-01-01 10:00:00');

INSERT INTO tb_order_detail(order_id, product_id, price, cnt)
VALUES (301001, 8001, 8500, 2),
       (301001, 8002, 15000, 1),
       (301002, 8001, 8500, 1),
       (301002, 8002, 16000, 1),
       (301003, 8002, 14000, 1),
       (301003, 8003, 18000, 1);
# Write your MySQL query statement below
WITH tmp AS (SELECT tpi.product_id, tpi.in_price, tod.cnt, tod.price
             FROM tb_product_info tpi
                      INNER JOIN tb_order_detail tod ON tpi.product_id = tod.product_id
                      INNER JOIN tb_order_overall too ON tod.order_id = too.order_id
             WHERE DATE_FORMAT(too.event_time, '%Y-%m') >= '2021-10'
               AND tpi.shop_id = 901)
SELECT '店铺汇总'                                                                AS `product_id`,
       CONCAT(ROUND((1 - SUM(in_price * cnt) / SUM(price * cnt)) * 100, 1), '%') AS `profit_rate`
FROM tmp
UNION ALL
(SELECT product_id, CONCAT(ROUND((1 - SUM(in_price * cnt) / SUM(price * cnt)) * 100, 1), '%') AS `profit_rate`
 FROM tmp
 GROUP BY product_id
 HAVING ROUND((1 - SUM(in_price * cnt) / SUM(price * cnt)) * 100, 1) > 24.9
 ORDER BY product_id);

SELECT IFNULL(tpi.product_id, '店铺汇总')                                                        AS `product_id`,
       CONCAT(ROUND((1 - SUM(tpi.in_price * tod.cnt) / SUM(tod.price * tod.cnt)) * 100, 1), '%') AS `profit_rate`
FROM tb_product_info tpi
         INNER JOIN tb_order_detail tod ON tpi.product_id = tod.product_id
         INNER JOIN tb_order_overall too ON tod.order_id = too.order_id
WHERE DATE_FORMAT(too.event_time, '%Y-%m') >= '2021-10'
  AND tpi.shop_id = 901
GROUP BY tpi.product_id
WITH ROLLUP
HAVING ROUND((1 - SUM(tpi.in_price * tod.cnt) / SUM(tod.price * tod.cnt)) * 100, 1) > 24.9
    OR tpi.product_id IS NULL
ORDER BY tpi.product_id;