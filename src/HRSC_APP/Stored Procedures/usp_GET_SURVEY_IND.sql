
CREATE PROCEDURE [HRSC_APP].[usp_GET_SURVEY_IND]
@ReqID bigint, @SURVEY_IND bit OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_GET_SURVEY_IND
-- 
-- Tony Paradis 2015-04-10
------------------------------------------------------
Set @SURVEY_IND = (SELECT  SC.SURVEY_IND
				   FROM HRSC.CD_REQUEST_SUB_CATEGORY SC
				   WHERE SC.REQUEST_SUB_CATEGORY_ID = (SELECT HR.REQUEST_SUB_CATEGORY_ID
													   FROM HRSC.HR_REQUEST HR
													   WHERE HR.HR_REQUEST_ID = @ReqID));
