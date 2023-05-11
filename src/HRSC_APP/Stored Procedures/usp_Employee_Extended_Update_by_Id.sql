



-- =============================================
-- Author:		MT
-- Create date: 2018-06-27
-- Description:	Update table employee_extended by Id
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_Employee_Extended_Update_by_Id]
	@pId bigint, 
	@pPri nvarchar(9), 
	@pGuid nvarchar(38), 
	@pLanguageId bigint,  
	@pPayCycle nvarchar(2),  
	@pPayList bigint,
	@pSurName nvarchar(100),
	@pGivenName nvarchar(100),
	@pEmployeeInitial nvarchar(10),
	@pManagerInd bit,
	@pUser nvarchar(120),
	@pReturnCode bigint OUTPUT
AS


	update HRSC.EMPLOYEE_EXTENDED
		set [LANGUAGE] = @pLanguageId,
			[PAYCYCLE] = @pPayCycle,
			[PAYLIST] = @pPayList,
			[SURNAME] = @pSurName,
			[GIVEN_NAME] = @pGivenName,
			[EMPLOYEE_INITIAL] = @pEmployeeInitial,
			[MANAGER_IND] = @pManagerInd,
			[GUID] = @pGuid,
			[PRI] = @pPri,
			[USER_UPDATED] = @pUser, 
			[DATE_UPDATED] = GETDATE()
		WHERE EMPLOYEE_EXTENDED_ID = @pId

	SELECT @pReturnCode = @@ERROR;

	return @pReturnCode






