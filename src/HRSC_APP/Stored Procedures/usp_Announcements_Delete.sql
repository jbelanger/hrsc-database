



CREATE   PROCEDURE [HRSC_APP].[usp_Announcements_Delete]
	@Announcements_ID bigint,
	@ReturnCode int OUTPUT

		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- UPDATE Announcement
-- UPDATE an existing Announcement for request in DB 
-- Tony Paradis 2011-12-18 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int
	
     Delete HRSC.HRSC_ANNOUNCEMENTS
     WHERE HRSC_ANNOUNCEMENTS_ID = @Announcements_ID  				   
          
     
			

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0
