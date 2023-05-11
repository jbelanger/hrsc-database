

CREATE     PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_SelectRecall]
@lngBCID bigint, @lngEmpID bigint, @lngManagerId bigint, @lngCategoryID bigint, @lngSubCategoryID bigint, @lngStatusId bigint, @RowIndexStart bigint, @RowIndexEnd bigint, @recCount bigint OUTPUT
WITH EXEC AS CALLER
AS

declare @TempTable table
  (
    HR_REQUEST_ID bigint,
    HR_REQUEST_INTERVENTION_ID bigint,
    HR_REQUEST_IDENTIFIER nvarchar(16),
    BUSINESS_CENTER_ID bigint,
    REQUEST_STATUS_ID bigint,
    REQUEST_STATUS_NAME_EN nvarchar(250),
    REQUEST_STATUS_NAME_FR nvarchar(250),
    REQUEST_CATEGORY_ID bigint,
    REQUEST_SUB_CATEGORY_ID bigint,
    REQUEST_SUB_CATEGORY_NAME_EN nvarchar(250),
    REQUEST_SUB_CATEGORY_NAME_FR nvarchar(250),
    EMP_NAME nvarchar(100),
    MANAGER nvarchar(100),
    MANAGER_ID bigint,
    ROLE nvarchar(1),
    FORM_VERSION tinyint,
    TimeStamp nvarchar(10),
    DATE_CREATED datetime,
	IS_PROTECTED bit
  )

 

  Insert into @TempTable
  ( HR_REQUEST_ID,
    HR_REQUEST_INTERVENTION_ID,
    HR_REQUEST_IDENTIFIER,
    BUSINESS_CENTER_ID,
    REQUEST_STATUS_ID,
    REQUEST_STATUS_NAME_EN,
    REQUEST_STATUS_NAME_FR,
    REQUEST_CATEGORY_ID,
    REQUEST_SUB_CATEGORY_ID,
    REQUEST_SUB_CATEGORY_NAME_EN,
    REQUEST_SUB_CATEGORY_NAME_FR,
    EMP_NAME,
    MANAGER,
    MANAGER_ID,
    ROLE,
    FORM_VERSION,
    TimeStamp,
    DATE_CREATED,
	IS_PROTECTED
  )
  SELECT I.HR_REQUEST_ID,
          I.HR_REQUEST_INTERVENTION_ID,
          REQ.HR_REQUEST_IDENTIFIER,
          I.BUSINESS_CENTER_ID,
          CDSTAT.REQUEST_STATUS_ID,
          CDSTAT.REQUEST_STATUS_NAME_EN,
          CDSTAT.REQUEST_STATUS_NAME_FR,
          I.REQUEST_CATEGORY_ID,
          I.REQUEST_SUB_CATEGORY_ID,
          SCAT.REQUEST_SUB_CATEGORY_NAME_EN,
          SCAT.REQUEST_SUB_CATEGORY_NAME_FR,
          c.GIVEN_NAME + ' ' + c.SURNAME as EMP_NAME,
          HRSC_APP.GetManagerName(req.hr_request_id) as MANAGER,
          HRSC_APP.GetManagerID(req.hr_request_id) as MANAGER_ID,
          (CASE R.EMPLOYEE_ROLE_ID WHEN (Select employee_role_id from HRSC.CD_EMPLOYEE_ROLE where EMPLOYEE_ROLE_CODE = 'LEAD') THEN 'L' ELSE 'C' END) as ROLE,
          REQ.FORM_VERSION,
          CONVERT(char(10), I.DATE_CREATED,103) as TimeStamp,
          REQ.DATE_CREATED,
		  REQ.IS_PROTECTED

 

FROM  HRSC.HR_RQST_INTRVNT_HRSC_USER R
       INNER JOIN HRSC.HR_REQUEST_INTERVENTION I ON  I.HR_REQUEST_INTERVENTION_ID = R.REQUEST_INTERVENTION_ID 
      INNER JOIN HRSC.HR_REQUEST REQ ON REQ.HR_REQUEST_ID = I.HR_REQUEST_ID
      INNER JOIN  HRSC.CD_REQUEST_STATUS CDSTAT ON I.REQUEST_STATUS_ID = CDSTAT.REQUEST_STATUS_ID 
      INNER JOIN HRSC.CD_REQUEST_CATEGORY CAT ON CAT.REQUEST_CATEGORY_ID = I.REQUEST_CATEGORY_ID 
      INNER JOIN HRSC.CD_REQUEST_SUB_CATEGORY SCAT ON SCAT.REQUEST_SUB_CATEGORY_ID = I.REQUEST_SUB_CATEGORY_ID 
	  LEFT JOIN HRSC.HR_REQUEST_CLIENT c on c.HR_REQUEST_CLIENT_ID = REQ.HR_REQUEST_CLIENT_ID
 

WHERE I.BUSINESS_CENTER_ID = @lngBCID
      AND R.EMPLOYEE_ID =  ISNULL(@lngEmpID, R.EMPLOYEE_ID) AND
      I.REQUEST_STATUS_ID in (select request_status_id from HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE in (N'RTRNC', N'WSIGN'))
      and REQ.MODE_OF_RECEIPT_ID not in ( select MODE_OF_RECEIPT_ID from HRSC.CD_MODE_OF_RECEIPT where MODE_OF_RECEIPT_CODE = 'PPSFT')
      
     -- STAT.REQUEST_STATUS_ID = CDSTAT.REQUEST_STATUS_ID AND
     -- STAT.REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID AND
     -- STAT.HR_REQUEST_STATUS_ID = (select MAX(HR_REQUEST_STATUS_ID) from HRSC.HR_REQUEST_STATUS where REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID) AND
      
   
--
----------------------------------------------------------
---- DELETE the non Necessary data from the Temp Table. --
----------------------------------------------------------

 

if not @lngSubCategoryID is null
    delete from @TempTable where REQUEST_SUB_CATEGORY_ID <> @lngSubCategoryID;
  
if not @lngCategoryID is null
    delete from @TempTable where REQUEST_CATEGORY_ID <> @lngCategoryID;

 

if not @lngManagerId is null
  delete from @TempTable where MANAGER_ID <> @lngManagerId;

 

if not @lngStatusId is null
  delete from @TempTable where REQUEST_STATUS_ID <> @lngStatusId;
--else
  --delete from @TempTable where REQUEST_STATUS_ID not in (select request_status_id from HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE in (N'RTRNC', N'WSIGN'));

 

--------------------------------------------------------
-- Return the Data. --
--------------------------------------------------------
SELECT *, HRSC_APP.CheckIfUserHasAccessToProtectedRequest(HR_REQUEST_ID, IS_PROTECTED, ISNULL(@lngEmpID, 0)) as USER_HAS_ACCESS FROM
(
  SELECT Row_Number() over (order by DATE_CREATED asc) as RowIndex, *
    FROM @TempTable
) as NewReq
WHERE NewReq.RowIndex >= @RowIndexStart and NewReq.rowindex <= @RowIndexEnd;

 

SELECT @recCount = COUNT(HR_REQUEST_INTERVENTION_ID) from @TempTable;
