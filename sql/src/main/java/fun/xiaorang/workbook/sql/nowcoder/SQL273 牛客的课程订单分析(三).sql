-- SQL Schema
drop table if exists order_info;
CREATE TABLE order_info
(
    id           int(4)       NOT NULL,
    user_id      int(11)      NOT NULL,
    product_name varchar(256) NOT NULL,
    status       varchar(32)  NOT NULL,
    client_id    int(4)       NOT NULL,
    date         date         NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO order_info
VALUES (1, 557336, 'C++', 'no_completed', 1, '2025-10-10'),
       (2, 230173543, 'Python', 'completed', 2, '2025-10-12'),
       (3, 57, 'JS', 'completed', 3, '2025-10-23'),
       (4, 57, 'C++', 'completed', 3, '2025-10-23'),
       (5, 557336, 'Java', 'completed', 1, '2025-10-23'),
       (6, 57, 'Java', 'completed', 1, '2025-10-24'),
       (7, 557336, 'C++', 'completed', 1, '2025-10-25');
# Write your MySQL query statement below
SELECT *
FROM order_info
WHERE user_id IN (SELECT user_id
                  FROM order_info
                  WHERE date > '2025-10-15'
                    AND status = 'completed'
                    AND product_name IN ('C++', 'Java', 'Python')
                  GROUP BY user_id
                  HAVING COUNT(*) >= 2)
  AND status = 'completed'
  AND date > '2025-10-15'
  AND product_name IN ('C++', 'Java', 'Python')
ORDER BY id;

SELECT id,
       user_id,
       product_name,
       status,
       client_id,
       date
FROM (SELECT *, COUNT(*) OVER (PARTITION BY user_id) AS `cnt`
      FROM order_info
      WHERE date > '2025-10-15'
        AND status = 'completed'
        AND product_name IN ('C++', 'Java', 'Python')) t
WHERE cnt >= 2
ORDER BY id;