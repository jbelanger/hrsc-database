



CREATE   PROCEDURE [HRSC_APP].[usp_Announcements_Get]
	
	@Announcement_ID bigint
	
WITH EXEC AS CALLER
AS

select * 
from HRSC.HRSC_ANNOUNCEMENTS
where 
HRSC_ANNOUNCEMENTS_ID = @Announcement_ID

