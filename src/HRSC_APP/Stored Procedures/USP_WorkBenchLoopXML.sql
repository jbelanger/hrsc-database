




CREATE   PROCEDURE [HRSC_APP].[USP_WorkBenchLoopXML]
@BC_ID bigint, @EMP_ID bigint, @OutXML xml OUTPUT
WITH EXEC AS CALLER
AS
DECLARE @UnAssignedPD bigint, @UnAssignedCurrent bigint, @UnAssignedFuture bigint, @UnAssignedCount bigint
DECLARE @ActivePD bigint, @ActiveCurrent bigint, @ActiveFuture bigint, @ActiveCount bigint
DECLARE @PendingPD bigint, @PendingCurrent bigint, @PendingFuture bigint, @PendingCount bigint

DECLARE @BC_NAME_EN nvarchar(250), @BC_NAME_FR nvarchar(250), @BC_CODE nvarchar(5);

DECLARE @EMP_NAME nvarchar(100);

declare @MainTable table
  (
    HR_REQUEST_ID bigint,
    HR_REQUEST_INTERVENTION_ID bigint,
    BUSINESS_CENTER_ID bigint,
    PROCESSING_OPEN_DATE date,
    PROCESSING_CLOSE_DATE date,
    STATUS nvarchar(250)
  )

declare @TempTable table
  (
    HR_REQUEST_ID bigint,
    HR_REQUEST_INTERVENTION_ID bigint,
    BUSINESS_CENTER_ID bigint,
    PROCESSING_OPEN_DATE date,
    PROCESSING_CLOSE_DATE date,
    STATUS nvarchar(250)
  )

  Select @BC_NAME_EN = BUSINESS_CENTER_NAME_EN, @BC_NAME_FR = BUSINESS_CENTER_NAME_FR,  @BC_CODE = BUSINESS_CENTER_CODE 
  from HRSC.CD_BUSINESS_CENTER 
  where BUSINESS_CENTER_ID = @BC_ID;
 
  select @EMP_NAME = EMPLOYEE_GIVEN_NAME + ' ' + EMPLOYEE_SURNAME 
  from HRSC.EMPLOYEE 
  where EMPLOYEE_ID = @EMP_ID
 
	  Insert into @TempTable ( 
		HR_REQUEST_ID,
		HR_REQUEST_INTERVENTION_ID,
		BUSINESS_CENTER_ID,
		PROCESSING_OPEN_DATE,
		PROCESSING_CLOSE_DATE,
		STATUS)
	Select R.HR_REQUEST_ID,
         I.HR_REQUEST_INTERVENTION_ID, 
         I.BUSINESS_CENTER_ID,
         R.PROCESSING_OPEN_DATE,
         R.PROCESSING_CLOSE_DATE,
         SS.REQUEST_STATUS_CODE
	from HRSC.HR_REQUEST_INTERVENTION I
		 JOIN HRSC.HR_REQUEST R ON I.HR_REQUEST_ID = R.HR_REQUEST_ID
		 JOIN HRSC.CD_REQUEST_STATUS SS ON SS.REQUEST_STATUS_ID = I.REQUEST_STATUS_ID
    where business_center_id = @BC_ID
         AND I.REQUEST_STATUS_ID IN (
			SELECT REQUEST_STATUS_ID 
			FROM HRSC.CD_REQUEST_STATUS 
			WHERE REQUEST_STATUS_CODE IN ('ATSF', 'NEW', 'NUPD','TSF')
		)
         
Select @UnAssignedCount = count(HR_REQUEST_ID) from @TempTable;
select @UnAssignedPD = count(HR_REQUEST_ID) from @TempTable where PROCESSING_CLOSE_DATE < getdate();
select @UnAssignedCurrent = count(HR_REQUEST_ID) from @TempTable where PROCESSING_OPEN_DATE is null or (PROCESSING_OPEN_DATE <= getdate() and PROCESSING_CLOSE_DATE >= getdate());
select @UnAssignedFuture = count(HR_REQUEST_ID) from @TempTable where PROCESSING_OPEN_DATE > getdate();
  
delete from @TempTable;

Insert into @MainTable
  ( HR_REQUEST_ID,
    HR_REQUEST_INTERVENTION_ID,
    BUSINESS_CENTER_ID,
    PROCESSING_OPEN_DATE,
    PROCESSING_CLOSE_DATE,
    STATUS
  )

Select  R.HR_REQUEST_ID,
        I.HR_REQUEST_INTERVENTION_ID,
        I.BUSINESS_CENTER_ID,
        R.PROCESSING_OPEN_DATE,
        R.PROCESSING_CLOSE_DATE,
        SS.REQUEST_STATUS_CODE

from HRSC.HR_REQUEST_INTERVENTION I 
JOIN HRSC.HR_RQST_INTRVNT_HRSC_USER U ON U.REQUEST_INTERVENTION_ID = I.HR_REQUEST_INTERVENTION_ID
JOIN HRSC.HR_REQUEST R ON I.HR_REQUEST_ID = R.HR_REQUEST_ID
JOIN HRSC.CD_REQUEST_STATUS SS ON SS.REQUEST_STATUS_ID = I.REQUEST_STATUS_ID
where EMPLOYEE_ID = @EMP_ID
      and I.BUSINESS_CENTER_ID = @BC_ID
      AND I.REQUEST_STATUS_ID not IN (SELECT REQUEST_STATUS_ID FROM HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE IN ('ATSF', 'NEW', 'NUPD','TSF','CLOSE', 'NOACT', 'CANC', 'REJ'))
      

Insert into @TempTable
  ( HR_REQUEST_ID,
    HR_REQUEST_INTERVENTION_ID,
    BUSINESS_CENTER_ID,
    PROCESSING_OPEN_DATE,
    PROCESSING_CLOSE_DATE,
    STATUS
  )

  Select  HR_REQUEST_ID,
          HR_REQUEST_INTERVENTION_ID,
          BUSINESS_CENTER_ID,
          PROCESSING_OPEN_DATE,
          PROCESSING_CLOSE_DATE,
          STATUS
         
         from @MainTable
         where STATUS IN ('ASGN', 'PROC', 'SIGND', 'RTNFC')

Select @ActiveCount = count(HR_REQUEST_ID) from @TempTable;
select @ActivePD = count(HR_REQUEST_ID) from @TempTable where PROCESSING_CLOSE_DATE < getdate();
select @ActiveCurrent = count(HR_REQUEST_ID) from @TempTable where PROCESSING_OPEN_DATE is null or (PROCESSING_OPEN_DATE <= getdate() and PROCESSING_CLOSE_DATE >= getdate());
select @ActiveFuture = count(HR_REQUEST_ID) from @TempTable where PROCESSING_OPEN_DATE > getdate();

delete from @TempTable;

-- Do the Counts for Pending Records.
Insert into @TempTable
  ( HR_REQUEST_ID,
    HR_REQUEST_INTERVENTION_ID,
    BUSINESS_CENTER_ID,
    PROCESSING_OPEN_DATE,
    PROCESSING_CLOSE_DATE,
    STATUS
  )

  Select  HR_REQUEST_ID,
          HR_REQUEST_INTERVENTION_ID,
          BUSINESS_CENTER_ID,
          PROCESSING_OPEN_DATE,
          PROCESSING_CLOSE_DATE,
          STATUS
         
         from @MainTable
         where STATUS IN ('WAIT', 'WSIGN', 'RTRNC', 'RTURN')

Select @PendingCount = count(HR_REQUEST_ID) from @TempTable;
select @PendingPD = count(HR_REQUEST_ID) from @TempTable where PROCESSING_CLOSE_DATE < getdate();
select @PendingCurrent = count(HR_REQUEST_ID) from @TempTable where PROCESSING_OPEN_DATE is null or (PROCESSING_OPEN_DATE <= getdate() and PROCESSING_CLOSE_DATE >= getdate());
select @PendingFuture = count(HR_REQUEST_ID) from @TempTable where PROCESSING_OPEN_DATE > getdate();

SET @outXML = (
	SELECT @BC_ID as BC_ID, @BC_NAME_EN as BC_NAME_EN, @BC_NAME_FR as BC_NAME_FR, @BC_CODE as BC_CODE, @EMP_NAME as EMPLOYEE_NAME, @UnAssignedPD as UnAssignedPD, @UnAssignedCurrent as UnAssignedCurrent, @UnAssignedFuture as UnAssignedFuture, @UnAssignedCount as UnAssignedCount, @ActivePD as ActivePD, @ActiveCurrent as ActiveCurrent, @ActiveFuture as ActiveFuture, @ActiveCount as ActiveCount, @PendingPD as PendingPD, @PendingCurrent as PendingCurrent, @PendingFuture as PendingFuture, @PendingCount as PendingCount 
	FOR XML PATH ('DashResult'), ROOT ('DashResults'), ELEMENTS);

