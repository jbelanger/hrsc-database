



-- =============================================
-- Author:		Michel tardif
-- Create date: 2018-12-04
-- Description:	Check If Leader or Collaborator can edit a request
-- =============================================
CREATE   PROCEDURE [HRSC_APP].[usp_REQUEST_CheckIfLeaderOrCollCanEdit]
	@pRequestID bigint,  @pCanEdit bit OUTPUT
AS
SET @pCanEdit = 0;

IF NOT EXISTS(
	-- Si le ou les interventions ne sont sont pas inclu dans la liste des statuts on ne continuer le processus
	SELECT RS.[REQUEST_STATUS_CODE]
		  ,RI.[REQUEST_STATUS_ID]
		  ,RI.[HR_REQUEST_INTERVENTION_ID]
		  ,RI.[USER_CREATED]
		  ,RI.[USER_UPDATED]
		  ,RI.[DATE_CREATED]
		  ,RI.[DATE_UPDATED]
		  ,RI.[EXPIRY_DATE]
	  FROM [HRSC].[HR_REQUEST_INTERVENTION] RI
  		INNER JOIN [HRSC].[CD_REQUEST_STATUS] RS ON RS.[REQUEST_STATUS_ID] = RI.[REQUEST_STATUS_ID]
	  WHERE RI.[HR_REQUEST_ID] = @pRequestID AND  NOT (RS.[REQUEST_STATUS_CODE] IN ('TSF', 'NEW', 'ASGN', 'NOACT', 'ATSF', 'PROC'))
	  
	  )

	BEGIN
		---- Recherche combien de leader pour la demande si plus de 1 on ne peut modifier la demande
		DECLARE @NbrLeader BIGINT;
		DECLARE @NbrCollabo BIGINT;

 		SET @NbrLeader = (SELECT DISTINCT COUNT(US.[EMPLOYEE_ID])
				FROM [HRSC].[HR_RQST_INTRVNT_HRSC_USER] US
					INNER JOIN [HRSC].[HR_REQUEST_INTERVENTION] RI ON RI.[HR_REQUEST_INTERVENTION_ID] = US.[REQUEST_INTERVENTION_ID]
					INNER JOIN [HRSC].[CD_EMPLOYEE_ROLE] ER ON ER.[EMPLOYEE_ROLE_ID] = US.[EMPLOYEE_ROLE_ID]
				WHERE RI.[HR_REQUEST_ID] = @pRequestID AND ER.[EMPLOYEE_ROLE_CODE] = 'LEAD' AND US.[EXPIRY_DATE] IS NULL)

 		SET @NbrCollabo = (SELECT DISTINCT COUNT(US.[EMPLOYEE_ID])
				FROM [HRSC].[HR_RQST_INTRVNT_HRSC_USER] US
					INNER JOIN [HRSC].[HR_REQUEST_INTERVENTION] RI ON RI.[HR_REQUEST_INTERVENTION_ID] = US.[REQUEST_INTERVENTION_ID]
					INNER JOIN [HRSC].[CD_EMPLOYEE_ROLE] ER ON ER.[EMPLOYEE_ROLE_ID] = US.[EMPLOYEE_ROLE_ID]
				WHERE RI.[HR_REQUEST_ID] = @pRequestID AND ER.[EMPLOYEE_ROLE_CODE] = 'COL' AND US.[EXPIRY_DATE] IS NULL)


		IF @NbrLeader + @NbrCollabo > 0
			SET @pCanEdit = 1;			
		ELSE
			SET @pCanEdit = 0;			

	END


