


CREATE   PROCEDURE [HRSC_APP].[usp_PositionLanguageProfiles_InsertUpdate] (
	@LangProfileNewID BIGINT OUTPUT,
	@LangProfileCurrentID BIGINT OUTPUT,
	@LangProficiencyNewID BIGINT,
	@LangProficiencyCurrentID BIGINT,
	@ReadingEnNewID BIGINT,
	@ReadingEnCurrentID BIGINT,
	@ReadingFrNewID BIGINT,
	@ReadingFrCurrentID BIGINT,
	@WritingEnNewID BIGINT,
	@WritingEnCurrentID BIGINT,
	@WritingFrNewID BIGINT,
	@WritingFrCurrentID BIGINT,
	@OralEnNewID BIGINT,
	@OralEnCurrentID BIGINT,
	@OralFrNewID BIGINT,
	@OralFrCurrentID BIGINT,
	@User VARCHAR(60)
)
	
WITH EXEC AS CALLER
AS

IF @LangProfileNewID > 0 
	BEGIN
		UPDATE HRSC.LANGUAGE_PROFILE SET 
			LANG_PROFICIENCY_ID = @LangProficiencyNewID,
			ORAL_EN_LANG_LVL_ID = @OralEnNewID,
			ORAL_FR_LANG_LVL_ID = @OralFrNewID,
			RDNG_EN_LANG_LVL_ID = @ReadingEnNewID,
			RDNG_FR_LANG_LVL_ID = @ReadingFrNewID,
			WRTNG_EN_LANG_LVL_ID = @WritingEnNewID,
			WRTNG_FR_LANG_LVL_ID = @WritingFrNewID,
			USER_UPDATED = @User,
			DATE_UPDATED = GETDATE()
		 WHERE LANGUAGE_PROFILE_ID = @LangProfileNewID;
	END
	
ELSE 
	BEGIN
		INSERT INTO HRSC.LANGUAGE_PROFILE(
			LANG_PROFICIENCY_ID,
			ORAL_EN_LANG_LVL_ID,
			ORAL_FR_LANG_LVL_ID,
			RDNG_EN_LANG_LVL_ID,
			RDNG_FR_LANG_LVL_ID,
			WRTNG_EN_LANG_LVL_ID,
			WRTNG_FR_LANG_LVL_ID,
			USER_CREATED,
			DATE_CREATED)
		VALUES (
		@LangProficiencyNewID,
		@OralEnNewID,
		@OralFrNewID,
		@ReadingEnNewID,
		@ReadingFrNewID,
		@WritingEnNewID,
		@WritingFrNewID,
		@User,
		GETDATE());

		Set @LangProfileNewID = @@IDENTITY;
	END

	
 IF @LangProfileCurrentID > 0 
    BEGIN
		UPDATE HRSC.LANGUAGE_PROFILE SET 
			LANG_PROFICIENCY_ID = @LangProficiencyCurrentID,
			ORAL_EN_LANG_LVL_ID = @OralEnCurrentID,
			ORAL_FR_LANG_LVL_ID = @OralFrCurrentID,
			RDNG_EN_LANG_LVL_ID = @ReadingEnCurrentID,
			RDNG_FR_LANG_LVL_ID = @ReadingFrCurrentID,
			WRTNG_EN_LANG_LVL_ID = @WritingEnCurrentID,
			WRTNG_FR_LANG_LVL_ID = @WritingFrCurrentID,
			USER_UPDATED = @User,
			DATE_UPDATED = GETDATE()
		 WHERE LANGUAGE_PROFILE_ID = @LangProfileCurrentID;
	END
	
ELSE
	BEGIN
		INSERT INTO HRSC.LANGUAGE_PROFILE( 
			LANG_PROFICIENCY_ID,
			ORAL_EN_LANG_LVL_ID,
			ORAL_FR_LANG_LVL_ID,
			RDNG_EN_LANG_LVL_ID,
			RDNG_FR_LANG_LVL_ID,
			WRTNG_EN_LANG_LVL_ID,
			WRTNG_FR_LANG_LVL_ID,
			USER_CREATED,
			DATE_CREATED)
		VALUES (
			@LangProficiencyCurrentID,
			@OralEnCurrentID,
			@OralFrCurrentID,
			@ReadingEnCurrentID,
			@ReadingFrCurrentID,
			@WritingEnCurrentID,
			@WritingFrCurrentID,
			@User,
			GETDATE());	  

  		SET @LangProfileCurrentID = @@IDENTITY;
	END
