



CREATE   PROCEDURE [HRSC_APP].[usp_INTERVENTION_USER_InsertBulk]
@xmlData xml, @lngInterventionID bigint, @strUser nvarchar(50), @pReturnCode bigint OUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- [usp_INTERVENTION_USER_Insert] -- Replaces usp_INTERVENTION_AssignToLeadAndCollaborator_XML
-- Assign an Intervention to a Lead or Collaborator
-- Joel Belanger 2018-07-09
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;
DECLARE @intReturnCode Integer;

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
			  x.y.value( 'InterventionId[1]', 'bigint' ) AS REQUEST_INTERVENTION_ID,
			  x.y.value( 'EmployeeId[1]', 'bigint' ) AS EMPLOYEE_ID,
			  x.y.value( 'EmployeeRoleId[1]', 'bigint' ) AS EMPLOYEE_ROLE_ID,
			  @strUser as USER_CREATED,
			  getdate() as DATE_CREATED
		  FROM @xmlData.nodes('/ArrayOfInterventionUser/InterventionUser') x(y);
     
		 Select @Error = @@Error;
	  End

If @Error = 0
  Begin
	EXEC [HRSC_APP].[usp_REQUEST_Note_InsertBulk]
        @xmlData, --@xmlData
		@strUser, --@strUserCreated
		@intReturnCode OUT; --@intReturnCode

	Select @Error = @intReturnCode;
  End
