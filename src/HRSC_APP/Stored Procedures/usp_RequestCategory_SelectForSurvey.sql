



-- =============================================
-- RequestCategory_SelectForSurvey
-- Retreives all Category where survey indicator = 1
-- MT  2018-09-07
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_RequestCategory_SelectForSurvey]

AS
select distinct(RC.REQUEST_CATEGORY_ID), 
		   RC.REQUEST_CATEGORY_NAME_EN +'/'+ RC.REQUEST_CATEGORY_NAME_FR as CATEGORY_NAME,
		   RC.REQUEST_CATEGORY_NAME_FR +'/'+ RC.REQUEST_CATEGORY_NAME_EN as CATEGORY_NAME_FR

	FROM HRSC.CD_REQUEST_CATEGORY RC
	JOIN HRSC.CD_REQUEST_SUB_CATEGORY SC ON SC.REQUEST_CATEGORY_ID = RC.REQUEST_CATEGORY_ID
	WHERE  SC.SURVEY_IND = 1
	ORDER BY CATEGORY_NAME
