



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_GetSubmitter] (
	@RequestIdentifier VARCHAR(100),
	@Submitter VARCHAR(100) OUTPUT
)
WITH EXEC AS CALLER
AS
/*
	 Submitter name by request
	 Yves Robichaud 2013-09-20
*/

/*TEST*/
	--declare @RequestIdentifier VARCHAR(100)='2013-0000584', @Submitter VARCHAR(100) 

SELECT @Submitter = (SELECT USER_CREATED 
							FROM HRSC.HR_REQUEST 
							WHERE HR_REQUEST_IDENTIFIER = @RequestIdentifier )
