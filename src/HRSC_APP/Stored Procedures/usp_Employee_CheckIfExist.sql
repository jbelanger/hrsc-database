




CREATE   PROCEDURE [HRSC_APP].[usp_Employee_CheckIfExist]
@pUserGuid nvarchar(50), @pGivenName nvarchar(30), @pSurname nvarchar(64), @pEmailAddress nvarchar(240), @pWorkPhone nvarchar(25), @pCellPhone nvarchar(25), @pTermOfUse bit, @pActiveInd bit, @pExpiryDate datetime, @pDisplayName nvarchar(120),
@pRcCode varchar(10),
@pUserCreated nvarchar(30)
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- Employee_CheckIfExist
-- Check if user exists in DB, if not create it
-- and retrun the data
-- Gaétan Demers 2012-01-03 
------------------------------------------------------
declare @EmployeeID bigint;
declare @LanguageID bigint;
DECLARE @Error int;
set @EmployeeID = 0;

-- Default language to English
select @LanguageID = LANGUAGE_ID FROM HRSC.CD_LANGUAGE where LANGUAGE_CODE = 1

-- Check if user exists.
select @EmployeeID = employee_id from HRSC.EMPLOYEE
where USER_AD_GUID = @pUserGuid

if @EmployeeID = 0 
    -- Employee do not exist, create it.
    insert into hrsc.employee
      (
      USER_AD_GUID,
      EMPLOYEE_GIVEN_NAME,
      EMPLOYEE_SURNAME,
      EMPLOYEE_EMAIL_ADDRESS,
      WORK_PHONE_NUMBER,
      CELL_PHONE_NUMBER,
      TERM_OF_USE_AGREEMENT_IND,
      ACTIVE_IND,
      EXPIRY_DATE,
      USER_CREATED,
      DATE_CREATED,
      LANGUAGE_ID,
      DISPLAY_NAME,
	  RC_CODE
      )
    values
      (
      @pUserGuid,
      @pGivenName,
      @pSurname,
      @pEmailAddress,
      @pWorkPhone,
      @pCellPhone,
      1,
      1,
      null,
      @pUserCreated,
      GetDate(),
      @LanguageID,
      @pDisplayName,
	  @pRcCode
      );
else
 -- Employee Exists... Update it while we are here with the info from WSED -- YR 2016/01/13
   update HRSC.EMPLOYEE
    set
    EMPLOYEE_GIVEN_NAME = @pGivenName,
    EMPLOYEE_SURNAME = @pSurname,
	--EMPLOYEE_PRI = @pPRI,
    EMPLOYEE_EMAIL_ADDRESS = @pEmailAddress,
    WORK_PHONE_NUMBER = @pWorkPhone,
    CELL_PHONE_NUMBER = @pCellPhone,
    USER_UPDATED = @pUserCreated,
    DATE_UPDATED= GetDate(),
    DISPLAY_NAME = @pDisplayName,
	LANGUAGE_ID = @LanguageID,
	RC_CODE = @pRcCode
    where USER_AD_GUID = @pUserGuid;
      
set @Error = @@ERROR;

-- If no error, get the data for the employee by it's GUID
-- A Stored Proc always return 0 if no error.
if @Error = 0 
  select * from HRSC.EMPLOYEE where USER_AD_GUID = @pUserGuid;











/****** Object:  StoredProcedure [HRSC_APP].[usp_Employee_UpdateUserProfileFromAD]    Script Date: 2020-11-09 23:00:42 ******/
SET ANSI_NULLS ON
