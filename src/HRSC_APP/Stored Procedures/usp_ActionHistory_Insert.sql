



CREATE   PROCEDURE [HRSC_APP].[usp_ActionHistory_Insert]
@ACTION_DATE DATETIME, 
@USER_CREATED NVARCHAR(120),
@ACTION_TYPE_ID BIGINT,
@REASON_TYPE_ID BIGINT,
@HR_REQUEST_ID BIGINT,
@NewRowID BIGINT = null OUTPUT

WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_ActionHistory_Insert
-- Insert a new NPC Action History in DB 
------------------------------------------------------
-- Declare our variables
DECLARE @VarError int;

INSERT INTO HRSC.ACTION_HISTORY
	(
	 --[ACTION_HISTORY_ID],
	 [ACTION_DATE],
	 --[EXPIRY_DATE],
	 [USER_CREATED],
	 --[USER_UPDATED],
	 [DATE_CREATED],
	 --[DATE_UPDATED],
	 [ACTION_TYPE_ID],
	 [REASON_TYPE_ID],
	 [HR_REQUEST_ID]
	)
	
VALUES (
		@ACTION_DATE, 
		@USER_CREATED,
		GETDATE(),
		@ACTION_TYPE_ID,
		@REASON_TYPE_ID,
		@HR_REQUEST_ID
	);
			
 -- Move it to our local variable, and check for an error condition
SELECT @VarError = @@ERROR;
SET @NewRowID = @@IDENTITY;
