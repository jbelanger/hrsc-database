




CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_SendEmailReminderThreadCleanup]
@pDate date
WITH EXEC AS CALLER
AS
/***************************************************/
/*                    ENO                          */
/* This is used to cleanup the status that do      */
/* not need need Reminders to be sent to the clients */
/***************************************************/

update HRSC.HR_REQUEST 
  set EMAIL_REMINDER_COUNT = null,
      NEXT_EMAIL_REMINDER_DATE=null

where REQUEST_STATUS_ID in (select REQUEST_STATUS_ID from HRSC.CD_REQUEST_STATUS where not REQUEST_STATUS_CODE in (N'WSIGN', N'RTRNC'))
and EMAIL_REMINDER_COUNT > 0 and NEXT_EMAIL_REMINDER_DATE is not null
