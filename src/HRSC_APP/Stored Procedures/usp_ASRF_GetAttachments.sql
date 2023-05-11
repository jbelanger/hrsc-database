



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ASRF_GetAttachments]
	@formID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
   SET NOCOUNT ON;

   SELECT  HRSC.ASRF_ATTACHMENTS.AT_ID , HRSC.ASRF_ATTACHMENTS.At_AttachmentName as NAME
	FROM         HRSC.ASRF_FORMS_ATTACHMENTS INNER JOIN
						  HRSC.ASRF_ATTACHMENTS ON HRSC.ASRF_FORMS_ATTACHMENTS.At_ID = HRSC.ASRF_ATTACHMENTS.At_ID
	where HRSC.ASRF_FORMS_ATTACHMENTS.F_ID = @formID
END

