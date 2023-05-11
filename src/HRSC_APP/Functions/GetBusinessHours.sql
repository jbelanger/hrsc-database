



/*================
Created by:		Elena Akhmetova 
Creation Date:	2012-11-27
Description:	Used in several report SPs: 
calculation of business hours (from 7.30 to 19.00) with no 
holidays (common for all provinces, no special ones) and weekends.
==================*/
CREATE   FUNCTION [HRSC_APP].[GetBusinessHours] (
	@StartDate DATETIME
	,@EndDate DATETIME
	,@FY BIT
	)
RETURNS FLOAT
AS
/*TEST*/
--DECLARE	
--@StartDate DATETIME = '2013/04/01',
--@EndDate DATETIME = '2013/05/31 11:59:59 PM',
--@FY BIT = 0
BEGIN
	-------------
	/*since it is always same hours- predefined 
but could be set as Function parameters for each week day
*/
	DECLARE @DayStart TIME = '7:30 AM'
		,@DayEnd TIME = '7:00 PM'
	DECLARE @YearS INT = DATEPART(YEAR, @StartDate)
		,@YearE INT = DATEPART(YEAR, @EndDate)
	DECLARE @StartDateFiscal DATETIME
		,@EndDateFiscal DATETIME

	IF @FY = 1
	BEGIN
		SELECT @StartDateFiscal = FISCAL_YEAR_START_DATE
			,@EndDateFiscal = FISCAL_YEAR_END_DATE
		FROM HRSC.CD_FISCAL_YEAR
		WHERE FISCAL_YEAR = @YearS
			AND EXPIRY_DATE IS NOT NULL
	END
	ELSE
	BEGIN
		SELECT @StartDateFiscal = @StartDate
			,@EndDateFiscal = @EndDate
	END

	/*
    EASTER CALCULATION
	Source of algorithm : Nature, 1876 April 20, vol. 13, p. 487
	Converted to T-SQL : Robert Davis, February 6, 2005
	*/
	/* INTeger variables for mathematical computations */
	DECLARE @a INT
		,@b INT
		,@c INT
		,@d INT
		,@e INT
		,@f INT
		,@g INT
		,@h INT
		,@i INT
		,@k INT
		,@l INT
		,@m INT
		,@p INT
		,@Year INT
	/* INTeger variables for mathematical results */
	DECLARE @EasterMonth INT
		,@EasterDay INT
	DECLARE @Easter DATETIME
		,@EasterS DATETIME
		,@EasterE DATETIME
		,@GoodFriday DATETIME
		,@GoodFridayS DATETIME
		,@GoodFridayE DATETIME
		,@EasterMonday DATETIME
		,@EasterMondayS DATETIME
		,@EasterMondayE DATETIME
		,@NewYear DATETIME
		,@VictoriaDay DATETIME
		,@CanadaDay DATETIME
		,@ChristmasDay DATETIME
		,@RememberanceDay DATETIME
		,@BoxingDay DATETIME

	--IF @Year < 1582 -- oldest year for which algorithm works
	--    BEGIN
	--		SET @Easter = NULL--Year2Easter() expects a 4 digit year => 1582.''
	--    END
	--ELSE
	BEGIN
		SET @Year = @YearS
		SET @a = @Year % 19
		SET @b = @Year / 100
		SET @c = @Year % 100
		SET @d = @b / 4
		SET @e = @b % 4
		SET @f = (@b + 8) / 25
		SET @g = (@b - @f + 1) / 3
		SET @h = (19 * @a + @b - @d - @g + 15) % 30
		SET @i = @c / 4
		SET @k = @c % 4
		SET @l = (32 + 2 * @e + 2 * @i - @h - @k) % 7
		SET @m = (@a + 11 * @h + 22 * @l) / 451
		SET @EasterMonth = (@h + @l - 7 * @m + 114) / 31 -- [3 = March, 4 = April]
		SET @p = (@h + @l - 7 * @m + 114) % 31
		SET @EasterDay = @p + 1 -- Day of the month

		SELECT @EasterS = CONVERT(DATETIME, Cast(@Year AS VARCHAR) + '/' + CONVERT(VARCHAR, @EasterMonth) + '/' + Cast(@EasterDay AS VARCHAR))
	END

	SELECT @EasterMonth = NULL
		,@EasterDay = NULL
		,@Year = NULL
		,@a = NULL
		,@b = NULL
		,@c = NULL
		,@d = NULL
		,@e = NULL
		,@f = NULL
		,@g = NULL
		,@h = NULL
		,@i = NULL
		,@k = NULL
		,@l = NULL
		,@m = NULL
		,@p = NULL

	BEGIN
		SET @Year = @YearE
		SET @a = @Year % 19
		SET @b = @Year / 100
		SET @c = @Year % 100
		SET @d = @b / 4
		SET @e = @b % 4
		SET @f = (@b + 8) / 25
		SET @g = (@b - @f + 1) / 3
		SET @h = (19 * @a + @b - @d - @g + 15) % 30
		SET @i = @c / 4
		SET @k = @c % 4
		SET @l = (32 + 2 * @e + 2 * @i - @h - @k) % 7
		SET @m = (@a + 11 * @h + 22 * @l) / 451
		SET @EasterMonth = (@h + @l - 7 * @m + 114) / 31 -- [3 = March, 4 = April]
		SET @p = (@h + @l - 7 * @m + 114) % 31
		SET @EasterDay = @p + 1 -- Day of the month

		SELECT @EasterE = CONVERT(DATETIME, Cast(@Year AS VARCHAR) + '/' + CONVERT(VARCHAR, @EasterMonth) + '/' + Cast(@EasterDay AS VARCHAR))
	END

	SELECT @GoodFridayS = DATEADD(DAY, - 2, @EasterS)

	SELECT @GoodFridayE = DATEADD(DAY, - 2, @EasterE)

	SELECT @EasterMondayS = DATEADD(DAY, 1, @EasterS)

	SELECT @EasterMondayE = DATEADD(DAY, 1, @EasterE)

	IF @GoodFridayS BETWEEN @StartDate
			AND @EndDate
		SET @GoodFriday = @GoodFridayS
	ELSE IF @GoodFridayE BETWEEN @StartDate
			AND @EndDate
		SET @GoodFriday = @GoodFridayE

	IF @EasterMondayS BETWEEN @StartDate
			AND @EndDate
		SET @EasterMonday = @EasterMondayS
	ELSE IF @EasterMondayE BETWEEN @StartDate
			AND @EndDate
		SET @EasterMonday = @EasterMondayE

	IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate) + 1) + '/01/01') BETWEEN @StartDate
			AND @EndDate
		SET @NewYear = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate) + 1) + '/01/01')
	ELSE IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate) + 1) + '/01/01') BETWEEN @StartDate
			AND @EndDate
		SET @NewYear = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate) + 1) + '/01/01')

	IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/05/25') BETWEEN @StartDate
			AND @EndDate
		SET @VictoriaDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/05/25')
	ELSE IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/05/25') BETWEEN @StartDate
			AND @EndDate
		SET @VictoriaDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/05/25')

	IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/07/01') BETWEEN @StartDate
			AND @EndDate
		SET @CanadaDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/07/01')
	ELSE IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/07/01') BETWEEN @StartDate
			AND @EndDate
		SET @CanadaDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/07/01')

	IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/11/11') BETWEEN @StartDate
			AND @EndDate
		SET @RememberanceDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/11/11')
	ELSE IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/11/11') BETWEEN @StartDate
			AND @EndDate
		SET @RememberanceDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/11/11')

	IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/12/26') BETWEEN @StartDate
			AND @EndDate
		SET @BoxingDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/12/26')
	ELSE IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/12/26') BETWEEN @StartDate
			AND @EndDate
		SET @BoxingDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/12/26')

	IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/12/25') BETWEEN @StartDate
			AND @EndDate
		SET @ChristmasDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@StartDate)) + '/12/25')
	ELSE IF CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/12/25') BETWEEN @StartDate
			AND @EndDate
		SET @ChristmasDay = CONVERT(DATETIME, CONVERT(VARCHAR, Year(@EndDate)) + '/12/25')

	------------------
	DECLARE @AllYear TABLE (
		WeekRank INT
		,StartDate DATETIME
		,DayNo INT
		,WeekNo INT
		,MonthNo INT
		)
	DECLARE @Holidays TABLE (
		Name VARCHAR(100)
		,StartDate DATETIME
		)
	DECLARE @Counter INT
		,@ThanksgivingDay DATETIME
		,@LabourDay DATETIME
	DECLARE @Calendar TABLE (
		DayNo VARCHAR(50)
		,Name VARCHAR(50)
		,StartTime TIME
		,EndTime TIME
		,Duration FLOAT
		)
		--All dates, day numbers, months, weeks in given fiscal year 
		;

	WITH AllYear
	AS (
		SELECT @StartDateFiscal AS StartDate
			,DATEPART(WEEKDAY, @StartDateFiscal) AS DayNo
			,DATEPART(WEEK, @StartDateFiscal) AS WeekNo
			,DATEPART(MONTH, @StartDateFiscal) AS MonthNo
		
		UNION ALL
		
		SELECT DATEADD(DAY, 1, StartDate) AS StartDate
			,DATEPART(WEEKDAY, DATEADD(DAY, 1, StartDate)) AS DayNo
			,DATEPART(WEEK, DATEADD(DAY, 1, StartDate)) AS WeekNo
			,DATEPART(MONTH, DATEADD(DAY, 1, StartDate)) AS MonthNo
		FROM AllYear
		WHERE StartDate < @EndDateFiscal
		)
	--define week orders per month: week numbers 49,50,51,52 set as 1,2,3,4	
	INSERT INTO @AllYear
	SELECT DENSE_RANK() OVER (
			PARTITION BY MonthNo ORDER BY WeekNo
			) AS WeekRank
		,*
	FROM AllYear
	OPTION (MAXRECURSION 1000)

	--Find TnxGiving and Labor days	
	SELECT @Counter = COUNT(*)
	FROM @AllYear
	WHERE MonthNo = 10
		AND WeekRank = 1
		AND DayNo = 2

	IF @Counter > 0
		SELECT @ThanksgivingDay = StartDate
		FROM @AllYear
		WHERE MonthNo = 10
			AND WeekRank = 2
			AND DayNo = 2
	ELSE
		SELECT @ThanksgivingDay = StartDate
		FROM @AllYear
		WHERE MonthNo = 10
			AND WeekRank = 3
			AND DayNo = 2

	SELECT @Counter = COUNT(*)
	FROM @AllYear
	WHERE MonthNo = 9
		AND WeekRank = 1
		AND DayNo = 2

	IF @Counter > 0
		SELECT @LabourDay = StartDate
		FROM @AllYear
		WHERE MonthNo = 9
			AND WeekRank = 1
			AND DayNo = 2
	ELSE
		SELECT @LabourDay = StartDate
		FROM @AllYear
		WHERE MonthNo = 9
			AND WeekRank = 2
			AND DayNo = 2

	--All statutory holidays without weekend considaration 	
	INSERT INTO @Holidays
	SELECT 'New Year''s Day'
		,@NewYear
	
	UNION
	
	SELECT 'Good Friday'
		,@GoodFriday
	
	UNION
	
	SELECT 'Easter Monday'
		,@EasterMonday
	
	UNION
	
	SELECT 'Victoria Day'
		,@VictoriaDay
	
	UNION
	
	SELECT 'Canada Day'
		,@CanadaDay
	
	UNION
	
	SELECT 'Labour Day'
		,@LabourDay
	
	UNION
	
	SELECT 'Thanksgiving Day'
		,@ThanksgivingDay
	
	UNION
	
	SELECT 'Rememberance Day'
		,@RememberanceDay
	
	UNION
	
	SELECT 'Christmas Day'
		,@ChristmasDay
	
	UNION
	
	SELECT 'Boxing Day'
		,@BoxingDay

	--Move statutory holidays if weekend
	UPDATE @Holidays
	SET StartDate = CASE 
			WHEN DATEPART(WEEKDAY, StartDate) = 1
				THEN DATEADD(DAY, 1, StartDate)
			WHEN DATEPART(WEEKDAY, StartDate) = 7
				THEN DATEADD(DAY, 2, StartDate)
			ELSE StartDate
			END

	--businees hours for each business day
	INSERT INTO @Calendar
	--SELECT 1, 'Sunday', @DayStart, @DayEnd, DATEDIFF(SECOND,@DayStart,@DayEnd)
	--UNION
	SELECT 2
		,'Monday'
		,@DayStart
		,@DayEnd
		,DATEDIFF(SECOND, @DayStart, @DayEnd)
	
	UNION
	
	SELECT 3
		,'Tuesday'
		,@DayStart
		,@DayEnd
		,DATEDIFF(SECOND, @DayStart, @DayEnd)
	
	UNION
	
	SELECT 4
		,'Wednesday'
		,@DayStart
		,@DayEnd
		,DATEDIFF(SECOND, @DayStart, @DayEnd)
	
	UNION
	
	SELECT 5
		,'Thursday'
		,@DayStart
		,@DayEnd
		,DATEDIFF(SECOND, @DayStart, @DayEnd)
	
	UNION
	
	SELECT 6
		,'Friday'
		,@DayStart
		,@DayEnd
		,DATEDIFF(SECOND, @DayStart, @DayEnd)

	--UNION
	--SELECT 7, 'Saturday', @DayStart, @DayEnd, DATEDIFF(SECOND,@DayStart,@DayEnd)
	--calculation of real business hours (no weekends, holidays, time off)	
	RETURN (
			SELECT AvgDays = SUM(CASE 
						WHEN [DATE] = DATEADD(DAY, DATEDIFF(DAY, 0, @StartDateFiscal), 0)
							THEN CASE 
									WHEN @StartDateFiscal > [DATE] + CAST(StartTime AS DATETIME)
										THEN DATEDIFF(SECOND, @StartDateFiscal, [DATE] + CAST([EndTime] AS DATETIME))
									ELSE Duration
									END
						WHEN [DATE] = DATEADD(DAY, DATEDIFF(DAY, 0, @EndDateFiscal), 0)
							THEN CASE 
									WHEN @EndDateFiscal < [DATE] + CAST([EndTime] AS DATETIME)
										THEN DATEDIFF(SECOND, [DATE] + CAST(StartTime AS DATETIME), @EndDateFiscal)
									ELSE Duration
									END
						ELSE Duration
						END) / 3600.00 / 24
			FROM [HRSC_APP].udf_TABLE_DATE(@StartDateFiscal, @EndDateFiscal) D
			JOIN @Calendar C ON D.WEEKDAY_NAME_LONG = C.Name
			WHERE [DATE] NOT IN (
					SELECT StartDate
					FROM @Holidays
					WHERE StartDate IS NOT NULL
					)
			)
END
