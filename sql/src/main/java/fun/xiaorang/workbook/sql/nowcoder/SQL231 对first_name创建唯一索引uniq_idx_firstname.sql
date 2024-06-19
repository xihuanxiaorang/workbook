-- SQL Schema
CREATE TABLE IF NOT EXISTS `actor`
(
    actor_id    smallint(5) NOT NULL PRIMARY KEY,
    first_name  varchar(45) NOT NULL,
    last_name   varchar(45) NOT NULL,
    last_update datetime    NOT NULL
);
# Write your MySQL query statement below
ALTER TABLE `actor`
    ADD UNIQUE INDEX uniq_idx_firstname (first_name),
    ADD INDEX idx_lastname (last_name);

CREATE UNIQUE INDEX uniq_idx_firstname ON `actor` (first_name);
CREATE INDEX idx_lastname ON `actor` (last_name);