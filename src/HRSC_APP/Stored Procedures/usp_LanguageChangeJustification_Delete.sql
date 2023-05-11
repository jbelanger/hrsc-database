



CREATE   PROCEDURE [HRSC_APP].[usp_LanguageChangeJustification_Delete]
	@PositionID bigint

WITH EXEC AS CALLER
AS

	DELETE HRSC.Lang_Chnge_Obligation 
	WHERE POSITION_ID = @PositionID;

