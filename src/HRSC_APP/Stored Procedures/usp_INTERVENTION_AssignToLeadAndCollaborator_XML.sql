



CREATE   PROCEDURE [HRSC_APP].[usp_INTERVENTION_AssignToLeadAndCollaborator_XML]
@xmlData xml, @lngREQId bigint, @lngInterventionID bigint,@strNote nvarchar(2000), @strUser nvarchar(50), @blnChangeLead bit, @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- INTERVENTION_AssignToLeadAndCollaborator_XML
-- Assign and Intervention to a Lead and Collaborator
-- Eric Nolet 2012-02-04
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;
DECLARE @statusID bigint;
--declare @InterventionID bigint;
DECLARE @NoteTypeID bigint;
DECLARE @intReturnCode Integer;

BEGIN TRANSACTION;

  Begin
    
    delete HRSC.HR_RQST_INTRVNT_HRSC_USER where REQUEST_INTERVENTION_ID = @lngInterventionID;
    Select @Error = @@Error
     
  End

  If @Error = 0
  Begin
    INSERT INTO HRSC.HR_RQST_INTRVNT_HRSC_USER
    (
      REQUEST_INTERVENTION_ID,
      EMPLOYEE_ID,
      EMPLOYEE_ROLE_ID,
      USER_CREATED,
      DATE_CREATED
    )
      SELECT 
          x.y.value( 'HrInterventionID[1]', 'bigint' ) AS REQUEST_INTERVENTION_ID,
          x.y.value( 'EmployeeID[1]', 'bigint' ) AS EMPLOYEE_ID,
          x.y.value( 'EmployeeRoleID[1]', 'bigint' ) AS EMPLOYEE_ROLE_ID,
          @strUser as USER_CREATED,
          getdate() as DATE_CREATED
      FROM @xmlData.nodes('/ArrayOfClsEmployeeRoleForIntervention/clsEmployeeRoleForIntervention') x(y);
     
     Select @Error = @@Error;
  End

If @Error = 0
  Begin
	  EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_AssignToLeadAndCollaborator_XML]
        @xmlData, --@xmlData
		@strUser, --@strUserCreated
		@intReturnCode OUT; --@intReturnCode
  End 

If @Error = 0 and @blnChangeLead = 1
  Begin
  
      Select @statusID = REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS where REQUEST_STATUS_CODE = 'ASGN'
      
      INSERT INTO HRSC.HR_REQUEST_STATUS
        ( REQUEST_INTERVENTION_ID, 
          REQUEST_STATUS_ID, 
          USER_CREATED, 
          DATE_CREATED
         )
      VALUES
      (@lngInterventionID, 
       @statusID,
       @strUser,
       GETDATE());
	   
	  Begin
  		-- Update the latest status in the HR_REQUEST_INTERVENTION new field [REQUEST_STATUS_ID] which will always be set to the latest status.  Y.R. 2015/09/09
		-- Will need to revisit this and somehow populate the new field TOTAL_TIME_ELAPSED.
		UPDATE [HRSC].[HR_REQUEST_INTERVENTION]
		SET [REQUEST_STATUS_ID] = @statusID,
			[REQUEST_STATUS_DATE] = GETDATE(),
			[USER_UPDATED] = @strUser,
			[DATE_UPDATED] = GetDate()
		WHERE [HR_REQUEST_INTERVENTION_ID] = @lngInterventionID
	  End

	   EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_forStatusChange] 
          NULL, --@lngReqId 
		  @lngInterventionID, --@lngIntId
		  @statusID, --@lngStatusId
		  @strUser, --@strUserCreated
		  0,					--@lngJustificationID
		  NULL,					--@strJustification
		  @intReturnCode OUT; --@intReturnCode
     Select @Error = @@Error
     
  End
  if @Error = 0 and len(@strNote) > 0
  begin
  Set @NoteTypeID = (SELECT [NOTE_TYPE_ID]
								FROM [HRSC].[CD_NOTE_TYPE]
								WHERE [HRSC].[CD_NOTE_TYPE].[NOTE_TYPE_CODE] = 'NOTE')

  INSERT INTO HRSC.HR_REQUEST_NOTE
        (	HR_REQUEST_NOTE_TEXT,
			USER_CREATED,
		    DATE_CREATED,
			NOTE_TYPE_ID,
			HR_REQUEST_ID,
			HR_REQUEST_INTERVENTION_ID 
         )
      VALUES
       (     @strNote,
			@strUser,
			GETDATE(),
			@NoteTypeID,
			@lngREQId,
			@lngInterventionID);
		 Select @Error = @@Error
  End
  If @Error = 0
  Begin
     If @Error = 0
        COMMIT TRANSACTION
     Else
        ROLLBACK TRANSACTION
        set @pReturnCode = @ERROR;
  End
