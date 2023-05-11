

CREATE   PROCEDURE [HRSC_APP].[USP_ManagerDashboardLoopXML]
@BC varchar(50), @OutXML xml OUTPUT
WITH EXEC AS CALLER
AS
DECLARE @UnresolvedPD bigint, @UnresolvedCurrent bigint, @UnresolvedFuture bigint, @UnresolvedCount bigint
DECLARE @ActivePD bigint, @ActiveCurrent bigint, @ActiveFuture bigint, @ActiveCount bigint
DECLARE @PendingPD bigint, @PendingCurrent bigint, @PendingFuture bigint, @PendingCount bigint

DECLARE @BC_ID bigint, @BC_NAME_EN nvarchar(250), @BC_NAME_FR nvarchar(250);

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
 
  Select @BC_ID = BUSINESS_CENTER_ID, @BC_NAME_EN = BUSINESS_CENTER_NAME_EN, @BC_NAME_FR = BUSINESS_CENTER_NAME_FR from HRSC.CD_BUSINESS_CENTER where BUSINESS_CENTER_CODE = @BC;
 
  Insert into @MainTable
  ( HR_REQUEST_ID,
    HR_REQUEST_INTERVENTION_ID,
    BUSINESS_CENTER_ID,
    PROCESSING_OPEN_DATE,
    PROCESSING_CLOSE_DATE,
    STATUS
  )

  Select R.HR_REQUEST_ID,
         I.HR_REQUEST_INTERVENTION_ID, 
         I.BUSINESS_CENTER_ID,
         R.PROCESSING_OPEN_DATE,
         R.PROCESSING_CLOSE_DATE,
         SS.REQUEST_STATUS_CODE
         from	HRSC.HR_REQUEST_INTERVENTION I
				INNER JOIN HRSC.HR_REQUEST R ON i.HR_REQUEST_ID = r.HR_REQUEST_ID
				INNER JOIN HRSC.CD_REQUEST_STATUS SS ON SS.REQUEST_STATUS_ID = I.REQUEST_STATUS_ID
         where business_center_id = (select BUSINESS_CENTER_ID from HRSC.CD_BUSINESS_CENTER where BUSINESS_CENTER_CODE = @BC)
         AND I.REQUEST_STATUS_ID not IN (SELECT REQUEST_STATUS_ID FROM HRSC.CD_REQUEST_STATUS WHERE REQUEST_STATUS_CODE IN ('CLOSE', 'NOACT', 'CANC', 'REJ'))
         
--select * from @MainTable;
--
Select @UnresolvedCount = count(HR_REQUEST_ID) from @MainTable;
select @UnresolvedPD = count(HR_REQUEST_ID) from @MainTable where PROCESSING_CLOSE_DATE < getdate();
select @UnresolvedCurrent = count(HR_REQUEST_ID) from @MainTable where PROCESSING_OPEN_DATE is null or (PROCESSING_OPEN_DATE <= getdate() and PROCESSING_CLOSE_DATE >= getdate());
select @UnresolvedFuture = count(HR_REQUEST_ID) from @MainTable where PROCESSING_OPEN_DATE > getdate();
--
--Select @UnresolvedPD as UR_PD, @UnresolvedCurrent as UR_CO, @UnresolvedFuture as UR_FU, @UnresolvedCount as Count;

delete from @TempTable;

-- Do the Counts for Active Records.
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
--
--Select @ActivePD as AC_PD, @ActiveCurrent as AC_CO, @ActiveFuture as AC_FU, @ActiveCount as Count;

delete from @TempTable;

-- Do the Counts for Active Records.
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
--
--Select @PendingPD as PEND_PD, @PendingCurrent as PEND_CO, @PendingFuture as PEND_FU, @PendingCount as PEND_Count;

delete from @TempTable;

SET @outXML = (SELECT @BC_ID as BC_ID, @BC_NAME_EN as BC_NAME_EN, @BC_NAME_FR as BC_NAME_FR, @UnresolvedPD as UnresolvedPD, @UnresolvedCurrent as UnresolvedCurrent, @UnresolvedFuture as UnresolvedFuture, @UnresolvedCount as UnresolvedCount, @ActivePD as ActivePD, @ActiveCurrent as ActiveCurrent, @ActiveFuture as ActiveFuture, @ActiveCount as ActiveCount , @PendingPD as PendingPD, @PendingCurrent as PendingCurrent, @PendingFuture as PendingFuture, @PendingCount as PendingCount FOR XML PATH ('DashResult'), ROOT ('DashResults'), ELEMENTS);

