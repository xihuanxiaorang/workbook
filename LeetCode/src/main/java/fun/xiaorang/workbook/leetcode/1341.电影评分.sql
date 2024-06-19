-- SQL Schema
Drop table If Exists Movies;
Drop table If Exists Users;
Drop table If Exists MovieRating;
Create table If Not Exists Movies
(
    movie_id int,
    title    varchar(30)
);
Create table If Not Exists Users
(
    user_id int,
    name    varchar(30)
);
Create table If Not Exists MovieRating
(
    movie_id   int,
    user_id    int,
    rating     int,
    created_at date
);
Truncate table Movies;
insert into Movies (movie_id, title)
values ('1', 'Avengers');
insert into Movies (movie_id, title)
values ('2', 'Frozen 2');
insert into Movies (movie_id, title)
values ('3', 'Joker');
Truncate table Users;
insert into Users (user_id, name)
values ('1', 'Daniel');
insert into Users (user_id, name)
values ('2', 'Monica');
insert into Users (user_id, name)
values ('3', 'Maria');
insert into Users (user_id, name)
values ('4', 'James');
Truncate table MovieRating;
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('1', '1', '3', '2020-01-12');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('1', '2', '4', '2020-02-11');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('1', '3', '2', '2020-02-12');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('1', '4', '1', '2020-01-01');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('2', '1', '5', '2020-02-17');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('2', '2', '2', '2020-02-01');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('2', '3', '2', '2020-03-01');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('3', '1', '3', '2020-02-22');
insert into MovieRating (movie_id, user_id, rating, created_at)
values ('3', '2', '4', '2020-02-25');
# Write your MySQL query statement below
(SELECT u.name AS `results`
 FROM users u
          LEFT JOIN movierating mr ON u.user_id = mr.user_id
 GROUP BY u.user_id, u.name
 ORDER BY COUNT(DISTINCT mr.movie_id) DESC, u.name
 LIMIT 1)
UNION ALL
(SELECT m.title AS `results`
 FROM movies m
          LEFT JOIN movierating mr ON m.movie_id = mr.movie_id
 WHERE DATE_FORMAT(mr.created_at, '%Y-%m') = '2020-02'
 GROUP BY m.movie_id, m.title
 ORDER BY AVG(rating) DESC, m.title
 LIMIT 1);
