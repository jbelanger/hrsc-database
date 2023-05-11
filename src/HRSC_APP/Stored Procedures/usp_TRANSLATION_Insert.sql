




CREATE     PROCEDURE [HRSC_APP].[usp_TRANSLATION_Insert]
@strXML nvarchar(MAX), @strUser nvarchar(50), @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- TRANSLATION_Insert
-- Insert a new Translation XML in DB 
-- Eric Nolet 2012-01-30
------------------------------------------------------
-- Declare our variables
DECLARE @Error int;
--DECLARE @IntMaxID int;


BEGIN TRANSACTION;

  Begin
      --Select @intMaxID = MAX(Translation_id) from HRSC.TRANSLATION;
      
      --Set @intMaxID += 1;
      
      INSERT INTO HRSC.TRANSLATION
        (TRANSLATION_XML,
--         TRANSLATION_ID,        
         USER_CREATED,
         DATE_CREATED 
         )
      VALUES
      (@strXML, 
--       @intMaxID,
       @strUser,
       GETDATE());
     Select @Error = @@Error;
     
  End

  Begin
     If @Error = 0
        COMMIT TRANSACTION
     Else
        ROLLBACK TRANSACTION
        set @pReturnCode = @ERROR;
  End
