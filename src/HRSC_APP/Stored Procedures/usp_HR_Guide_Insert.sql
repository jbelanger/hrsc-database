



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Guide_Insert]
   	@GuideType      bigint, 
   	@FormIDs	    varchar(MAX),
	@NameEn         nvarchar(250), 
	@NameFr         nvarchar(250), 
	@DescriptionEn  nvarchar(4000), 
	@DescriptionFr  nvarchar(4000), 
	@ContentLinkEn  nvarchar(500),
	@ContentLinkFr  nvarchar(500),
	@User           nvarchar(60),
	@GuideID        bigint OUTPUT


WITH EXEC AS CALLER
AS
------------------------------------------------------
-- HR_Guide, Procedure Insert
-- Insert HR_Guide, Desk Procedure files Admin screen
-- Oksana Zhukova 2013-01-10
/** Modified for SQL Server 2016 Michel Tardif ***/
------------------------------------------------------
-- Declare our variables
DECLARE @Error int, @LanguageEnID int, @LanguageFrID int--, @count

	--SELECT @LanguageEnID = HRSC_APP.GetLanguage('1')
	--SELECT @LanguageFrID = HRSC_APP.GetLanguage('2')
	SELECT @LanguageEnID = [LANGUAGE_ID]  FROM [HRSC].[CD_LANGUAGE] where [LANGUAGE_CODE2] = '1'
	SELECT @LanguageFrID = [LANGUAGE_ID]  FROM [HRSC].[CD_LANGUAGE] where [LANGUAGE_CODE2] = '2'
	--s id n = par 
	
	IF 
	(select COUNT(*) from HRSC.HR_GUIDE where HR_GUIDE_NAME_EN = @NameEn or 
		   HR_GUIDE_NAME_FR = @NameFr) = 0
		   
	begin	   
  INSERT INTO HRSC.HR_GUIDE
		 (HR_GUIDE_TYPE_ID,
		   HR_GUIDE_NAME_EN,
		   HR_GUIDE_NAME_FR,
		   HR_GUIDE_DESC_EN,
		   HR_GUIDE_DESC_FR)
	VALUES
		  (@GuideType,
		   @NameEn,			
		   @NameFr,			
		   @DescriptionEn,	
		   @DescriptionFr)


	SELECT  @GuideID = @@IDENTITY
	   if 	 @ContentLinkEn != '' and @ContentLinkFr != ''
	   begin  	   
			   INSERT INTO HRSC.HR_GUIDE_CONTENT
					   (HR_GUIDE_ID,
						LANGUAGE_ID,
						HR_CONTENT_LINK,
						USER_CREATED,
						DATE_CREATED)
				 VALUES
					   --EN File
						(@GuideID,
						 @LanguageEnID,
						 @ContentLinkEn,
						 @User,
						 GETDATE()),
			             		          
						--FR File
						 (@GuideID,
						  @LanguageFrID,
						  @ContentLinkFr,
						  @User,
						  GETDATE())	
	end
	--else return	  	
--begin transaction			  
DECLARE @Temp TABLE (ID INT IDENTITY(1,1), Item BIGINT)
   INSERT INTO @Temp (Item)
   
	SELECT * FROM HRSC_App.Split (@FormIDs, '|')
	--SELECT * FROM HRSC_App.Split ('2|5', '|')	
	
	DECLARE @CountFromTemp INT = (SELECT COUNT(*) FROM @Temp)   
		
--check if 	guide exist and set expiry date of the form to today date--------------
 Declare @CountID int	
  	SELECT @CountID = COUNT(*) 
  	FROM HRSC.HR_REQUEST_GUIDE RG 
  	     INNER JOIN  HRSC.HR_GUIDE G ON G.HR_GUIDE_ID = RG.HR_GUIDE_ID        
	WHERE G.HR_GUIDE_TYPE_ID = @GuideType  -- 2 guide, 3 procedure
	
	IF @CountID > 0 
		BEGIN
			DECLARE @ID BIGINT
			
			DECLARE cursorName CURSOR FOR Select Item FROM @Temp--2,5		
			OPEN cursorName 

			FETCH NEXT FROM cursorName INTO @ID
			WHILE @@FETCH_STATUS = 0
			--Select * FROM @Temp
			--select @ID
			BEGIN
			-----udate all
			 UPDATE HRSC.HR_REQUEST_GUIDE  
					SET USER_UPDATED = @User,
						DATE_UPDATED = GETDATE(),
						EXPIRY_DATE  = GETDATE()
			  FROM HRSC.HR_REQUEST_GUIDE  RG
				INNER JOIN HRSC.HR_GUIDE G ON RG.HR_GUIDE_ID = G.HR_GUIDE_ID
			  WHERE  G.HR_GUIDE_TYPE_ID = @GuideType
				AND RG.HR_REQUEST_TYPE_ID = @ID 
				AND RG.EXPIRY_DATE IS NULL
						  
			   FETCH NEXT FROM cursorName INTO @ID
   
			END
			CLOSE cursorName 
			DEALLOCATE cursorName 
			
		END
		--select RG.HR_REQUEST_GUIDE_ID, rg.HR_REQUEST_TYPE_ID, rg.EXPIRY_DATE   	
		--FROM HRSC.HR_REQUEST_GUIDE RG 
  --	     INNER JOIN  HRSC.HR_GUIDE G ON G.HR_GUIDE_ID = RG.HR_GUIDE_ID 
  --	     WHERE G.HR_GUIDE_TYPE_ID = 2 
--rollback transaction	

--insert new with expiry date =null---------------------------------------------------------			  			   
	--IF (SELECT COUNT(*) FROM @Temp) != 0 AND @GuideID != 0
	--@CountFromTemp
	IF @CountFromTemp != 0 AND @GuideID != 0
		BEGIN
			DECLARE @Count INT = (SELECT MIN(ID) FROM @Temp) 
			DECLARE @RequestTypeID INT 
			
			   WHILE @Count <= (SELECT MAX(ID) FROM @Temp) 
				   BEGIN
					  SELECT @RequestTypeID = Item FROM @Temp WHERE ID = @Count
					  INSERT INTO [HRSC].[HR_REQUEST_GUIDE]
								 (HR_GUIDE_ID,
								  HR_REQUEST_TYPE_ID,
								  USER_CREATED,
								  DATE_CREATED
								  )
						   VALUES
								 (@GuideID,
								  @RequestTypeID,
								  @User,
								  GETDATE()
								  ) 
				   SET @Count = @Count + 1
				   END
			END
end	

SET @GuideID = @GuideID
  

