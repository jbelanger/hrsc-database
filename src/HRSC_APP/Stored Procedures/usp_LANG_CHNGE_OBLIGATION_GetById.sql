



CREATE   PROCEDURE [HRSC_APP].[usp_LANG_CHNGE_OBLIGATION_GetById]
	@Position_id int,
	@pReturnCode int OUTPUT

	WITH EXEC AS CALLER
AS
------------------------------------------------------
-- LANG_CHNGE_OBLIGATION_GetById
-- get the serviceids for the cbl based on positionid
-- Dave Seddon 2013-03-07 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

SELECT service_id, effective_date
FROM hrsc.LANG_CHNGE_OBLIGATION
WHERE position_id = @position_id
AND expiry_date is null


-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
 
 


