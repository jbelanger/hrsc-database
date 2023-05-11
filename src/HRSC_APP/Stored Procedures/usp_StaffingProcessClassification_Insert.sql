


CREATE   PROCEDURE [HRSC_APP].[usp_StaffingProcessClassification_Insert]
	@pSTAFFING_PROCESS_ID BIGINT,
	@ClassificationGroupID BIGINT,
	@ClassificationSubGroupID BIGINT,
	@ClassificationLevelID BIGINT,
	@UserCreated varchar(100),
    @NewRowID BIGINT OUTPUT

WITH EXEC AS CALLER
AS

	INSERT INTO HRSC.STAFFING_PROCESS_CLASSIFICATION(
		STAFFING_PROCESS_ID,
		USER_CREATED,
		DATE_CREATED,
		CLASSIFICATION_GROUP_ID,
		CLASSIFICATION_LEVEL_ID,
		CLASSIFICATION_SUB_GROUP_ID)
	VALUES (
		@pSTAFFING_PROCESS_ID,
		@UserCreated,
		GETDATE(),
		@ClassificationGroupID,
		@ClassificationLevelID,
		@ClassificationSubGroupID
	);

	SET @NewRowID = @@IDENTITY;
