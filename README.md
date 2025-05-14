# Ecommerce-Analytics-with-SQL-on-BigQuery
A hands-on SQL project using Google Analytics sample dataset on BigQuery to extract e-commerce insights.
## Summary
This project is an SQL hands-on exercise using the Google Analytics sample dataset on BigQuery to extract key e-commerce insights. The queries are designed to answer key questions about traffic volume, bounce rates, revenue by source, purchasing behavior, and product performance, helping business managers better understand customer journeys and optimize operations.

## Table of Contents
- [Introduction](#introduction)
- [Dataset](#dataset)
- [Methodology](#methodology)
- [Results & Analysis (Insights)](#results--analysis-insights)
- [Recommendations](#recommendations)
- [Setup and Usage](#setup-and-usage)
- [SQL Queries](#sql-queries)

## Introduction
In the e-commerce domain, understanding customer behavior and website performance is crucial. This project leverages SQL on Google Analytics data to answer key business questions such as traffic trends, bounce rates by source, revenue distribution, user engagement, and product purchase patterns.

## Dataset
- **Data Source:** Google Analytics Sample Dataset on Google BigQuery.
    - This is a public dataset containing obfuscated Google Analytics data from the Google Merchandise Store, a real e-commerce website that sells Google-branded merchandise.
    - Time period: January to July 2017
    - Detailed Schema Reference: [Google Analytics Export Schema](https://support.google.com/analytics/answer/3437719?hl=en)
- **Data Description:**
    - The data includes information about user sessions, traffic sources, on-page behavior (pageviews, events), transaction information (products, revenue), and user demographics and geographic information.
    - The data is structured with nested fields, requiring the `UNNEST` technique in SQL for access.
- **Data Preprocessing:**
    - Key preprocessing steps are performed directly within the SQL queries, including:
        - Filtering data by specific time ranges (e.g., month, year).
        - `UNNEST`ing nested fields to access detailed data (e.g., `hits`, `hits.product`).
        - Calculating derived metrics (e.g., `bounce_rate`, `add_to_cart_rate`, `purchase_rate`).
        - Handling `NULL` values where necessary for accurate calculations (e.g., `productRevenue IS NOT NULL`).

## Methodology
- **Tools & Language:**
    - Language: SQL (Google BigQuery Standard SQL dialect)
    - Platform: Google BigQuery
- **Analysis Process:**
    The project was carried out by building and executing 08 SQL queries, each designed to answer a specific analytical question:
    1.  Calculate total visits, pageviews, and transactions monthly.
    2.  Analyze bounce rate by traffic source (7/2017)
    3.  Track revenue by traffic source weekly and monthly (6/2017, weekly & monthly)
    4.  Compare average pageviews between purchasers and non-purchasers (6-7/2017)
    5.  Calculate the average number of transactions per purchasing user (7/2017)
    6.  Calculate the average amount spent per session by purchasers (7/2017)
    7.  Identify other products purchased alongside a specific product (7/2017)
    8.  Perform a cohort analysis of the customer journey: from product view to add-to-cart to purchase (1-3/2017)

## Results & Analysis (Insights)
**Query 01: Monthly Overview (Jan, Feb, Mar 2017)**
![image](https://github.com/user-attachments/assets/748f8722-7193-4050-a08a-4bc5c36142a9)
*   **Insight 1:** Visits and pageviews remained relatively stable during the first quarter of 2017, with a slight dip in February.
*   **Insight 2:** However, transactions steadily increased, peaking in March, indicating improved conversion rates. This suggests that the website became more effective at turning visitors into buyers over time, possibly due to marketing efforts or UX improvements.

**Query 02: Bounce Rate by Traffic Source (July 2017)**
![image](https://github.com/user-attachments/assets/ec7d273d-135e-4e4f-a3bf-6a702ef4c788)

*   **Insight 1:** Google drives most traffic but has a moderate bounce rate. 
*   **Insight 2:** Direct traffic has lower bounce, indicating higher engagement. 
*   **Insight 3:** YouTube traffic has high bounce, suggesting landing page optimization needed.

**Query 03: Revenue by Traffic Source (June 2017)**

![image](https://github.com/user-attachments/assets/11e68b6d-bc95-4783-b2bc-0f9d9b6c4c7a)




*   **Insight 1:** The direct traffic source generates the highest revenue by a large margin (~97,333.62 units), significantly outperforming all other sources in June 2017.
*   **Insight 2:** Google organic traffic is the second-highest revenue source (~18,757.18 units), followed by dfa (~8,862.23 units) and mail.google.com (~2,563.13 units).
*   **Insight 3:** Other sources such as groups.google.com, search.myway.com, and dealspotr.com contribute modest revenue amounts (under 150 units).

*   **Insight 4:** This distribution highlights the critical importance of direct and branded traffic channels for revenue generation, with paid or referral sources contributing less but still meaningful revenue.

*   **Insight 5:** Weekly data show fluctuations but maintain the same general ranking of revenue sources.

**Query 04: Average Pageviews by User Type (June, July 2017)**
![image](https://github.com/user-attachments/assets/b78b124d-ffa8-46e1-85ba-64138b6d16d5)

*   **Insight 1:** Non-purchasers consistently view about three times more pages than purchasers, which may indicate browsing without purchase intent or difficulty finding products.
*   **Insight 2:** Purchasers tend to navigate more efficiently, possibly because they know what they want. Improving site navigation could help convert more browsers into buyers.

**Query 05: Average Transactions per Purchasing User (July 2017)**
![image](https://github.com/user-attachments/assets/c1ab0eb2-a7f4-41b9-a024-06da08674460)

*   **Insight 1:** Each purchasing user completed on average over four transactions in July, indicating strong repeat purchase behavior or multiple purchases per session. This reflects high customer engagement and loyalty during this period. 
*   **Insight 2:** Businesses can capitalize on this by focusing on retention and personalized marketing.

**Query 06: Average Amount Spent per Session (July 2017 - Purchasers)**
![image](https://github.com/user-attachments/assets/a489be89-d309-49e5-9f8e-5548526a4936)

*   **Insight:** Each purchasing session generates an average revenue of 43.86 units.

**Query 07: Other Products Purchased with "YouTube Men's Vintage Henley" (July 2017)**
![image](https://github.com/user-attachments/assets/434ed1dd-a054-42b4-9fe4-05b14e174ac0)

*   **Insight 1:** The most frequently co-purchased product with "YouTube Men's Vintage Henley" is Google Sunglasses with 20 units sold alongside.
*   **Insight 2:** Other notable co-purchased items include various apparel such as Google Women's Vintage Hero Tee Black, SPF-15 Slim & Slender Lip Balm, and Google Women's Short Sleeve Hero Tee Red Heather.
*   **Insight 3:** The diversity of products purchased together ranges from clothing to accessories and branded merchandise, indicating cross-selling potential across multiple product categories.
*   **Insight 4:** This data can guide targeted recommendations and bundle offers to increase average order value and improve customer experience.

**Query 08: Cohort Analysis (View -> AddToCart -> Purchase) (Jan, Feb, Mar 2017)**
![image](https://github.com/user-attachments/assets/27cfc740-5739-4468-91a9-a3e8408a9257)

*   **Insight 1:** Conversion funnel rates improved steadily from January to March, with add-to-cart rates increasing by nearly 9 percentage points and purchase rates by over 4 points. This indicates successful optimization efforts and better customer journey management. 
*   **Insight 2:** Tracking these metrics helps identify bottlenecks and improve overall sales performance.

## Recommendations
Based on the analysis above, here are some potential recommendations:
1.  **Optimize Traffic Sources:**
    *   Reduce bounce rates by improving landing pages and traffic quality, especially for sources like youtube.com.
    *   Increase investment in high-revenue channels such as dfa, mail.google.com, and direct traffic.
2.  **Enhance User Experience:**
    *   Simplify navigation and the purchase process to convert browsers into buyers, particularly non-purchasers who view many pages.
    *   Maintain factors that contributed to higher add-to-cart and purchase rates in Q1 2017.
3.  **Product & Sales Strategy:**
    *   Implement cross-selling strategies based on co-purchase data (e.g., Google Sunglasses with apparel).
    *   Create promotional bundles from popular product pairings to increase average order value.
4.  **Continuous Monitoring and Analysis:**
    *   Regularly track key metrics such as average revenue per session and average transactions per buyer.
    *   Continuously optimize the conversion funnel from product view to purchase to improve sales performance.

## Setup and Usage
1.  **Requirements:**
    *   Google Cloud Platform (GCP) Account.
    *   Access to Google BigQuery.
2.  **Accessing the Dataset:**
    *   The `bigquery-public-data.google_analytics_sample` dataset is public and can be queried directly in BigQuery.
3.  **Executing Queries:**
    *   Open the Google BigQuery Console.
    *   Copy and paste each SQL query from the /sql_queries directory into the query editor.
    *   Run each query to obtain the results.
    *   Export query results as needed for visualization or reporting purposes.

## SQL Queries
Below is a summary of the questions addressed by the SQL queries. The detailed SQL code for each query can be found in the `sql_queries/` directory of this repository.

*   **Query 01:** Calculate total visit, pageview, transaction for Jan, Feb and March 2017 - [View SQL](./sql_queries/query01.sql)
*   **Query 02:** Bounce rate per traffic source in July 2017 - [View SQL](./sql_queries/query02.sql)
*   **Query 03:** Revenue by traffic source by week, by month in June 2017 - [View SQL](./sql_queries/query03.sql)
*   **Query 04:** Average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017 - [View SQL](./sql_queries/query04.sql)
*   **Query 05:** Average number of transactions per user that made a purchase in July 2017 - [View SQL](./sql_queries/query05.sql)
*   **Query 06:** Average amount of money spent per session. Only include purchaser data in July 2017 - [View SQL](./sql_queries/query06.sql)
*   **Query 07:** Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017 - [View SQL](./sql_queries/query07.sql)
*   **Query 08:** Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017 - [View SQL](./sql_queries/query08.sql)
