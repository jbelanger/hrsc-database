



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_UpdatePriority]
@lngID bigint, @Priority bigint, @strUser nvarchar(50), @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_UpdatePriority
-- 
-- Tony Paradis 2018-05-08
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;



  
	UPDATE [HRSC].[HR_REQUEST]
	SET [PRIORITY_OF_REQUEST_ID] = @Priority,
		[USER_UPDATED] = @strUser,
		[DATE_UPDATED] = GetDate()
	WHERE [HR_REQUEST_ID] = @lngID;

IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0

