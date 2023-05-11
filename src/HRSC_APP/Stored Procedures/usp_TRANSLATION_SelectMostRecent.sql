



CREATE   PROCEDURE [HRSC_APP].[usp_TRANSLATION_SelectMostRecent]
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- TRANSLATION_SelectMostRecent
-- Gets the most recent translation XML file
-- Eric Nolet 2012-01-30
------------------------------------------------------

  Select * from HRSC.TRANSLATION
  where TRANSLATION_ID = (select max(TRANSLATION_ID) from HRSC.TRANSLATION)
