





CREATE   PROCEDURE [HRSC_APP].[usp_CD_Announcement_Type_GetListActive]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- Announcement_Type_GetListActive
-- Retreives all Announcement Types that have not expired
-- Jacqueline Pottle 2013-01-017
------------------------------------------------------
select ANNOUNCEMENT_TYPE_ID, ANNOUNCEMENT_TYPE_NAME_EN +'/'+ ANNOUNCEMENT_TYPE_NAME_FR as ANNOUNCEMENT_TYPE_NAME
from HRSC.CD_ANNOUNCEMENT_TYPE
WHERE  expiry_date IS null
order by ANNOUNCEMENT_TYPE_NAME



