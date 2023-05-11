

CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Note_InsertBulk]
@xmlData xml, @strUserCreated nvarchar(30), @intReturnCode int OUTPUT
WITH EXEC AS CALLER
AS

-- Example of how to call this SP
/*
  Begin
    DECLARE @intReturnCode Integer;
	  EXEC [HRSC_APP].[usp_REQUEST_Note_Insert_AssignToLeadAndCollaborator_XML]
      @xmlData --@xmlData
		@strUser, --@strUserCreated
		@intReturnCode OUT; --@intReturnCode
  End 
*/

------------------------------------------------------
-- REQUEST_Note_Insert_AssignToLeadAndCollaborator_XML
-- Insert a new system generated Note in REQUEST_NOTE
-- Yves Robichaud 2015/04/14
------------------------------------------------------
-- For testing...
--SET @XMLData = '<?xml version="1.0"?><ArrayOfClsEmployeeRoleForIntervention xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><clsEmployeeRoleForIntervention><HrInterventionID>2876</HrInterventionID><EmployeeID>190</EmployeeID><EmployeeRoleID>21</EmployeeRoleID></clsEmployeeRoleForIntervention><clsEmployeeRoleForIntervention><HrInterventionID>2876</HrInterventionID><EmployeeID>219</EmployeeID><EmployeeRoleID>24</EmployeeRoleID></clsEmployeeRoleForIntervention></ArrayOfClsEmployeeRoleForIntervention>' 
--SET @xmlData = '<?xml version="1.0"?><ArrayOfClsEmployeeRoleForIntervention xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><clsEmployeeRoleForIntervention><HrInterventionID>2876</HrInterventionID><EmployeeID>190</EmployeeID><EmployeeRoleID>21</EmployeeRoleID></clsEmployeeRoleForIntervention></ArrayOfClsEmployeeRoleForIntervention>'


DECLARE @Error int;
DECLARE @lngReqId bigint;
DECLARE @lngIntId bigint;
DECLARE @NoteTypeID bigint;
DECLARE @strNoteFr nvarchar(600) = '';
DECLARE @strNoteEn nvarchar(600) = '';
DECLARE @strLeadandCollFr nvarchar(500) = '';
DECLARE @strLeadandCollEn nvarchar(500) = '';

DECLARE @intIntID bigint
DECLARE @intEmpID bigint
DECLARE @intEmpRoleID bigint

DECLARE @strEmpRoleFR nvarchar(250) = '';
DECLARE @strEmpRoleEN nvarchar(250) = '';
DECLARE @strEmployeeName nvarchar(100) = '';


SELECT
		@NoteTypeID = [NOTE_TYPE_ID],
		@strNoteFr = RTRIM([NOTE_TYPE_NAME_DESC_FR]),
		@strNoteEn = RTRIM([NOTE_TYPE_NAME_DESC_EN])
FROM [HRSC].[CD_NOTE_TYPE]
WHERE [HRSC].[CD_NOTE_TYPE].[NOTE_TYPE_CODE] = 'ASGN';

DECLARE xml_cursor_2 CURSOR FOR
  
SELECT    x.y.value( 'InterventionId[1]', 'bigint' ) AS REQUEST_INTERVENTION_ID,
          x.y.value( 'EmployeeId[1]', 'bigint' ) AS EMPLOYEE_ID,
          x.y.value( 'EmployeeRoleId[1]', 'bigint' ) AS EMPLOYEE_ROLE_ID

FROM @xmlData.nodes('/ArrayOfInterventionUser/InterventionUser') x(y);


OPEN xml_cursor_2
  FETCH NEXT FROM xml_cursor_2 INTO @intIntID, @intEmpID, @intEmpRoleID
      
  WHILE @@FETCH_STATUS = 0
          
    BEGIN

	    SET @lngIntId = @intIntID

		SELECT 
			@strEmpRoleFR = [CD_EMPLOYEE_ROLE].[EMPLOYEE_ROLE_NAME_FR],
			@strEmpRoleEN = [CD_EMPLOYEE_ROLE].[EMPLOYEE_ROLE_NAME_EN]
		FROM [HRSC].[CD_EMPLOYEE_ROLE]
		WHERE [CD_EMPLOYEE_ROLE].[EMPLOYEE_ROLE_ID] = @intEmpRoleID

		SELECT 
		@strEmployeeName = [EMPLOYEE].[DISPLAY_NAME] 
		FROM [HRSC].[EMPLOYEE] 
		WHERE [EMPLOYEE].[EMPLOYEE_ID] = @intEmpID

		SET @strLeadandCollFr += CHAR(13) + @strEmployeeName + ' - ' + @strEmpRoleFR
		SET @strLeadandCollEn += CHAR(13) + @strEmployeeName + ' - ' + @strEmpRoleEN

	    FETCH NEXT FROM xml_cursor_2 INTO @intIntID, @intEmpID, @intEmpRoleID
    END
    
CLOSE xml_cursor_2
DEALLOCATE xml_cursor_2

SELECT @lngReqId = HR_REQUEST_ID FROM [HRSC].[HR_REQUEST_INTERVENTION] WHERE [HR_REQUEST_INTERVENTION_ID] = @lngIntId;

SET @strNoteFr += ' ' + RTRIM(@strLeadandCollFr)
SET @strNoteEn += ' ' + RTRIM(@strLeadandCollEn)

DECLARE @strNote nvarchar(2000) = @strNoteEn + ' / ' + @strNoteFr

INSERT INTO HRSC.HR_REQUEST_NOTE

( HR_REQUEST_ID,
  HR_REQUEST_INTERVENTION_ID,
  HR_REQUEST_NOTE_TEXT,
  NOTE_TYPE_ID,
  [HR_REQUEST_AUTO_NOTE_EN],
  [HR_REQUEST_AUTO_NOTE_FR],
  USER_CREATED,
  DATE_CREATED
)
values
( @lngReqId,
  @lngIntId,
  @strNote,
  @NoteTypeID,
  @strNoteEn,
  @strNoteFr,
  @strUserCreated,
  GetDate());

-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR;

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @intReturnCode = @@ERROR;
