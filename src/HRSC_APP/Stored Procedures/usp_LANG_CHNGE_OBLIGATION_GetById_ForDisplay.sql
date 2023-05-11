




CREATE   PROCEDURE [HRSC_APP].[usp_LANG_CHNGE_OBLIGATION_GetById_ForDisplay]
@Position_id int
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_LANG_CHNGE_OBLIGATION_GetById_ForDisplay
-- get the serviceids for the cbl based on positionid
-- Eric Nolet 2013-03-27
------------------------------------------------------
SELECT LC.LANG_CHNGE_OBLIGATION_ID,
       LC.SERVICE_ID,
--       LC.COMMENTS,
       lc.POSITION_ID,
       S.SERVICE_CODE,
       S.SERVICE_NAME_EN,
       S.SERVICE_NAME_FR,
       LC.USER_CREATED,
       LC.USER_UPDATED,
       LC.DATE_CREATED,
       LC.DATE_UPDATED,
       lc.EFFECTIVE_DATE,
       lc.EXPIRY_DATE

FROM HRSC.LANG_CHNGE_OBLIGATION lc

JOIN HRSC.CD_SERVICE S ON LC.SERVICE_ID = S.SERVICE_ID
WHERE LC.POSITION_ID = @position_id AND lc.expiry_date is null

