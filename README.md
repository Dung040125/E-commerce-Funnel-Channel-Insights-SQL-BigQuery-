# 📊 **E-commerce Funnel & Channel Insights (SQL – BigQuery)**
![image](https://github.com/user-attachments/assets/efa5122d-5aa7-4718-84e4-e2922e9f8418)


* **Author:** Nguyen Thi Thuy Dung
* **Date:** 2025-03
* **Tools Used:** SQL (Google BigQuery)
---

## 📑 Table of Contents
[📌 Background & Overview](#-background--overview)  
[📂 Dataset Description & Data Structure](#-dataset-description--data-structure)  
[⚒️ Main Process: Data Preparation, SQL Analysis & Insights](#%EF%B8%8F-main-process-data-preparation-sql-analysis--insights)  
[🔎 Final Conclusion & Recommendations](#-final-conclusion--recommendations)  
[🌟 Key Personal Takeaways](#-key-personal-takeaways)

---

## 📌 Background & Overview

### Objective
📖 **What is this project about? What Business Questions will it solve?**

This project provides **e-commerce analytics** insights from Google Analytics data (using SQL) to drive **marketing optimization** and inform business strategy.

It answers key questions like:

*   **Performance & Traffic:** How do website metrics and traffic sources impact revenue and engagement?
*   **Customer & Conversion:** How does user behavior influence conversions, and how can the sales funnel be improved?
*   **Sales & Opportunities:** What are key sales trends and potential cross-selling opportunities?

👤 **Who is this project for?**
*   Data Analysts & Business Analysts
*   E-commerce Managers & Stakeholders interested in e-commerce performance
*   Marketing Professionals

---

## 📂 Dataset Description & Data Structure

📌 **Data Source**
*   **Source:** Google Analytics Sample Dataset on Google BigQuery (Public dataset from the Google Merchandise Store).
*   **Size:** Contains 1 year of data (Aug 2016 - Aug 2017), with ~903k session rows in `ga_sessions_YYYYMMDD`.
*   **Format:** BigQuery tables with nested and repeated fields (JSON-like).
*   **Time Period Analyzed:** January 2017 to July 2017.

📊 **Data Structure & Relationships**
*   **Primary Table:** `ga_sessions_*` (sharded daily tables).
*   **Key Schema Elements Used:** `fullVisitorId`, `visitId`, `date`, `totals` (record with `visits`, `hits`, `pageviews`, `transactions`, `bounces`), `trafficSource` (record with `source`, `medium`), and `hits` (repeated record with `type`, `product` details, `eCommerceAction` details).
*   **Schema Reference:** For a complete schema, refer to the [Google Analytics Export Schema documentation](https://support.google.com/analytics/answer/3437719?hl=en).

---

## ⚒️ Main Process: Data Preparation, SQL Analysis & Insights

This project involved key data preparation and analysis steps performed directly via SQL queries in Google BigQuery. Detailed SQL scripts for each task are available in the `/sql_queries` directory.

### 1️⃣ Data Preparation & Preprocessing (Performed via SQL)
Key data preparation steps embedded within the SQL queries included:
*   **Schema Traversal:** Navigating nested fields (e.g., `hits`, `hits.product`) using `UNNEST()`.
*   **Data Type Handling:** Converting `productRevenue` to its actual monetary value.
*   **Filtering:** Selecting data by date ranges and specific conditions (e.g., `totals.transactions >=1`).
*   **Metric Calculation:** Deriving metrics like bounce rate and conversion rates.
*   **Session & User Identification:** Utilizing `fullVisitorId` and `visitId`.

---

### 2️⃣ Exploratory Data Analysis (EDA) & SQL Analysis Tasks

This section details the specific SQL analyses performed to answer the business questions outlined in the **[📌 Background & Overview](#-background--overview)**.

#### Task 01: Monthly Overview (Jan, Feb, Mar 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Performance & Traffic:** How do website metrics and traffic sources impact revenue and engagement?"
    *   *Purpose:* To track core metrics like total **visits**, **pageviews**, and **transactions** on a monthly basis. This provides a high-level view of website health and performance for Q1 2017, indicating trends in user interaction and **conversion** capabilities.
*   📄 **SQL Code:**
    ```sql
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
    ```
*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/748f8722-7193-4050-a08a-4bc5c36142a9" alt="Query 01 Output: Monthly Overview" width="800">
    </p>
*   💡 **Visits** & **pageviews** were stable; **transactions increased, peaking in March**, indicating improved **conversion rates**.

---

### Task 02: Bounce Rate by Traffic Source (July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Performance & Traffic:** ...how do traffic sources impact ...engagement?"
    *   *Term Definition:* **Bounce Rate** is the percentage of visitors who navigate away from the site after viewing only one page. A high bounce rate can indicate that the landing page content isn't relevant to visitors from a particular source, or that the user experience is poor.
    *   *Purpose:* To determine **bounce rates** for different **traffic sources**. This helps identify which channels are bringing engaged users (low bounce rate) and which may require landing page or targeting optimization to improve **user engagement**.
*   📄 **SQL Code:**
    ```sql
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
    ```

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/ec7d273d-135e-4e4f-a3bf-6a702ef4c788" alt="Query 02 Output: Bounce Rate by Source" width="800">
    </p>
*   💡 Google drove most traffic (moderate **bounce rate**); **Direct traffic** showed **higher engagement** (lower bounce rate); YouTube traffic had a high **bounce rate**.

---

### Task 03: Revenue by Traffic Source (June 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Performance & Traffic:** ...how do traffic sources impact **revenue**?"
    *   *Purpose:* To analyze monthly and weekly **revenue** generated by different **traffic sources**. Understanding which channels drive the most revenue is critical for optimizing marketing spend and focusing efforts on high-value sources.
*   📄 **SQL Code:**
    ```sql
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
    ```

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/11e68b6d-bc95-4783-b2bc-0f9d9b6c4c7a" alt="Query 03 Output: Revenue by Source" width="600">
    </p>
*   💡 **`(direct)` traffic** was the **highest revenue generator**. Google organic, `dfa`, and `mail.google.com` also contributed significantly.

---

### Task 04: Average Pageviews by User Type (June, July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** How does user behavior influence conversions...?"
    *   *Purpose:* To compare the average number of **pageviews** for users who made a purchase versus those who didn't. This helps understand different browsing behaviors: purchasers might find what they need more efficiently, while non-purchasers might be exploring more broadly or encountering friction. This insight can inform **user experience** improvements.
*   📄 **SQL Code:**
    ```sql
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
    ```

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/b78b124d-ffa8-46e1-85ba-64138b6d16d5" alt="Query 04 Output: Avg Pageviews by User Type" width="600">
    </p>
*   💡 **Non-purchasers** viewed significantly more **pages** than **purchasers**, suggesting different browsing behaviors or potential navigation challenges.

---

### Task 05: Average Transactions per Purchasing User (July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** How does user behavior influence conversions...?"
    *   *Purpose:* To calculate the average number of **transactions** made by users who completed at least one purchase. This metric indicates customer loyalty or repeat purchase frequency, an important aspect of **customer lifetime value**.
*   📄 **SQL Code:**
    ```sql
    --Query 05: Average number of transactions per user that made a purchase in July 2017
    SELECT
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
      ROUND(SUM(totals.transactions) / COUNT(DISTINCT fullVisitorId), 4) AS avg_transactions_per_user
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE totals.transactions >= 1
      AND product.productRevenue IS NOT NULL
    GROUP BY month;
    ```

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/c1ab0eb2-a7f4-41b9-a024-06da08674460" alt="Query 05 Output: Avg Transactions per User" width="600">
    </p>
*   💡 Purchasing users averaged **over four transactions**, indicating strong **engagement**.

---

### Task 06: Average Amount Spent per Session (July 2017 - Purchasers)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** How does user behavior influence conversions?" and "**Sales & Opportunities:** What are key sales trends...?"
    *   *Purpose:* To determine the average **revenue** generated per session for users who made a purchase. This helps quantify the monetary value of a converting session and can inform ROI calculations for marketing efforts.
*   📄 **SQL Code:**
    ```sql
    --Query 06: Average amount of money spent per session. Only include purchaser data in July 2017
    SELECT
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
      ROUND(SUM(product.productRevenue) / SUM(totals.visits) / 1e6, 2) AS avg_revenue_per_session
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE totals.transactions >= 1
      AND product.productRevenue IS NOT NULL
    GROUP BY month;
    ```

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/a489be89-d309-49e5-9f8e-5548526a4936" alt="Query 06 Output: Avg Revenue per Session" width="600">
    </p>
*   💡 Each purchasing session generated approximately **43.86 units in revenue**.

---

### Task 07: Other Products Purchased with "YouTube Men's Vintage Henley" (July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Sales & Opportunities:** ...what are potential **cross-selling** opportunities?"
    *   *Purpose:* To identify products frequently bought together (a basic form of market basket analysis). This is valuable for uncovering **cross-selling** or **bundling** opportunities, which can increase the average order value.
*   📄 **SQL Code:**
    ```sql
    --Query 07: Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. 
    --Output should show product name and the quantity was ordered.
    WITH buyer_list AS (
      SELECT DISTINCT fullVisitorId
      FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
           UNNEST(hits) AS hits,
           UNNEST(hits.product) AS product
      WHERE product.v2ProductName = "YouTube Men's Vintage Henley"
        AND totals.transactions >= 1
        AND product.productRevenue IS NOT NULL
    )
   
    SELECT
      product.v2ProductName AS other_purchased_product,
      SUM(product.productQuantity) AS quantity
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    JOIN buyer_list USING(fullVisitorId)
    WHERE product.v2ProductName != "YouTube Men's Vintage Henley"
      AND product.productRevenue IS NOT NULL
    GROUP BY other_purchased_product
    ORDER BY quantity DESC;
    ```

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/479b9231-9f8a-416f-892d-fa1c08be89c2" alt="Query 07 Output: Co-purchased Products" width="700">
    </p>
*   💡 "**Google Sunglasses**" were most frequently co-purchased, suggesting **bundling potential**.

---

### Task 08: Cohort Analysis - Purchase Funnel (Jan, Feb, Mar 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** ...how can the sales **funnel** be improved?"
    *   *Term Definition:* A **Purchase Funnel** (or **Conversion Funnel**) describes the **customer journey** through various stages from initial awareness to final purchase (e.g., View Product → Add to Cart → Complete Purchase). **Cohort Analysis** here involves tracking groups of users (cohorts) as they move through this funnel over time.
    *   *Purpose:* To analyze **conversion rates** at each key step of the **customer journey**. This helps identify drop-off points (bottlenecks) in the **funnel** and measure the impact of any changes or marketing efforts on **conversion** effectiveness over time.
*   📄 **SQL Code:**
    ```sql
    --"Query 08: Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017. 
    --For example, 100% product view then 40% add_to_cart and 10% purchase.
    --Add_to_cart_rate = number product  add to cart/number product view. Purchase_rate = number product purchase/number product view. 
    --The output should be calculated in product level."
   
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
    ```

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/27cfc740-5739-4468-91a9-a3e8408a9257" alt="Query 08 Output: Purchase Funnel" width="1000">
    </p>
*   💡 **Add-to-cart** and **purchase rates** steadily **improved** from January to March, indicating increased **conversion effectiveness**.

---

## 🔎 Final Conclusion & Recommendations
👉🏻 Based on the insights and findings from the SQL queries, the following actions are recommended for the e-commerce and marketing teams:

📌 **Key Takeaways & Recommendations:**
*   ✔️ **Optimize Traffic Sources:** Improve landing pages for high bounce rate sources (e.g., YouTube). Invest in high-performing channels like direct traffic and Google organic.
*   ✔️ **Enhance User Experience & Conversion:** Simplify site navigation for non-purchasers. Build upon strategies that improved Q1 conversion funnel rates.
*   ✔️ **Boost Product & Sales Strategy:** Implement cross-selling based on co-purchase data (e.g., "Google Sunglasses" with "YouTube Henley"). Consider product bundles.
*   ✔️ **Continuous Monitoring:** Regularly track key metrics (avg. revenue/session, transactions/user, conversion rates) for ongoing optimization.

---
## 🌟 Key Personal Takeaways

This project was more than just SQL practice; it was a journey in refining analytical thinking:

*   **Structuring Ambiguity:** Sharpened my ability to translate often ambiguous **business questions** into clear, **data-driven insights**.
*   **Thinking in Flows:** Working with **nested data** in BigQuery (especially user session data) pushed me to think in terms of user flows and journeys—how users move, **convert**, and interact across channels—rather than isolated data points.
*   **Connecting Data to Decisions:** Most importantly, this project trained me to constantly ask "So what?" – to bridge the gap between raw numbers, meaningful insights, and ultimately, actionable **business decisions**.
*   **Strategic Data Application:** Beyond technical confidence with SQL and BigQuery, I developed a stronger sense of how data directly supports **strategy formulation** and drives concrete actions.

---
