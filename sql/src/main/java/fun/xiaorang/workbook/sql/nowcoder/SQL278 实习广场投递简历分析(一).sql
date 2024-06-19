-- SQL Schema
drop table if exists resume_info;
CREATE TABLE resume_info
(
    id   int(4)      NOT NULL,
    job  varchar(64) NOT NULL,
    date date        NOT NULL,
    num  int(11)     NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO resume_info
VALUES (1, 'C++', '2025-01-02', 53),
       (2, 'Python', '2025-01-02', 23),
       (3, 'Java', '2025-01-02', 12),
       (4, 'Java', '2025-02-03', 24),
       (5, 'C++', '2025-02-03', 23),
       (6, 'Python', '2025-02-03', 34),
       (7, 'Python', '2025-03-04', 54),
       (8, 'C++', '2025-03-04', 65),
       (9, 'Java', '2025-03-04', 92),
       (10, 'Java', '2026-01-04', 230);
# Write your MySQL query statement below
SELECT job, SUM(num) AS `cnt`
FROM resume_info
WHERE YEAR(date) = 2025
GROUP BY job
ORDER BY cnt DESC;