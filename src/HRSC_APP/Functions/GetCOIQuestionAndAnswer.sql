



CREATE   FUNCTION [HRSC_APP].[GetCOIQuestionAndAnswer]
(@COI_ID bigint, @bitEnglish bit)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
declare 
@QuestionAnswer nvarchar(MAX) = '', 
@CoiID bigint, 
@COIDeclarationTypeID bigint,
@DeclarationTypeIDTemp bigint = 0,
@DeclarationNameEn nvarchar(MAX),
@DeclarationNameFr nvarchar(MAX),
@QuestionEn nvarchar(MAX),
@QuestionFr nvarchar(MAX),
@Answer nvarchar(MAX),
@count bigint=0;
        
	

   


	  DECLARE MyCursor CURSOR
	  LOCAL STATIC READ_ONLY FORWARD_ONLY
	  FOR
	   SELECT  DT.[COI_DECLARATION_TYPE_ID],
	   ANSWER = (Select A.[ANSWER] FROM [HRSC].[COI_ANSWER] A where A.[COI_ID] = @COI_ID and A.[COI_QUESTION_ID] = Q.[COI_QUESTION_ID]),
		DT.[COI_DECLARATION_TYPE_NAME_EN],
		DT.[COI_DECLARATION_TYPE_NAME_FR],
		Q.[COI_QUESTION_EN],
		Q.[COI_QUESTION_FR]
		FROM [HRSC].[CD_COI_DECLARATION_TYPE] DT
			INNER JOIN [HRSC].[CD_COI_QUESTION] Q ON DT.[COI_DECLARATION_TYPE_ID] = Q.[COI_DECLARATION_TYPE_ID] 

		OPEN MyCursor
			FETCH NEXT FROM MyCursor INTO @COIDeclarationTypeID, @Answer, @DeclarationNameEn, @DeclarationNameFr, @QuestionEn, @QuestionFr
			WHILE @@FETCH_STATUS = 0
			BEGIN 
			
				if @COIDeclarationTypeID <> @DeclarationTypeIDTemp 
					begin
						if @Answer is not null
						begin
							if @count = 0
								begin
								set @QuestionAnswer += @DeclarationNameEn + CHAR(13) + CHAR(13);
								set @QuestionAnswer += @QuestionEn + CHAR(13);
								set @QuestionAnswer += @Answer + CHAR(13) + CHAR(13);
								set @count = 1
								end
							else
								begin
								set @QuestionAnswer += @QuestionEn + CHAR(13);
								set @QuestionAnswer += @Answer + CHAR(13) + CHAR(13);
								end 
							end
						
					end
				else
					begin
					if @Answer is not null	
					begin			
						set @QuestionAnswer += @QuestionEn + CHAR(13);
						set @QuestionAnswer += @Answer + CHAR(13) + CHAR(13);
						set @DeclarationTypeIDTemp = @COIDeclarationTypeID;
						set @count = 0
					end
					end
				
			
			FETCH NEXT FROM MyCursor INTO @COIDeclarationTypeID, @Answer, @DeclarationNameEn, @DeclarationNameFr, @QuestionEn, @QuestionFr
			END
			CLOSE MyCursor
			DEALLOCATE MyCursor
    return @QuestionAnswer;
END
