-- SQL Schema
Drop table If Exists Queries;
Create table If Not Exists Queries
(
    query_name varchar(30),
    result     varchar(50),
    position   int,
    rating     int
);
Truncate table Queries;
insert into Queries (query_name, result, position, rating)
values ('Dog', 'Golden Retriever', '1', '5');
insert into Queries (query_name, result, position, rating)
values ('Dog', 'German Shepherd', '2', '5');
insert into Queries (query_name, result, position, rating)
values ('Dog', 'Mule', '200', '1');
insert into Queries (query_name, result, position, rating)
values ('Cat', 'Shirazi', '5', '2');
insert into Queries (query_name, result, position, rating)
values ('Cat', 'Siamese', '3', '3');
insert into Queries (query_name, result, position, rating)
values ('Cat', 'Sphynx', '7', '4');
# Write your MySQL query statement below
SELECT query_name,
       ROUND(SUM(rating / position) / COUNT(*), 2)          AS `quality`,
       ROUND(SUM(IF(rating < 3, 1, 0)) / COUNT(*) * 100, 2) AS `poor_query_percentage`
FROM queries
WHERE query_name IS NOT NULL
GROUP BY query_name;