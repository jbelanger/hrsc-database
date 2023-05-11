



CREATE   PROCEDURE [HRSC_APP].[usp_CD_ModeOfReceipt_GetList]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- CD_Organization_GetList
-- Retreives all Organization
-- Tony Paradis 2012-01-03 
------------------------------------------------------

select MODE_OF_RECEIPT_ID, MODE_OF_RECEIPT_NAME_EN +'/'+ MODE_OF_RECEIPT_NAME_FR as MODE_OF_RECEIPT_NAME
from HRSC.CD_MODE_OF_RECEIPT

