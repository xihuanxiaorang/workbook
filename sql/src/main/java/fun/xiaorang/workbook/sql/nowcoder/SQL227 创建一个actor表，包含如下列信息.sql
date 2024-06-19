-- SQL Schema

# Write your MySQL query statement below
CREATE TABLE IF NOT EXISTS `actor`
(
    actor_id    SMALLINT(5)              NOT NULL PRIMARY KEY COMMENT '主键id',
    first_name  VARCHAR(45)              NOT NULL COMMENT '名字',
    last_name   VARCHAR(45)              NOT NULL COMMENT '姓氏',
    last_update DATE DEFAULT (CURDATE()) NOT NULL COMMENT '最后更新时间，默认是系统的当前时间'
);