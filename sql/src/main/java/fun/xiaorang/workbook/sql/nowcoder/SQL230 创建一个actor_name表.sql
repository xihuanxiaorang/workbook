-- SQL Schema
drop table if exists actor;
CREATE TABLE actor
(
    actor_id    smallint(5) NOT NULL PRIMARY KEY,
    first_name  varchar(45) NOT NULL,
    last_name   varchar(45) NOT NULL,
    last_update datetime    NOT NULL
);
insert into actor
values ('1', 'PENELOPE', 'GUINESS', '2006-02-15 12:34:33'),
       ('2', 'NICK', 'WAHLBERG', '2006-02-15 12:34:33');

# Write your MySQL query statement below
-- CREATE TABLE IF NOT EXISTS 要创建的表名(列1, 列2) SELECT 字段名 FROM 表名 WHERE 条件
CREATE TABLE IF NOT EXISTS `actor_name`
(
    first_name varchar(45) not null COMMENT '名字',
    last_name  varchar(45) not null COMMENT '姓氏'
)
SELECT first_name, last_name
FROM actor;

-- CREATE TABLE IF NOT EXISTS 要创建的表名(列1, 列2);
-- INSERT INTO 要创建的表名(列1, 列2) SELECT 字段名 FROM 表名 WHERE 条件;
CREATE TABLE IF NOT EXISTS `actor_name`
(
    first_name varchar(45) not null COMMENT '名字',
    last_name  varchar(45) not null COMMENT '姓氏'
);
INSERT INTO `actor_name`
SELECT first_name, last_name
FROM actor;