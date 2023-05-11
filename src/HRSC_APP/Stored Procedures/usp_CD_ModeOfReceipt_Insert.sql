



CREATE   PROCEDURE [HRSC_APP].[usp_CD_ModeOfReceipt_Insert]
@pNameEn nvarchar(250), @pNameFr nvarchar(250), @pDescEn nvarchar(4000), @pDescFr nvarchar(4000), @pModeofReceiptCode nvarchar(5), @pUserCreated nvarchar(30), @pReturnCode int OUTPUT
WITH EXEC AS CALLER
AS
------------------------------------------------------
-- InsertCdModeOfReceipt
-- Insert a new Mode of reception in DB 
-- Gaétan Demers 2011-12-13 
------------------------------------------------------
-- Declare our variables
DECLARE @Error int

insert into HRSC.CD_MODE_OF_RECEIPT
  (MODE_OF_RECEIPT_NAME_EN,
   MODE_OF_RECEIPT_NAME_FR,
   MODE_OF_RECEIPT_DESC_EN,
   MODE_OF_RECEIPT_DESC_FR,
   MODE_OF_RECEIPT_CODE,
   EFFECTIVE_DATE,
   USER_CREATED,
   DATE_CREATED)
values
  (@pNameEn,
   @pNameFr,
   @pDescEn,
   @pDescFr,
   @pModeofReceiptCode,
   GetDate(),
   @pUserCreated,
   GetDate())


-- Move it to our local variable, and check for an error condition
SELECT @Error = @@ERROR

-- A Stored Proc always return 0 if no error.
IF @Error != 0
  set @pReturnCode = @@ERROR
else
  set @pReturnCode = 0
