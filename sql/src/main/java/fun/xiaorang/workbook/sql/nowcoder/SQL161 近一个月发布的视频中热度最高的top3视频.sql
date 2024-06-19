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
VALUES (101, 2001, '2021-09-24 10:00:00', '2021-09-24 10:00:30', 1, 1, 1, null)
     , (101, 2001, '2021-10-01 10:00:00', '2021-10-01 10:00:31', 1, 1, 0, null)
     , (102, 2001, '2021-10-01 10:00:00', '2021-10-01 10:00:35', 0, 0, 1, null)
     , (103, 2001, '2021-10-03 11:00:50', '2021-10-03 11:01:35', 1, 1, 0, 1732526)
     , (106, 2002, '2021-10-02 10:59:05', '2021-10-02 11:00:04', 2, 0, 1, null)
     , (107, 2002, '2021-10-02 10:59:05', '2021-10-02 11:00:06', 1, 0, 0, null)
     , (108, 2002, '2021-10-02 10:59:05', '2021-10-02 11:00:05', 1, 1, 1, null)
     , (109, 2002, '2021-10-03 10:59:05', '2021-10-03 11:00:01', 0, 1, 0, null)
     , (105, 2002, '2021-09-25 11:00:00', '2021-09-25 11:00:30', 1, 0, 1, null)
     , (101, 2003, '2021-09-26 11:00:00', '2021-09-26 11:00:30', 1, 0, 0, null)
     , (101, 2003, '2021-09-30 11:00:00', '2021-09-30 11:00:30', 1, 1, 0, null);

INSERT INTO tb_video_info(video_id, author, tag, duration, release_time)
VALUES (2001, 901, '旅游', 30, '2021-09-05 7:00:00')
     , (2002, 901, '旅游', 60, '2021-09-05 7:00:00')
     , (2003, 902, '影视', 90, '2021-09-05 7:00:00')
     , (2004, 902, '影视', 90, '2021-09-05 8:00:00');
# Write your MySQL query statement below
SELECT tuvl.video_id,
       SUM(IF(TIMESTAMPDIFF(SECOND, tuvl.start_time, tuvl.end_time) >= tvi.duration, 1, 0))    `完播次数`,
       COUNT(*)                                                                                `播放次数`,
       AVG(IF(TIMESTAMPDIFF(SECOND, tuvl.start_time, tuvl.end_time) >= tvi.duration, 1, 0)) AS `完播率`,
       SUM(if_like)                                                                         AS `点赞数`,
       COUNT(comment_id)                                                                    AS `评论数`,
       SUM(if_retweet)                                                                      AS `转发数`,
       DATEDIFF((SELECT MAX(end_time) FROM tb_user_video_log), MAX(tuvl.end_time))          AS `最近无播放天数`,
       ROUND((100 * AVG(IF(TIMESTAMPDIFF(SECOND, tuvl.start_time, tuvl.end_time) >= tvi.duration, 1, 0)) +
              5 * SUM(if_like) + 3 * COUNT(comment_id) + 2 * SUM(if_retweet)) /
             (DATEDIFF((SELECT MAX(end_time) FROM tb_user_video_log), MAX(tuvl.end_time)) + 1),
             0)                                                                             AS `hot_index`
FROM tb_user_video_log tuvl
         INNER JOIN tb_video_info tvi on tuvl.video_id = tvi.video_id
WHERE DATEDIFF((SELECT MAX(end_time) FROM tb_user_video_log), tvi.release_time) <= 29
GROUP BY tuvl.video_id
ORDER BY hot_index DESC
LIMIT 3;

SELECT tuvl.video_id,
       ROUND((100 * AVG(IF(TIMESTAMPDIFF(SECOND, tuvl.start_time, tuvl.end_time) >= tvi.duration, 1, 0)) +
              5 * SUM(if_like) + 3 * COUNT(comment_id) + 2 * SUM(if_retweet)) /
             (DATEDIFF((SELECT MAX(end_time) FROM tb_user_video_log), MAX(tuvl.end_time)) + 1),
             0) AS `hot_index`
FROM tb_user_video_log tuvl
         INNER JOIN tb_video_info tvi on tuvl.video_id = tvi.video_id
WHERE DATEDIFF((SELECT MAX(end_time) FROM tb_user_video_log), tvi.release_time) <= 29
GROUP BY tuvl.video_id
ORDER BY hot_index DESC
LIMIT 3;