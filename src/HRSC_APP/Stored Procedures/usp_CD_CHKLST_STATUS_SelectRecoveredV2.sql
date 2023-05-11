
CREATE PROCEDURE [HRSC_APP].[usp_CD_CHKLST_STATUS_SelectRecoveredV2]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_CD_CHKLST_STATUS_SelectRecoveredV2
-- Tony Paradis 2014-10-30
------------------------------------------------------
SELECT  [CHKLST_STATUS_ID] AS id
      ,[CHKLST_STATUS_CODE] AS code
      ,[CHKLST_STATUS_NAME_EN] AS name_en
      ,[CHKLST_STATUS_NAME_FR] AS name_fr
      ,[CHKLST_STATUS_DESC_EN] AS desc_en
      ,[CHKLST_STATUS_DESC_FR] AS desc_fr
      ,[EFFECTIVE_DATE]
      ,[EXPIRY_DATE]
      ,[USER_CREATED]
      ,[DATE_CREATED]
      ,[USER_UPDATED]
      ,[DATE_UPDATED]
FROM    hrsc.[CD_CHKLST_STATUS]
WHERE CHKLST_STATUS_CODE in ('RECOV')
