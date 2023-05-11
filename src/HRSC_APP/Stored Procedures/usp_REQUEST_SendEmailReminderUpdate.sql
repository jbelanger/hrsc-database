



CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_SendEmailReminderUpdate]
@pID bigint, @pDate date, @pCount tinyint
WITH EXEC AS CALLER
AS
/***************************************************/
/*                    ENO                          */
/* This updates the counter and date of the        */
/*       request for the next Reminder             */
/***************************************************/

UPDATE HRSC.HR_REQUEST
set NEXT_EMAIL_REMINDER_DATE = @pDate,
 EMAIL_REMINDER_COUNT = @pCount
where HR_REQUEST_ID = @pID
