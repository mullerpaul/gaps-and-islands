ALTER SESSION SET nls_date_format = 'YYYY-Mon-DD';
col island_range_start for a20
col island_range_end for a20

SELECT range_id, range_start, range_end,
       SUM(island_start_flag) OVER (ORDER BY range_start, range_end) AS island_id
  FROM (SELECT range_id, range_start, range_end,
               CASE 
                 WHEN running_window_latest_end IS NULL
                   THEN 1  -- first row in window
                 WHEN range_start > (running_window_latest_end + 1) 
                   THEN 1  -- plus one because assignments starting the day after another ends are considered adjacent
                 ELSE 0
               END AS island_start_flag
          FROM (SELECT range_id, range_start, range_end,
                       MAX(range_end) OVER 
                          (ORDER BY range_start, range_end 
                           ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS running_window_latest_end
                  FROM date_ranges
               )
       )
/

SELECT island_id, island_range_start, island_range_end,
       island_range_end - island_range_start + 1 AS days_worked,
       island_range_start - LAG(island_range_end) OVER (ORDER BY island_id) - 1 AS gap_days
  FROM (SELECT island_id,
               MIN(range_start) AS island_range_start,
               MAX(range_end) AS island_range_end
          FROM (SELECT range_id, range_start, range_end,
                       SUM(island_start_flag) OVER (ORDER BY range_start, range_end) AS island_id
                  FROM (SELECT range_id, range_start, range_end,
                               CASE
                                 WHEN running_window_latest_end IS NULL
                                   THEN 1  -- first row in window
                                 WHEN range_start > (running_window_latest_end + 1)
                                   THEN 1  -- plus one because assignments starting the day after another ends are considered adjacent
                                 ELSE 0
                               END AS island_start_flag
                          FROM (SELECT range_id, range_start, range_end,
                                       MAX(range_end) OVER
                                          (ORDER BY range_start, range_end
                                           ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS running_window_latest_end
                                  FROM date_ranges
                               )
                       )
               )
         GROUP BY island_id
       )
 ORDER BY island_id
/
