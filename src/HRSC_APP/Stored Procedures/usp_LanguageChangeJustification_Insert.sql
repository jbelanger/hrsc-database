



CREATE   PROCEDURE [HRSC_APP].[usp_LanguageChangeJustification_Insert]
	@Position_id int,
	@Service_id int,
	@User nvarchar(60),
    @NewRowID BIGINT OUTPUT
		
WITH EXEC AS CALLER
AS

	INSERT INTO HRSC.Lang_Chnge_Obligation (
		POSITION_ID,
		SERVICE_ID,
		USER_CREATED,
		DATE_CREATED)
	VALUES (
		@Position_id,
		@Service_id,
		@User,
		GetDate()
	);

	SET @NewRowID = @@IDENTITY;
