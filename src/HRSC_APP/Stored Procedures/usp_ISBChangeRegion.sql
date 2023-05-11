



-- =============================================
-- Author:		Yves Robichaud
-- Create date: 2014/11/12
-- Description:	Change the request region, unassign intervention and change status to "Auto-tranfered" for ISB Intervention (SC Process)
-- Modified		MT 2018-11-29

-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ISBChangeRegion]
	@lngRequestID bigint, 
	@pInterventionID BIGINT,
	@lngRegionID bigint,
	@lngStatusID bigint, 
	@strUser nvarchar(50),
	@pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS

DECLARE @Error int;
DECLARE @intReturnCd Integer;

BEGIN TRANSACTION;

  --Update the Region
  Begin
    UPDATE HRSC.HR_REQUEST
    SET REGION_ID = @lngRegionID,
        USER_UPDATED = @strUser,
        DATE_UPDATED = GETDATE()
    WHERE HR_REQUEST_ID = @lngRequestID
     
    Select @Error = @@Error
  End

  --Update the Status
  If @Error = 0
  Begin
      DECLARE @ReqStatusId bigint;
	  SET @ReqStatusId = (SELECT [REQUEST_STATUS_ID] FROM [HRSC].[CD_REQUEST_STATUS] WHERE [REQUEST_STATUS_CODE] = 'ATSF')
      
	  INSERT INTO HRSC.HR_REQUEST_STATUS
        ( REQUEST_INTERVENTION_ID, 
           REQUEST_STATUS_ID, 
          USER_CREATED, 
          DATE_CREATED)

      VALUES
      (@pInterventionID, 
	   @ReqStatusId,		--@lngStatusID,
       @strUser,
       GETDATE());

	-- Update the latest status in the HR_REQUEST_INTERVENTION new field [REQUEST_STATUS_ID] which will always be set to the latest status.  Y.R. 2015/07/22
	-- Will need to revisit this and somehow populate the new field TOTAL_TIME_ELAPSED.
	UPDATE [HRSC].[HR_REQUEST_INTERVENTION]
	SET [REQUEST_STATUS_ID] = @lngStatusID,
		[REQUEST_STATUS_DATE] = GETDATE(),
		[USER_UPDATED] = @strUser,
		[DATE_UPDATED] = GetDate()
	WHERE [HR_REQUEST_INTERVENTION_ID] = @pInterventionID

	  EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
        NULL, --@lngReqId 
		@pInterventionID, --@lngIntId
		@ReqStatusId, ---@lngStatusID, 
		@strUser, --@strUserCreated
		0,					--@lngJustificationID
		NULL,					--@strJustification
		@intReturnCd OUT; --@intReturnCode

    Select @Error = @@Error
     
  End

  --Remove the Lead and Collaborator from the intervention
  If @Error = 0
  Begin

  	DELETE [HRSC].[HR_RQST_INTRVNT_HRSC_USER] 
	WHERE [HR_RQST_INTRVNT_HRSC_USER].[REQUEST_INTERVENTION_ID] = @pInterventionID

    Select @Error = @@Error
    DECLARE @NoteTypeId bigint;
	set @NoteTypeId = (select NOTE_TYPE_ID FROM [HRSC].[CD_NOTE_TYPE] where [CD_NOTE_TYPE].NOTE_TYPE_CODE = 'UNASS')
    
	EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_SystemNote]
		NULL,  --@lngReqId
		@pInterventionID, --@lngIntId
		@NoteTypeId,  --'UNASS', --@strNoteTypeCode -- In this case we want the "Un-Assign" type
		@strUser; --@strUserCreated
		--@intReturnCd;--@intReturnCode

  End


  Begin
     If @Error = 0
        COMMIT TRANSACTION
     Else
        ROLLBACK TRANSACTION
        set @pReturnCode = @ERROR;
  End
