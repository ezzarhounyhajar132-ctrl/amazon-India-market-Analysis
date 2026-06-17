#  Amazon India Market Insights — Data Analysis (SQL + Excel + Power BI)

---

## Project Overview

This project presents a complete end-to-end data analytics workflow applied to an Amazon India product dataset sourced from Kaggle.

It covers data cleaning and transformation using SQL, exploratory data analysis to identify pricing and rating trends, and the development of interactive dashboards in both Excel and Power BI.

The goal is to analyze product distribution, pricing strategies, discount patterns, and customer ratings across categories to derive meaningful market insights.

---

## Tools & Technologies

- MySQL 8.0
- SQL (Window Functions, Aggregations, CASE statements)
- Microsoft Excel (Pivot Tables, Pivot Charts, Dashboard & Analysis)
- Power BI Desktop (Interactive Dashboard, DAX Measures)
- GitHub (Version Control)

---

## Project Structure

- `amazon_cleaning.sql` — SQL scripts for cleaning and standardizing the dataset
- `amazon_eda.sql` — SQL exploratory data analysis queries
- `amazon_dashboard_excel.xlsx` — Excel interactive dashboard
- `amazon_dashboard_powerbi.pbix` — Power BI dashboard
- `screenshots/` — dashboard screenshots & demos
- `README.md` — project documentation

---

## Data Source

The dataset was sourced from [Kaggle — Amazon Sales Dataset](https://www.kaggle.com/) and contains real Amazon India product listings with pricing, discounts, ratings, and review counts.

---

## Dataset Highlights

- Total Raw Products: 1,465
- Total Clean Products: 1,151
- Total Categories: 8
- Price Range: ₹150 — ₹125,000
- Discount Range: 0% — 94%
- Rating Range: 2.0 — 5.0

---

## Data Cleaning Steps

- Created a working copy table to preserve raw data (`amazon` → `amazon_cleaned` → `amazon_final`)
- Removed `₹` currency symbol from discounted_price and actual_price columns
- Removed `%` symbol from discount column
- Removed comma and space separators from numeric columns
- Replaced corrupted rating values (`|`) with NULL
- Replaced literal string `"null"` in rating_count with NULL
- Dropped irrelevant columns (about_product, user_id, user_name, review_id, review_title, review_content, img_link, product_link)
- Truncated product names to first 8 words for display using `SUBSTRING_INDEX()`
- Extracted main category from pipe-separated category values
- Removed duplicate products using `ROW_NUMBER()` partitioned by product_name_short
- Converted all columns to correct data types (DECIMAL, INT)

---

## Exploratory Data Analysis (EDA)

- Identified top 5 categories by product count and average price
- Analyzed top 10 most reviewed products by rating_count
- Examined average discount percentage by category
- Explored correlation between discount level and customer rating
- Investigated price range distribution across Budget / Mid / Premium segments
- Identified categories with the highest percentage of zero-discount products
- Analyzed average rating consistency across all categories

---

## Dashboards

### Excel Dashboard

Interactive dashboard using Pivot Tables, Pivot Charts, and Slicers.

Includes:
- Total Products · Most Reviewed Product · Top Category KPIs
- Top Categories by Product Count (Pie Chart)
- Average Rating by Category (Bar Chart)
- Average Discount by Category (Bar Chart)
- Average Prices by Category (Bar Chart)
- Price Range Distribution (Donut Chart)
- Most Reviewed Products (Bar Chart)
- Interactive filtering by Price Range

### Power BI Dashboard

Interactive dashboard with dynamic filtering and DAX measures.

Features:
- KPI Cards (Total Products, Avg Discount, Avg Rating, Most Reviewed, Top Category)
- Price Range Distribution (Donut Chart)
- Top Categories by Average Price (Table)
- Average Discount by Category (Bar Chart)
- Discount vs Rating Correlation (Scatter Plot)
- Average Rating by Category (Bar Chart)
- Most Reviewed Products (Horizontal Bar Chart)
- Price Range Slicer
- Overview & Insights navigation pages

---

## Dashboard Preview

### Excel Dashboard
![Overview_excel](screenshots/Overview_Amazon_excel.png)

![Insights_excel](screenshots/Insights_Amazon_excel.png)

![excel gif](screenshots/gif_Amazon_excel.png)

### Power BI Dashboard
![Overview_powerbi](screenshots/Overview_Amazon_powerbi.png)

![Insights_powerbi](screenshots/Insights_Amazon_powerbi.png)

![Gif_powerbi](screenshots/gif_Amazon_powerbi.png)

---

## Key Insights

- Electronics leads with ₹9,719 average price — 2.3x higher than the overall average
- HomeImprovement offers the steepest discounts at 58% average
- Toys&Games has 0% average discount yet maintains the highest rating of 4.3
- No strong correlation found between discount level and customer rating
- All categories maintain consistently strong ratings between 3.8 and 4.3 out of 5
- Amazon Basics High Speed HDMI Cable is the most reviewed product with 426,973 ratings
- Home&Kitchen dominates with 436 products — 38% of the entire catalog
- 44.74% of products fall in the Premium (>₹2,000) range — Amazon India skews premium
- OfficeProducts is the smallest category with only 29 products

---

## Notes

- The dataset is a product catalog, not a transactional sales dataset — no order IDs, dates, or quantities sold are available, which limits revenue analysis.
- Duplicate products were caused by multiple review entries per product and time-based scraping. Resolved by aggregating to one row per product.

---

## Data Pipeline

- Raw Amazon CSV (Kaggle)
- Data Cleaning & Transformation (MySQL)
- Exploratory Data Analysis (MySQL)
- Data Export to Excel & Power BI
- Dashboard Development in Excel
- Dashboard Development in Power BI

---

## Author

**HajarEzzy**
SQL | Excel | Power BI | Data Analytics
[GitHub: HajarEzzy](https://github.com/HajarEzzy)
