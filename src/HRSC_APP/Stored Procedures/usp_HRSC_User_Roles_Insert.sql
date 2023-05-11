


CREATE     PROCEDURE [HRSC_APP].[usp_HRSC_User_Roles_Insert]
@xmlData xml, @pEmployeeID bigint, @pUser nvarchar(30)
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- INSERT HRSC_USER_ROLE_BC
-- Eric Nolet 29-04-2016
------------------------------------------------------
-- Declare our variables
DECLARE @XML nvarchar(MAX) = '<?xml>  <ArrayOfClsUserManagementRoles><clsUserManagementRoles>      <RoleID>6</RoleID>      <BCID>17</BCID>    </clsUserManagementRoles>    <clsUserManagementRoles>      <RoleID>6</RoleID>      <BCID>56</BCID>    </clsUserManagementRoles>    <clsUserManagementRoles>      <RoleID>6</RoleID>      <BCID>28</BCID>    </clsUserManagementRoles>  </ArrayOfClsUserManagementRoles>'
--DECLARE @Return bigint;

--set @Return = 0;

--EXEC HRSC_APP.usp_HRSC_User_Role_DELETE @pEmployeeID,@Return;
----EXEC usp_HRSC_User_Role_EXPIRE @pEmployeeID;

--if @Return = 0
begin
DELETE HRSC.HRSC_USER_ROLE_BC
WHERE EMPLOYEE_ID = @pEmployeeID

INSERT INTO HRSC.HRSC_USER_ROLE_BC
    (
      HRSC_USER_ROLE_ID,
      BUSINESS_CENTER_ID,
      EMPLOYEE_ID,
      USER_CREATED,
      DATE_CREATED
    )
      SELECT 
          x.y.value( 'RoleID[1]', 'bigint' ) AS HRSC_USER_ROLE_ID,
          x.y.value( 'BCID[1]', 'bigint' ) AS BUSINESS_CENTER_ID,
          @pEmployeeID AS EMPLOYEE_ID,
          @pUser as USER_CREATED,
          getdate() as DATE_CREATED
      FROM @xmlData.nodes('/ArrayOfClsUserManagementRoles/clsUserManagementRoles') x(y);
end;
