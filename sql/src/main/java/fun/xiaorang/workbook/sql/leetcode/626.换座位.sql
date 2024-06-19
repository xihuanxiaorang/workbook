-- SQL Schema
Drop table If Exists Seat;
Create table If Not Exists Seat
(
    id      int,
    student varchar(255)
);
Truncate table Seat;
insert into Seat (id, student)
values ('1', 'Abbot');
insert into Seat (id, student)
values ('2', 'Doris');
insert into Seat (id, student)
values ('3', 'Emerson');
insert into Seat (id, student)
values ('4', 'Green');
insert into Seat (id, student)
values ('5', 'Jeames');
# Write your MySQL query statement below
SELECT s1.id, IFNULL(s2.student, s1.student) AS `student`
FROM seat s1
         LEFT JOIN seat s2 ON IF(s1.id % 2 = 1, s2.id = s1.id + 1, s2.id = s1.id - 1);

SELECT (CASE WHEN id % 2 = 0 THEN id - 1 WHEN id = (SELECT COUNT(*) FROM seat) THEN id ELSE id + 1 END) AS `id`, student
FROM seat
ORDER BY id;