



CREATE   PROCEDURE [HRSC_APP].[usp_AgreementTerms_Insert]
	@FormIDs varchar(MAX),
    @Agreement_Term_code nvarchar(05),
	@Agreement_Term_Name_en nvarchar(250),
	@Agreement_Term_Name_fr nvarchar(250),
	@Agreement_Term_Desc_en nvarchar(4000),
	@Agreement_Term_Desc_fr nvarchar(4000),
	@Effective_date datetime,
	@User nvarchar(60),
	@ReturnCode int OUTPUT,
	@New_Identity int  OUTPUT

		
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- Insert Agreement
-- Insert a new Agreement in DB 
-- Dave Seddon 2013-01-17

------------------------------------------------------
-- Declare our variables
DECLARE @Error int
	
	IF 
	(select COUNT(*) from HRSC.HR_AGREEMENT_TERM where AGREEMENT_TERM_NAME_EN = @Agreement_Term_Name_en or 
		   AGREEMENT_TERM_NAME_FR = @Agreement_Term_Name_fr) = 0
		   
	BEGIN	 
     INSERT INTO HRSC.HR_AGREEMENT_TERM
          ( 
		   AGREEMENT_TERM_CODE,
           AGREEMENT_TERM_NAME_EN,
		   AGREEMENT_TERM_NAME_FR,
		   AGREEMENT_TERM_DESC_EN,
		   AGREEMENT_TERM_DESC_FR,
		   EFFECTIVE_DATE        ,
		   USER_CREATED          ,
		   DATE_CREATED         
		   ) 
     VALUES 
          ( 
		    @Agreement_Term_code ,
            @Agreement_Term_Name_en ,
			@Agreement_Term_Name_fr ,
			@Agreement_Term_Desc_en ,
			@Agreement_Term_Desc_fr ,
			@Effective_date        ,
			@User                  ,
			GETDATE()
			)
		
		SELECT @New_Identity = @@IDENTITY
				  
	END    

 --begin transaction			  
DECLARE @Temp TABLE (ID INT IDENTITY(1,1), Item BIGINT)
   INSERT INTO @Temp (Item)
   
	SELECT * FROM HRSC_App.Split (@FormIDs, '|')	
	
	DECLARE @CountFromTemp INT = (SELECT COUNT(*) FROM @Temp)   
	
	       
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
			 UPDATE HRSC.HR_Agreement_Request_Type  
					SET USER_UPDATED = @User,
						DATE_UPDATED = GETDATE(),
						EXPIRY_DATE  = GETDATE()
			  FROM HRSC.HR_Agreement_Request_Type  ART
			  WHERE ART.HR_REQUEST_TYPE_ID = @ID
			  AND ART.EXPIRY_DATE IS NULL
						  
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
	IF @CountFromTemp != 0 AND @New_Identity != 0
		BEGIN
			DECLARE @Count INT = (SELECT MIN(ID) FROM @Temp) 
			DECLARE @RequestTypeID INT 
			
			   WHILE @Count <= (SELECT MAX(ID) FROM @Temp) 
				   BEGIN
					  SELECT @RequestTypeID = Item FROM @Temp WHERE ID = @Count
					  INSERT INTO [HRSC].HR_Agreement_Request_Type
								 (AGREEMENT_TERM_ID,
								  HR_REQUEST_TYPE_ID,
								  EFFECTIVE_DATE,
								  USER_CREATED,
								  DATE_CREATED
								  )
						   VALUES
								 (@New_Identity,
								  @RequestTypeID,
								  @Effective_date,
								  @User,
								  GETDATE()
								  ) 
				   SET @Count = @Count + 1
				END
		END


SET @New_Identity = @New_Identity

		SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @ReturnCode = @@ERROR
else
  set @ReturnCode = 0

 




