



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_Insert_from_XML]
@xmlData xml, @lngReqID bigint, @lngPriority bigint, @strNotes nvarchar(2000), @strTransferCode nvarchar(10), @strUser nvarchar(50), @lngIntID bigint OUTPUT, @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- REQUEST_INTERVENTION_Insert_from_XML
-- Insert a new Intervention  in DB 
-- Eric Nolet 2012-01-15
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;
DECLARE @statusID bigint;
declare @InterventionID bigint;
DECLARE @NoteTypeID bigint;
DECLARE @intReturnCode Integer;

Set @NoteTypeID = (SELECT [NOTE_TYPE_ID]
								FROM [HRSC].[CD_NOTE_TYPE]
								WHERE [HRSC].[CD_NOTE_TYPE].[NOTE_TYPE_CODE] = 'NOTE')

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
          1,
          @strUser as User_created,
          getdate() as DATE_CREATED,
		  (select [HR_REQUEST_TYPE_ID] from [HRSC].[HR_REQUEST] where [HR_REQUEST_ID] = @lngReqID)
      FROM @xmlData.nodes('/ArrayOfClsIntervention/clsIntervention') x(y)
	  WHERE 0 = (Select count(RI.[BUSINESS_CENTER_ID]) 
				from [HRSC].[HR_REQUEST_INTERVENTION] RI
				Where @lngReqID = RI.[HR_REQUEST_ID]
				and x.y.value( 'BCId[1]', 'bigint' ) = RI.[BUSINESS_CENTER_ID] 
				and RI.REQUEST_STATUS_ID NOT IN (Select CRS.[REQUEST_STATUS_ID]
											From [HRSC].[CD_REQUEST_STATUS] CRS
											Where CRS.[REQUEST_STATUS_CODE] in ('CLOSE','NOACT'))); 
				-- The following condition was replaced by the one above because it was causing an error for Gen Req when attaching a signed contract. YR 2016/03/03
				
				--and RI.[HR_REQUEST_INTERVENTION_ID] not in (Select RS.[REQUEST_INTERVENTION_ID]
															--From [HRSC].[HR_REQUEST_STATUS] RS
															--Where RS.[REQUEST_STATUS_ID] = (Select CRS.[REQUEST_STATUS_ID]
															--								From [HRSC].[CD_REQUEST_STATUS] CRS
															--								Where CRS.[REQUEST_STATUS_CODE] not in ('CLOSE','NOACT'))
															--and RS.[REQUEST_STATUS_ID] = (Select max(HRS.[HR_REQUEST_STATUS_ID])
															--								From [HRSC].[HR_REQUEST_STATUS] HRS
															--								WHERE RS.[HR_REQUEST_STATUS_ID] = HRS.[HR_REQUEST_STATUS_ID])));
     
     Select @Error = @@Error
  End

  If @Error = 0
  Begin
    Select top 1 @lngIntid = HR_REQUEST_INTERVENTION_ID from HRSC.HR_REQUEST_INTERVENTION
    where HR_REQUEST_ID = @lngReqid order by HR_REQUEST_INTERVENTION_ID desc

    Select @Error = @@Error
     
  End

  If @Error = 0
  Begin
      UPDATE HRSC.HR_REQUEST
      SET PRIORITY_OF_REQUEST_ID = @LngPriority
      WHERE HR_REQUEST_ID = @lngReqid;

     Select @Error = @@Error
     
  End

  If @Error = 0 and
    LEN(@strNotes) > 0
  
  Begin
      INSERT INTO HRSC.HR_REQUEST_NOTE
        (HR_REQUEST_ID,
		 HR_REQUEST_INTERVENTION_ID,
         HR_REQUEST_NOTE_TEXT,
		 NOTE_TYPE_ID,
         USER_CREATED,
         DATE_CREATED 
         )
      VALUES
      (@lngReqid,
	   @lngIntid,
       @strNotes,
	   @NoteTypeID,
       @strUser,
       GETDATE());
     Select @Error = @@Error
     
  End


  If @Error = 0

  Begin

    SELECT @statusID = REQUEST_STATUS_ID FROM HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE = @strTransferCode;

      DECLARE objIntervention CURSOR FOR
        SELECT i.hr_request_intervention_id FROM HRSC.HR_REQUEST_INTERVENTION i
        WHERE i.HR_REQUEST_ID = @lngReqid
        and not exists
        (Select * from HRSC.HR_RQST_INTRVNT_HRSC_USER where REQUEST_INTERVENTION_ID = i.hr_request_intervention_id)
		and not exists (Select * from HRSC.HR_REQUEST_STATUS where REQUEST_INTERVENTION_ID = i.hr_request_intervention_id);
 
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
