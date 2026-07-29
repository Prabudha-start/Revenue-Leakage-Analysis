DROP TABLE IF EXISTS online_retail;

CREATE TABLE online_retail (
    Invoice TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TEXT,
    Price REAL,
    CustomerID INTEGER,
    Country TEXT,
    Revenue REAL,
    "Invoice Year" INTEGER,
    "Invoice Month" INTEGER,
    "Year-Month" TEXT,
    "Invoice Day" INTEGER,
    "Invoice Hour" INTEGER
);

