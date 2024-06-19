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
       (4, 'C++', '2025-01-03', 54),
       (5, 'Python', '2025-01-03', 43),
       (6, 'Java', '2025-01-03', 41),
       (7, 'Java', '2025-02-03', 24),
       (8, 'C++', '2025-02-03', 23),
       (9, 'Python', '2025-02-03', 34),
       (10, 'Java', '2025-02-04', 42),
       (11, 'C++', '2025-02-04', 45),
       (12, 'Python', '2025-02-04', 59),
       (13, 'Python', '2025-03-04', 54),
       (14, 'C++', '2025-03-04', 65),
       (15, 'Java', '2025-03-04', 92),
       (16, 'Python', '2025-03-05', 34),
       (17, 'C++', '2025-03-05', 34),
       (18, 'Java', '2025-03-05', 34),
       (19, 'Python', '2026-01-04', 230),
       (20, 'C++', '2026-02-06', 231);
# Write your MySQL query statement below
SELECT job, DATE_FORMAT(date, '%Y-%m') AS `mon`, SUM(num) AS `cnt`
FROM resume_info
WHERE YEAR(date) = 2025
GROUP BY 1, 2
ORDER BY 2 DESC, 3 DESC;