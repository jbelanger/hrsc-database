



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_Insert_New_from_XML]
@xmlData xml, @InterventionKeyword nvarchar(50), @lngReqID bigint, @strTransferCode nvarchar(10), @strUser nvarchar(50), @lngIntID bigint OUTPUT, @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_INTERVENTION_Insert_New_from_XML
-- 
-- Eric Nolet 2012-03-03
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;
DECLARE @statusID bigint;
declare @InterventionID bigint;
DECLARE @intReturnCode Integer;

BEGIN TRANSACTION;

  Begin
    INSERT INTO HRSC.HR_REQUEST_INTERVENTION
    (
      HR_REQUEST_ID,
      REQUEST_CATEGORY_ID,
      REQUEST_SUB_CATEGORY_ID,  
      BUSINESS_CENTER_ID,
      PROCESSING_RC_CODE,
      AUTOMATIC_TRANSFER_IND,
      SEND_EMAIL_IND,
	  INTERVENTION_KEYWORD,
      REQUEST_COUNT,
      USER_CREATED,
      DATE_CREATED,
	  HR_REQUEST_TYPE_ID
    )
      SELECT 
          x.y.value( 'ReqID[1]', 'bigint' ) AS ReqID,
          x.y.value( 'CatId[1]', 'int' ) AS CatID,
          x.y.value( 'SubCatId[1]', 'int' ) AS SubCatID,
          x.y.value( 'BCId[1]', 'bigint' ) AS BCID,
          x.y.value( 'ProcessingRC[1]', 'nvarchar(10)' ) AS RC,
          x.y.value( 'AutoMatic_Transfer[1]', 'bit' ) AS AutoMaticTransfer,
          x.y.value( 'SendEmail[1]', 'bit' ) AS SendEmail,
		  @InterventionKeyword,
          1,
          @strUser as User_created,
          getdate() as DATE_CREATED,
		  (select [HR_REQUEST_TYPE_ID] from [HRSC].[HR_REQUEST] where [HR_REQUEST_ID] = @lngReqID)
      FROM @xmlData.nodes('/ArrayOfClsIntervention/clsIntervention') x(y);
     
     Select @Error = @@Error
  End

  If @Error = 0
  Begin
    Select top 1 @lngIntid = HR_REQUEST_INTERVENTION_ID from HRSC.HR_REQUEST_INTERVENTION
    where HR_REQUEST_ID = @lngReqid

    Select @Error = @@Error
     
  End

  If @Error = 0

  Begin

    SELECT @statusID = REQUEST_STATUS_ID FROM HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE = @strTransferCode;

    DECLARE objIntervention CURSOR FOR
            SELECT REQINT.HR_REQUEST_INTERVENTION_ID
            FROM HRSC.HR_REQUEST_INTERVENTION REQINT
            WHERE REQINT.HR_REQUEST_ID = @lngReqid and
            NOT EXISTS 
              (Select * from HRSC.HR_REQUEST_STATUS STAT where STAT.REQUEST_INTERVENTION_ID = REQINT.HR_REQUEST_INTERVENTION_ID and 
              REQUEST_STATUS_ID <> (select request_status_id from HRSC.CD_REQUEST_STATUS where request_status_code = 'ASGN'))
            
    OPEN objIntervention
    FETCH NEXT FROM objIntervention 
    INTO @InterventionID
    WHILE @@FETCH_STATUS = 0

    BEGIN
      INSERT INTO HRSC.HR_REQUEST_STATUS
        ( REQUEST_INTERVENTION_ID, 
          REQUEST_STATUS_ID, 
          USER_CREATED, 
          DATE_CREATED
         )
      VALUES
      (@InterventionID, 
       @statusID,
       @strUser,
       GETDATE());

  		-- Update the latest status in the HR_REQUEST_INTERVENTION new field [REQUEST_STATUS_ID] which will always be set to the latest status.  Y.R. 2015/07/22
		-- Will need to revisit this and somehow populate the new field TOTAL_TIME_ELAPSED.
		UPDATE [HRSC].[HR_REQUEST_INTERVENTION]
		SET [REQUEST_STATUS_ID] = @statusID,
			[REQUEST_STATUS_DATE] = GETDATE(),
			[USER_UPDATED] = @strUser,
			[DATE_UPDATED] = GetDate()
		WHERE [HR_REQUEST_INTERVENTION_ID] = @InterventionID

	  EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
        NULL, --@lngReqId 
		@InterventionID, --@lngIntId
		@statusID, --@lngStatusId
		@strUser, --@strUserCreated
		0,						--@lngJustificationID
		NULL,					--@strJustification
		@intReturnCode OUT; --@intReturnCode
            
      FETCH NEXT FROM objIntervention INTO @InterventionID
    END
    
    CLOSE objIntervention;

    DEALLOCATE objIntervention;

    Select @Error = @@Error
     
  End

  Begin
     If @Error = 0
        COMMIT TRANSACTION
     Else
        ROLLBACK TRANSACTION
        set @pReturnCode = @ERROR;
  End
