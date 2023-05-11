/*
Found in internet: created by Michael Valentine Jones from SQLTeam 
*/

CREATE   FUNCTION [HRSC_APP].[udf_TABLE_DATE]
(
 @FIRST_DATE DATETIME,
 @LAST_DATE DATETIME
)
/*
Function: [HRSC_APP].udf_TABLE_DATE

This function returns a date TABLE containing all dates
FROM @FIRST_DATE through @LAST_DATE inclusive.
@FIRST_DATE must be less than or equal to @LAST_DATE.
The valid date range is 1754-01-01 through 9997-12-31.
IF any input parameters are invalid, the fuction will produce
an error.

The TABLE returned by udf_TABLE_DATE contains a date and
columns with many calculated attributes of that date.
It is designed to make it convenient to get various commonly
needed date attributes without having to program and test
the same logic in many applications.

udf_TABLE_DATE is primarily INTENDed to load a permanant
date TABLE, but it can be used directly by an application
when the date range needed falls outside the range loaded
in a permanant TABLE.

IF udf_TABLE_DATE is used to load a permanant TABLE, the create
TABLE code can be copied FROM this function.  For a permanent
date TABLE, most columns should be indexed to produce the
best application performance.


Column Descriptions
------------------------------------------------------------------


DATE_ID               
 Unique ID = Days since 1753-01-01

DATE                            
 Date at Midnight(00:00:00.000)

NEXT_DAY_DATE                   
 Next day after DATE at Midnight(00:00:00.000)
 INTENDed to be used in queries against columns
 containing DATETIME values (1998-12-13 14:35:16)
 that need to join to a DATE.
 Example:

 FROM
 MyTABLE a
 join
 DATE b
 on a.DATETIMECol >= b. DATE and
  a.DATETIMECol < b.NEXT_DAY_DATE

YEAR                            
 Year number in format YYYY, Example = 2005

YEAR_QUARTER                    
 Year and Quarter number in format YYYYQ, Example = 20052

YEAR_MONTH                      
 Year and MONTH number in format YYYYMM, Example = 200511

YEAR_DAY_OF_YEAR                
 Year and Day of Year number in format YYYYDDD, Example = 2005364

QUARTER                         
 Quarter number in format Q, Example = 4

MONTH                           
 MONTH number in format MM, Example = 11

DAY_OF_YEAR                     
 Day of Year number in format DDD, Example = 362

DAY_OF_MONTH                    
 Day of MONTH number in format DD, Example = 31

DAY_OF_WEEK                     
 Day of week number, Sun=1, Mon=2, Tue=3, Wed=4, Thu=5, Fri=6, Sat=7

YEAR_NAME                       
 Year name text in format YYYY, Example = 2005

YEAR_QUARTER_NAME               
 Year Quarter name text in format YYYY QQ, Example = 2005 Q3

YEAR_MONTH_NAME                 
 Year MONTH name text in format YYYY MMM, Example = 2005 Mar

YEAR_MONTH_NAME_LONG            
 Year MONTH long name text in format YYYY MMMMMMMMM,
 Example = 2005 September

QUARTER_NAME                    
 Quarter name text in format QQ, Example = Q1

MONTH_NAME                      
 MONTH name text in format MMM, Example = Mar

MONTH_NAME_LONG                 
 MONTH long name text in format MMMMMMMMM, Example = September

WEEKDAY_NAME                    
 Weekday name text in format DDD, Example = Tue

WEEKDAY_NAME_LONG               
 Weekday long name text in format DDDDDDDDD, Example = Wednesday

START_OF_YEAR_DATE              
 First Day of Year that DATE is in

END_OF_YEAR_DATE                
 Last Day of Year that DATE is in

START_OF_QUARTER_DATE           
 First Day of Quarter that DATE is in

END_OF_QUARTER_DATE             
 Last Day of Quarter that DATE is in

START_OF_MONTH_DATE             
 First Day of MONTH that DATE is in

END_OF_MONTH_DATE               
 Last Day of MONTH that DATE is in

*** Start and END of week columns allow SELECTions by week
*** for any week start date needed.

START_OF_WEEK_STARTING_SUN_DATE 
 First Day of Week starting Sunday that DATE is in

END_OF_WEEK_STARTING_SUN_DATE   
 Last Day of Week starting Sunday that DATE is in

START_OF_WEEK_STARTING_MON_DATE 
 First Day of Week starting Monday that DATE is in

END_OF_WEEK_STARTING_MON_DATE   
 Last Day of Week starting Monday that DATE is in

START_OF_WEEK_STARTING_TUE_DATE 
 First Day of Week starting Tuesday that DATE is in

END_OF_WEEK_STARTING_TUE_DATE   
 Last Day of Week starting Tuesday that DATE is in

START_OF_WEEK_STARTING_WED_DATE 
 First Day of Week starting Wednesday that DATE is in

END_OF_WEEK_STARTING_WED_DATE   
 Last Day of Week starting Wednesday that DATE is in

START_OF_WEEK_STARTING_THU_DATE 
 First Day of Week starting Thursday that DATE is in

END_OF_WEEK_STARTING_THU_DATE   
 Last Day of Week starting Thursday that DATE is in

START_OF_WEEK_STARTING_FRI_DATE 
 First Day of Week starting Friday that DATE is in

END_OF_WEEK_STARTING_FRI_DATE   
 Last Day of Week starting Friday that DATE is in

START_OF_WEEK_STARTING_SAT_DATE 
 First Day of Week starting Saturday that DATE is in

END_OF_WEEK_STARTING_SAT_DATE   
 Last Day of Week starting Saturday that DATE is in

*** Sequence No columns are INTENDed to allow easy offsets by
*** Quarter, MONTH, or Week for applications that need to look at
*** Last or Next Quarter, MONTH, or Week.  Thay can also be used to
*** generate dynamic cross tab results by Quarter, MONTH, or Week.

QUARTER_SEQ_NO                  
 Sequential Quarter number as offset FROM Quarter starting 1753/01/01

MONTH_SEQ_NO                    
 Sequential MONTH number as offset FROM MONTH starting 1753/01/01

WEEK_STARTING_SUN_SEQ_NO        
 Sequential Week number as offset FROM Week starting Sunday, 1753/01/07

WEEK_STARTING_MON_SEQ_NO        
 Sequential Week number as offset FROM Week starting Monday, 1753/01/01

WEEK_STARTING_TUE_SEQ_NO        
 Sequential Week number as offset FROM Week starting Tuesday, 1753/01/02

WEEK_STARTING_WED_SEQ_NO        
 Sequential Week number as offset FROM Week starting Wednesday, 1753/01/03

WEEK_STARTING_THU_SEQ_NO        
 Sequential Week number as offset FROM Week starting Thursday, 1753/01/04

WEEK_STARTING_FRI_SEQ_NO        
 Sequential Week number as offset FROM Week starting Friday, 1753/01/05

WEEK_STARTING_SAT_SEQ_NO        
 Sequential Week number as offset FROM Week starting Saturday, 1753/01/06

JULIAN_DATE                     
 Julian Date number as offset FROM noon on January 1, 4713 BCE
 to noon on day of DATE in system of Joseph Scaliger

MODIFIED_JULIAN_DATE            
 Modified Julian Date number as offset FROM midnight(00:00:00.000) on
 1858/11/17 to midnight(00:00:00.000) on day of DATE

ISO_DATE                        
 ISO 8601 Date in format YYYY-MM-DD, Example = 2004-02-29

ISO_YEAR_WEEK_NO                
 ISO 8601 year and week in format YYYYWW, Example = 200403

ISO_WEEK_NO                     
 ISO 8601 week of year in format WW, Example = 52

ISO_DAY_OF_WEEK                 
 ISO 8601 Day of week number, 
 Mon=1, Tue=2, Wed=3, Thu=4, Fri=5, Sat=6, Sun=7

ISO_YEAR_WEEK_NAME              
 ISO 8601 year and week in format YYYY-WNN, Example = 2004-W52

ISO_YEAR_WEEK_DAY_OF_WEEK_NAME  
 ISO 8601 year, week, and day of week in format YYYY-WNN-D,
 Example = 2004-W52-2

DATE_FORMAT_YYYY_MM_DD          
 Text date in format YYYY/MM/DD, Example = 2004/02/29

DATE_FORMAT_YYYY_M_D            
 Text date in format YYYY/M/D, Example = 2004/2/9

DATE_FORMAT_MM_DD_YYYY          
 Text date in format MM/DD/YYYY, Example = 06/05/2004

DATE_FORMAT_M_D_YYYY            
 Text date in format M/D/YYYY, Example = 6/5/2004

DATE_FORMAT_MMM_D_YYYY          
 Text date in format MMM D, YYYY, Example = Jan 4, 2006

DATE_FORMAT_MMMMMMMMM_D_YYYY    
 Text date in format MMMMMMMMM D, YYYY, Example = September 3, 2004

DATE_FORMAT_MM_DD_YY            
 Text date in format MM/DD/YY, Example = 06/05/97

DATE_FORMAT_M_D_YY              
 Text date in format M/D/YY, Example = 6/5/97

*/

RETURNS @DATE TABLE 
(
[DATE_ID]  [int] NOT NULL primary key clustered,
[DATE] [DATETIME] NOT NULL,
[NEXT_DAY_DATE]  [DATETIME] NOT NULL,
[YEAR] [smallint] NOT NULL,
[YEAR_QUARTER]  [int] NOT NULL,
[YEAR_MONTH]  [int] NOT NULL,
[YEAR_DAY_OF_YEAR]  [int] NOT NULL,
[QUARTER]  [tinyint] NOT NULL,
[MONTH] [tinyint] NOT NULL,
[DAY_OF_YEAR]  [smallint] NOT NULL,
[DAY_OF_MONTH]  [smallint] NOT NULL,
[DAY_OF_WEEK]  [tinyint] NOT NULL,

[YEAR_NAME]  [VARCHAR] (4) NOT NULL,
[YEAR_QUARTER_NAME]  [VARCHAR] (7) NOT NULL,
[YEAR_MONTH_NAME]  [VARCHAR] (8) NOT NULL,
[YEAR_MONTH_NAME_LONG]  [VARCHAR] (14) NOT NULL,
[QUARTER_NAME]  [VARCHAR] (2) NOT NULL,
[MONTH_NAME]  [VARCHAR] (3) NOT NULL,
[MONTH_NAME_LONG]  [VARCHAR] (9) NOT NULL,
[WEEKDAY_NAME]  [VARCHAR] (3) NOT NULL,
[WEEKDAY_NAME_LONG]  [VARCHAR] (9) NOT NULL,

[START_OF_YEAR_DATE]  [DATETIME] NOT NULL,
[END_OF_YEAR_DATE]  [DATETIME] NOT NULL,
[START_OF_QUARTER_DATE]  [DATETIME] NOT NULL,
[END_OF_QUARTER_DATE]  [DATETIME] NOT NULL,
[START_OF_MONTH_DATE]  [DATETIME] NOT NULL,
[END_OF_MONTH_DATE]  [DATETIME] NOT NULL,

[START_OF_WEEK_STARTING_SUN_DATE] [DATETIME] NOT NULL,
[END_OF_WEEK_STARTING_SUN_DATE] [DATETIME] NOT NULL,
[START_OF_WEEK_STARTING_MON_DATE] [DATETIME] NOT NULL,
[END_OF_WEEK_STARTING_MON_DATE] [DATETIME] NOT NULL,
[START_OF_WEEK_STARTING_TUE_DATE] [DATETIME] NOT NULL,
[END_OF_WEEK_STARTING_TUE_DATE] [DATETIME] NOT NULL,
[START_OF_WEEK_STARTING_WED_DATE] [DATETIME] NOT NULL,
[END_OF_WEEK_STARTING_WED_DATE] [DATETIME] NOT NULL,
[START_OF_WEEK_STARTING_THU_DATE] [DATETIME] NOT NULL,
[END_OF_WEEK_STARTING_THU_DATE] [DATETIME] NOT NULL,
[START_OF_WEEK_STARTING_FRI_DATE] [DATETIME] NOT NULL,
[END_OF_WEEK_STARTING_FRI_DATE] [DATETIME] NOT NULL,
[START_OF_WEEK_STARTING_SAT_DATE] [DATETIME] NOT NULL,
[END_OF_WEEK_STARTING_SAT_DATE] [DATETIME] NOT NULL,

[QUARTER_SEQ_NO]  [int] NOT NULL,
[MONTH_SEQ_NO]  [int] NOT NULL,

[WEEK_STARTING_SUN_SEQ_NO] [int] NOT NULL,
[WEEK_STARTING_MON_SEQ_NO] [int] NOT NULL,
[WEEK_STARTING_TUE_SEQ_NO] [int] NOT NULL,
[WEEK_STARTING_WED_SEQ_NO] [int] NOT NULL,
[WEEK_STARTING_THU_SEQ_NO] [int] NOT NULL,
[WEEK_STARTING_FRI_SEQ_NO] [int] NOT NULL,
[WEEK_STARTING_SAT_SEQ_NO] [int] NOT NULL,

[JULIAN_DATE]  [int] NOT NULL,
[MODIFIED_JULIAN_DATE]  [int] NOT NULL,

[ISO_DATE]  [VARCHAR](10) NOT NULL,
[ISO_YEAR_WEEK_NO]  [int] NOT NULL,
[ISO_WEEK_NO]  [smallint] NOT NULL,
[ISO_DAY_OF_WEEK]  [tinyint] NOT NULL,
[ISO_YEAR_WEEK_NAME]  [VARCHAR](8) NOT NULL,
[ISO_YEAR_WEEK_DAY_OF_WEEK_NAME] [VARCHAR](10) NOT NULL,

[DATE_FORMAT_YYYY_MM_DD] [VARCHAR](10) NOT NULL,
[DATE_FORMAT_YYYY_M_D]  [VARCHAR](10) NOT NULL,
[DATE_FORMAT_MM_DD_YYYY] [VARCHAR](10) NOT NULL,
[DATE_FORMAT_M_D_YYYY]  [VARCHAR](10) NOT NULL,
[DATE_FORMAT_MMM_D_YYYY] [VARCHAR](12) NOT NULL,
[DATE_FORMAT_MMMMMMMMM_D_YYYY] [VARCHAR](18) NOT NULL,
[DATE_FORMAT_MM_DD_YY]  [VARCHAR](8) NOT NULL,
[DATE_FORMAT_M_D_YY]  [VARCHAR](8) NOT NULL 
) 
AS
BEGIN
DECLARE @cr VARCHAR(2)
SELECT @cr = CHAR(13)+CHAR(10)
DECLARE @ErrorMessage VARCHAR(400)
DECLARE @START_DATE DATETIME
DECLARE @END_DATE DATETIME
DECLARE @LOW_DATE DATETIME

DECLARE @start_no INT
DECLARE @END_no INT

-- Verify @FIRST_DATE is NOT NULL 
IF @FIRST_DATE IS NULL
 BEGIN
 SELECT @ErrorMessage =
 '@FIRST_DATE cannot be null'
 GOTO Error_Exit
 END

-- Verify @LAST_DATE is NOT NULL 
IF @LAST_DATE is null
 BEGIN
 SELECT @ErrorMessage =
 '@LAST_DATE cannot be null'
 GOTO Error_Exit
 END

-- Verify @FIRST_DATE is not before 1754-01-01
IF  @FIRST_DATE < '17540101' BEGIN
 SELECT @ErrorMessage =
 '@FIRST_DATE cannot before 1754-01-01'+
 ', @FIRST_DATE = '+
 isnull(CONVERT(VARCHAR(40),@FIRST_DATE,121),'NULL')
 GOTO Error_Exit
 END

-- Verify @LAST_DATE is not after 9997-12-31
IF  @LAST_DATE > '99971231' BEGIN
 SELECT @ErrorMessage =
 '@LAST_DATE cannot be after 9997-12-31'+
 ', @LAST_DATE = '+
 isnull(CONVERT(VARCHAR(40),@LAST_DATE,121),'NULL')
 GOTO Error_Exit
 END

-- Verify @FIRST_DATE is not after @LAST_DATE
IF @FIRST_DATE > @LAST_DATE
 BEGIN
 SELECT @ErrorMessage =
 '@FIRST_DATE cannot be after @LAST_DATE'+
 ', @FIRST_DATE = '+
 isnull(CONVERT(VARCHAR(40),@FIRST_DATE,121),'NULL')+
 ', @LAST_DATE = '+
 isnull(CONVERT(VARCHAR(40),@LAST_DATE,121),'NULL')
 GOTO Error_Exit
 END

-- Set @START_DATE = @FIRST_DATE at midnight
SELECT @START_DATE = DATEADD(dd,DATEDIFF(dd,0,@FIRST_DATE),0)
-- Set @END_DATE = @LAST_DATE at midnight
SELECT @END_DATE = DATEADD(dd,DATEDIFF(dd,0,@LAST_DATE),0)
-- Set @LOW_DATE = earliest possible SQL Server DATETIME
SELECT @LOW_DATE = CONVERT(DATETIME,'17530101')

-- Find the number of day FROM 1753-01-01 to @START_DATE and @END_DATE
SELECT @start_no = DATEDIFF(dd,@LOW_DATE,@START_DATE),
 @END_no = DATEDIFF(dd,@LOW_DATE,@END_DATE)

-- DECLARE number TABLEs
DECLARE @num1 TABLE (NUMBER INT NOT NULL primary key clustered)
DECLARE @num2 TABLE (NUMBER INT NOT NULL primary key clustered)
DECLARE @num3 TABLE (NUMBER INT NOT NULL primary key clustered)

-- DECLARE TABLE of ISO Week ranges
DECLARE @ISO_WEEK TABLE
(
[ISO_WEEK_YEAR]  INT NOT NULL primary key clustered,
[ISO_WEEK_YEAR_START_DATE] DATETIME NOT NULL,
[ISO_WEEK_YEAR_END_DATE] DATETIME NOT NULL
)

-- Find rows needed in number TABLEs
DECLARE @rows_needed INT
DECLARE @rows_needed_root INT
SELECT @rows_needed = @END_no - @start_no + 1
SELECT  @rows_needed =
 CASE
 WHEN @rows_needed < 10
 THEN 10
 ELSE @rows_needed
 END
SELECT @rows_needed_root = CONVERT(INT,CEILING(SQRT(@rows_needed)))

-- Load number 0 to 16
INSERT INTO @num1 (NUMBER)
SELECT NUMBER = 0 UNION ALL SELECT  1 UNION ALL SELECT  2 UNION ALL
SELECT          3 UNION ALL SELECT  4 UNION ALL SELECT  5 UNION ALL
SELECT          6 UNION ALL SELECT  7 UNION ALL SELECT  8 UNION ALL
SELECT          9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL
SELECT         12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL
SELECT         15
ORDER BY
 1
-- Load TABLE with numbers zero thru square root of the number of rows needed +1
INSERT INTO @num2 (NUMBER)
SELECT
 NUMBER = a.NUMBER+(16*b.NUMBER)+(256*c.NUMBER)
FROM
 @num1 a cross join @num1 b cross join @num1 c
WHERE
 a.NUMBER+(16*b.NUMBER)+(256*c.NUMBER) <
 @rows_needed_root
ORDER BY
 1

-- Load TABLE with the number of rows needed for the date range
INSERT INTO @num3 (NUMBER)
SELECT
 NUMBER = a.NUMBER+(@rows_needed_root*b.NUMBER)
FROM
 @num2 a
 cross join
 @num2 b
WHERE
 a.NUMBER+(@rows_needed_root*b.NUMBER) < @rows_needed
ORDER BY
 1

DECLARE @iso_start_year INT
DECLARE @iso_END_year INT

SELECT @iso_start_year = datepart(year,DATEADD(year,-1,@start_date))
SELECT @iso_END_year = datepart(year,DATEADD(year,1,@END_date))

-- Load TABLE with start and END dates for ISO week years
INSERT INTO @ISO_WEEK
 (
 [ISO_WEEK_YEAR],
 [ISO_WEEK_YEAR_START_DATE],
 [ISO_WEEK_YEAR_END_DATE]
 )
SELECT
 [ISO_WEEK_YEAR] = a.NUMBER,
 [0ISO_WEEK_YEAR_START_DATE] =
 DATEADD(dd,(DATEDIFF(dd,@LOW_DATE,
 DATEADD(day,3,DATEADD(year,a.[NUMBER]-1900,0))
 )/7)*7,@LOW_DATE),
 [ISO_WEEK_YEAR_END_DATE] =
 DATEADD(dd,-1,DATEADD(dd,(DATEDIFF(dd,@LOW_DATE,
 DATEADD(day,3,DATEADD(year,a.[NUMBER]+1-1900,0))
 )/7)*7,@LOW_DATE))
FROM
 (
 SELECT
 NUMBER = NUMBER+@iso_start_year
 FROM
 @num3
 WHERE
 NUMBER+@iso_start_year <= @iso_END_year
 ) a
ORDER BY
 a.NUMBER

-- Load Date TABLE
INSERT INTO @DATE
SELECT
 [DATE_ID]  = a.[DATE_ID],
 [DATE]  = a.[DATE],

 [NEXT_DAY_DATE]  =
 DATEADD(day,1,a.[DATE]),

 [YEAR]  =
 datepart(year,a.[DATE]),
 [YEAR_QUARTER] =
 (10*datepart(year,a.[DATE]))+datepart(quarter,a.[DATE]),

 [YEAR_MONTH] =
 (100*datepart(year,a.[DATE]))+datepart(MONTH,a.[DATE]),
 [YEAR_DAY_OF_YEAR] =
 (1000*datepart(year,a.[DATE]))+
 DATEDIFF(dd,DATEADD(yy,DATEDIFF(yy,0,a.[DATE]),0),a.[DATE])+1,
 [QUARTER] =
 datepart(quarter,a.[DATE]),
 [MONTH] =
 datepart(MONTH,a.[DATE]),
 [DAY_OF_YEAR]  =
 DATEDIFF(dd,DATEADD(yy,DATEDIFF(yy,0,a.[DATE]),0),a.[DATE])+1,
 [DAY_OF_MONTH]  =
 datepart(day,a.[DATE]),
 [DAY_OF_WEEK] =
 -- Sunday = 1, Monday = 2,,,,Saturday = 7
 (DATEDIFF(dd,'17530107',a.[DATE])%7)+1 ,
 [YEAR_NAME] =
 DATENAME(year,a.[DATE]),
 [YEAR_QUARTER_NAME] =
 DATENAME(year,a.[DATE])+' Q'+DATENAME(quarter,a.[DATE]),
 [YEAR_MONTH_NAME] =
 DATENAME(year,a.[DATE])+' '+LEFT(DATENAME(MONTH,a.[DATE]),3),
 [YEAR_MONTH_NAME_LONG] =
 DATENAME(year,a.[DATE])+' '+DATENAME(MONTH,a.[DATE]),
 [QUARTER_NAME] =
 'Q'+DATENAME(quarter,a.[DATE]),
 [MONTH_NAME] =
 LEFT(DATENAME(MONTH,a.[DATE]),3),
 [MONTH_NAME_LONG] =
 DATENAME(MONTH,a.[DATE]),
 [WEEKDAY_NAME] =
 LEFT(DATENAME(weekday,a.[DATE]),3),
 [WEEKDAY_NAME_LONG] =
 DATENAME(weekday,a.[DATE]),

 [START_OF_YEAR_DATE] =
 DATEADD(year,DATEDIFF(year,0,a.[DATE]),0),
 [END_OF_YEAR_DATE] =
 DATEADD(day,-1,DATEADD(year,DATEDIFF(year,0,a.[DATE])+1,0)),

 [START_OF_QUARTER_DATE] =
 DATEADD(quarter,DATEDIFF(quarter,0,a.[DATE]),0),
 [END_OF_QUARTER_DATE] =
 DATEADD(day,-1,DATEADD(quarter,DATEDIFF(quarter,0,a.[DATE])+1,0)),

 [START_OF_MONTH_DATE] =
 DATEADD(MONTH,DATEDIFF(MONTH,0,a.[DATE]),0),
 [END_OF_MONTH_DATE] =
 DATEADD(day,-1,DATEADD(MONTH,DATEDIFF(MONTH,0,a.[DATE])+1,0)),

 [START_OF_WEEK_STARTING_SUN_DATE] =
 DATEADD(dd,(DATEDIFF(dd,'17530107',a.[DATE])/7)*7,'17530107'),
 [END_OF_WEEK_STARTING_SUN_DATE] =
 DATEADD(dd,((DATEDIFF(dd,'17530107',a.[DATE])/7)*7)+6,'17530107'),

 [START_OF_WEEK_STARTING_MON_DATE] =
 DATEADD(dd,(DATEDIFF(dd,'17530101',a.[DATE])/7)*7,'17530101'),
 [END_OF_WEEK_STARTING_MON_DATE] =
 DATEADD(dd,((DATEDIFF(dd,'17530101',a.[DATE])/7)*7)+6,'17530101'),

 [START_OF_WEEK_STARTING_TUE_DATE] =
 DATEADD(dd,(DATEDIFF(dd,'17530102',a.[DATE])/7)*7,'17530102'),
 [END_OF_WEEK_STARTING_TUE_DATE] =
 DATEADD(dd,((DATEDIFF(dd,'17530102',a.[DATE])/7)*7)+6,'17530102'),

 [START_OF_WEEK_STARTING_WED_DATE] =
 DATEADD(dd,(DATEDIFF(dd,'17530103',a.[DATE])/7)*7,'17530103'),
 [END_OF_WEEK_STARTING_WED_DATE] =
 DATEADD(dd,((DATEDIFF(dd,'17530103',a.[DATE])/7)*7)+6,'17530103'),

 [START_OF_WEEK_STARTING_THU_DATE] =
 DATEADD(dd,(DATEDIFF(dd,'17530104',a.[DATE])/7)*7,'17530104'),
 [END_OF_WEEK_STARTING_THU_DATE] =
 DATEADD(dd,((DATEDIFF(dd,'17530104',a.[DATE])/7)*7)+6,'17530104'),

 [START_OF_WEEK_STARTING_FRI_DATE] =
 DATEADD(dd,(DATEDIFF(dd,'17530105',a.[DATE])/7)*7,'17530105'),
 [END_OF_WEEK_STARTING_FRI_DATE] =
 DATEADD(dd,((DATEDIFF(dd,'17530105',a.[DATE])/7)*7)+6,'17530105'),

 [START_OF_WEEK_STARTING_SAT_DATE] =
 DATEADD(dd,(DATEDIFF(dd,'17530106',a.[DATE])/7)*7,'17530106'),
 [END_OF_WEEK_STARTING_SAT_DATE] =
 DATEADD(dd,((DATEDIFF(dd,'17530106',a.[DATE])/7)*7)+6,'17530106'),

 [QUARTER_SEQ_NO]  = 
 DATEDIFF(quarter,@LOW_DATE,a.[DATE]),
 [MONTH_SEQ_NO]  =
 DATEDIFF(MONTH,@LOW_DATE,a.[DATE]),

 [WEEK_STARTING_SUN_SEQ_NO] =
 DATEDIFF(day,'17530107',a.[DATE])/7,
 [WEEK_STARTING_MON_SEQ_NO] =
 DATEDIFF(day,'17530101',a.[DATE])/7,
 [WEEK_STARTING_TUE_SEQ_NO] =
 DATEDIFF(day,'17530102',a.[DATE])/7,
 [WEEK_STARTING_WED_SEQ_NO] =
 DATEDIFF(day,'17530103',a.[DATE])/7,
 [WEEK_STARTING_THU_SEQ_NO] =
 DATEDIFF(day,'17530104',a.[DATE])/7,
 [WEEK_STARTING_FRI_SEQ_NO] =
 DATEDIFF(day,'17530105',a.[DATE])/7,
 [WEEK_STARTING_SAT_SEQ_NO] =
 DATEDIFF(day,'17530106',a.[DATE])/7,

 [JULIAN_DATE]  =
 DATEDIFF(day,@LOW_DATE,a.[DATE])+2361331,
 [MODIFIED_JULIAN_DATE] =
 DATEDIFF(day,'18581117',a.[DATE]),
--/*

 [ISO_DATE] =
 replace(CONVERT(CHAR(10),a.[DATE],111),'/','-'),

 [ISO_YEAR_WEEK_NO] =
 (100*b.[ISO_WEEK_YEAR])+
 (DATEDIFF(dd,b.[ISO_WEEK_YEAR_START_DATE],a.[DATE])/7)+1,

 [ISO_WEEK_NO] =
 (DATEDIFF(dd,b.[ISO_WEEK_YEAR_START_DATE],a.[DATE])/7)+1,

 [ISO_DAY_OF_WEEK] =
 -- Sunday = 1, Monday = 2,,,,Saturday = 7
 (DATEDIFF(dd,@LOW_DATE,a.[DATE])%7)+1 ,

 [ISO_YEAR_WEEK_NAME] =
 CONVERT(VARCHAR(4),b.[ISO_WEEK_YEAR])+'-W'+
 right('00'+CONVERT(VARCHAR(2),(DATEDIFF(dd,b.[ISO_WEEK_YEAR_START_DATE],a.[DATE])/7)+1),2),

 [ISO_YEAR_WEEK_DAY_OF_WEEK_NAME] =
 CONVERT(VARCHAR(4),b.[ISO_WEEK_YEAR])+'-W'+
 right('00'+CONVERT(VARCHAR(2),(DATEDIFF(dd,b.[ISO_WEEK_YEAR_START_DATE],a.[DATE])/7)+1),2) +
 '-'+CONVERT(VARCHAR(1),(DATEDIFF(dd,@LOW_DATE,a.[DATE])%7)+1),
--*/
 [DATE_FORMAT_YYYY_MM_DD] =
 CONVERT(CHAR(10),a.[DATE],111),
 [DATE_FORMAT_YYYY_M_D] = 
 CONVERT(VARCHAR(10),
 CONVERT(VARCHAR(4),YEAR(a.[DATE]))+'/'+
 CONVERT(VARCHAR(2),MONTH(a.[DATE]))+'/'+
 CONVERT(VARCHAR(2),DAY(a.[DATE]))),
 [DATE_FORMAT_MM_DD_YYYY] = 
 CONVERT(CHAR(10),a.[DATE],101),
 [DATE_FORMAT_M_D_YYYY] = 
 CONVERT(VARCHAR(10),
 CONVERT(VARCHAR(2),MONTH(a.[DATE]))+'/'+
 CONVERT(VARCHAR(2),DAY(a.[DATE]))+'/'+
 CONVERT(VARCHAR(4),YEAR(a.[DATE]))),
 [DATE_FORMAT_MMM_D_YYYY] = 
 CONVERT(VARCHAR(12),
 LEFT(DATENAME(MONTH,a.[DATE]),3)+' '+
 CONVERT(VARCHAR(2),DAY(a.[DATE]))+', '+
 CONVERT(VARCHAR(4),YEAR(a.[DATE]))),
 [DATE_FORMAT_MMMMMMMMM_D_YYYY] = 
 CONVERT(VARCHAR(18),
 DATENAME(MONTH,a.[DATE])+' '+
 CONVERT(VARCHAR(2),DAY(a.[DATE]))+', '+
 CONVERT(VARCHAR(4),YEAR(a.[DATE]))),
 [DATE_FORMAT_MM_DD_YY] =
 CONVERT(CHAR(8),a.[DATE],1),
 [DATE_FORMAT_M_D_YY] = 
 CONVERT(VARCHAR(8),
 CONVERT(VARCHAR(2),MONTH(a.[DATE]))+'/'+
 CONVERT(VARCHAR(2),DAY(a.[DATE]))+'/'+
 right(CONVERT(VARCHAR(4),YEAR(a.[DATE])),2))
FROM
 (
 -- Derived TABLE is all dates needed for date range
 SELECT TOP 100 PERCENT
 [DATE_ID] = aa.[NUMBER],
 [DATE] =
  DATEADD(dd,aa.[NUMBER],@LOW_DATE)
 FROM
 (
 SELECT
  NUMBER = NUMBER+@start_no 
 FROM
  @num3
 WHERE
  NUMBER+@start_no <= @END_no
 ) aa
 ORDER BY
 aa.[NUMBER]
 ) a
 join
 -- Match each date to the proper ISO week year
 @ISO_WEEK b on a.[DATE] between b.[ISO_WEEK_YEAR_START_DATE] AND b.[ISO_WEEK_YEAR_END_DATE]
ORDER BY
 a.[DATE_ID]

RETURN

Error_Exit:

-- Return a pseudo error message by trying to
-- CONVERT an error message string to an INT.
-- This method is used because the error displays
-- the string it was trying to CONVERT, and so the
-- calling application sees a formatted error message.

DECLARE @error INT

SET @error = CONVERT(INT,@cr+@cr+
'*******************************************************************'+@cr+
'* Error in function udf_TABLE_DATE:'+@cr+'* '+
isnull(@ErrorMessage,'Unknown Error')+@cr+
'*******************************************************************'+@cr+@cr)

RETURN

END
