



CREATE   PROCEDURE [HRSC_APP].[usp_CD_ModeofReceipt_Get]
	
	@pModeofReceipt_ID bigint
	
WITH EXEC AS CALLER
AS

select * 
from HRSC.CD_MODE_OF_RECEIPT
where 
MODE_OF_RECEIPT_ID =@pModeofReceipt_ID

