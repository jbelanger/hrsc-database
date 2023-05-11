



CREATE   PROCEDURE [HRSC_APP].[usp_AgreementTerms_Delete]
	@Agreement_Term_Id bigint,
	@ReturnCode int OUTPUT
------------------------------------------------------
-- usp_AgreementTerms_Delete
-- update agreement term based on term_id input param
-- Dave Seddon 2013-01-22 
------------------------------------------------------
		
WITH EXEC AS CALLER
AS

-- Declare our variables
DECLARE @Error int

 DELETE FROM HRSC.HR_AGREEMENT_REQUEST_TYPE
     WHERE AGREEMENT_TERM_ID = @Agreement_Term_Id  			   
          
	
     DELETE FROM HRSC.HR_AGREEMENT_TERM
     WHERE AGREEMENT_TERM_ID = @Agreement_Term_Id  

	
		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0

  --    DELETE FROM HRSC.HR_AGREEMENT_TERM
   --  WHERE AGREEMENT_TERM_ID = @Agreement_Term_Id  


