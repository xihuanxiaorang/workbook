-- SQL Schema
drop table if exists actor;
CREATE TABLE actor
(
    actor_id    smallint(5) NOT NULL PRIMARY KEY,
    first_name  varchar(45) NOT NULL,
    last_name   varchar(45) NOT NULL,
    last_update DATETIME    NOT NULL
);

# Write your MySQL query statement below
INSERT INTO actor(actor_id, first_name, last_name, last_update)
VALUES (1, 'PENELOPE', 'GUINESS', '2006-02-15 12:34:33'),
       (2, 'NICK', 'WAHLBERG', '2006-02-15 12:34:33');