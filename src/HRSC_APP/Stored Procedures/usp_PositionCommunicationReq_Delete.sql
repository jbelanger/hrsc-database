



CREATE   PROCEDURE [HRSC_APP].[usp_PositionCommunicationReq_Delete]
	@PositionID bigint

WITH EXEC AS CALLER
AS

	DELETE HRSC.POSITION_COMM_REQ 
	WHERE POSITION_ID = @PositionID;

