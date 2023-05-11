



CREATE   PROCEDURE [HRSC_APP].[usp_TRANSLATION_SelectAll]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- TRANSLATION_SelectAll
-- Gets the all translation XML file
-- Yves Robichaud 2016-05-12
------------------------------------------------------

  SELECT    [TRANSLATION_ID],
			--[TRANSLATION_XML],
			[EXPIRY_DATE],
			[USER_CREATED],
			[USER_UPDATED],
			[DATE_CREATED],
			[DATE_UPDATED] 
  FROM [HRSC].[TRANSLATION]
  ORDER BY [TRANSLATION_ID] DESC
