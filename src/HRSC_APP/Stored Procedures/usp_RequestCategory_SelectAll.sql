



-- =============================================

-- Retreives all Category
-- MT		    2018-09-06
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_RequestCategory_SelectAll]
	-- Add the parameters for the stored procedure here
AS
SELECT DISTINCT(RC.REQUEST_CATEGORY_ID), 
		   RC.REQUEST_CATEGORY_NAME_EN +'/'+ RC.REQUEST_CATEGORY_NAME_FR as CATEGORY_NAME,
		   RC.REQUEST_CATEGORY_NAME_FR +'/'+ RC.REQUEST_CATEGORY_NAME_EN as CATEGORY_NAME_FR,
		   RC.SURVEY_IND as SURVEY_IND

	FROM HRSC.CD_REQUEST_CATEGORY RC
	
	order by CATEGORY_NAME
