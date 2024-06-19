-- SQL Schema
drop table if exists strings;
CREATE TABLE strings
(
    id     int(5)      NOT NULL PRIMARY KEY,
    string varchar(45) NOT NULL
);
insert into strings
values (1, '10,A,B'),
       (2, 'A,B,C,D'),
       (3, 'A,11,B,C,D,E');
# Write your MySQL query statement below
SELECT id, LENGTH(string) - LENGTH(REPLACE(string, ',', '')) AS `cnt`
FROM strings;