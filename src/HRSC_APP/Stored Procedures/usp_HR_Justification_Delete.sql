



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Justification_Delete]
	@JustificationID BIGINT,
	@User nvarchar(60),
	@ReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- HR_justification_Delete
-- Delete  Justification  in DB 
-- Oksana Zhukova 2013-02-04 
-- Michel Tardif 2015-07-21
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

-- DELETE FROM HRSC.REQ_STATUS_JUSTIFICATION WHERE HR_JUSTIFICATION_ID = @JustificationID
-- DELETE FROM HRSC.CD_HR_JUSTIFICATION WHERE HR_JUSTIFICATION_ID = @JustificationID 

				  
 UPDATE HRSC.REQ_STATUS_JUSTIFICATION
	SET EXPIRY_DATE  = GETDATE(),
		USER_UPDATED = @User,
		DATE_UPDATED = GETDATE()
	WHERE HR_JUSTIFICATION_ID = @JustificationID
		 AND EXPIRY_DATE IS NULL	

 UPDATE HRSC.CD_HR_JUSTIFICATION
	   SET EXPIRY_DATE = GETDATE(),
		   USER_UPDATED = @User,
		   DATE_UPDATED = GETDATE()
	 WHERE HR_JUSTIFICATION_ID =  @JustificationID
	 	 	

SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  SET @ReturnCode = @@ERROR
ELSE
  SET @ReturnCode = 0
