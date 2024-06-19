-- SQL Schema
DROP TABLE IF EXISTS tb_user_video_log, tb_video_info;
CREATE TABLE tb_user_video_log
(
    id         INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    uid        INT NOT NULL COMMENT '用户ID',
    video_id   INT NOT NULL COMMENT '视频ID',
    start_time datetime COMMENT '开始观看时间',
    end_time   datetime COMMENT '结束观看时间',
    if_follow  TINYINT COMMENT '是否关注',
    if_like    TINYINT COMMENT '是否点赞',
    if_retweet TINYINT COMMENT '是否转发',
    comment_id INT COMMENT '评论ID'
) CHARACTER SET utf8
  COLLATE utf8_bin;

CREATE TABLE tb_video_info
(
    id           INT PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    video_id     INT UNIQUE  NOT NULL COMMENT '视频ID',
    author       INT         NOT NULL COMMENT '创作者ID',
    tag          VARCHAR(16) NOT NULL COMMENT '类别标签',
    duration     INT         NOT NULL COMMENT '视频时长(秒数)',
    release_time datetime    NOT NULL COMMENT '发布时间'
) CHARACTER SET utf8
  COLLATE utf8_bin;

INSERT INTO tb_user_video_log(uid, video_id, start_time, end_time, if_follow, if_like, if_retweet, comment_id)
VALUES (101, 2001, '2021-09-01 10:00:00', '2021-09-01 10:00:20', 0, 1, 1, null)
     , (105, 2002, '2021-09-10 11:00:00', '2021-09-10 11:00:30', 1, 0, 1, null)
     , (101, 2001, '2021-10-01 10:00:00', '2021-10-01 10:00:20', 1, 1, 1, null)
     , (102, 2001, '2021-10-01 10:00:00', '2021-10-01 10:00:15', 0, 0, 1, null)
     , (103, 2001, '2021-10-01 11:00:50', '2021-10-01 11:01:15', 1, 1, 0, 1732526)
     , (106, 2002, '2021-10-01 10:59:05', '2021-10-01 11:00:05', 2, 0, 0, null);

INSERT INTO tb_video_info(video_id, author, tag, duration, release_time)
VALUES (2001, 901, '影视', 30, '2021-01-01 7:00:00')
     , (2002, 901, '影视', 60, '2021-01-01 7:00:00')
     , (2003, 902, '旅游', 90, '2020-01-01 7:00:00')
     , (2004, 902, '美女', 90, '2020-01-01 8:00:00');
# Write your MySQL query statement below
SELECT tvi.author                                                                AS `author`,
       DATE_FORMAT(start_time, '%Y-%m')                                          AS `month`,
       ROUND(AVG(IF(if_follow = 1, 1, IF(if_follow = 2, -1, 0))), 3)             AS `fans_growth_rate`,
       SUM(SUM(IF(if_follow = 1, 1, IF(if_follow = 2, -1, 0))))
           OVER (PARTITION BY author ORDER BY DATE_FORMAT(start_time, '%Y-%m') ) AS `total_fans`
FROM tb_user_video_log tuvl
         INNER JOIN tb_video_info tvi on tuvl.video_id = tvi.video_id
WHERE YEAR(tuvl.start_time) = 2021
GROUP BY 1, 2
ORDER BY 1, 4;