



CREATE   PROCEDURE [HRSC_APP].[usp_Announcements_GetAllActive]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_Announcements_GetAllActive
-- Retreives all active Announcements
-- Gaétan Demers 2012-03-14 
------------------------------------------------------
select * 
from HRSC.HRSC_ANNOUNCEMENTS A
WHERE A.DRAFT_IND = 0 AND 
A.ACTIVE_IND = 1 AND
(A.EFFECTIVE_DATE IS NULL OR A.EFFECTIVE_DATE <= GETDATE()) AND
(A.EXPIRY_DATE IS NULL OR A.EXPIRY_DATE > GETDATE())
ORDER BY COALESCE(A.DATE_UPDATED,A.DATE_CREATED)  DESC




