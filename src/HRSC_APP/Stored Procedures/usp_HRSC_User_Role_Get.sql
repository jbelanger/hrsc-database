



CREATE   PROCEDURE [HRSC_APP].[usp_HRSC_User_Role_Get]
@pEmployeeID bigint

WITH EXEC AS CALLER
AS
------------------------------------------------------
-- HRSC_User_Role_Get
-- Retreives all Roles for an user
-- Tony Paradis 2012-01-13 
------------------------------------------------------
/** Modified for SQL Server 2016 François Girouard ***/

SELECT	R_BC.HRSC_USER_ROLE_BC_ID,
		R_BC.HRSC_USER_ROLE_ID,
		R_BC.BUSINESS_CENTER_ID,
		BC.BUSINESS_CENTER_CODE,
		UR.HRSC_USER_ROLE_CODE AS code
FROM	HRSC.HRSC_USER_ROLE_BC R_BC
		INNER JOIN HRSC.CD_BUSINESS_CENTER BC ON BC.BUSINESS_CENTER_ID = R_BC.BUSINESS_CENTER_ID
		INNER JOIN HRSC.CD_HRSC_USER_ROLE UR ON R_BC.HRSC_USER_ROLE_ID = UR.HRSC_USER_ROLE_ID
WHERE	R_BC.EMPLOYEE_ID = @pEmployeeID AND
		R_BC.EXPIRY_DATE is NULL
		
		

