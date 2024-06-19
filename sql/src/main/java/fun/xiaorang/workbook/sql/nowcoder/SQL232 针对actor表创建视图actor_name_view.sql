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
CREATE VIEW actor_name_view AS
SELECT first_name AS `first_name_v`, last_name AS `last_name_v`
FROM actor;
