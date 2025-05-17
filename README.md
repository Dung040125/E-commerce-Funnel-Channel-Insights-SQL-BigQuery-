# 📊 Project Title: Ecommerce Analytics with SQL on BigQuery
Author: Nguyen Thi Thuy Dung
Date: 2025-03
Tools Used: SQL (Google BigQuery)

---
📑 Table of Contents
📌 Background & Overview
📂 Dataset Description & Data Structure
⚒️ Main Process: Data Preparation, SQL Analysis & Insights
🔎 Final Conclusion & Recommendations
📂 Project Files & Setup

---
📌 Background & Overview
Objective:
📖 **What is this project about? What Business Question will it solve?**
This project is a hands-on SQL exercise utilizing the Google Analytics sample dataset on BigQuery. The primary goal is to extract key e-commerce insights to help business managers better understand customer journeys and optimize operations.

The project aims to answer critical business questions such as:
✔️ How do key metrics like website visits, pageviews, and transactions trend monthly?
✔️ What is the bounce rate per traffic source, and which sources are most/least effective?
✔️ How does revenue vary by traffic source, both weekly and monthly?
✔️ What are the differences in browsing behavior (average pageviews) between customers who make a purchase and those who don't?
✔️ For purchasing users, what is the average number of transactions?
✔️ What is the average revenue generated per session for purchasing users?
✔️ Which products are frequently purchased together, suggesting cross-selling opportunities?
✔️ How do customers progress through the purchasing funnel (product view -> add to cart -> purchase), and what are the conversion rates at each step?

👤 **Who is this project for?**
This project can be beneficial for:
✔️ Data Analysts & Business Analysts
✔️ E-commerce Managers & Strategists
✔️ Marketing Professionals
✔️ Decision-makers & Stakeholders interested in e-commerce performance.

---
📂 Dataset Description & Data Structure
📌 **Data Source**
*   **Source:** Google Analytics Sample Dataset on Google BigQuery. This is a public dataset containing obfuscated Google Analytics data from the Google Merchandise Store.
*   **Size:** The dataset contains 1 year of data (August 1, 2016, to August 1, 2017) from the Google Merchandise Store. It consists of daily session data, with a total of ~903k rows in the `ga_sessions_YYYYMMDD` wildcard table.
*   **Format:** Data is stored in Google BigQuery tables, with a schema that includes nested and repeated fields (JSON-like structure).
*   **Time Period Analyzed:** January 2017 to July 2017.

---
📊 **Data Structure & Relationships**
1️⃣ **Tables Used:**
The primary data source is a set of sharded tables in BigQuery, collectively referred to as `ga_sessions_*`.

2️⃣ **Table Schema:**
The `ga_sessions_*` table has a complex nested schema. Key fields and structures used include `fullVisitorId`, `visitId`, `date`, `totals` (containing `visits`, `hits`, `pageviews`, `transactions`, `bounces`), `trafficSource` (with `source`, `medium`), and `hits` (a repeated record with `type`, `product` details like `v2ProductName`, `productRevenue`, `productQuantity`, and `eCommerceAction` details like `action_type`).

👉🏻 **Schema Reference:** For a complete and detailed schema, please refer to the [Google Analytics Export Schema documentation](https://support.google.com/analytics/answer/3437719?hl=en).

⚒️ **Main Process: Data Preparation, SQL Analysis & Insights**
This project involved several key data preparation and analysis steps performed directly via SQL queries in Google BigQuery. The detailed SQL scripts for each analysis task can be found in the `/sql_queries` directory.

1️⃣ **Data Preparation & Preprocessing (Performed via SQL):**
Prior to analysis, data from the `ga_sessions_*` tables underwent several preparation steps embedded within the SQL queries:
*   **Schema Traversal:** Navigating nested and repeated fields (e.g., `hits`, `hits.product`, `hits.eCommerceAction`) using `UNNEST()` to flatten data structures for easier querying.
*   **Data Type Handling:** Converting `productRevenue` (stored as an integer) to its actual monetary value by dividing by 1,000,000.
*   **Filtering:** Selecting relevant data subsets based on date ranges (e.g., Jan-Jul 2017) and specific conditions (e.g., filtering for actual purchases using `totals.transactions >=1` or `product.productRevenue IS NOT NULL`).
*   **Metric Calculation:** Deriving key metrics such as bounce rate (`totals.bounces / totals.visits`), add-to-cart rate, and purchase rate as part of the SQL queries.
*   **Session & User Identification:** Utilizing `fullVisitorId` and `visitId` for user and session-level aggregations.

2️⃣ **Exploratory Data Analysis (EDA) & SQL Analysis Tasks:**

**Task 01: Monthly Overview (Jan, Feb, Mar 2017)**
*   **Purpose:** To calculate and track total visits, pageviews, and transactions monthly for Q1 2017.
*   **SQL Script:** [`query01.sql`](./sql_queries/query01.sql)
*   **Result Snapshot:**
    ![Query 01 Output](https://github.com/user-attachments/assets/748f8722-7193-4050-a08a-4bc5c36142a9)
*   **Findings:**
    ✔️ Visits and pageviews were relatively stable; transactions steadily increased, peaking in March, indicating improved conversion rates.

**Task 02: Bounce Rate by Traffic Source (July 2017)**
*   **Purpose:** To determine the bounce rate for different traffic sources in July 2017.
*   **SQL Script:** [`query02.sql`](./sql_queries/query02.sql)
*   **Result Snapshot:**
    ![Query 02 Output](https://github.com/user-attachments/assets/ec7d273d-135e-4e4f-a3bf-6a702ef4c788)
*   **Findings:**
    ✔️ Google drove most traffic (moderate bounce rate); Direct traffic showed higher engagement (lower bounce rate); YouTube traffic had a high bounce rate.

**Task 03: Revenue by Traffic Source (June 2017 - Monthly & Weekly)**
*   **Purpose:** To analyze revenue generated by different traffic sources monthly and weekly for June 2017.
*   **SQL Script:** [`query03.sql`](./sql_queries/query03.sql)
*   **Result Snapshot:**
    ![Query 03 Output](https://github.com/user-attachments/assets/11e68b6d-bc95-4783-b2bc-0f9d9b6c4c7a)
*   **Findings:**
    ✔️ `(direct)` traffic was the highest revenue generator. Google organic, `dfa`, and `mail.google.com` also contributed significantly.

**Task 04: Average Pageviews by User Type (June, July 2017)**
*   **Purpose:** To compare average pageviews for purchasers vs. non-purchasers.
*   **SQL Script:** [`query04.sql`](./sql_queries/query04.sql)
*   **Result Snapshot:**
    ![Query 04 Output](https://github.com/user-attachments/assets/b78b124d-ffa8-46e1-85ba-64138b6d16d5)
*   **Findings:**
    ✔️ Non-purchasers viewed significantly more pages than purchasers, suggesting different browsing behaviors or navigation challenges.

**Task 05: Average Transactions per Purchasing User (July 2017)**
*   **Purpose:** To calculate the average number of transactions per purchasing user in July 2017.
*   **SQL Script:** [`query05.sql`](./sql_queries/query05.sql)
*   **Result Snapshot:**
    ![Query 05 Output](https://github.com/user-attachments/assets/c1ab0eb2-a7f4-41b9-a024-06da08674460)
*   **Findings:**
    ✔️ Purchasing users averaged over four transactions, indicating strong engagement or multiple purchases.

**Task 06: Average Amount Spent per Session (July 2017 - Purchasers)**
*   **Purpose:** To determine the average revenue per purchasing session in July 2017.
*   **SQL Script:** [`query06.sql`](./sql_queries/query06.sql)
*   **Result Snapshot:**
    ![Query 06 Output](https://github.com/user-attachments/assets/a489be89-d309-49e5-9f8e-5548526a4936)
*   **Findings:**
    ✔️ Each purchasing session generated approximately 43.86 units in revenue.

**Task 07: Other Products Purchased with "YouTube Men's Vintage Henley" (July 2017)**
*   **Purpose:** To identify cross-selling opportunities by finding products frequently bought with a specific item.
*   **SQL Script:** [`query07.sql`](./sql_queries/query07.sql)
*   **Result Snapshot:**
    ![Query 07 Output](https://github.com/user-attachments/assets/434ed1dd-a054-42b4-9fe4-05b14e174ac0)
*   **Findings:**
    ✔️ "Google Sunglasses" were most frequently co-purchased, along with other apparel, suggesting bundling potential.

**Task 08: Cohort Analysis - Purchase Funnel (Jan, Feb, Mar 2017)**
*   **Purpose:** To analyze customer journey conversion rates from product view to add-to-cart to purchase for Q1 2017.
*   **SQL Script:** [`query08.sql`](./sql_queries/query08.sql)
*   **Result Snapshot:**
    ![Query 08 Output](https://github.com/user-attachments/assets/27cfc740-5739-4468-91a9-a3e8408a9257)
*   **Findings:**
    ✔️ Add-to-cart and purchase rates steadily improved from January to March, indicating increased conversion effectiveness.

---
🔎 Final Conclusion & Recommendations
👉🏻 Based on the insights and findings from the SQL queries, we would recommend the e-commerce and marketing teams to consider the following:

📌 **Key Takeaways & Recommendations:**
✔️ **Optimize Traffic Sources:** Improve landing pages for high bounce rate sources (e.g., YouTube). Invest in high-performing channels like direct traffic and Google organic.
✔️ **Enhance User Experience & Conversion:** Simplify site navigation for non-purchasers. Build upon strategies that improved Q1 conversion funnel rates.
✔️ **Boost Product & Sales Strategy:** Implement cross-selling based on co-purchase data (e.g., "Google Sunglasses" with "YouTube Henley"). Consider product bundles.
✔️ **Continuous Monitoring:** Regularly track key metrics (avg. revenue/session, transactions/user, conversion rates) for ongoing optimization.

---
📂 Project Files & Setup
1.  **SQL Queries:** All SQL scripts used for analysis are located in the `/sql_queries` directory. You can find individual scripts for each task (e.g., `query01.sql`, `query02.sql`, etc.) there.
2.  **Setup Requirements:**
    *   Google Cloud Platform (GCP) Account.
    *   Access to Google BigQuery.
3.  **Accessing the Dataset:**
    *   The `bigquery-public-data.google_analytics_sample` dataset is public and can be queried directly in BigQuery.
4.  **Executing Queries:**
    *   Open the Google BigQuery Console.
    *   Copy and paste the SQL code from the respective file in the `/sql_queries` directory into the query editor.
    *   Run the query to obtain results.
