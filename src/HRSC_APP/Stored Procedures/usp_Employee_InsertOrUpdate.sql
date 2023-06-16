



CREATE   PROCEDURE [HRSC_APP].[usp_Employee_InsertOrUpdate]
	@pUserGuid nvarchar(50), 
	@pGivenName nvarchar(30), 
	@pSurname nvarchar(64), 
	@pEmailAddress nvarchar(240), 
	@pWorkPhone nvarchar(25), 
	@pCellPhone nvarchar(25), 
	@pTermOfUse bit, 
	@pActiveInd bit, 
	@pExpiryDate datetime, 
	@pDisplayName nvarchar(120), 
	@pUserCreated nvarchar(30),
	@pNewRowID bigint OUTPUT
WITH EXEC AS CALLER
AS

	declare @EmployeeID bigint;
	declare @LanguageID bigint;
	set @EmployeeID = 0;

	-- Default language to English
	select @LanguageID = LANGUAGE_ID FROM HRSC.CD_LANGUAGE where LANGUAGE_CODE2 = '1'

	-- Check if user exists.
	select @EmployeeID = employee_id 
	from HRSC.EMPLOYEE
	where USER_AD_GUID = @pUserGuid

	if @EmployeeID = 0 
		BEGIN
			-- Employee do not exist, create it.
			INSERT INTO hrsc.employee (
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
			  DISPLAY_NAME
			)
			VALUES (
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
			  @pDisplayName
			);

			set @EmployeeID = @@IDENTITY;
		END;
	ELSE
		BEGIN
			-- Employee Exists... Update it while we are here with the info from WSED -- YR 2016/01/13
			update HRSC.EMPLOYEE set
				EMPLOYEE_GIVEN_NAME = @pGivenName,
				EMPLOYEE_SURNAME = @pSurname,
				EMPLOYEE_EMAIL_ADDRESS = @pEmailAddress,
				WORK_PHONE_NUMBER = @pWorkPhone,
				CELL_PHONE_NUMBER = @pCellPhone,
				USER_UPDATED = @pUserCreated,
				DATE_UPDATED= GetDate(),
				DISPLAY_NAME = @pDisplayName,
				LANGUAGE_ID = @LanguageID
			where USER_AD_GUID = @pUserGuid;
		END;
      
	set @pNewRowID = @EmployeeID;
