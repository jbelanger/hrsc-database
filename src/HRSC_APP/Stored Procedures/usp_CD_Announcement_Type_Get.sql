






CREATE   PROCEDURE [HRSC_APP].[usp_CD_Announcement_Type_Get]

	@Announcement_Type_ID bigint

WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_Announcement_Type_Get
-- Retreives one Announcement Type
-- based on ID passed in
-- Jacqueline Pottle 2013-01-017
------------------------------------------------------
select *
from HRSC.CD_ANNOUNCEMENT_TYPE
where ANNOUNCEMENT_TYPE_ID = @Announcement_Type_ID
order by ANNOUNCEMENT_TYPE_CODE




