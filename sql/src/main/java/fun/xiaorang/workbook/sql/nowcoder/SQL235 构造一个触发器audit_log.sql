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
    EMP_no INT  NOT NULL,
    NAME   TEXT NOT NULL
);

# Write your MySQL query statement below
CREATE TRIGGER `audit_log`
    AFTER INSERT
    ON `employees_test`
    FOR EACH ROW
BEGIN
    INSERT INTO audit VALUES (NEW.ID, NEW.NAME);
END;