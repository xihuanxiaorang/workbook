-- SQL Schema
drop table if exists grade;
drop table if exists language;
CREATE TABLE `grade`
(
    `id`          int(4) NOT NULL,
    `language_id` int(4) NOT NULL,
    `score`       int(4) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `language`
(
    `id`   int(4)      NOT NULL,
    `name` varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO grade
VALUES (1, 1, 12000),
       (2, 1, 13000),
       (3, 2, 11000),
       (4, 2, 10000),
       (5, 3, 11000),
       (6, 1, 11000),
       (7, 2, 11000);

INSERT INTO language
VALUES (1, 'C++'),
       (2, 'JAVA'),
       (3, 'Python');

# Write your MySQL query statement below
SELECT id, name, score
FROM (SELECT g.id, l.name, g.score, DENSE_RANK() OVER (PARTITION BY g.language_id ORDER BY g.score DESC) AS `rn`
      FROM grade g
               INNER JOIN language l on g.language_id = l.id) t
WHERE rn <= 2
ORDER BY name, score DESC, id;
