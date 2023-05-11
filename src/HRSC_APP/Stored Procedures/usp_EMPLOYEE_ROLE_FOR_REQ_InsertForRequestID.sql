
CREATE PROCEDURE [HRSC_APP].[usp_EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID]
@pRequestID bigint, @pUserCreated nvarchar(30), @pXmlManager xml
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- EMPLOYEE_ROLE_FOR_REQ_InsertForRequestID
-- Insert a new record for a specific Request.
-- Gaétan Demers 2012-01-23
------------------------------------------------------
declare @vErrorNum int;

 Begin
    INSERT INTO HRSC.EMPLOYEE_ROLE_FOR_REQUEST
    (
  EMPLOYEE_ID,
  HR_REQUEST_ID,
  EMPLOYEE_ROLE_ID,
  DATE_CREATED,
  USER_CREATED
    )
      SELECT 
          x.y.value( 'EmployeeID[1]', 'bigint' ) AS YeeID,
          @pRequestID,
          x.y.value( 'EmployeeRoleID[1]', 'int' ) AS RoleID,
          getdate() as DATE_CREATED,
          @pUserCreated as User_created
      FROM @pXmlManager.nodes('/ArrayOfClsEmployeeRoleForRequest/clsEmployeeRoleForRequest') x(y);
     
     Select @vErrorNum = @@Error
     
     return @vErrorNum
  End
