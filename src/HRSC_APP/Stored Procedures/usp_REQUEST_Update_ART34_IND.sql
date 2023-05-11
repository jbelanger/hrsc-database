



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_Update_ART34_IND]
@pRequestID bigint, @pArt34_ind bit, @pReturnCode bigint OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_REQUEST_Update_ART34_IND
-- Update an ART34_IND HR Request in DB 
-- Tony Paradis 2015-04-10 -- 
-- Declare our variables
DECLARE @Error int
BEGIN TRANSACTION
  begin
   
  update HRSC.HR_REQUEST
    set 
      ART34_IND=@pArt34_ind      
  where HR_REQUEST_ID = @pRequestID;


  SELECT @Error = @@ERROR;
  END

Begin
     If @Error = 0
        COMMIT TRANSACTION
     Else
        ROLLBACK TRANSACTION
        set @pReturnCode = @ERROR;
  End
 
