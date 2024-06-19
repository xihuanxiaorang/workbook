-- SQL Schema
drop table if exists actor;
CREATE TABLE actor
(
    actor_id    smallint(5) NOT NULL PRIMARY KEY,
    first_name  varchar(45) NOT NULL,
    last_name   varchar(45) NOT NULL,
    last_update datetime    NOT NULL
);

# Write your MySQL query statement below
ALTER TABLE `actor`
    ADD COLUMN `create_date` DATETIME NOT NULL DEFAULT '2020-10-01 00:00:00' AFTER `last_update`;