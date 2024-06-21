-- SQL Schema
drop table if exists issue_tb;
CREATE TABLE issue_tb
(
    issue_id   char(10) NOT NULL,
    issue_type char(10) NOT NULL
);
INSERT INTO issue_tb
VALUES ('E001', 'Education');
INSERT INTO issue_tb
VALUES ('E002', 'Education');
INSERT INTO issue_tb
VALUES ('E003', 'Education');
INSERT INTO issue_tb
VALUES ('C001', 'Career');
INSERT INTO issue_tb
VALUES ('C002', 'Career');
INSERT INTO issue_tb
VALUES ('C003', 'Career');
INSERT INTO issue_tb
VALUES ('C004', 'Career');
INSERT INTO issue_tb
VALUES ('P001', 'Psychology');
INSERT INTO issue_tb
VALUES ('P002', 'Psychology');

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
SELECT COUNT(*) AS `num`
FROM (SELECT DISTINCT author_id
      FROM answer_tb at
               INNER JOIN issue_tb it USING (issue_id)
      WHERE issue_type = 'Career') a
         INNER JOIN (SELECT DISTINCT author_id
                     FROM answer_tb at
                              INNER JOIN issue_tb it USING (issue_id)
                     WHERE issue_type = 'Education') b USING (author_id);