
CREATE PROCEDURE [HRSC_APP].[usp_COI_ANSWER_DELETE_FOR_COIID]
@lngCOI_ID bigint
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_COI_ANSWER_DELETE_FOR_COIID
-- 
-- Eric Nolet 2016-10-05
------------------------------------------------------

Delete [HRSC].[COI_ANSWER] where [COI_ID] = @lngCOI_ID
