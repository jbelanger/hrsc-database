



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Guide_Delete]
	@GuideID bigint,
	@ReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- HR_Guide_Delete
-- Delete (logical) an HR_Guide / Pocedure in DB 
-- Oksana Zhukova 2013-01-17 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

   DELETE FROM HRSC.HR_REQUEST_GUIDE WHERE HR_GUIDE_ID = @GuideID
   DELETE FROM HRSC.HR_GUIDE_CONTENT WHERE  HR_GUIDE_ID = @GuideID
   DELETE FROM  HRSC.HR_GUIDE WHERE HR_GUIDE_ID =  @GuideID
  

SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  SET @ReturnCode = @@ERROR
ELSE
  SET @ReturnCode = 0
