# Ecommerce-Analytics-with-SQL-on-BigQuery
A hands-on SQL project using Google Analytics sample dataset on BigQuery to extract e-commerce insights.
## Summary
This project is an SQL hands-on exercise using the Google Analytics sample dataset on BigQuery to extract key e-commerce insights. The queries are designed to answer key questions about traffic volume, bounce rates, revenue by source, purchasing behavior, and product performance, helping business managers better understand customer journeys and optimize operations.

## Table of Contents
- [Introduction](#introduction)
- [Dataset](#dataset)
- [Methodology](#methodology)
- [Data Visualization](#data-visualization)
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

## Data Visualization
(ảnh)

1.  **Query 01: Monthly Overview (Jan, Feb, Mar 2017)**
    *   **Suggested Chart Type:** Grouped Bar Chart.
        *   X-axis: Month (201701, 201702, 201703).
        *   Y-axis: Count.
        *   Three groups of bars for each month: `total_visits`, `total_pageviews`, `total_transactions`.
    *   **Purpose:** Visually compare key metrics across months.
    *   `<!-- [Insert image: Chart for Query 1 here - e.g., images/query1_monthly_overview.png] -->`

2.  **Query 02: Bounce Rate by Traffic Source (July 2017)**
    *   **Suggested Chart Type:** Two Horizontal Bar Charts.
        *   Chart 1: `total_visits` by `source`.
        *   Chart 2: `bounce_rate` by `source` (Sorted by `total_visits` descending for easy comparison).
    *   **Purpose:** Identify which traffic sources bring the most visits and which have high/low bounce rates.
    *   `<!-- [Insert image: Total Visits by Source chart for Query 2 here - e.g., images/query2_visits_by_source.png] -->`
    *   `<!-- [Insert image: Bounce Rate by Source chart for Query 2 here - e.g., images/query2_bounce_rate_by_source.png] -->`

3.  **Query 03: Revenue by Traffic Source (June 2017 - Monthly & Weekly)**
    *   **Suggested Chart Type:**
        *   For `time_type = 'Month'`: Horizontal Bar Chart showing `revenue` by `source`.
        *   For `time_type = 'Week'`: If there are many weeks and sources, consider a Line Chart with each line representing a `source` across weeks, or a Stacked Bar Chart for each week, with segments representing revenue from different `source`s. (Based on your output, weekly data might not be detailed enough for complex charts; a summary table or simple bar chart for the week with the highest revenue from a particular source might be suitable).
    *   **Purpose:** Identify top revenue-generating traffic sources.
    *   `<!-- [Insert image: Monthly Revenue by Source chart for Query 3 here - e.g., images/query3_monthly_revenue_by_source.png] -->`
    *   (If you visualize weekly data) `<!-- [Insert image: Weekly Revenue Insights chart for Query 3 here - e.g., images/query3_weekly_revenue.png] -->`

4.  **Query 04: Average Pageviews by User Type (June, July 2017)**
    *   **Suggested Chart Type:** Grouped Bar Chart.
        *   X-axis: Month (201706, 201707).
        *   Y-axis: `avg_pageviews`.
        *   Two groups of bars for each month: `avg_pageviews_purchasers` and `avg_pageviews_non_purchasers`.
    *   **Purpose:** Compare engagement levels (pageviews) between purchasers and non-purchasers.
    *   `<!-- [Insert image: Avg Pageviews by User Type chart for Query 4 here - e.g., images/query4_avg_pageviews_user_type.png] -->`

5.  **Query 05: Average Transactions per Purchasing User (July 2017)**
    *   **Suggested Chart Type:** This is a single metric. It can be presented as a "Metric Card" or highlighted text. No complex chart needed.
    *   **Purpose:** Understand the purchase frequency of a typical customer.
    *   *(No chart image needed, but you can insert the query output image in the Insights section)*

6.  **Query 06: Average Amount Spent per Session (July 2017 - Purchasers)**
    *   **Suggested Chart Type:** Similar to Query 5, this is a single metric. Present as a "Metric Card" or text.
    *   **Purpose:** Assess the average value of each purchasing session.
    *   *(No chart image needed, but you can insert the query output image in the Insights section)*

7.  **Query 07: Other Products Purchased with "YouTube Men's Vintage Henley" (July 2017)**
    *   **Suggested Chart Type:** Horizontal Bar Chart.
        *   Y-axis: `other_purchased_product`.
        *   X-axis: `quantity`.
    *   **Purpose:** Discover frequently co-purchased items, suggesting cross-selling opportunities.
    *   `<!-- [Insert image: Co-purchased Products chart for Query 7 here - e.g., images/query7_co_purchased_products.png] -->`

8.  **Query 08: Cohort Analysis (View -> AddToCart -> Purchase) (Jan, Feb, Mar 2017)**
    *   **Suggested Chart Type:**
        *   Ideally, 3 Funnel Charts, one for each month (Jan, Feb, Mar), showing `num_product_view` -> `num_add_to_cart` -> `num_purchase`.
        *   Alternatively, a Line Chart with the X-axis as month, and two lines representing `add_to_cart_rate` and `purchase_rate` across months.
    *   **Purpose:** Track conversion rates through the shopping funnel and their changes over time.
    *   `<!-- [Insert image: Funnel Analysis or Conversion Rates chart for Query 8 here - e.g., images/query8_conversion_funnel.png] -->`

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
    *   Further analyze sources with high bounce rates (e.g., `youtube.com`) to improve landing page experience or traffic quality.
    *   Invest in high-revenue generating channels like `dfa` and `mail.google.com` (based on June 2017 data). Investigate why organic search channels showed lower revenue during this period.
2.  **Enhance User Experience:**
    *   Investigate why non-purchasers view significantly more pages (if the insight from Query 4 is accurate after review). They might be struggling with navigation, product discovery, or a complex checkout process. Simplifying the user flow could boost conversions.
    *   Maintain and enhance factors that contributed to the increased add-to-cart and purchase rates seen in Q1 2017.
3.  **Product and Sales Strategy:**
    *   Leverage information on frequently co-purchased items (Query 7) to create "cross-selling" recommendations (e.g., "Customers who bought X also bought Y") on product pages or in the cart.
    *   Consider promotional bundles based on popular product pairings.
4.  **Continuous Monitoring and Analysis:**
    *   Metrics like average revenue per session and average transactions per user are key KPIs that should be monitored regularly to assess business performance.
    *   Continue tracking the conversion funnel (view -> add to cart -> purchase) to quickly identify bottlenecks and improvement opportunities.

## Setup and Usage
1.  **Requirements:**
    *   Google Cloud Platform (GCP) Account.
    *   Access to Google BigQuery.
2.  **Accessing the Dataset:**
    *   The `bigquery-public-data.google_analytics_sample` dataset is public and can be queried directly in BigQuery.
3.  **Executing Queries:**
    *   Open the Google BigQuery Console.
    *   Copy and paste each SQL query (provided in the `/sql_queries` directory or below) into the query editor.
    *   Run the query to see the results.

## SQL Queries
<!-- You should create a directory, e.g., `sql_queries`, in your repo, and save each query to a separate .sql file (e.g., `query01.sql`, `query02.sql`, ...). Then, you can link to those files. -->
<!-- Example:
- [Query 01: Total Visits, Pageviews, Transactions](./sql_queries/query01.sql)
- [Query 02: Bounce Rate by Traffic Source](./sql_queries/query02.sql)
- ... and so on for the remaining queries
-->
Below is a summary of the questions addressed by the SQL queries. The detailed SQL code for each query can be found in the `sql_queries/` directory of this repository. *(Please create this directory and place your .sql files there)*

*   **Query 01:** Calculate total visit, pageview, transaction for Jan, Feb and March 2017.
*   **Query 02:** Bounce rate per traffic source in July 2017.
*   **Query 03:** Revenue by traffic source by week, by month in June 2017.
*   **Query 04:** Average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017.
*   **Query 05:** Average number of transactions per user that made a purchase in July 2017.
*   **Query 06:** Average amount of money spent per session. Only include purchaser data in July 2017.
*   **Query 07:** Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017.
*   **Query 08:** Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017.

---
*(Optional: Add sections like "Contributing," "License," "Contact" if you wish)*

<!--
## Contributing
If you have ideas for improving this project, please feel free to create a Pull Request or open an Issue.

## License
This project is licensed under the MIT License - see the `LICENSE` file (if present) for details.

## Contact
- Your Name - [your.email@example.com]
- Project Link: [Link to your GitHub repo]
-->
