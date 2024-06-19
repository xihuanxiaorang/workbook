-- SQL Schema
drop table if exists submission;
CREATE TABLE submission
(
    id          int(11) NOT NULL,
    subject_id  int(11) NOT NULL,
    create_time date    NOT NULL
);

CREATE TABLE subject
(
    id   int(11)     NOT NULL,
    name varchar(32) NOT NULL
);

INSERT INTO submission
VALUES (1, 2, '2999-02-11'),
       (2, 2, '2999-02-21'),
       (3, 1, '2999-02-21'),
       (4, 1, '2999-02-22'),
       (5, 3, '2999-02-22'),
       (6, 2, '2999-02-22'),
       (7, 2, '2999-02-22');

INSERT INTO subject
VALUES (1, 'jzoffer'),
       (2, 'tiba'),
       (3, 'huaweijishi'),
       (4, 'top101');
# Write your MySQL query statement below
SELECT s.name, COUNT(*) AS `cnt`
FROM submission s1
         INNER JOIN subject s on s1.subject_id = s.id
WHERE s1.create_time = CURDATE()
GROUP BY s.id, s.name
ORDER BY cnt DESC, s.id;