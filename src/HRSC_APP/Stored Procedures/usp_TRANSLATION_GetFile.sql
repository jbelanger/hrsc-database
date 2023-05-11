



CREATE   PROCEDURE [HRSC_APP].[usp_TRANSLATION_GetFile]
    (
    @pI_TRANSLATION_ID BIGINT,
    @pI_TRANSLATION_CONTENT NVARCHAR(MAX) OUTPUT
    )
AS
------------------------------------------------------
-- TRANSLATION_GetFile
-- Gets the XML file based on provided ID
-- Yves Robichaud 2016-05-12
------------------------------------------------------
BEGIN
    SET NOCOUNT ON;

    SELECT @pI_TRANSLATION_CONTENT = [TRANSLATION_XML]
    FROM [HRSC].[TRANSLATION]
    WHERE [TRANSLATION].[TRANSLATION_ID] = @pI_TRANSLATION_ID;

END
