



CREATE   PROCEDURE [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract]
    (
    @pI_language smallint,
    @pI_paycycle nvarchar(2),
    @pI_pay_list bigint,
    @pI_last_name nvarchar(20),
    @pI_first_name nvarchar(10),
    @pI_initials nvarchar(3),
    @pI_manager BIT,
    @pI_tenure_id bigint,
    @pI_pri nvarchar(9),
	@PI_GUID nvarchar(36)
    )
AS
BEGIN
    SET NOCOUNT ON;


--SET @pI_language = 1 --	@language_id_code
--SET	@pI_paycycle = '7C' --@CompletePayCycle
--SET	@pI_pay_list = 1100 -- @pay_list
--SET	@pI_pri = 070000700 -- @pri
--SET	@pI_last_name = 'Boombastic' -- @last_name
--SET	@pI_first_name = 'Mark' --@first_name
--SET	@pI_initials = 'M' --@initials
--SET	@pI_manager = 0 --@manager 
--SET	@pI_tenure_id = 19 --@tenure_id
--SET	@PI_GUID = '310B5E98-CFBB-406A-9469-23D3318BF138' --@guid

	UPDATE [HRSC].[EMPLOYEE_EXTENDED]
	SET [LANGUAGE] = @pI_language, 
		[PAYCYCLE] = @pI_paycycle, 
		[PAYLIST] = @pI_pay_list, 
		[SURNAME] = @pI_last_name, 
		[GIVEN_NAME] = @pI_first_name, 
		[EMPLOYEE_INITIAL] = @pI_initials, 
		[MANAGER_IND] = @pI_manager, 
		--[TENURE_TYPE_ID] = @pI_tenure_id, 
		[USER_UPDATED] = 'CMS_EXTRACT', 
		[DATE_UPDATED]= GETDATE(), 
		[CMS_REFRESH_DATE] = GETDATE(), 
		[GUID] = NULLIF(@pI_GUID, '')     --@pI_GUID
	WHERE [HRSC].[EMPLOYEE_EXTENDED].[PRI] = @pI_pri


END
