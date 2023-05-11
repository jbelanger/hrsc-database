






CREATE   PROCEDURE [HRSC_APP].[usp_Announcements_GetAllActiveByType]
	
	@int_Announcement_Type bigint
	
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_Announcements_GetAllActiveByType
-- Retreives all active Announcements of type HR
-- Jacqueline Pottle 2013-01-30 
------------------------------------------------------
select * 
from HRSC.HRSC_ANNOUNCEMENTS A
WHERE A.DRAFT_IND = 0 AND 
A.ACTIVE_IND = 1 AND
A.ANNOUNCEMENT_TYPE_ID=@int_Announcement_Type AND
(A.EFFECTIVE_DATE is NULL OR A.EFFECTIVE_DATE <= GETDATE()) AND
(A.EXPIRY_DATE is NULL OR A.EXPIRY_DATE > GETDATE())

ORDER BY COALESCE(A.DATE_UPDATED,A.DATE_CREATED)  DESC


