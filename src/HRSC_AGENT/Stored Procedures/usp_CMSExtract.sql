



CREATE   PROCEDURE [HRSC_AGENT].[usp_CMSExtract]
(
@pI_EmailTO nvarchar(max)
)
AS
BEGIN




--**************************************************************************************

-- MADE BY SIMON VALOIS. NOVEMBER 2011**--
-- Updated and adapted for HRSC by Yves Robichaud 29/09/2015


--****AJUST PARAMETER


UPDATE [HRSC].[CMS_EXTRACT]
SET [HRSC].[CMS_EXTRACT].[LANGUAGE] = 1
FROM [HRSC].[CMS_EXTRACT] WHERE [HRSC].[CMS_EXTRACT].[LANGUAGE] = 0

--******


--DECLARE CURSOR VARIABLES
--declare @pay_list_id_email nvarchar(max)
declare @pri nvarchar(9)
declare @first_name nvarchar(10)
declare @initials nvarchar(3)
declare @last_name nvarchar(20)
declare @tenure nvarchar(1)
declare @pay_list bigint
declare @pay_office bigint
declare @language_id_code smallint
declare @manager1 nvarchar(1)
declare @manager2 nvarchar(1)
declare @paycycle2 nvarchar(1)
declare @paycycle nvarchar(1)
declare @insertcounter bigint = 0
declare @updatecounter bigint = 0
declare @insertpaylistcounter int = 0
declare @extracttimestart time = convert(time, GETDATE())
declare @extracttimeend time
declare @duration int = 0
declare @errorcounter int = 0
declare @linebreak varchar(2) = char(13) + char(10)
declare @stringerrorcounter nvarchar(100)
declare @CompletePayCycle nvarchar(2)
declare @guid nvarchar(36)






--DECLARE, OPEN CURSOR
declare [CMS_EMPLOYEE] CURSOR FOR

SELECT [TENURE]
      ,[PRI]
      ,[FIRST_NAME]
      ,[INITIALS]
      ,[LAST_NAME]
      ,[PAY_OFFICE]
      ,[PAY_LIST]
      ,[LANGUAGE]
      ,[MANAGER1]
      ,[MANAGER2]
      ,[PAYCYCLE2]
      ,[PAYCYCLE]
	  ,[GUID]
  FROM [HRSC].[CMS_EXTRACT]

OPEN [CMS_EMPLOYEE]
FETCH NEXT FROM [CMS_EMPLOYEE]
INTO @tenure, @pri, @first_name, @initials, @last_name, @pay_office, @pay_list, @language_id_code, @manager1, @manager2, @paycycle2, @paycycle, @guid


WHILE @@FETCH_STATUS = 0


BEGIN TRY
	set nocount on

	declare @tenure_id bigint = 0
	declare @manager bit = 0


	---TRIM STRING
	set @last_name = RTRIM(@last_name)
	set @first_name = RTRIM(@first_name)
	set @initials = RTRIM(@initials)

	set @guid = LTRIM(RTRIM(@guid))

	---SET TENURE_ID   
	set @tenure_id = 1;

  
	---SET MANAGER 
	IF @manager1 = 'Y' 
	OR @manager2 = 'Y'

	set @manager = 'TRUE'

	ELSE 

	set @manager = 'FALSE'


	---SET PAYCYCLE
	set @CompletePayCycle = RTRIM(substring(@paycycle,1,1) + @paycycle2)



	---Print variables for debugging
--	PRINT '@language_id_code'
--	PRINT @language_id_code
--	PRINT '@CompletePayCycle'
--	PRINT @CompletePayCycle
--	PRINT '@pay_list'
--	PRINT @pay_list
--	PRINT '@pri'
--	PRINT @pri
--	PRINT '@last_name'
--	PRINT @last_name
--	PRINT '@first_name'
--	PRINT @first_name
--	PRINT '@initials'
--	PRINT @initials
--	PRINT '@manager'
--	PRINT @manager
--	PRINT '@tenure_id'
--	PRINT @tenure_id
--	PRINT '@guid'
--	PRINT @guid


	--INSERT INTO EMPLOYEE TABLE
	IF NOT EXISTS(SELECT [HRSC].[EMPLOYEE_EXTENDED].[PRI]
		   FROM [HRSC].[EMPLOYEE_EXTENDED]
		   WHERE [HRSC].[EMPLOYEE_EXTENDED].[PRI] = @pri)
		BEGIN
		-- Does the GUID already exist for another PRI. If it does, replace the @guid with blanks
		IF EXISTS(SELECT [HRSC].[EMPLOYEE_EXTENDED].[GUID]
					FROM [HRSC].[EMPLOYEE_EXTENDED]
					WHERE [HRSC].[EMPLOYEE_EXTENDED].[PRI] <> @pri AND --*** This condition should never happen in this section of code...
						  [HRSC].[EMPLOYEE_EXTENDED].[GUID] = @GUID AND
						  [HRSC].[EMPLOYEE_EXTENDED].[GUID] <> '')
			BEGIN
				set @guid = ''
			END
		INSERT INTO [HRSC].[EMPLOYEE_EXTENDED] ([LANGUAGE], [PAYCYCLE], [PAYLIST], [PRI], [SURNAME], [GIVEN_NAME], [EMPLOYEE_INITIAL], [MANAGER_IND], [USER_CREATED], [CMS_REFRESH_DATE], [GUID])
		VALUES (@language_id_code, @CompletePayCycle, @pay_list, @pri, @last_name, @first_name, @initials, @manager, 'CMS_EXTRACT', GETDATE(), @guid)
		set @insertcounter = @insertcounter + 1
		END

	ELSE

		BEGIN

		IF @guid <> ''
		BEGIN
			-- Does the GUID already exist for another PRI. If it does, replace the @guid with blanks
			DECLARE @CurrentGUID nvarchar(36);
			SELECT @CurrentGUID = [HRSC].[EMPLOYEE_EXTENDED].[GUID]
				FROM [HRSC].[EMPLOYEE_EXTENDED]
				WHERE [HRSC].[EMPLOYEE_EXTENDED].[PRI] <> @pri
			IF @guid <> @CurrentGUID
			BEGIN
				IF EXISTS(SELECT [HRSC].[EMPLOYEE_EXTENDED].[GUID]
							FROM [HRSC].[EMPLOYEE_EXTENDED]
							WHERE	[HRSC].[EMPLOYEE_EXTENDED].[PRI] <> @pri AND --*** This condition should never happen in this section of code...
									[HRSC].[EMPLOYEE_EXTENDED].[GUID] = @GUID AND
									[HRSC].[EMPLOYEE_EXTENDED].[GUID] <> '')
					BEGIN
						set @guid = ''
					END

			END
		END

		IF @language_id_code <> (SELECT [LANGUAGE] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END
		IF @CompletePayCycle <> (SELECT [PAYCYCLE] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END

		IF @pay_list <> (SELECT [PAYLIST] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END

		IF @last_name not like (SELECT [SURNAME] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END

		IF @first_name not like (SELECT [GIVEN_NAME] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END

		IF @initials not like (SELECT [EMPLOYEE_INITIAL] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END

		IF @manager <> (SELECT [MANAGER_IND] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END

		if @guid <> (SELECT [GUID] from [HRSC].[EMPLOYEE_EXTENDED] WHERE [PRI] = @pri)
		BEGIN
			EXEC [HRSC_APP].[usp_UpdateEmployeeFromCMSExtract] @language_id_code, @CompletePayCycle, @pay_list, @last_name, @first_name, @initials, @manager, @tenure_id, @pri, @guid
			set @updatecounter = @updatecounter + 1
		END
	END
	
FETCH NEXT FROM [CMS_EMPLOYEE]
INTO @tenure, @pri, @first_name, @initials, @last_name, @pay_office, @pay_list, @language_id_code, @manager1, @manager2, @paycycle2, @paycycle, @guid

END TRY
BEGIN CATCH


	INSERT INTO [HRSC].[CMS_EXTRACT_ERRORS] ([TENURE], [PRI], [FIRST_NAME], [INITIALS], [LAST_NAME], [PAY_OFFICE], [PAY_LIST], [LANGUAGE], [MANAGER1], [MANAGER2], [PAYCYCLE2], [PAYCYCLE] ) 
	VALUES									(@tenure, @pri, @first_name, @initials, @last_name, @pay_office, @pay_list, @language_id_code, @manager1, @manager2, @paycycle2, @paycycle)
	


 set @errorcounter = @errorcounter + 1
FETCH NEXT FROM [CMS_EMPLOYEE]
INTO @tenure, @pri, @first_name, @initials, @last_name, @pay_office, @pay_list, @language_id_code, @manager1, @manager2, @paycycle2, @paycycle, @guid

END CATCH

--CLOSE & DEALLOCATE CURSOR

CLOSE [CMS_EMPLOYEE]
DEALLOCATE [CMS_EMPLOYEE]

--CALC DURATION

set @extracttimeend = CONVERT(time, GETDATE())

set @duration = DATEDIFF(MI,@extracttimestart,@extracttimeend)



--INSERT INTO EMPLOYEE_EXTRACT
INSERT INTO [HRSC].[EMPLOYEE_EXTRACT] ([EXTRACT_DATE], [EMPLOYEE_ADDED_COUNT], [EMPLOYEE_REFRESHED_COUNT], [PAYLIST_ADDED_COUNT], [EXTRACT_DURATION]) 
VALUES (GETDATE(), @insertcounter, @updatecounter, @insertpaylistcounter, @duration)




--SEND NOTIFICATION EMAIL


declare @stringinsertcounter nvarchar(max)
declare @stringupdatecounter nvarchar(max)

set @stringinsertcounter = 'CMS_EXTRACT PROCEDURE INSERTED ' + convert(varchar(5), @insertcounter) + ' ROWS.'
set @stringupdatecounter = 'CMS_EXTRACT PROCEDURE UPDATED ' + convert(varchar(5), @updatecounter) + ' RECORDS.'
set @stringerrorcounter = 'CMS_EXTRACT PROCEDURE INSERTED ' + convert(nvarchar(5),@errorcounter) + ' ERROR RECORDS INTO CMS_EXTRACT_ERRORS TABLE.'

declare @subject nvarchar(100) = 'HRSC/CSRH - CMS_EXTRACT ' + convert(nvarchar(20),getdate())
declare @p_recipients nvarchar(max) = @pI_EmailTO
declare @emailbody nvarchar(max) = @stringupdatecounter + @linebreak + @stringinsertcounter + @linebreak + @stringerrorcounter + @linebreak + @linebreak + 'Duration: ' + convert(nvarchar(40),@duration) + ' Minute'
declare @profile nvarchar(100) = 'SQL Server Databases Services'


-- To be uncommented to send the email
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = @profile,
    @recipients = @p_recipients,
    @body = @emailbody, 
    @subject = @subject;



--**************************************************************************************


END
