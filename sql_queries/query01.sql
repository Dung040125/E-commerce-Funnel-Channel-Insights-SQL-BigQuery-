-- Query 01: Calculate total visits, pageviews, and transactions by month (Jan–Mar 2017)
WITH monthly_metrics AS (
  SELECT
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
      totals.visits AS visits,
      totals.pageviews AS pageviews,
      totals.transactions AS transactions
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170331'
)

SELECT
    month,
    SUM(visits) AS total_visits,
    SUM(pageviews) AS total_pageviews,
    SUM(transactions) AS total_transactions
FROM monthly_metrics
GROUP BY month
ORDER BY month;
