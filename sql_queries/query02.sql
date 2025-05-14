-- Query 02: Calculate bounce rate per traffic source for July 2017
WITH source_bounce_stats AS (
  SELECT
      trafficSource.source AS source,
      SUM(totals.visits) AS total_visits,
      SUM(totals.bounces) AS total_bounces
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
  GROUP BY trafficSource.source
)

SELECT
    source,
    total_visits,
    total_bounces,
    ROUND((total_bounces * 100.0) / total_visits, 3) AS bounce_rate
FROM source_bounce_stats
ORDER BY total_visits DESC;
