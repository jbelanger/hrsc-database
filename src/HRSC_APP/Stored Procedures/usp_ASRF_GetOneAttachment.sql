



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ASRF_GetOneAttachment]
	@ATID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  HRSC.ASRF_ATTACHMENTS.At_AttachmentData , HRSC.ASRF_ATTACHMENTS.At_AttachmentName 
			FROM  HRSC.ASRF_ATTACHMENTS 
			WHERE HRSC.ASRF_ATTACHMENTS.AT_ID = @ATID


   
END

