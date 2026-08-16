# 📊 Revenue Leakage Analysis

An end-to-end Data Analytics portfolio project investigating revenue leakage, customer behaviour, sales performance, product performance, country-level trends, and returns using Python, SQL, SQLite, Jupyter Notebook, and Power BI.

---

## 📌 Project Overview

Revenue leakage can reduce realized sales through returns and other transaction-level issues. This project uses an online retail dataset to investigate sales performance and identify where returned transactions create measurable revenue loss.

The analysis covers:

- Revenue and sales KPIs
- Revenue leakage from returned transactions
- Customer purchasing behaviour
- Product performance and return patterns
- Country-level sales and return trends
- Monthly and time-based performance
- Advanced SQL analysis
- Executive dashboard reporting

The project demonstrates a complete analytics workflow from raw data preparation through business analysis and dashboard storytelling.

---

## 🚀 Tech Stack

- Python
- Pandas
- NumPy
- Matplotlib
- Plotly
- SQL
- SQLite
- SQLAlchemy
- Jupyter Notebook
- Power BI
- Git
- GitHub

---

## 📂 Project Structure

```text
Revenue-Leakage-Analysis/
│
├── dashboard/
│   └── Revenue_Leakage_Dashboard.pbix
│
├── data/
│   ├── raw/
│   │   └── online_retail_II.xlsx
│   └── cleaned/
│       └── online_retail_cleaned.csv
│
├── images/
│   ├── executive_dashboard.png
│   ├── customer_analysis.png
│   ├── country_analysis.png
│   └── product_analysis.png
│
├── notebooks/
│   ├── 01_data_understanding.ipynb
│   ├── 02_data_cleaning.ipynb
│   ├── 03_feature_engineering.ipynb
│   └── 04_exploratory_analysis.ipynb
│
├── reports/
│
├── sql/
│   ├── 00_schema.sql
│   ├── 01_executive_kpis.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_product_analysis.sql
│   ├── 05_revenue_leakage.sql
│   ├── 06_time_analysis.sql
│   └── 07_advanced_sql.sql
│
├── src/
│
├── requirements.txt
├── .gitignore
└── README.md
