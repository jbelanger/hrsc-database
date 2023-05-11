



CREATE   PROCEDURE [HRSC_APP].[usp_COI_ANSWER_Insert]
		@COI_QUESTION_ID bigint,
		@COI_ID bigint,
		@ANSWER nvarchar(max),
		@COI_DECLARATION_TYPE_ID bigint,
		@strUser nvarchar(50),
		@pNewRowID bigint OUTPUT


WITH EXEC AS CALLER
AS

    INSERT INTO [HRSC].[COI_ANSWER] (
		[COI_QUESTION_ID],
		[COI_ID],
		[ANSWER],
		[COI_DECLARATION_TYPE_ID],
		[EFFECTIVE_DATE],
		[USER_CREATED],
		[DATE_CREATED]
	)
    VALUES (          
        @COI_QUESTION_ID,
        @COI_ID,
        @ANSWER,
		@COI_DECLARATION_TYPE_ID,
        getdate(),
        @strUser,
        getdate()
	);
	
	set @pNewRowID = @@IDENTITY;
     
