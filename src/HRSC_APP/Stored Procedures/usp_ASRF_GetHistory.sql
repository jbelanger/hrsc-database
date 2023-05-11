



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_ASRF_GetHistory]
	@FID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT HRSC.ASRF_FORMS.F_ID, HRSC.ASRF_FORMS.S_StateName_EN, HRSC.ASRF_FORMS.S_StateName_FR, HRSC.ASRF_FORMS.S_StateTimestamp
		FROM  HRSC.ASRF_FORMS
		WHERE	HRSC.ASRF_FORMS.F_ID = @FID
		ORDER BY HRSC.ASRF_FORMS.S_StateTimestamp DESC
END

