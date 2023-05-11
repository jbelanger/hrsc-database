



CREATE   PROCEDURE [HRSC_APP].[usp_TRANSLATION_Delete]
    (
    @pI_TRANSLATION_ID BIGINT
    )
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- TRANSLATION_Delete
-- Delete a Translation File based on the provided ID
-- Yves Robichaud 2016-05-12
------------------------------------------------------

BEGIN
    SET NOCOUNT ON;

    DELETE [HRSC].[TRANSLATION]
    WHERE [TRANSLATION_ID] = @pI_TRANSLATION_ID;

END
