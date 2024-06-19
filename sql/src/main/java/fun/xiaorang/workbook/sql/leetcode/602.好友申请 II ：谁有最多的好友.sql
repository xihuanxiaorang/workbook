-- SQL Schema
Drop table If Exists RequestAccepted;
Create table If Not Exists RequestAccepted
(
    requester_id int  not null,
    accepter_id  int  null,
    accept_date  date null
);
Truncate table RequestAccepted;
insert into RequestAccepted (requester_id, accepter_id, accept_date)
values ('1', '2', '2016/06/03');
insert into RequestAccepted (requester_id, accepter_id, accept_date)
values ('1', '3', '2016/06/08');
insert into RequestAccepted (requester_id, accepter_id, accept_date)
values ('2', '3', '2016/06/08');
insert into RequestAccepted (requester_id, accepter_id, accept_date)
values ('3', '4', '2016/06/09');
# Write your MySQL query statement below
SELECT id, COUNT(*) AS `num`
FROM (SELECT requester_id AS `id`
      FROM requestaccepted
      UNION ALL
      SELECT accepter_id AS `id`
      FROM requestaccepted) t
GROUP BY id
ORDER BY COUNT(*) DESC
LIMIT 1;