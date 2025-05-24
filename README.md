# 📊 **E-commerce Funnel & Channel Insights (SQL – BigQuery)**
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

This project provides **e-commerce analytics** insights from Google Analytics data (using SQL) to drive **marketing optimization** and inform business strategy.

It answers key questions like:

*   **Performance & Traffic:** How do website metrics and traffic sources impact revenue and engagement?
*   **Customer & Conversion:** How does user behavior influence conversions, and how can the sales funnel be improved?
*   **Sales & Opportunities:** What are key sales trends and potential cross-selling opportunities?

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

---

### 2️⃣ Exploratory Data Analysis (EDA) & SQL Analysis Tasks

This section details the specific SQL analyses performed to answer the business questions outlined in the **[📌 Background & Overview](#-background--overview)**.

**Task 01: Monthly Overview (Jan, Feb, Mar 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Performance & Traffic:** How do website metrics and traffic sources impact revenue and engagement?"
    *   *Purpose:* To track core metrics like total **visits**, **pageviews**, and **transactions** on a monthly basis. This provides a high-level view of website health and performance for Q1 2017, indicating trends in user interaction and **conversion** capabilities.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/6822a7eb-4399-454e-9b71-9205b52c37b8" alt="SQL Code Preview for Task 01" width="700">
    </p>

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/748f8722-7193-4050-a08a-4bc5c36142a9" alt="Query 01 Output: Monthly Overview" width="800">
    </p>
*   💡 **Visits** & **pageviews** were stable; **transactions increased, peaking in March**, indicating improved **conversion rates**.

---

**Task 02: Bounce Rate by Traffic Source (July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Performance & Traffic:** ...how do traffic sources impact ...engagement?"
    *   *Term Definition:* **Bounce Rate** is the percentage of visitors who navigate away from the site after viewing only one page. A high bounce rate can indicate that the landing page content isn't relevant to visitors from a particular source, or that the user experience is poor.
    *   *Purpose:* To determine **bounce rates** for different **traffic sources**. This helps identify which channels are bringing engaged users (low bounce rate) and which may require landing page or targeting optimization to improve **user engagement**.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/0b3d6254-13fe-4e94-9721-39f532d7c4f0" alt="SQL Code Preview for Task 02" width="700">
    </p>

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/ec7d273d-135e-4e4f-a3bf-6a702ef4c788" alt="Query 02 Output: Bounce Rate by Source" width="800">
    </p>
*   💡 Google drove most traffic (moderate **bounce rate**); **Direct traffic** showed **higher engagement** (lower bounce rate); YouTube traffic had a high **bounce rate**.

---

**Task 03: Revenue by Traffic Source (June 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Performance & Traffic:** ...how do traffic sources impact **revenue**?"
    *   *Purpose:* To analyze monthly and weekly **revenue** generated by different **traffic sources**. Understanding which channels drive the most revenue is critical for optimizing marketing spend and focusing efforts on high-value sources.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/497f5095-f74c-4615-bd68-1ede5ebbb272" alt="SQL Code Preview for Task 03" width="700">
    </p>

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/11e68b6d-bc95-4783-b2bc-0f9d9b6c4c7a" alt="Query 03 Output: Revenue by Source" width="600">
    </p>
*   💡 **`(direct)` traffic** was the **highest revenue generator**. Google organic, `dfa`, and `mail.google.com` also contributed significantly.

---

**Task 04: Average Pageviews by User Type (June, July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** How does user behavior influence conversions...?"
    *   *Purpose:* To compare the average number of **pageviews** for users who made a purchase versus those who didn't. This helps understand different browsing behaviors: purchasers might find what they need more efficiently, while non-purchasers might be exploring more broadly or encountering friction. This insight can inform **user experience** improvements.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/97bb4523-27be-446d-b230-9b881128a316" alt="SQL Code Preview for Task 04" width="800">
    </p>

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/b78b124d-ffa8-46e1-85ba-64138b6d16d5" alt="Query 04 Output: Avg Pageviews by User Type" width="600">
    </p>
*   💡 **Non-purchasers** viewed significantly more **pages** than **purchasers**, suggesting different browsing behaviors or potential navigation challenges.

---

**Task 05: Average Transactions per Purchasing User (July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** How does user behavior influence conversions...?"
    *   *Purpose:* To calculate the average number of **transactions** made by users who completed at least one purchase. This metric indicates customer loyalty or repeat purchase frequency, an important aspect of **customer lifetime value**.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/bf345c26-81f6-477e-b21e-69aaa9b3aea4" alt="SQL Code Preview for Task 05" width="800">
    </p>

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/c1ab0eb2-a7f4-41b9-a024-06da08674460" alt="Query 05 Output: Avg Transactions per User" width="600">
    </p>
*   💡 Purchasing users averaged **over four transactions**, indicating strong **engagement**.

---

**Task 06: Average Amount Spent per Session (July 2017 - Purchasers)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** How does user behavior influence conversions?" and "**Sales & Opportunities:** What are key sales trends...?"
    *   *Purpose:* To determine the average **revenue** generated per session for users who made a purchase. This helps quantify the monetary value of a converting session and can inform ROI calculations for marketing efforts.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/5d769ea2-ceb7-4f49-bbda-09f5b2fde9a1" alt="SQL Code Preview for Task 06" width="800">
    </p>

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/a489be89-d309-49e5-9f8e-5548526a4936" alt="Query 06 Output: Avg Revenue per Session" width="600">
    </p>
*   💡 Each purchasing session generated approximately **43.86 units in revenue**.

---

**Task 07: Other Products Purchased with "YouTube Men's Vintage Henley" (July 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Sales & Opportunities:** ...what are potential **cross-selling** opportunities?"
    *   *Purpose:* To identify products frequently bought together (a basic form of market basket analysis). This is valuable for uncovering **cross-selling** or **bundling** opportunities, which can increase the average order value.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/f0b8da05-44e9-4176-9e78-10f8d818533e" alt="SQL Code Preview for Task 07" width="900">
    </p>

*   🖼️ **Result Snapshot:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/479b9231-9f8a-416f-892d-fa1c08be89c2" alt="Query 07 Output: Co-purchased Products" width="700">
    </p>
*   💡 "**Google Sunglasses**" were most frequently co-purchased, suggesting **bundling potential**.

---

**Task 08: Cohort Analysis - Purchase Funnel (Jan, Feb, Mar 2017)**
*   🎯 **Business Context & Analytical Purpose:**
    *   *Answers:* "**Customer & Conversion:** ...how can the sales **funnel** be improved?"
    *   *Term Definition:* A **Purchase Funnel** (or **Conversion Funnel**) describes the **customer journey** through various stages from initial awareness to final purchase (e.g., View Product → Add to Cart → Complete Purchase). **Cohort Analysis** here involves tracking groups of users (cohorts) as they move through this funnel over time.
    *   *Purpose:* To analyze **conversion rates** at each key step of the **customer journey**. This helps identify drop-off points (bottlenecks) in the **funnel** and measure the impact of any changes or marketing efforts on **conversion** effectiveness over time.
*   📄 **SQL Code Preview:**
    <p align="center">
      <img src="https://github.com/user-attachments/assets/ee02243c-db49-4c33-8e80-54fe1c5b59c7" alt="SQL Code Preview for Task 08 (Part 1)" width="900">
    </p>
    <p align="center">
      <img src="https://github.com/user-attachments/assets/6ed66208-6c51-435b-aeca-a0b55dcef11c" alt="SQL Code Preview for Task 08 (Part 2)" width="900">
    </p>

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
