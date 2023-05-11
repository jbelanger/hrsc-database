


/*================
Created by:		Oksana Zhukova
Creation Date:	2013-01-15
Description:	Get Language English
==================*/
CREATE   FUNCTION [HRSC_APP].[GetLanguage]

(  
    @Language NVARCHAR(10)  
) 

RETURNS BIGINT  
AS 
BEGIN 
	DECLARE @LanguageID   INT

	SELECT @LanguageID = LANGUAGE_ID FROM HRSC.CD_LANGUAGE WHERE LANGUAGE_NAME_EN = @Language

		RETURN @LanguageID
END
