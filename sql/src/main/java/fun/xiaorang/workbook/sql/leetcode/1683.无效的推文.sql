-- SQL Schema;
Drop table If Exists Tweets;
Create table If Not Exists Tweets
(
    tweet_id int,
    content  varchar(50)
);
Truncate table Tweets;
insert into Tweets (tweet_id, content)
values ('1', 'Vote for Biden');
insert into Tweets (tweet_id, content)
values ('2', 'Let us make America great again!');
# Write your MySQL query statement below
SELECT tweet_id
FROM tweets
WHERE CHAR_LENGTH(content) > 15;