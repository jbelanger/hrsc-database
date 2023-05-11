





CREATE   PROCEDURE [HRSC_APP].[usp_Employee_UpdateUserInfo]
@pEmployeeID BIGINT, @pGivenName nvarchar(30), @pSurname nvarchar(64), @pEmailAddress nvarchar(240), @pPhoneWork nvarchar(25), @pActive_IND bit, @pLanguage bigint,  @pUser nvarchar(30)

AS
------------------------------------------------------
-- Employee_UpdateUserInfo
-- Update an employee with infos ,
-- Tony Paradis 2012-01-24 
------------------------------------------------------
-- Declare our variables

  update HRSC.EMPLOYEE
    set
    EMPLOYEE_GIVEN_NAME = @pGivenName,
    EMPLOYEE_SURNAME = @pSurname,
    EMPLOYEE_EMAIL_ADDRESS = @pEmailAddress,
    WORK_PHONE_NUMBER = @pPhoneWork,
	ACTIVE_IND =  case when @pActive_IND = 0 then 0 else 1 end,
	EXPIRY_DATE		 = CASE WHEN @pActive_IND = 0 Then GETDATE() ELSE NULL END,
    USER_UPDATED = @pUser,
    DATE_UPDATED= GetDate(),
	LANGUAGE_ID = @pLanguage
    where EMPLOYEE_ID = @pEmployeeID;
    

