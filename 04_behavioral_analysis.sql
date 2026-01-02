-- Purpose:
-- Identify behavioral differences among learners who cross the
-- early retention threshold.

CREATE TABLE engaged_8plus AS
SELECT *
FROM course_base
WHERE active_days >= 8;

-- Completion rate among retained learners
SELECT
  COUNT(*) AS users,
  ROUND(100.0 * SUM(certified) / COUNT(*), 2) AS certification_rate
FROM engaged_8plus;

-- Raw engagement comparison
SELECT
  certified,
  ROUND(AVG(nevents), 1) AS avg_events,
  ROUND(AVG(ndays_act), 1) AS avg_days_active,
  ROUND(AVG(nplay_video), 1) AS avg_videos,
  ROUND(AVG(nchapters), 1) AS avg_chapters,
  ROUND(AVG(nforum_posts), 2) AS avg_forum_posts
FROM engaged_8plus
GROUP BY certified;

-- Normalized per-day engagement
SELECT
  certified,
  ROUND(AVG(nevents * 1.0 / active_days), 2) AS events_per_day,
  ROUND(AVG(nplay_video * 1.0 / active_days), 2) AS videos_per_day,
  ROUND(AVG(nchapters * 1.0 / active_days), 2) AS chapters_per_day,
  ROUND(AVG(nforum_posts * 1.0 / active_days), 3) AS forum_posts_per_day
FROM engaged_8plus
GROUP BY certified;

-- Early-stage forum activity check
SELECT
  certified,
  ROUND(AVG(nforum_posts), 2) AS avg_forum_posts
FROM engaged_8plus
WHERE active_days <= 14
GROUP BY certified;
