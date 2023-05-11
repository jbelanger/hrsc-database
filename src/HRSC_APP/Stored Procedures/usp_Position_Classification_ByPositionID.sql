



CREATE   PROCEDURE [HRSC_APP].[usp_Position_Classification_ByPositionID]
@PositionID BIGINT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- POSITION_CLASSIFICATION_getbyid
-- select Classification Group, Sub-group and Level IDs by position id
-- E.Akhmetova 2013/04/
------------------------------------------------------

SELECT --POSITION_ID, 
	CONVERT(VARCHAR,CLASSIFICATION_GROUP_ID) AS 'Group',
	CONVERT(VARCHAR,CLASSIFICATION_SUB_GROUP_ID) AS 'SubGroup', 
	CONVERT(VARCHAR,CLASSIFICATION_LEVEL_ID) AS 'Level',
	ROW_NUMBER() OVER(ORDER BY Position_Classification_ID) AS ID
FROM HRSC.POSITION_CLASSIFICATION
WHERE POSITION_ID = @PositionID AND EXPIRY_DATE IS NULL

