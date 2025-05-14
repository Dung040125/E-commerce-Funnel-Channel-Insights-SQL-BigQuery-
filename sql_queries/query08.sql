--"Query 08: Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017. For example, 100% product view then 40% add_to_cart and 10% purchase.
--Add_to_cart_rate = number product  add to cart/number product view. Purchase_rate = number product purchase/number product view. The output should be calculated in product level."

WITH product_stats AS (
  -- Query for Jan 2017
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    product.v2ProductName AS product_name,
    COUNTIF(hits.eCommerceAction.action_type = '2') AS num_product_view,
    COUNTIF(hits.eCommerceAction.action_type = '3') AS num_add_to_cart,
    COUNTIF(hits.eCommerceAction.action_type = '6' AND product.productRevenue IS NOT NULL) AS num_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201701*`,
       UNNEST(hits) AS hits,
       UNNEST(hits.product) AS product
  WHERE hits.eCommerceAction.action_type IN ('2', '3', '6')
  GROUP BY month, product_name
  
  UNION ALL
  
  -- Query for Feb 2017
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    product.v2ProductName AS product_name,
    COUNTIF(hits.eCommerceAction.action_type = '2') AS num_product_view,
    COUNTIF(hits.eCommerceAction.action_type = '3') AS num_add_to_cart,
    COUNTIF(hits.eCommerceAction.action_type = '6' AND product.productRevenue IS NOT NULL) AS num_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201702*`,
       UNNEST(hits) AS hits,
       UNNEST(hits.product) AS product
  WHERE hits.eCommerceAction.action_type IN ('2', '3', '6')
  GROUP BY month, product_name
  
  UNION ALL
  
  -- Query for Mar 2017
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    product.v2ProductName AS product_name,
    COUNTIF(hits.eCommerceAction.action_type = '2') AS num_product_view,
    COUNTIF(hits.eCommerceAction.action_type = '3') AS num_add_to_cart,
    COUNTIF(hits.eCommerceAction.action_type = '6' AND product.productRevenue IS NOT NULL) AS num_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201703*`,
       UNNEST(hits) AS hits,
       UNNEST(hits.product) AS product
  WHERE hits.eCommerceAction.action_type IN ('2', '3', '6')
  GROUP BY month, product_name
)

-- Final aggregation and calculation
SELECT
  product_stats.month,
  SUM(product_stats.num_product_view) AS num_product_view,
  SUM(product_stats.num_add_to_cart) AS num_add_to_cart,
  SUM(product_stats.num_purchase) AS num_purchase,
  ROUND((SUM(product_stats.num_add_to_cart) * 100.0 / NULLIF(SUM(product_stats.num_product_view), 0)), 2) AS add_to_cart_rate,
  ROUND((SUM(product_stats.num_purchase) * 100.0 / NULLIF(SUM(product_stats.num_product_view), 0)), 2) AS purchase_rate
FROM product_stats
GROUP BY product_stats.month
ORDER BY product_stats.month;
