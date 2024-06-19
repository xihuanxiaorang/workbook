-- SQL Schema
drop table if exists person;
drop table if exists task;
CREATE TABLE `person`
(
    `id`   int(4)      NOT NULL,
    `name` varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `task`
(
    `id`        int(4)      NOT NULL,
    `person_id` int(4)      NOT NULL,
    `content`   varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO person
VALUES (1, 'fh'),
       (2, 'tm');

INSERT INTO task
VALUES (1, 2, 'tm works well'),
       (2, 2, 'tm works well');

# Write your MySQL query statement below
SELECT p.id, p.name, t.content
FROM person p
         LEFT JOIN task t on p.id = t.person_id
ORDER BY p.id;