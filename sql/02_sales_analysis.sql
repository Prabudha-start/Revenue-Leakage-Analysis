/*==============================================================================
PROJECT      : Revenue Leakage Analysis
FILE         : 02_sales_analysis.sql

QUERY 1
Sales by Country

Business Question
-----------------
Which countries generate the highest revenue?

Business Value
--------------
Identifies the company's strongest geographic markets by comparing
sales performance, order volume, average order value, and highest
transaction value.

==============================================================================*/

.headers on
.mode box

SELECT
    Country,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Revenue),
        2
    ) AS Total_Revenue,

    ROUND(
        SUM(Revenue) * 1.0 /
        COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value,

    ROUND(
        MAX(Revenue),
        2
    ) AS Highest_Order

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND Country <> 'Country'
  AND TRIM(Country) <> ''

GROUP BY Country

ORDER BY Total_Revenue DESC;

/*==============================================================================
QUERY 2
Monthly Revenue Trend

Business Question
-----------------
How has monthly revenue changed over time?

Business Value
--------------
Measures month-over-month sales performance and identifies growth
or decline trends for executive reporting.
==============================================================================*/

.headers on
.mode box

WITH MonthlySales AS (

    SELECT
        "Year-Month",
        ROUND(SUM(Revenue), 2) AS Monthly_Revenue

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'
      AND "Year-Month" <> 'Year-Month'

    GROUP BY "Year-Month"

)

SELECT
    "Year-Month",

    Monthly_Revenue,

    LAG(Monthly_Revenue) OVER (
        ORDER BY "Year-Month"
    ) AS Previous_Month_Revenue,

    ROUND(
        Monthly_Revenue -
        LAG(Monthly_Revenue) OVER (
            ORDER BY "Year-Month"
        ),
        2
    ) AS Revenue_Change,

    ROUND(
        CASE
            WHEN LAG(Monthly_Revenue) OVER (
                ORDER BY "Year-Month"
            ) IS NULL
            THEN NULL

            ELSE
                (
                    (Monthly_Revenue -
                    LAG(Monthly_Revenue) OVER (
                        ORDER BY "Year-Month"
                    ))
                    * 100.0
                ) /
                LAG(Monthly_Revenue) OVER (
                    ORDER BY "Year-Month"
                )
        END,
        2
    ) AS Growth_Percentage

FROM MonthlySales;