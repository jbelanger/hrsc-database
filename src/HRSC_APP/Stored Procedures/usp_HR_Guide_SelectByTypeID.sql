



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Guide_SelectByTypeID]
	@GuideTypeID bigint
	WITH EXEC AS CALLER
	AS
------------------------------------------------------
-- usp_HR_Guide_SelectByTypeID
-- Retreives a list of Manageres Guide by Type
-- Oksana Zhukova 2013-01-11
------------------------------------------------------

SELECT DISTINCT 
	    G.HR_GUIDE_ID AS GuideID,
		HR_GUIDE_NAME_EN +'/'+ HR_GUIDE_NAME_FR  AS GuideName      
FROM HRSC.HR_GUIDE G
WHERE   G.HR_GUIDE_TYPE_ID = @GuideTypeID 
ORDER BY GuideName

