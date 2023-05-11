



CREATE   PROCEDURE [HRSC_APP].[usp_Request_CheckIfRelationAlreadyExists]
    (
    @pI_REQUEST_ID bigint, 
	@pI_RELATED_REQUEST_ID bigint,
    @pO_Exists BIT OUTPUT
    )
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_Request_CheckIfRelationAlreadyExists
-- Check if the Request Relation already exists
-- 
-- Yves Robichaud 2015-09-11
------------------------------------------------------
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(
              SELECT [REQUEST_RELATED].[REQUEST_RELATED_ID]
				FROM   [HRSC].[REQUEST_RELATED] 

				WHERE ([HRSC].[REQUEST_RELATED].[HR_REQUEST_ID] = @pI_REQUEST_ID and [HRSC].[REQUEST_RELATED].[HR_REQUEST_ID_PARENT] = @pI_RELATED_REQUEST_ID) or
					  ([HRSC].[REQUEST_RELATED].[HR_REQUEST_ID] = @pI_RELATED_REQUEST_ID and [HRSC].[REQUEST_RELATED].[HR_REQUEST_ID_PARENT] = @pI_REQUEST_ID)
             )
    SET @pO_Exists = 'True';
    ELSE
    SET @pO_Exists = 'False';

END
