



CREATE   PROCEDURE [HRSC_APP].[usp_BC_Category_Get]
@pSub_Category_ID bigint, @pClassificationGroupID bigint


WITH EXEC AS CALLER
AS
------------------------------------------------------
-- BC_Category_Get
-- Retreives all BC_CATEGORY for a Sub_Category
-- Tony Paradis 2012-01-31 
-- Michel Tardif 2017-04-11 (Add BC_NAME ENGLISH AND FRENCH)
-- MT 2018-10-25 
------------------------------------------------------
declare @classificationCode nvarchar(5);
declare @EX_IND bit;


if @pClassificationGroupID <> 0 
begin
set @classificationCode = (select CLASSIFICATION_GROUP_CODE from HRSC.CD_CLASSIFICATION_GROUP where @pClassificationGroupID = CLASSIFICATION_GROUP_ID)
end

set @EX_IND = (CASE 
				WHEN @classificationCode = 'EX' THEN 1
				WHEN @pClassificationGroupID = 600000 THEN 1
				ELSE 0
				END)


SELECT BCC.REQUEST_SUB_CATEGORY_ID, BCC.BC_CATEGORY_ID, BCC.BUSINESS_CENTER_ID, BC.BUSINESS_CENTER_CODE, BC.BUSINESS_CENTER_NAME_EN, BC.BUSINESS_CENTER_NAME_FR 
	FROM HRSC.BC_CATEGORY BCC 
		INNER JOIN HRSC.CD_BUSINESS_CENTER BC ON BC.BUSINESS_CENTER_ID = BCC.BUSINESS_CENTER_ID 
	WHERE BCC.REQUEST_SUB_CATEGORY_ID = @pSub_Category_ID  and 
		BCC.EXPIRY_DATE is NULL and
		EX_IND = @EX_IND

