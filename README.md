# 📊 **Project Title:** Ecommerce Analytics with SQL on BigQuery

![image](https://github.com/user-attachments/assets/efa5122d-5aa7-4718-84e4-e2922e9f8418)


* **Author:** Nguyen Thi Thuy Dung
* **Date:** 2025-03
* **Tools Used:** SQL (Google BigQuery)
---

## 📑 Table of Contents
- [📌 Background & Overview](#-background--overview)
- [📂 Dataset Description & Data Structure](#-dataset-description--data-structure)
- [⚒️ Main Process: Data Preparation, SQL Analysis & Insights](#%EF%B8%8F-main-process-data-preparation-sql-analysis--insights)
- [🔎 Final Conclusion & Recommendations](#-final-conclusion--recommendations)
- [📂 Project Files & Setup](#-project-files--setup)

---

## 📌 Background & Overview

### Objective
📖 **What is this project about? What Business Questions will it solve?**

This project is a hands-on SQL exercise utilizing the Google Analytics sample dataset on BigQuery. The primary goal is to extract key e-commerce insights to help business managers better understand customer journeys and optimize operations.

The project aims to answer critical business questions, including:
*   How do key metrics like website visits, pageviews, and transactions trend monthly?
*   What is the bounce rate per traffic source, and which sources are most/least effective?
*   How does revenue vary by traffic source, both weekly and monthly?
*   What are the differences in browsing behavior (average pageviews) between purchasers and non-purchasers?
*   For purchasing users, what is their average number of transactions?
*   What is the average revenue generated per session for purchasing users?
*   Which products are frequently purchased together, indicating cross-selling opportunities?
*   How do customers progress through the purchasing funnel (view → add to cart → purchase), and what are the conversion rates?

👤 **Who is this project for?**
*   Data Analysts & Business Analysts
*   E-commerce Managers & Strategists
*   Marketing Professionals
*   Decision-makers & Stakeholders interested in e-commerce performance.

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

### 2️⃣ Exploratory Data Analysis (EDA) & SQL Analysis Tasks

**Task 01: Monthly Overview (Jan, Feb, Mar 2017)**
*   **Purpose:** Track total visits, pageviews, and transactions monthly for Q1 2017.
*   **SQL Script:** [`query01.sql`](./sql_queries/query01.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/748f8722-7193-4050-a08a-4bc5c36142a9" alt="Query 01 Output: Monthly Overview" width="800">
    </p>
*   **Findings:** Visits & pageviews were stable; **transactions increased, peaking in March**, indicating improved conversion rates.

**Task 02: Bounce Rate by Traffic Source (July 2017)**
*   **Purpose:** Determine bounce rates for different traffic sources.
*   **SQL Script:** [`query02.sql`](./sql_queries/query02.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/ec7d273d-135e-4e4f-a3bf-6a702ef4c788" alt="Query 02 Output: Bounce Rate by Source" width="800">
    </p>
*   **Findings:** Google drove most traffic (moderate bounce rate); **Direct traffic showed higher engagement** (lower bounce rate); YouTube traffic had a high bounce rate.

**Task 03: Revenue by Traffic Source (June 2017)**
*   **Purpose:** Analyze monthly and weekly revenue by traffic source.
*   **SQL Script:** [`query03.sql`](./sql_queries/query03.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/11e68b6d-bc95-4783-b2bc-0f9d9b6c4c7a" alt="Query 03 Output: Revenue by Source" width="600">
    </p>
*   **Findings:** **`(direct)` traffic was the highest revenue generator**. Google organic, `dfa`, and `mail.google.com` also contributed significantly.

**Task 04: Average Pageviews by User Type (June, July 2017)**
*   **Purpose:** Compare average pageviews for purchasers vs. non-purchasers.
*   **SQL Script:** [`query04.sql`](./sql_queries/query04.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/b78b124d-ffa8-46e1-85ba-64138b6d16d5" alt="Query 04 Output: Avg Pageviews by User Type" width="600">
    </p>
*   **Findings:** **Non-purchasers viewed significantly more pages** than purchasers, suggesting different browsing behaviors or potential navigation challenges.

**Task 05: Average Transactions per Purchasing User (July 2017)**
*   **Purpose:** Calculate average transactions per purchasing user.
*   **SQL Script:** [`query05.sql`](./sql_queries/query05.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/c1ab0eb2-a7f4-41b9-a024-06da08674460" alt="Query 05 Output: Avg Transactions per User" width="600">
    </p>
*   **Findings:** Purchasing users averaged **over four transactions**, indicating strong engagement.

**Task 06: Average Amount Spent per Session (July 2017 - Purchasers)**
*   **Purpose:** Determine average revenue per purchasing session.
*   **SQL Script:** [`query06.sql`](./sql_queries/query06.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/a489be89-d309-49e5-9f8e-5548526a4936" alt="Query 06 Output: Avg Revenue per Session" width="600">
    </p>
*   **Findings:** Each purchasing session generated approximately **43.86 units in revenue**.

**Task 07: Other Products Purchased with "YouTube Men's Vintage Henley" (July 2017)**
*   **Purpose:** Identify cross-selling opportunities.
*   **SQL Script:** [`query07.sql`](./sql_queries/query07.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/434ed1dd-a054-42b4-9fe4-05b14e174ac0" alt="Query 07 Output: Co-purchased Products" width="600">
    </p>
*   **Findings:** **"Google Sunglasses" were most frequently co-purchased**, suggesting bundling potential.

**Task 08: Cohort Analysis - Purchase Funnel (Jan, Feb, Mar 2017)**
*   **Purpose:** Analyze customer journey conversion rates.
*   **SQL Script:** [`query08.sql`](./sql_queries/query08.sql)
*   **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/27cfc740-5739-4468-91a9-a3e8408a9257" alt="Query 08 Output: Purchase Funnel" width="1000">
    </p>
*   **Findings:** **Add-to-cart and purchase rates steadily improved** from January to March, indicating increased conversion effectiveness.

---

## 🔎 Final Conclusion & Recommendations
👉🏻 Based on the insights and findings from the SQL queries, the following actions are recommended for the e-commerce and marketing teams:

📌 **Key Takeaways & Recommendations:**
*   ✔️ **Optimize Traffic Sources:** Improve landing pages for high bounce rate sources (e.g., YouTube). Invest in high-performing channels like direct traffic and Google organic.
*   ✔️ **Enhance User Experience & Conversion:** Simplify site navigation for non-purchasers. Build upon strategies that improved Q1 conversion funnel rates.
*   ✔️ **Boost Product & Sales Strategy:** Implement cross-selling based on co-purchase data (e.g., "Google Sunglasses" with "YouTube Henley"). Consider product bundles.
*   ✔️ **Continuous Monitoring:** Regularly track key metrics (avg. revenue/session, transactions/user, conversion rates) for ongoing optimization.

---

## 📂 Project Files & Setup

1.  **SQL Queries:**
    *   All SQL scripts used for analysis are located in the `/sql_queries` directory.
    *   Each task above links directly to its corresponding SQL script (e.g., [`query01.sql`](./sql_queries/query01.sql)).
2.  **Setup Requirements:**
    *   Google Cloud Platform (GCP) Account.
    *   Access to Google BigQuery.
3.  **Accessing the Dataset:**
    *   The `bigquery-public-data.google_analytics_sample` dataset is public and can be queried directly in BigQuery.
4.  **Executing Queries:**
    *   Open the Google BigQuery Console.
    *   Copy and paste the SQL code from the respective file in the `/sql_queries` directory into the query editor.
    *   Run the query to obtain results.
