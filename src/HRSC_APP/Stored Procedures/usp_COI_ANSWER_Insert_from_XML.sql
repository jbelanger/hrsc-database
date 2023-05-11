
CREATE PROCEDURE [HRSC_APP].[usp_COI_ANSWER_Insert_from_XML]
@xmlData xml, @lngCOI_ID bigint, @strUser nvarchar(50), @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_COI_ANSWER_Insert_from_XML
-- 
-- Tony Paradis 2016-07-19
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;


DECLARE @intReturnCode Integer;

BEGIN TRANSACTION;

-- Delete all the answer entered before enter the new set.
-- I do this because it's easyer this way. I don't have to find wicht one has to be updated and witch one has to be added

Delete [HRSC].[COI_ANSWER] where [COI_ID] = @lngCOI_ID

  Begin
    INSERT INTO [HRSC].[COI_ANSWER]
    (
		
		[COI_QUESTION_ID],
		[COI_ID],
		[ANSWER],
		[COI_DECLARATION_TYPE_ID],
		[EFFECTIVE_DATE],
		[USER_CREATED],
		[DATE_CREATED]
    )
      SELECT          
          x.y.value( 'COI_QUESTIONS_ID[1]', 'int' ) AS COI_QUEST_ID,
          @lngCOI_ID,
          x.y.value( 'COI_ANSWER[1]', 'nvarchar(max)' ) AS ANSWER,
		  (select [COI_DECLARATION_TYPE_ID] from [HRSC].[CD_COI_QUESTION] WHERE [COI_QUESTION_ID] = x.y.value( 'COI_QUESTIONS_ID[1]', 'int' )) as Dec_typeID,
          getdate() as EffectiveDate,
          @strUser as User_created,
          getdate() as DATE_CREATED
      FROM @xmlData.nodes('/ArrayOfClsCOI_Question/clsCOI_Question') x(y);
     
     Select @Error = @@Error
  End

  

  Begin
     If @Error = 0
        COMMIT TRANSACTION
     Else
        ROLLBACK TRANSACTION
        set @pReturnCode = @ERROR;
  End
