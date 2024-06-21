-- SQL Schema
drop table if exists answer_tb;
CREATE TABLE answer_tb
(
    answer_date date     NOT NULL,
    author_id   int(10)  NOT NULL,
    issue_id    char(10) NOT NULL,
    char_len    int(10)  NOT NULL
);
INSERT INTO answer_tb
VALUES ('2021-11-1', 101, 'E001', 150);
INSERT INTO answer_tb
VALUES ('2021-11-1', 101, 'E002', 200);
INSERT INTO answer_tb
VALUES ('2021-11-1', 102, 'C003', 50);
INSERT INTO answer_tb
VALUES ('2021-11-1', 103, 'P001', 35);
INSERT INTO answer_tb
VALUES ('2021-11-1', 104, 'C003', 120);
INSERT INTO answer_tb
VALUES ('2021-11-1', 105, 'P001', 125);
INSERT INTO answer_tb
VALUES ('2021-11-1', 102, 'P002', 105);
INSERT INTO answer_tb
VALUES ('2021-11-2', 101, 'P001', 201);
INSERT INTO answer_tb
VALUES ('2021-11-2', 110, 'C002', 200);
INSERT INTO answer_tb
VALUES ('2021-11-2', 110, 'C001', 225);
INSERT INTO answer_tb
VALUES ('2021-11-2', 110, 'C002', 220);
INSERT INTO answer_tb
VALUES ('2021-11-3', 101, 'C002', 180);
INSERT INTO answer_tb
VALUES ('2021-11-4', 109, 'E003', 130);
INSERT INTO answer_tb
VALUES ('2021-11-4', 109, 'E001', 123);
INSERT INTO answer_tb
VALUES ('2021-11-5', 108, 'C001', 160);
INSERT INTO answer_tb
VALUES ('2021-11-5', 108, 'C002', 120);
INSERT INTO answer_tb
VALUES ('2021-11-5', 110, 'P001', 180);
INSERT INTO answer_tb
VALUES ('2021-11-5', 106, 'P002', 45);
INSERT INTO answer_tb
VALUES ('2021-11-5', 107, 'E003', 56);
# Write your MySQL query statement below
SELECT answer_date, ROUND(COUNT(issue_id) / COUNT(DISTINCT author_id), 2) AS `per_num`
FROM answer_tb
WHERE MONTH(answer_date) = 11
GROUP BY answer_date
ORDER BY answer_date;