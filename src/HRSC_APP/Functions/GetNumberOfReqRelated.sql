


-- =============================================
-- Author:		Michel Tardif
-- Create date: 2017-04-26
-- Description:	Number of request related with a request
-- =============================================
CREATE   FUNCTION [HRSC_APP].[GetNumberOfReqRelated]
(
	@ReqID bigint
)
RETURNS bigint
WITH EXEC AS CALLER
AS
BEGIN
	-- Declare the return variable here
	DECLARE @intStatusOpen bigint = 0;
	DECLARE @intCount bigint = 0;

	SELECT @intStatusOpen = count([HR_REQUEST_ID])
		FROM [HRSC].[HR_REQUEST] 
		WHERE [HR_REQUEST_ID] =  @ReqID AND
			NOT ([REQUEST_STATUS_ID] =17 OR [REQUEST_STATUS_ID] = 21 OR [REQUEST_STATUS_ID] = 28 OR [REQUEST_STATUS_ID] = 37)
	


	IF 	@intStatusOpen > 0 
		BEGIN
			select @intCount = count(HR_REQUEST_ID)
				FROM [HRSC].[REQUEST_RELATED]
				WHERE [HR_REQUEST_ID] =  @ReqID or [HR_REQUEST_ID_PARENT] = @ReqID
		
		
		END
					
	-- Return the result of the function
	return @intCount;
END
