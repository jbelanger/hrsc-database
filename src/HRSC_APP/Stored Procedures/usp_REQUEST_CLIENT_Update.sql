



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_CLIENT_Update](
	@pId bigint,
	@pPRI varchar(9),
    @pGIVEN_NAME nvarchar(50),
    @pSURNAME nvarchar(50),
    @pEMAIL nvarchar(250),
    @pHOME_PHONE nvarchar(25),
    @pWORK_PHONE nvarchar(25),   
	@pHOME_ADDRESS nvarchar(250),
	@pLanguageId bigint,	
	@pUSER nvarchar(30),
    @pPERSONAL_EMAIL nvarchar(250)
)
WITH EXEC AS CALLER
AS

	UPDATE [HRSC].[HR_REQUEST_CLIENT]
	   SET [PRI] = @pPRI
		  ,[GIVEN_NAME] = @pGIVEN_NAME
		  ,[SURNAME] = @pSURNAME
		  ,[EMAIL] = @pEMAIL
		  ,[HOME_PHONE] = @pHOME_PHONE
		  ,[WORK_PHONE] = @pWORK_PHONE
		  ,[USER_UPDATED] = @pUSER
		  ,[DATE_UPDATED] = getdate()		 
		  ,[HOME_ADDRESS] = @pHOME_ADDRESS 
		  ,POSITION_LANGUAGE_ID = @pLanguageId
		  ,[PERSONAL_EMAIL] = @pPERSONAL_EMAIL
	 WHERE [HR_REQUEST_CLIENT_ID] = @pId;
