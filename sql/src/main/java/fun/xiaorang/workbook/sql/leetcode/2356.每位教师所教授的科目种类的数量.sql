-- SQL Schema
Drop table If Exists Teacher;
Create table If Not Exists Teacher
(
    teacher_id int,
    subject_id int,
    dept_id    int
);
Truncate table Teacher;
insert into Teacher (teacher_id, subject_id, dept_id)
values ('1', '2', '3');
insert into Teacher (teacher_id, subject_id, dept_id)
values ('1', '2', '4');
insert into Teacher (teacher_id, subject_id, dept_id)
values ('1', '3', '3');
insert into Teacher (teacher_id, subject_id, dept_id)
values ('2', '1', '1');
insert into Teacher (teacher_id, subject_id, dept_id)
values ('2', '2', '1');
insert into Teacher (teacher_id, subject_id, dept_id)
values ('2', '3', '1');
insert into Teacher (teacher_id, subject_id, dept_id)
values ('2', '4', '1');
# Write your MySQL query statement below
SELECT teacher_id, COUNT(DISTINCT subject_id) AS `cnt`
FROM teacher
GROUP BY teacher_id;