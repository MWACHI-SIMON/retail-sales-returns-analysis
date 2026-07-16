/* ============================================================================
   ONLINE RETAIL — Sales, Seasonality & Returns Analysis
   Author: Simon Mwachi Masaba
   Data:   Online Retail II (UCI) — real UK online retailer, Dec 2009–Dec 2011
   Table:  retail.transactions  (~1.03M cleaned rows, TransactionType = Sale/Return)
   ============================================================================ */

USE retail;

/* ---- Orientation ---------------------------------------------------------- */

-- Row count (use COUNT(*), not COUNT(column) — Customer ID has ~243K nulls)
SELECT COUNT(*) AS row_count FROM transactions;

-- Sales vs Returns: counts and total revenue
SELECT TransactionType,
       COUNT(*)               AS RowCount,
       ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM transactions
GROUP BY TransactionType;

/* ---- Top products (real merchandise only) --------------------------------- */
-- Excludes operational line items (postage, manual adjustments) that otherwise
-- appear among the "best sellers".
SELECT Description,
       SUM(Quantity)          AS TotalQtySold,
       ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM transactions
WHERE TransactionType = 'Sale'
  AND Description NOT IN ('Manual','POSTAGE','DOTCOM POSTAGE','CARRIAGE',
                          'Adjust bad debt','Discount')
  AND StockCode   NOT IN ('POST','M','D','DOT','C2','BANK CHARGES')
GROUP BY Description
ORDER BY TotalRevenue DESC
LIMIT 10;

/* ---- Seasonality ---------------------------------------------------------- */

-- Monthly revenue timeline (year + month)
SELECT YEAR(InvoiceDate)  AS Yr,
       MONTH(InvoiceDate) AS Mth,
       ROUND(SUM(Revenue), 2) AS MonthlyRevenue
FROM transactions
WHERE TransactionType = 'Sale'
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY Yr, Mth;

-- Peak-season ranking: calendar month across both years
SELECT MONTH(InvoiceDate) AS Mth,
       ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM transactions
WHERE TransactionType = 'Sale'
GROUP BY MONTH(InvoiceDate)
ORDER BY TotalRevenue DESC;

/* ---- Returns analysis (the distinctive hook) ------------------------------ */

-- Monthly sales vs returns side by side (conditional aggregation)
SELECT MONTH(InvoiceDate) AS Mth,
       ROUND(SUM(CASE WHEN TransactionType='Sale'   THEN Revenue ELSE 0 END), 2) AS SalesRevenue,
       ROUND(SUM(CASE WHEN TransactionType='Return' THEN Revenue ELSE 0 END), 2) AS ReturnsValue
FROM transactions
GROUP BY MONTH(InvoiceDate)
ORDER BY Mth;

-- Most-returned genuine products (accounting adjustments excluded)
SELECT Description,
       ABS(SUM(Quantity))     AS QtyReturned,
       ROUND(SUM(Revenue), 2) AS ReturnValue
FROM transactions
WHERE TransactionType = 'Return'
  AND Description NOT IN ('Manual','POSTAGE','DOTCOM POSTAGE','CARRIAGE','Discount',
                          'AMAZON FEE','Bank Charges','CRUK Commission','Adjust bad debt',
                          'SAMPLES','Adjustment')
  AND StockCode   NOT IN ('POST','M','D','DOT','C2','BANK CHARGES','AMAZONFEE',
                          'CRUK','B','S','ADJUST')
GROUP BY Description
ORDER BY ReturnValue ASC;

-- The correction: true product returns vs accounting adjustments
-- (A) genuine product returns
SELECT ROUND(SUM(Revenue), 2) AS TrueProductReturns
FROM transactions
WHERE TransactionType = 'Return'
  AND Description NOT IN ('Manual','POSTAGE','DOTCOM POSTAGE','CARRIAGE','Discount',
                          'AMAZON FEE','Bank Charges','CRUK Commission','Adjust bad debt',
                          'SAMPLES','Adjustment')
  AND StockCode   NOT IN ('POST','M','D','DOT','C2','BANK CHARGES','AMAZONFEE',
                          'CRUK','B','S','ADJUST');
-- (B) accounting adjustments (the contaminant): the complement of the above
