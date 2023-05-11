



CREATE   PROCEDURE [HRSC_APP].[usp_Announcements_GetList]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- Announcements_GetList
-- Retreives all Announcements
-- Tony Paradis 2011-12-13 
------------------------------------------------------
select HRSC_ANNOUNCEMENTS_ID, HRSC_ANNOUNCEMENTS_SBJCT_EN +'/'+ HRSC_ANNOUNCEMENTS_SBJCT_FR as HRSC_SUBJECT
from HRSC.HRSC_ANNOUNCEMENTS
order by HRSC_SUBJECT

