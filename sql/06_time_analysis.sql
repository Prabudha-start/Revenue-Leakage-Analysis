/*==============================================================================
PROJECT      : Revenue Leakage Analysis
FILE         : 06_time_analysis.sql

BUSINESS GOAL
-------------
Analyze sales timing to identify monthly trends, seasonality,
high-performing weekdays, and peak trading hours.

==============================================================================*/

.headers on
.mode box


/*==============================================================================
QUERY 1
Monthly Revenue Trend

Business Question
-----------------
How does revenue and order volume change month by month?

==============================================================================*/

SELECT
    strftime('%Y-%m', InvoiceDate) AS Year_Month,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Revenue),
        2
    ) AS Total_Revenue,

    ROUND(
        SUM(Revenue) * 1.0 /
        COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND InvoiceDate IS NOT NULL
  AND InvoiceDate <> ''

GROUP BY strftime('%Y-%m', InvoiceDate)

ORDER BY Year_Month;


/*==============================================================================
QUERY 2
Best Revenue Months

Business Question
-----------------
Which months generated the highest revenue?

==============================================================================*/

SELECT
    strftime('%Y-%m', InvoiceDate) AS Year_Month,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Revenue),
        2
    ) AS Total_Revenue,

    ROUND(
        SUM(Revenue) * 1.0 /
        COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND InvoiceDate IS NOT NULL
  AND InvoiceDate <> ''

GROUP BY strftime('%Y-%m', InvoiceDate)

ORDER BY Total_Revenue DESC

LIMIT 5;


/*==============================================================================
QUERY 3
Orders by Weekday

Business Question
-----------------
Which weekdays generate the highest order volume and revenue?

==============================================================================*/

SELECT
    CASE strftime('%w', InvoiceDate)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS Weekday,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Revenue),
        2
    ) AS Revenue

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND InvoiceDate IS NOT NULL
  AND InvoiceDate <> ''

GROUP BY strftime('%w', InvoiceDate)

ORDER BY Orders DESC;


/*==============================================================================
QUERY 4
Peak Sales Hour

Business Question
-----------------
During which hours is order activity highest?

==============================================================================*/

SELECT
    strftime('%H', InvoiceDate) AS Hour,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Revenue),
        2
    ) AS Revenue

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND InvoiceDate IS NOT NULL
  AND InvoiceDate <> ''

GROUP BY strftime('%H', InvoiceDate)

ORDER BY Orders DESC;
