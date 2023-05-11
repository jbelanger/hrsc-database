



-- =============================================
-- Author:		<Michel Tardif>
-- Create date: <2017-05-25>
-- Description:	<Update Effective date in tale hr_request
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_UpdateEffectiveDate]
	@lngID bigint, @dteEffectiveDate datetime, @strUser nvarchar(50), @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
-- Declare our variables
DECLARE @Error int;

-- BEGIN TRANSACTION T1

  BEGIN
	UPDATE [HRSC].[HR_REQUEST]
		SET [EFFECTIVE_DATE] = @dteEffectiveDate,
			[USER_UPDATED] = @strUser,
			[DATE_UPDATED] = GetDate()
		WHERE [HR_REQUEST_ID] = @lngID;


     If @Error = 0
  --      COMMIT TRANSACTION T1
		set @pReturnCode = 0;
     Else
  --      ROLLBACK TRANSACTION T1
        set @pReturnCode = @ERROR;
  END
