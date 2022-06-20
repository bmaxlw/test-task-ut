-- MS SQL Server-based syntax used

-- Task #1:
-- If partition needed only by dates and countries are applied just as general a filter.
SELECT [Date],
       COUNT(DISTINCT userId) RealUsers
FROM registration
-- <WHERE> here works with <GROUP BY> since it filters 
-- the <SELECT> stmt and not <GROUP BY> itself
WHERE TestType = 1 
      AND CAST([Date] AS NVARCHAR)
      BETWEEN '2022-01-01' AND '2022-04-31'
      AND Country IN ( 'US', 'GB', 'MX', 'CA', 'IE' )
GROUP BY [Date];

-- If partition needed both by dates and by countries
SELECT DISTINCT [Date],
       Country,
       COUNT(userId) OVER (PARTITION BY [Date], Country) RealUsers
FROM registration
WHERE TestType = 1
      AND CAST([Date] AS NVARCHAR)
      BETWEEN '2022-01-01' AND '2022-04-31'
      AND Country IN ( 'US', 'GB', 'MX', 'CA', 'IE' )
ORDER BY [Date]

-- Task #2:
SELECT DISTINCT
    [Date],
    SUM(PriceAmount) OVER (PARTITION BY ([Date])) TotalAmount
FROM Payments
WHERE TestType = 1
      AND TransactionStatus = 2
      AND CAST([Date] AS NVARCHAR)
      BETWEEN '2021-01-01' AND '2021-12-31';
