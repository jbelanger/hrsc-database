






CREATE   PROCEDURE [HRSC_APP].[usp_Employee_UpdateUserProfileFromAD]
	@pGuidID nvarchar(50), 
	@pGivenName nvarchar(30), 
	@pSurname nvarchar(64), 
	@pEmailAddress nvarchar(240), 
	@pPhoneWork nvarchar(25), 
	@pPhoneMobile nvarchar(25), 
	@pUser nvarchar(30), 
	@pDisplayName nvarchar(120), 
	@pRcCode varchar(10),
	@pPri nvarchar(20),
	@pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS

	update HRSC.EMPLOYEE set
		EMPLOYEE_GIVEN_NAME = @pGivenName,
		EMPLOYEE_SURNAME = @pSurname,
		EMPLOYEE_EMAIL_ADDRESS = @pEmailAddress,
		WORK_PHONE_NUMBER = @pPhoneWork,
		CELL_PHONE_NUMBER = @pPhoneMobile,
		USER_UPDATED = @pUser,
		DATE_UPDATED= GetDate(),
		DISPLAY_NAME = @pDisplayName,
		LAST_LOGIN_DATE = GETDATE(),
		RC_CODE = @pRcCode,
		EMPLOYEE_PRI = @pPri
    where USER_AD_GUID = @pGuidID;
