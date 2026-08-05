/*==============================================================================
Time Analysis
File: 06_time_analysis.sql

Business Goal
-------------
Analyze monthly sales trends, seasonality, and order performance.

==============================================================================*/

.headers on
.mode box

/*==============================================================================
Query 1: Monthly Revenue Trend
==============================================================================*/

SELECT

    strftime('%Y-%m', InvoiceDate) AS Year_Month,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(SUM(Revenue),2) AS Total_Revenue,

    ROUND(AVG(Revenue),2) AS Average_Sale

FROM online_retail

WHERE Invoice NOT LIKE 'C%'

GROUP BY strftime('%Y-%m', InvoiceDate)

ORDER BY Year_Month;

/*==============================================================================
Query 2: Best Revenue Month
==============================================================================*/

SELECT

    strftime('%Y-%m', InvoiceDate) AS Year_Month,

    ROUND(SUM(Revenue),2) AS Revenue

FROM online_retail

WHERE Invoice NOT LIKE 'C%'

GROUP BY strftime('%Y-%m', InvoiceDate)

ORDER BY Revenue DESC

LIMIT 5;


/*==============================================================================
Query 3: Orders by Weekday
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

ROUND(SUM(Revenue),2) AS Revenue

FROM online_retail

WHERE Invoice NOT LIKE 'C%'

GROUP BY strftime('%w', InvoiceDate)

ORDER BY Orders DESC;



/*==============================================================================
Query 4: Peak Sales Hour
==============================================================================*/

SELECT

strftime('%H', InvoiceDate) AS Hour,

COUNT(DISTINCT Invoice) AS Orders,

ROUND(SUM(Revenue),2) AS Revenue

FROM online_retail

WHERE Invoice NOT LIKE 'C%'

GROUP BY Hour

ORDER BY Orders DESC;