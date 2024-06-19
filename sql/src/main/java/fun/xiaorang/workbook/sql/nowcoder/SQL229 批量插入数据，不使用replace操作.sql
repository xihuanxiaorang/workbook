-- SQL Schema
drop table if exists actor;
CREATE TABLE actor
(
    actor_id    smallint(5) NOT NULL PRIMARY KEY,
    first_name  varchar(45) NOT NULL,
    last_name   varchar(45) NOT NULL,
    last_update DATETIME    NOT NULL
);
insert into actor
values ('3', 'WD', 'GUINESS', '2006-02-15 12:34:33');
# Write your MySQL query statement below
INSERT IGNORE INTO `actor`
VALUES ('3', 'ED', 'CHASE', '2006-02-15 12:34:33');