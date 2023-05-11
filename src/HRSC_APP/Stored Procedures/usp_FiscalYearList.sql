




CREATE   PROCEDURE [HRSC_APP].[usp_FiscalYearList]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- Fiscal Year: get a list
-- E.Akhmetova, 2013/05/08
------------------------------------------------------
SELECT 
	FISCAL_YEAR AS FiscalYear,
	FISCAL_YEAR_START_DATE AS Start,
	FISCAL_YEAR_END_DATE AS [End],
	FISCAL_YEAR_ID AS ID
FROM HRSC.CD_FISCAL_YEAR
WHERE EXPIRY_DATE IS NULL
ORDER BY FISCAL_YEAR DESC
