



CREATE   PROCEDURE [HRSC_APP].[usp_Employee_GetUserProfileByGuid]
@pGuid nvarchar(50)
WITH EXEC AS CALLER
AS
select * from HRSC.EMPLOYEE
where USER_AD_GUID = @pGuid
