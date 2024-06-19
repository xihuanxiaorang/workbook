-- SQL Schema;
Drop table If Exists Accounts;
Create table If Not Exists Accounts
(
    account_id int,
    income     int
);
Truncate table Accounts;
insert into Accounts (account_id, income)
values ('3', '108939');
insert into Accounts (account_id, income)
values ('2', '12747');
insert into Accounts (account_id, income)
values ('8', '87709');
insert into Accounts (account_id, income)
values ('6', '91796');
# Write your MySQL query statement below
WITH cte AS (SELECT MAX(income) max_income, MIN(income) min_income
             FROM accounts
             GROUP BY account_id)
SELECT 'Low Salary' AS `category`, SUM(IF(max_income < 20000, 1, 0)) AS accounts_count
FROM cte
UNION ALL
SELECT 'Average Salary' AS `category`, SUM(IF(min_income >= 20000 AND max_income <= 50000, 1, 0)) AS accounts_count
FROM cte
UNION ALL
SELECT 'High Salary' AS `category`, SUM(IF(min_income > 50000, 1, 0)) AS accounts_count
FROM cte;

SELECT 'Low Salary' AS `category`, count(*) AS accounts_count
FROM accounts
WHERE income < 20000
UNION ALL
SELECT 'Average Salary' AS `category`, count(*) AS accounts_count
FROM accounts
WHERE income >= 20000
  AND income <= 50000
UNION ALL
SELECT 'High Salary' AS `category`, count(*) AS accounts_count
FROM accounts
WHERE income > 50000;