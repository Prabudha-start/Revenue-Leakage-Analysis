# Revenue Leakage Analysis 🧐

An end-to-end Data Analytics portfolio project investigating revenue leakage, customer behaviour, sales performance, product performance, country-level trends, and returns using Python, SQL, SQLite, Jupyter Notebook, and Power BI.

---

## Project Overview 

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

## Tech Stack

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

## Project Structure

```text
Revenue-Leakage-Analysis/
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
├── requirements.txt
├── .gitignore
└── README.md
```

## 📉 Dashboard Pages

The project includes dashboard views covering the following analytical areas:

### Executive Dashboard

Provides an executive view of business performance, including:

- Total Sales
- Revenue Lost
- Revenue Leakage %
- Total Customers
- Total Orders
- Average Order Value
- Monthly Revenue Trend

### Customer Analysis

Analyzes customer purchasing behaviour and revenue contribution.

Includes:

- Top Customers by Sales
- Customer Revenue Contribution
- Customer Segmentation
- Orders per Customer
- Average Order Value
- Customer Return Analysis

### Country Analysis

Examines geographic sales and return performance.

Includes:

- Sales by Country
- Revenue Leakage by Country
- Returned Orders
- Average Order Value
- Country-level performance comparisons

### Product Analysis

Examines product-level sales and return behaviour.

Includes:

- Top Revenue-generating Products
- Products with Highest Revenue Leakage
- Returned Items
- Revenue Lost by Product
- Product Return Rate

---

## 📈 Key KPIs

- Total Sales
- Revenue Lost
- Revenue Leakage %
- Total Customers
- Total Orders
- Returned Orders
- Average Order Value
- Quantity Sold

---

## 💻 SQL Analysis

The SQL layer contains reusable SQLite analysis covering:

- Executive KPIs
- Sales by Country
- Monthly Revenue Trends
- Customer Analysis
- Customer Segmentation
- Product Performance
- Revenue Leakage by Country, Customer, and Product
- Return Order Metrics
- Time-based Analysis
- Advanced SQL using window functions, ranking, quartiles, and running totals

---

## 🌈 Dashboard Preview

### Executive Dashboard

![Executive Dashboard](images/executive_dashboard.png)

### Customer Analysis Dashboard

![Customer Analysis](images/customer_analysis.png)

### Country Analysis Dashboard

![Country Analysis](images/country_analysis.png)

### Product Analysis Dashboard

![Product Analysis](images/product_analysis.png)

---

## ⏯️ How to Run

Clone the repository:

```bash
git clone https://github.com/Prabudha-start/Revenue-Leakage-Analysis.git
cd Revenue-Leakage-Analysis
```

Create and activate a virtual environment, then install the dependencies:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Open the notebooks in `notebooks/` to review the analysis and use the SQL files in `sql/` with SQLite.

The dashboard preview images are available in `images/`.

---

## 🎭 Skills Demonstrated

- Data Understanding
- Data Cleaning
- Feature Engineering
- Exploratory Data Analysis
- SQL Analytics
- KPI Development
- Business Intelligence
- Data Visualization
- Dashboard Design
- Business Storytelling

---

## 😇 Author

**Prabudha Darabare**

Data Analyst | Prompt Engineer | AI-Assisted Analytics

GitHub:  
https://github.com/Prabudha-start
