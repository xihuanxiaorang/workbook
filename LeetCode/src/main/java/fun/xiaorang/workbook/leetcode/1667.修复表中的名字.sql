-- SQL Schema;
DROP TABLE IF EXISTS Users;
Create table If Not Exists Users
(
    user_id int,
    name    varchar(40)
);
Truncate table Users;
insert into Users (user_id, name)
values ('1', 'aLice');
insert into Users (user_id, name)
values ('2', 'bOB');
# Write your MySQL query statement below
SELECT user_id, CONCAT(UPPER(SUBSTR(name, 1, 1)), LOWER(SUBSTR(name, 2))) AS `name`
FROM users
ORDER BY user_id;