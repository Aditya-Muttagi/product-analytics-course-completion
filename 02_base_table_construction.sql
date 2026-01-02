-- Purpose:
-- Build a clean, analysis-ready base table with parsed dates
-- and derived retention metrics.

CREATE TABLE course_base AS
SELECT
    userid_DI AS user_id,
    course_id,

    registered,
    viewed,
    explored,
    certified,

    -- Parse start_time_DI (MM/DD/YYYY or M/D/YYYY)
    date(
      substr(start_time_DI, instr(start_time_DI, '/') + 1
        + instr(substr(start_time_DI, instr(start_time_DI, '/') + 1), '/')) || '-' ||
      printf('%02d', substr(start_time_DI, 1, instr(start_time_DI, '/') - 1)) || '-' ||
      printf('%02d',
        substr(
          start_time_DI,
          instr(start_time_DI, '/') + 1,
          instr(substr(start_time_DI, instr(start_time_DI, '/') + 1), '/') - 1
        )
      )
    ) AS start_time,

    -- Parse last_event_DI
    date(
      substr(last_event_DI, instr(last_event_DI, '/') + 1
        + instr(substr(last_event_DI, instr(last_event_DI, '/') + 1), '/')) || '-' ||
      printf('%02d', substr(last_event_DI, 1, instr(last_event_DI, '/') - 1)) || '-' ||
      printf('%02d',
        substr(
          last_event_DI,
          instr(last_event_DI, '/') + 1,
          instr(substr(last_event_DI, instr(last_event_DI, '/') + 1), '/') - 1
        )
      )
    ) AS last_event_time,

    nevents,
    ndays_act,
    nplay_video,
    nchapters,
    nforum_posts
FROM raw_courses
WHERE registered = 1;

-- Retention duration
ALTER TABLE course_base ADD COLUMN active_days INTEGER;

UPDATE course_base
SET active_days =
  CAST(julianday(last_event_time) - julianday(start_time) AS INTEGER);

-- Handle missing last activity (early abandonment)
ALTER TABLE course_base ADD COLUMN effective_last_event_time DATE;

UPDATE course_base
SET effective_last_event_time =
  CASE
    WHEN last_event_time IS NULL THEN start_time
    ELSE last_event_time
  END;
