-- Purpose:
-- Diagnose lifecycle drop-offs and identify early retention thresholds
-- gating course completion.

-- Funnel metrics
SELECT
  COUNT(*) AS registered_users,
  SUM(viewed) AS viewed_users,
  SUM(explored) AS explored_users,
  SUM(certified) AS certified_users,

  ROUND(100.0 * SUM(viewed) / COUNT(*), 2) AS pct_viewed,
  ROUND(100.0 * SUM(explored) / SUM(viewed), 2) AS pct_viewed_to_explored,
  ROUND(100.0 * SUM(certified) / SUM(explored), 2) AS pct_explored_to_certified
FROM course_base;

-- Absolute drop-offs
SELECT
  (COUNT(*) - SUM(viewed)) AS drop_registered_to_viewed,
  (SUM(viewed) - SUM(explored)) AS drop_viewed_to_explored,
  (SUM(explored) - SUM(certified)) AS drop_explored_to_certified
FROM course_base;

-- Funnel conditional on outcome
SELECT
  AVG(viewed) AS pct_viewed,
  AVG(explored) AS pct_explored
FROM course_base
WHERE certified = 1;

SELECT
  AVG(viewed) AS pct_viewed,
  AVG(explored) AS pct_explored
FROM course_base
WHERE certified = 0;
