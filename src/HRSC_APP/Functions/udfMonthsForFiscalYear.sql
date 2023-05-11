-- =============================================
-- Author:		Elena Akhmetova
-- Create date: 2012/11/16
-- Description:	Used for reports: all month start and dates for a fiscal year
-- =============================================
CREATE   FUNCTION [HRSC_APP].[udfMonthsForFiscalYear]
(
	@FiscalYear  int
)
RETURNS 
@Months TABLE (MonthStart DATETIME, MonthEND DATETIME, MonthNo INT)
AS

--declare @FiscalYear  int = 2012
BEGIN

	DECLARE 
	@Start DATETIME = DATEADD(day,0,DATEADD(MONTH,((@FiscalYear-1900)*12)+3,0)), 
	@End DATETIME = DATEADD(day,30,DATEADD(MONTH,(((@FiscalYear + 1)-1900)*12)+2,0))

	;WITH Months AS (
		SELECT 
			@Start AS MonthStart
	UNION ALL
		SELECT DATEADD(MONTH, 1, MonthStart) AS MonthStart
		FROM Months
		WHERE MonthStart < DATEADD(MONTH, 11, @Start)
	)
	
	INSERT INTO @Months
	SELECT 
		MonthStart, 
		DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,MonthStart)+1,0)) AS MonthEND, 
		MONTH(MonthStart) AS MonthNo
	FROM Months

	RETURN 
END
