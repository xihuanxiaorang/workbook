-- SQL Schema
drop table if exists audit;
drop table if exists employees_test;
CREATE TABLE employees_test
(
    ID      INT PRIMARY KEY NOT NULL,
    NAME    TEXT            NOT NULL,
    AGE     INT             NOT NULL,
    ADDRESS CHAR(50),
    SALARY  REAL
);

CREATE TABLE audit
(
    EMP_no      INT      NOT NULL,
    create_date datetime NOT NULL
);

# Write your MySQL query statement below
ALTER TABLE audit
    ADD CONSTRAINT FOREIGN KEY (EMP_no) REFERENCES employees_test (ID);