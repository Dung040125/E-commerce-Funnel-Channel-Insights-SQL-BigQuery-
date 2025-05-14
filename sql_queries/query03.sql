-- Query 03: Revenue by traffic source by week and month in June 2017

WITH monthly_revenue AS (
  SELECT
    'Month' AS time_type,
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS time,
    trafficSource.source AS source,
    ROUND(SUM(product.productRevenue) / 1000000, 4) AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS hits,
       UNNEST(hits.product) AS product
  WHERE _TABLE_SUFFIX BETWEEN '20170601' AND '20170630'
    AND product.productRevenue IS NOT NULL
  GROUP BY time_type, time, source
),

weekly_revenue AS (
  SELECT
    'Week' AS time_type,
    FORMAT_DATE('%Y%V', PARSE_DATE('%Y%m%d', date)) AS time,
    trafficSource.source AS source,
    ROUND(SUM(product.productRevenue) / 1000000, 4) AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS hits,
       UNNEST(hits.product) AS product
  WHERE _TABLE_SUFFIX BETWEEN '20170601' AND '20170630'
    AND product.productRevenue IS NOT NULL
  GROUP BY time_type, time, source
)

SELECT *
FROM monthly_revenue
UNION ALL
SELECT *
FROM weekly_revenue
ORDER BY time_type, time;
