




CREATE   PROCEDURE [HRSC_APP].[usp_CD_HrRequestType_SelectAll]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_HrRequestType_SelectAll 
-- Retreives all active HR Request Type (Active and inactive)
-- Gaétan Demers  2011-12-13
-- Eric Nolet     2011-12-15 Added Aliases
------------------------------------------------------
SELECT  HR_REQUEST_TYPE_ID AS ID,
        HR_REQUEST_TYPE_NAME_EN AS NAME_EN,
        HR_REQUEST_TYPE_NAME_FR AS NAME_FR,
        HR_REQUEST_TYPE_DESC_EN AS DESC_EN,
        HR_REQUEST_TYPE_DESC_FR AS DESC_FR,
        HR_REQUEST_TYPE_CODE AS CODE,
        EFFECTIVE_DATE,
        EXPIRY_DATE,
        USER_CREATED,
        USER_UPDATED,
        DATE_CREATED,
        DATE_UPDATED
FROM    HRSC.CD_HR_REQUEST_TYPE

