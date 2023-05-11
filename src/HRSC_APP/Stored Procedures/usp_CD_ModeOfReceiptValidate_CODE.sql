



CREATE   PROCEDURE [HRSC_APP].[usp_CD_ModeOfReceiptValidate_CODE]
	
	@pCode nvarchar(1000),
	@pReturnCode bigint OUTPUT

		
WITH EXEC AS CALLER
AS
------------------------------------------------------


DECLARE @Error int, @count bigint 

SELECT @Count = Count(*) FROM HRSC.CD_MODE_OF_RECEIPT WHERE upper(MODE_OF_RECEIPT_CODE) = UPPER(@pCode)
	
	

			

		--SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
set @pReturnCode = @@ERROR
else
set @pReturnCode = @Count
