


CREATE   FUNCTION [HRSC_APP].[GetEmployeeEmail]
(@ReqID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
declare @empEmail nvarchar(MAX), @SepID bigint, @PosID bigint, @OtID bigint, @ELSID bigint;
        
    Select @SepID = SEPARATION_CLEARANCE_ID from [HRSC].[SEPARATION_CLEARANCE] where HR_REQUEST_ID = @ReqID;
    Select @PosID = POSITION_ID from [HRSC].[POSITION] where HR_REQUEST_ID = @ReqID;
	Select @ELSID =  SLE_REQUEST_ID from [HRSC].[SLE_REQUEST] where HR_REQUEST_ID = @ReqID;
    --Select @OtID =  OVERTIME_ID from HRSC.HR_REQUEST where HR_REQUEST_ID = @ReqID;

    --if NOT @OtID is null
    --  begin
    --    set @empEmail = (Select EMPLOYEE_EMAIL_ADDRESS from HRSC.OVERTIME where OVERTIME_ID = @OtID);
    --  end

    if NOT @SepID is null
      begin
        set @empEmail = (SELECT RC.EMAIL From [HRSC].[HR_REQUEST_CLIENT] RC
						JOIN [HRSC].[HR_REQUEST] HR on HR.HR_REQUEST_CLIENT_ID = RC.HR_REQUEST_CLIENT_ID
						JOIN [HRSC].[SEPARATION_CLEARANCE] SC on SC.HR_REQUEST_ID = HR.HR_REQUEST_ID
						WHERE SC.SEPARATION_CLEARANCE_ID = @SepID);
      end
      
    if NOT @PosID is null
      begin
         set @empEmail = (SELECT RC.EMAIL From [HRSC].[HR_REQUEST_CLIENT] RC
						JOIN [HRSC].[HR_REQUEST] HR on HR.HR_REQUEST_CLIENT_ID = RC.HR_REQUEST_CLIENT_ID
						JOIN [HRSC].[POSITION] P on P.HR_REQUEST_ID = HR.HR_REQUEST_ID
						WHERE P.POSITION_ID = @PosID );
      end

	  if NOT @ELSID is null
      begin
        set @empEmail = (SELECT RC.EMAIL From [HRSC].[HR_REQUEST_CLIENT] RC
						JOIN [HRSC].[HR_REQUEST] HR on HR.HR_REQUEST_CLIENT_ID = RC.HR_REQUEST_CLIENT_ID
						JOIN [HRSC].[SLE_REQUEST] SLE on SLE.HR_REQUEST_ID = HR.HR_REQUEST_ID
						WHERE SLE.[SLE_REQUEST_ID] = @ELSID );
      end
     
    if @empEmail is Null 
      begin
        set @empEmail = '';
      end
      
    return @empEmail;
END
