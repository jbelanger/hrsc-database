



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_CLIENT_Insert](
	@pPRI varchar(9),
    @pGIVEN_NAME nvarchar(50),
    @pSURNAME nvarchar(50),
    @pEMAIL nvarchar(250),
    @pHOME_PHONE nvarchar(25),
    @pWORK_PHONE nvarchar(25),   
	@pHOME_ADDRESS nvarchar(250),
	@pLanguageId bigint,
	@pUSER nvarchar(30),
	@pPERSONAL_EMAIL nvarchar(250),
	@pNewRowID bigint OUTPUT

)
WITH EXEC AS CALLER
AS

	INSERT INTO [HRSC].[HR_REQUEST_CLIENT] (
        [PRI]
        ,[GIVEN_NAME]
        ,[SURNAME]
        ,[EMAIL]
        ,[HOME_PHONE]
        ,[WORK_PHONE]		
		,[HOME_ADDRESS]
		,POSITION_LANGUAGE_ID
		,[PERSONAL_EMAIL]
		,[USER_CREATED]
        ,[DATE_CREATED])
     VALUES (
		@pPRI,
		@pGIVEN_NAME,
		@pSURNAME,
		@pEMAIL,
		@pHOME_PHONE,
		@pWORK_PHONE,		
		@pHOME_ADDRESS,
		@pLanguageId,
		@pPERSONAL_EMAIL,
		@pUSER,
		getdate()
	);

	set @pNewRowID = @@IDENTITY;
