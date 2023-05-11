



CREATE   PROCEDURE [HRSC_APP].[usp_HRSC_User_Role_GetByGUID]
@pGUID varchar(50)

WITH EXEC AS CALLER
AS
------------------------------------------------------
-- HRSC_User_Role_Get
-- Retreives all Roles for an user
-- Tony Paradis 2012-01-13 
------------------------------------------------------
/** Modified for SQL Server 2016 François Girouard ***/

SELECT	UserRole.HRSC_USER_ROLE_CODE,
		BC.BUSINESS_CENTER_CODE  
FROM	HRSC.HRSC_USER_ROLE_BC R_BC
		INNER JOIN HRSC.CD_BUSINESS_CENTER BC ON BC.BUSINESS_CENTER_ID = R_BC.BUSINESS_CENTER_ID
		INNER JOIN HRSC.EMPLOYEE emp ON R_BC.EMPLOYEE_ID = emp.EMPLOYEE_ID
		INNER JOIN HRSC.CD_HRSC_USER_ROLE UserRole ON UserRole.HRSC_USER_ROLE_ID = R_BC.HRSC_USER_ROLE_ID
WHERE	R_BC.EXPIRY_DATE IS NULL AND
		emp.USER_AD_GUID = @pGUID AND
		emp.EXPIRY_DATE IS NULL AND
		UserRole.EXPIRY_DATE IS NULL
		
		
		

