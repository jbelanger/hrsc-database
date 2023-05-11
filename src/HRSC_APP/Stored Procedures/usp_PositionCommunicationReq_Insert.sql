



CREATE   PROCEDURE [HRSC_APP].[usp_PositionCommunicationReq_Insert]
	@PositionID bigint,
	@COMM_REQ_ID bigint,
	@UserCreated varchar(100),
	@NewRowID BIGINT OUTPUT

WITH EXEC AS CALLER
AS

	INSERT INTO HRSC.POSITION_COMM_REQ (POSITION_ID, COMMUNICATION_REQ_ID, USER_CREATED)
	VALUES (@PositionID, @COMM_REQ_ID, @UserCreated);

	SET @NewRowID = @@IDENTITY;

