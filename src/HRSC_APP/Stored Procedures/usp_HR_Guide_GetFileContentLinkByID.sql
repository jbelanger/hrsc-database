



-- =============================================
-- Author:		<MT>
-- Create date: <2015-07-06,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_HR_Guide_GetFileContentLinkByID]
	@GuideID	 INT,
	@Language  NVARCHAR(10),
	@ReturnLink NVARCHAR(500) OUTPUT
	
AS
	DECLARE @LanguageID INT 
		SELECT @LanguageID = HRSC_APP.GetLanguage(@Language)
BEGIN
	DECLARE @LinkURL NVARCHAR(500)
	-- SELECT  @LinkURL = HR_GUIDE_CONTENT_FILE
	SELECT  @LinkURL = HR_CONTENT_LINK
		FROM HRSC.HR_GUIDE_CONTENT 
		WHERE HR_GUIDE_ID = @GuideID
			AND LANGUAGE_ID = @LanguageID

	IF @LinkURL IS NULL 
		SET @ReturnLink = ''
	ELSE
		SET @ReturnLink = @LinkURL

END

