-- SQL Schema
drop table if exists order_info;
drop table if exists client;
CREATE TABLE order_info
(
    id           int(4)       NOT NULL,
    user_id      int(11)      NOT NULL,
    product_name varchar(256) NOT NULL,
    status       varchar(32)  NOT NULL,
    client_id    int(4)       NOT NULL,
    date         date         NOT NULL,
    is_group_buy varchar(32)  NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE client
(
    id   int(4)      NOT NULL,
    name varchar(32) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO order_info
VALUES (1, 557336, 'C++', 'no_completed', 1, '2025-10-10', 'No'),
       (2, 230173543, 'Python', 'completed', 2, '2025-10-12', 'No'),
       (3, 57, 'JS', 'completed', 0, '2025-10-23', 'Yes'),
       (4, 57, 'C++', 'completed', 3, '2025-10-23', 'No'),
       (5, 557336, 'Java', 'completed', 0, '2025-10-23', 'Yes'),
       (6, 57, 'Java', 'completed', 1, '2025-10-24', 'No'),
       (7, 557336, 'C++', 'completed', 0, '2025-10-25', 'Yes');

INSERT INTO client
VALUES (1, 'PC'),
       (2, 'Android'),
       (3, 'IOS'),
       (4, 'H5');
# Write your MySQL query statement below
SELECT id, is_group_buy, client_name
FROM (SELECT o.id, o.is_group_buy, c.name AS `client_name`, COUNT(*) OVER (PARTITION BY o.user_id) AS `cnt`
      FROM order_info o
               LEFT JOIN client c on c.id = o.client_id
      WHERE o.date > '2025-10-15'
        AND o.status = 'completed'
        AND o.product_name IN ('C++', 'Java', 'Python')) t
WHERE cnt >= 2
ORDER BY id;

SELECT o.id, o.is_group_buy, c.name AS `client_name`
FROM order_info o
         LEFT JOIN client c on c.id = o.client_id
WHERE user_id IN (SELECT user_id
                  FROM order_info
                  WHERE date > '2025-10-15'
                    AND status = 'completed'
                    AND product_name IN ('C++', 'Java', 'Python')
                  GROUP BY user_id
                  HAVING COUNT(*) >= 2)
  AND o.date > '2025-10-15'
  AND o.status = 'completed'
  AND o.product_name IN ('C++', 'Java', 'Python')
ORDER BY o.id;