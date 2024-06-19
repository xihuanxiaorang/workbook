-- 用户表t_user
DROP TABLE IF EXISTS t_user;
CREATE TABLE t_user
(
    user_id   INTEGER PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL
);

-- 好友关系表t_friend
DROP TABLE IF EXISTS t_friend;
CREATE TABLE t_friend
(
    user_id   INTEGER NOT NULL,
    friend_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, friend_id)
);

-- 粉丝表t_follower
DROP TABLE IF EXISTS t_follower;
CREATE TABLE t_follower
(
    user_id     INTEGER NOT NULL,
    follower_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, follower_id)
);

-- 关注表t_followed
DROP TABLE IF EXISTS t_followed;
CREATE TABLE t_followed
(
    user_id     INTEGER NOT NULL,
    followed_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, followed_id)
);

-- 生成初始化数据
INSERT INTO t_user
VALUES (1, '刘一');
INSERT INTO t_user
VALUES (2, '陈二');
INSERT INTO t_user
VALUES (3, '张三');
INSERT INTO t_user
VALUES (4, '李四');
INSERT INTO t_user
VALUES (5, '王五');
INSERT INTO t_user
VALUES (6, '赵六');
INSERT INTO t_user
VALUES (7, '孙七');
INSERT INTO t_user
VALUES (8, '周八');
INSERT INTO t_user
VALUES (9, '吴九');

INSERT INTO t_friend
VALUES (1, 2);
INSERT INTO t_friend
VALUES (2, 1);
INSERT INTO t_friend
VALUES (1, 3);
INSERT INTO t_friend
VALUES (3, 1);
INSERT INTO t_friend
VALUES (1, 4);
INSERT INTO t_friend
VALUES (4, 1);
INSERT INTO t_friend
VALUES (1, 7);
INSERT INTO t_friend
VALUES (7, 1);
INSERT INTO t_friend
VALUES (1, 8);
INSERT INTO t_friend
VALUES (8, 1);
INSERT INTO t_friend
VALUES (2, 3);
INSERT INTO t_friend
VALUES (3, 2);
INSERT INTO t_friend
VALUES (2, 5);
INSERT INTO t_friend
VALUES (5, 2);
INSERT INTO t_friend
VALUES (3, 4);
INSERT INTO t_friend
VALUES (4, 3);
INSERT INTO t_friend
VALUES (4, 6);
INSERT INTO t_friend
VALUES (6, 4);
INSERT INTO t_friend
VALUES (5, 8);
INSERT INTO t_friend
VALUES (8, 5);
INSERT INTO t_friend
VALUES (7, 8);
INSERT INTO t_friend
VALUES (8, 7);

INSERT INTO t_follower
VALUES (1, 2);
INSERT INTO t_follower
VALUES (1, 3);
INSERT INTO t_follower
VALUES (1, 4);
INSERT INTO t_follower
VALUES (1, 7);
INSERT INTO t_follower
VALUES (2, 3);
INSERT INTO t_follower
VALUES (3, 4);
INSERT INTO t_follower
VALUES (4, 1);
INSERT INTO t_follower
VALUES (5, 2);
INSERT INTO t_follower
VALUES (5, 8);
INSERT INTO t_follower
VALUES (6, 4);
INSERT INTO t_follower
VALUES (7, 8);
INSERT INTO t_follower
VALUES (8, 1);
INSERT INTO t_follower
VALUES (8, 7);

INSERT INTO t_followed
VALUES (1, 4);
INSERT INTO t_followed
VALUES (1, 8);
INSERT INTO t_followed
VALUES (2, 1);
INSERT INTO t_followed
VALUES (2, 5);
INSERT INTO t_followed
VALUES (3, 1);
INSERT INTO t_followed
VALUES (3, 2);
INSERT INTO t_followed
VALUES (4, 1);
INSERT INTO t_followed
VALUES (4, 3);
INSERT INTO t_followed
VALUES (4, 6);
INSERT INTO t_followed
VALUES (7, 1);
INSERT INTO t_followed
VALUES (7, 8);
INSERT INTO t_followed
VALUES (8, 5);
INSERT INTO t_followed
VALUES (8, 7);

-- 查找 "王五" 的好友列表
SELECT u.user_id '好友编号', u.user_name '好友姓名'
FROM t_friend f
         JOIN t_user u ON f.friend_id = u.user_id AND f.user_id = 5;

-- 查找 "张三" 和 "李四" 的共同好友
WITH f1 AS (SELECT friend_id
            FROM t_friend
            WHERE user_id = 3),
     f2 AS (SELECT friend_id
            FROM t_friend
            WHERE user_id = 4)
SELECT u.user_id '好友编号', u.user_name '好友姓名'
FROM f1
         JOIN f2 ON f1.friend_id = f2.friend_id
         JOIN t_user u ON u.user_id = f1.friend_id;

-- 查找可以推荐给 "陈二" 的用户
WITH friend(fid) AS (SELECT friend_id
                     FROM t_friend
                     WHERE user_id = 2),
     fof AS (SELECT f.friend_id
             FROM t_friend f
                      JOIN friend ON f.user_id = friend.fid AND f.friend_id != 2)
SELECT u.user_id '好友编号', u.user_name '好友姓名', COUNT(*) '共同好友数量'
FROM fof
         JOIN t_user u ON fof.friend_id = u.user_id
WHERE fof.friend_id NOT IN (SELECT fid FROM friend)
GROUP BY u.user_id, u.user_name;

-- 以 "赵六" 和 "孙七" 为例，查找他们之间的好友关系链
WITH RECURSIVE relation(uid, fid, hops, paths) AS
                   (SELECT user_id, friend_id, 0, CONCAT(user_id, '->', friend_id)
                    FROM t_friend
                    WHERE user_id = 6
                    UNION ALL
                    SELECT r.uid,
                           f.friend_id,
                           r.hops + 1,
                           CONCAT(r.paths, '->', f.friend_id)
                    FROM relation r
                             JOIN t_friend f ON r.fid = f.user_id
                    WHERE INSTR(r.paths, f.friend_id) = 0
                      AND r.hops < 6)
SELECT *
FROM relation
WHERE fid = 7;

-- 查找 "刘一" 关注了哪些用户
SELECT u.user_name '我的关注'
FROM t_followed f
         JOIN t_user u ON f.followed_id = u.user_id
WHERE f.user_id = 1;

-- 查找和 "刘一" 关注了相同用户的其他用户
WITH cf(user1, user2, followed) AS (SELECT d.user_id, r.follower_id, d.followed_id
                                    FROM t_followed d
                                             JOIN t_follower r ON r.user_id = d.followed_id AND r.follower_id != d.user_id
                                    WHERE d.user_id = 1)
SELECT u1.user_name '用户一', u2.user_name '用户二', u3.user_name '共同关注'
FROM cf
         JOIN t_user u1 ON u1.user_id = cf.user1
         JOIN t_user u2 ON u2.user_id = cf.user2
         JOIN t_user u3 ON u3.user_id = cf.followed;

-- 查找哪些用户是 "刘一" 的粉丝
SELECT u.user_name '我的粉丝'
FROM t_follower r
         JOIN t_user u ON r.follower_id = u.user_id
WHERE r.user_id = 1;

-- 查找哪些用户之间互为粉丝，或者互相关注
WITH df(user1, user2) AS (SELECT r.user_id, r.follower_id
                          FROM t_followed d
                                   JOIN t_follower r
                                        ON d.user_id = r.user_id AND d.followed_id = r.follower_id AND
                                           r.user_id < r.follower_id)
SELECT u1.user_name '用户一', u2.user_name '用户二'
FROM df
         JOIN t_user u1 ON u1.user_id = df.user1
         JOIN t_user u2 ON u2.user_id = df.user2;