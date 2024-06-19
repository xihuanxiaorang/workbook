-- SQL Schema
DROP TABLE IF EXISTS `follow`;
DROP TABLE IF EXISTS `music_likes`;
DROP TABLE IF EXISTS `music`;

CREATE TABLE `follow`
(
    `user_id`     int(4) NOT NULL,
    `follower_id` int(4) NOT NULL,
    PRIMARY KEY (`user_id`, `follower_id`)
);

CREATE TABLE `music_likes`
(
    `user_id`  int(4) NOT NULL,
    `music_id` int(4) NOT NULL,
    PRIMARY KEY (`user_id`, `music_id`)
);

CREATE TABLE `music`
(
    `id`         int(4)      NOT NULL,
    `music_name` varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO follow
VALUES (1, 2);
INSERT INTO follow
VALUES (1, 4);
INSERT INTO follow
VALUES (2, 3);

INSERT INTO music_likes
VALUES (1, 17);
INSERT INTO music_likes
VALUES (2, 18);
INSERT INTO music_likes
VALUES (2, 19);
INSERT INTO music_likes
VALUES (3, 20);
INSERT INTO music_likes
VALUES (4, 17);

INSERT INTO music
VALUES (17, 'yueyawang');
INSERT INTO music
VALUES (18, 'kong');
INSERT INTO music
VALUES (19, 'MOM');
INSERT INTO music
VALUES (20, 'Sold Out');

# Write your MySQL query statement below

SELECT m.music_name
FROM (SELECT DISTINCT music_id
      FROM music_likes
      WHERE user_id IN (SELECT follower_id FROM follow WHERE user_id = 1)
        AND music_id NOT IN (SELECT music_id FROM music_likes WHERE user_id = 1)) t
         INNER JOIN music m ON t.music_id = m.id
ORDER BY m.id;