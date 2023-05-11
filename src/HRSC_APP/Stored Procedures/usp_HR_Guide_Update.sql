



CREATE   PROCEDURE [HRSC_APP].[usp_HR_Guide_Update]
    @GuideID  bigint, 
	@GuideType      bigint, 
	@FormIDs	    varchar(MAX),
	@NameEn         nvarchar(250), 
	@NameFr         nvarchar(250), 
	@DescriptionEn  nvarchar(4000), 
	@DescriptionFr  nvarchar(4000), 
	@ContentLinkEn  nvarchar(500),
	@ContentLinkFr  nvarchar(500),
	@User           nvarchar(60)
		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- usp_HR_Guide_Update
-- UPDATE an existing Guide / Procedure
-- Oksana Zhukova 2013-01-14
------------------------------------------------------
-- Declare our variables
DECLARE @Error int, @LanguageEnID int, @LanguageFrID int;

	SELECT @LanguageEnID = LANGUAGE_ID FROM HRSC.CD_LANGUAGE WHERE LANGUAGE_CODE = '1';
	SELECT @LanguageFrID = LANGUAGE_ID FROM HRSC.CD_LANGUAGE WHERE LANGUAGE_CODE = '2';

	UPDATE HRSC.HR_GUIDE
	SET HR_GUIDE_TYPE_ID = @GuideType,
		   HR_GUIDE_NAME_EN = @NameEn,
		   HR_GUIDE_NAME_FR = @NameFr,
		   HR_GUIDE_DESC_EN = @DescriptionEn,
		   HR_GUIDE_DESC_FR = @DescriptionFr,
		   USER_UPDATED =@User,
		   DATE_UPDATED = GETDATE()
	 WHERE HR_GUIDE_ID = @GuideID

	--EN
	IF @ContentLinkEn IS NOT NULL
	BEGIN	
		UPDATE HRSC.HR_GUIDE_CONTENT SET 		  
			HR_CONTENT_LINK = @ContentLinkEn,
			USER_UPDATED = @User,
			DATE_UPDATED = GETDATE()
		 WHERE HR_GUIDE_ID = @GuideID
			AND LANGUAGE_ID = @LanguageEnID
	END
	       
	 --FR 
	 IF @ContentLinkFr IS NOT NULL
	 BEGIN     
		UPDATE HRSC.HR_GUIDE_CONTENT SET 
		   HR_CONTENT_LINK = @ContentLinkFr,
		   USER_UPDATED = @User,
		   DATE_UPDATED = GETDATE()
		WHERE HR_GUIDE_ID = @GuideID
	       AND LANGUAGE_ID = @LanguageFrID    
	 END
	  
--DELETE FROM HRSC.HR_REQUEST_GUIDE  WHERE HR_GUIDE_ID  = @GuideID
-----------------------------------------
--begin transaction			  
DECLARE @Temp TABLE (ID INT IDENTITY(1,1), Item BIGINT)
   INSERT INTO @Temp (Item)
   
	SELECT * FROM HRSC_App.Split (@FormIDs, '|')
	--SELECT * FROM HRSC_App.Split ('|1|2|5|6|', '|')	
--check if 	guide/procedure exist and update expiry date set getdate----

DECLARE @CountFromTemp INT = (SELECT COUNT(*) FROM @Temp)    
--select @CountFromTemp
 DECLARE @CountID INT	
  	SELECT @CountID = COUNT(*) 
  	FROM HRSC.HR_REQUEST_GUIDE RG 
  	     INNER JOIN  HRSC.HR_GUIDE G ON G.HR_GUIDE_ID = RG.HR_GUIDE_ID        
	WHERE G.HR_GUIDE_TYPE_ID = @GuideType  -- 2 guide, 3 procedure
	
  --IF @CountID > 0 
IF @CountID > 0 AND @CountFromTemp > 0
	BEGIN
			DECLARE @ID BIGINT				
			
			DECLARE cursorName CURSOR FOR	     --DECLARE cursor
			SELECT Item FROM @Temp--2,5		
			
			OPEN cursorName					     --OPEN the cursor to begin data processing 

			FETCH NEXT FROM cursorName		     --FETCH NEXT Assign the specific values from the cursor to the variables	
			INTO @ID		
			WHILE @@FETCH_STATUS = 0		     --WHILE Condition to BEGIN and continue data processing 
			
			BEGIN
			-----udate all
				  UPDATE HRSC.HR_REQUEST_GUIDE  
					SET USER_UPDATED = @User,
						DATE_UPDATED = GetDate(),
						EXPIRY_DATE  = GETDATE()
					FROM HRSC.HR_REQUEST_GUIDE  RG, HRSC.HR_GUIDE G 
					WHERE RG.HR_GUIDE_ID = G.HR_GUIDE_ID
						  AND G.HR_GUIDE_TYPE_ID = @GuideType
						  AND RG.HR_REQUEST_TYPE_ID = @ID 
						  AND RG.EXPIRY_DATE IS NULL
						  
				-----update by guideid
				UPDATE HRSC.HR_REQUEST_GUIDE  
								SET USER_UPDATED = @User,
								DATE_UPDATED = GetDate(),
								EXPIRY_DATE  = GETDATE()
					FROM HRSC.HR_REQUEST_GUIDE  RG, HRSC.HR_GUIDE G 
					WHERE RG.HR_GUIDE_ID = G.HR_GUIDE_ID
								AND G.HR_GUIDE_TYPE_ID =@GuideType
								AND RG.EXPIRY_DATE IS NULL
							   AND RG.HR_GUIDE_ID=@GuideID
				-------

			   FETCH NEXT FROM cursorName 
			   INTO @ID
			END
			CLOSE cursorName					-- CLOSE the cursor
			DEALLOCATE cursorName				--DELLOCATE Destroys the cursor
			
	END
--------update existing  
ELSE IF @CountID > 0 AND @CountFromTemp = 0
    BEGIN
		UPDATE HRSC.HR_REQUEST_GUIDE  
					SET USER_UPDATED = @User,
					DATE_UPDATED = GetDate(),
					EXPIRY_DATE  = GETDATE()
		FROM HRSC.HR_REQUEST_GUIDE  RG, HRSC.HR_GUIDE G 
		WHERE RG.HR_GUIDE_ID = G.HR_GUIDE_ID
					AND G.HR_GUIDE_TYPE_ID =@GuideType
					AND RG.EXPIRY_DATE IS NULL
				   AND RG.HR_GUIDE_ID=@GuideID
    END
--insert new with expiry date =null---------------------------------------------------------			  			   
	--IF (SELECT COUNT(*) FROM @Temp) != 0 --AND @GuideID != 0 
IF  @CountFromTemp > 0  --2,5
     BEGIN
			DECLARE @Count INT = (SELECT MIN(ID) FROM @Temp) 
			DECLARE @RequestTypeID INT 
			
			   WHILE @Count <= (SELECT MAX(ID) FROM @Temp) 
				   BEGIN
					  SELECT @RequestTypeID = Item FROM @Temp WHERE ID = @Count
					  INSERT INTO HRSC.HR_REQUEST_GUIDE
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
