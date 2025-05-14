--Query 04: Average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017.
WITH purchaser_data AS (
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    COUNT(DISTINCT fullVisitorId) AS num_users,
    SUM(totals.pageviews) AS total_pageviews
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS hits,
       UNNEST(hits.product) AS product
  WHERE _TABLE_SUFFIX BETWEEN '20170601' AND '20170731'
    AND totals.transactions >= 1
    AND product.productRevenue IS NOT NULL
  GROUP BY month
),

non_purchaser_data AS (
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    COUNT(DISTINCT fullVisitorId) AS num_users,
    SUM(totals.pageviews) AS total_pageviews
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS hits,
       UNNEST(hits.product) AS product
  WHERE _TABLE_SUFFIX BETWEEN '20170601' AND '20170731'
    AND totals.transactions IS NULL
    AND product.productRevenue IS NULL
  GROUP BY month
)

SELECT
  COALESCE(p.month, np.month) AS month,
  ROUND(p.total_pageviews / p.num_users, 4) AS avg_pageviews_purchase,
  ROUND(np.total_pageviews / np.num_users, 4) AS avg_pageviews_non_purchase
FROM purchaser_data p
FULL JOIN non_purchaser_data np
  ON p.month = np.month
ORDER BY month;
