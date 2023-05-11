



CREATE PROCEDURE [HRSC_APP].[usp_REQUEST_INTERVENTION_Update2]
	@lngIntID bigint OUTPUT, 
	@lngCatID bigint, 
	@lngSubCatID bigint, 
	@bfDate datetime, 
	@lngCount bigint, 
	@strKeyWordIntervention nvarchar(50), 
	@pStatusId bigint,
	@pStatusDate datetime,
	@strUser nvarchar(50), 
	@pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS

    UPDATE HRSC.HR_REQUEST_INTERVENTION
    SET REQUEST_CATEGORY_ID = @lngCatId,
        REQUEST_SUB_CATEGORY_ID = @lngSubCatId,
        BF_DATE = @bfDate,
        REQUEST_COUNT = @lngCount,
        USER_UPDATED = @strUser,
        DATE_UPDATED = GETDATE(),
		INTERVENTION_KEYWORD = @strKeyWordIntervention,
		REQUEST_STATUS_ID = @pStatusId,
		REQUEST_STATUS_DATE = @pStatusDate
    WHERE HR_REQUEST_INTERVENTION_ID = @lngIntID
     
    set @pReturnCode = @@Error
