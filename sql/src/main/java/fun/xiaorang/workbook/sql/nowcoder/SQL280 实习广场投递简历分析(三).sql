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
       (13, 'C++', '2026-01-04', 230),
       (14, 'Java', '2026-01-04', 764),
       (15, 'Python', '2026-01-04', 644),
       (16, 'C++', '2026-01-06', 240),
       (17, 'Java', '2026-01-06', 714),
       (18, 'Python', '2026-01-06', 624),
       (19, 'C++', '2026-02-14', 260),
       (20, 'Java', '2026-02-14', 721),
       (21, 'Python', '2026-02-14', 321),
       (22, 'C++', '2026-02-24', 134),
       (23, 'Java', '2026-02-24', 928),
       (24, 'Python', '2026-02-24', 525),
       (25, 'C++', '2027-02-06', 231);
# Write your MySQL query statement below
SELECT a.job, first_year_mon, first_year_cnt, second_year_mon, second_year_cnt
FROM (SELECT job, DATE_FORMAT(date, '%Y-%m') AS `first_year_mon`, SUM(num) AS `first_year_cnt`
      FROM resume_info
      WHERE YEAR(date) = 2025
      GROUP BY 1, 2) a
         INNER JOIN (SELECT job, DATE_FORMAT(date, '%Y-%m') AS `second_year_mon`, SUM(num) AS `second_year_cnt`
                     FROM resume_info
                     WHERE YEAR(date) = 2026
                     GROUP BY 1, 2) b
                    ON a.job = b.job AND
                       SUBSTRING_INDEX(a.first_year_mon, '-', -1) = SUBSTRING_INDEX(b.second_year_mon, '-', -1)
ORDER BY first_year_mon DESC, job DESC;