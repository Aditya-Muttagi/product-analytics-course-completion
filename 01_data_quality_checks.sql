-- Purpose:
-- Validate raw dataset structure, completeness, and logical consistency
-- before building analytical tables.

-- Row counts and entity coverage
SELECT COUNT(*) FROM raw_courses;

SELECT
  COUNT(*) AS rows,
  COUNT(DISTINCT userid_DI) AS users,
  COUNT(DISTINCT course_id) AS courses,
  COUNT(DISTINCT userid_DI || '-' || course_id) AS user_course_pairs
FROM raw_courses;

-- Binary flag validation
SELECT
  MIN(registered), MAX(registered),
  MIN(viewed), MAX(viewed),
  MIN(explored), MAX(explored),
  MIN(certified), MAX(certified)
FROM raw_courses;

-- Logical consistency checks
SELECT COUNT(*) AS violations
FROM raw_courses
WHERE certified = 1 AND explored = 0;

-- Missing time fields
SELECT
  COUNT(*) FILTER (WHERE start_time_DI IS NULL) AS start_time_nulls,
  COUNT(*) FILTER (WHERE last_event_DI IS NULL) AS last_event_nulls,
  COUNT(*) AS total_rows
FROM raw_courses;

-- Inspect raw date format
SELECT start_time_DI
FROM raw_courses
WHERE start_time_DI IS NOT NULL
LIMIT 10;

-- Engagement metric ranges
SELECT
  MIN(nevents), MAX(nevents),
  MIN(ndays_act), MAX(ndays_act),
  MIN(nplay_video), MAX(nplay_video),
  MIN(nchapters), MAX(nchapters),
  MIN(nforum_posts), MAX(nforum_posts)
FROM raw_courses;

-- Sanity check: activity days should not exceed events
SELECT COUNT(*)
FROM raw_courses
WHERE ndays_act > nevents;

-- Outcome distribution
SELECT
  certified,
  COUNT(*) AS rows,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM raw_courses
GROUP BY certified;
