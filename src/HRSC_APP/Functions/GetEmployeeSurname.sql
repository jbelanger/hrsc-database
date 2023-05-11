


CREATE   FUNCTION [HRSC_APP].[GetEmployeeSurname]
(@ReqID bigint)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
declare @empName nvarchar(MAX), @SepID bigint, @PosID bigint, @OtID bigint, @CoiID bigint, @ELSID bigint;
        
	Select @SepID = SEPARATION_CLEARANCE_ID from [HRSC].[SEPARATION_CLEARANCE] where HR_REQUEST_ID = @ReqID;
    Select @PosID = POSITION_ID from [HRSC].[POSITION] where HR_REQUEST_ID = @ReqID;
	Select @ELSID =  SLE_REQUEST_ID from [HRSC].[SLE_REQUEST] where HR_REQUEST_ID = @ReqID;
	Select @CoiID =  COI_ID from [HRSC].[COI] where HR_REQUEST_ID = @ReqID;

    if NOT @SepID is null
      begin
        set @empName = (SELECT RC.[SURNAME] From [HRSC].[HR_REQUEST_CLIENT] RC
						JOIN [HRSC].[HR_REQUEST] HR on HR.HR_REQUEST_CLIENT_ID = RC.HR_REQUEST_CLIENT_ID
						JOIN [HRSC].[SEPARATION_CLEARANCE] SC on SC.HR_REQUEST_ID = HR.HR_REQUEST_ID
						WHERE SC.SEPARATION_CLEARANCE_ID = @SepID)
      end
      
    if NOT @PosID is null
      begin
        set @empName = (SELECT RC.[SURNAME] From [HRSC].[HR_REQUEST_CLIENT] RC
						JOIN [HRSC].[HR_REQUEST] HR on HR.HR_REQUEST_CLIENT_ID = RC.HR_REQUEST_CLIENT_ID
						JOIN [HRSC].[POSITION] P on P.HR_REQUEST_ID = HR.HR_REQUEST_ID
						WHERE P.POSITION_ID = @PosID );
      end

	if NOT @CoiID is null
      begin
        set @empName = (SELECT RC.[SURNAME] From [HRSC].[HR_REQUEST_CLIENT] RC
						JOIN [HRSC].[HR_REQUEST] HR on HR.HR_REQUEST_CLIENT_ID = RC.HR_REQUEST_CLIENT_ID
						JOIN [HRSC].[COI] CO on CO.HR_REQUEST_ID = HR.HR_REQUEST_ID
						WHERE CO.COI_ID = @CoiID);
      end

	   if NOT @ELSID is null
      begin
        set @empName = (SELECT RC.[SURNAME] From [HRSC].[HR_REQUEST_CLIENT] RC
						JOIN [HRSC].[HR_REQUEST] HR on HR.HR_REQUEST_CLIENT_ID = RC.HR_REQUEST_CLIENT_ID
						JOIN [HRSC].[SLE_REQUEST] SLE on SLE.HR_REQUEST_ID = HR.HR_REQUEST_ID
						WHERE SLE.[SLE_REQUEST_ID] = @ELSID );
      end
     
    if @empName is Null 
      begin
        set @empName = '';
      end
      
    return @empName;
END
