param (
        [Parameter(Mandatory=$true, HelpMessage="Enter a valid connection string")]        
        [ValidateNotNullOrEmpty()]
        [string]$ConnectionString
    )

# -------------------------------
# Change this if needed
# -------------------------------
# Where to output the generated files
$path = "C:\Temp\ReferenceData"


# Function: Invoke-GenerateMergeProcedure
# Description: Executes a stored procedure to generate a merge script for a specified table and saves the result as a SQL file.
# Parameters:
#    - TableName: The name of the table for which the merge script will be generated.
#    - OutputPath: The path where the generated SQL file will be saved.
function Invoke-GenerateMergeProcedure {
    param (
        [string]$TableName,
		[string]$OutputPath
    )    

    # Create a new SqlConnection object
    $connection = New-Object System.Data.SqlClient.SqlConnection($ConnectionString)

    try {
        # Open the database connection
        $connection.Open()

        # Create a new SqlCommand object
        $command = New-Object System.Data.SqlClient.SqlCommand

        # Set the command properties
        $command.Connection = $connection
        $command.CommandType = [System.Data.CommandType]::StoredProcedure
        $command.CommandText = "hrsc_app.usp_generate_merge"

        # Create a parameter for the table name
        $paramTableName = New-Object System.Data.SqlClient.SqlParameter("@table_name", [System.Data.SqlDbType]::VarChar)
        $paramTableName.Value = $TableName
        $command.Parameters.Add($paramTableName) | Out-Null 
		
		# Hardcoded SQL parameters
        $paramSchema = New-Object System.Data.SqlClient.SqlParameter("@schema", [System.Data.SqlDbType]::VarChar)
        $paramSchema.Value = "HRSC"
        $command.Parameters.Add($paramSchema) | Out-Null 

        $paramBatchSeparator = New-Object System.Data.SqlClient.SqlParameter("@batch_separator", [System.Data.SqlDbType]::VarChar)
        $paramBatchSeparator.Value = [System.DBNull]::Value
        $command.Parameters.Add($paramBatchSeparator) | Out-Null 

        $paramIncludeUseDB = New-Object System.Data.SqlClient.SqlParameter("@include_use_db", [System.Data.SqlDbType]::Bit)
        $paramIncludeUseDB.Value = $false
        $command.Parameters.Add($paramIncludeUseDB) | Out-Null 

        $paramResultsToText = New-Object System.Data.SqlClient.SqlParameter("@results_to_text", [System.Data.SqlDbType]::Bit)
        $paramResultsToText.Value = $false
        $command.Parameters.Add($paramResultsToText) | Out-Null 
		
		$paramDeleteIfNotMatched = New-Object System.Data.SqlClient.SqlParameter("@delete_if_not_matched", [System.Data.SqlDbType]::Bit)
        $paramDeleteIfNotMatched.Value = $false
        $command.Parameters.Add($paramDeleteIfNotMatched) | Out-Null 
		
        # Execute the stored procedure and retrieve the result as XML
        $xmlResult = $command.ExecuteScalar() 		
        
		# Write the XML result to file
		if ($xmlResult) {
			# Remove "<?x" from the start of the string
			$xmlResult = $xmlResult -replace '^<\?x ---', ''

			# Remove "?>" from the end of the string
			$xmlResult = $xmlResult -replace '\?>$', ''
			
            $fileNamePath = "$OutputPath\HRSC.$TableName.Table.sql"
			$xmlResult | Set-Content -Path $fileNamePath -Encoding UTF8
			Write-Host "File $fileNamePath written successfully."
        }
    }
    finally {
        if ($connection.State -eq [System.Data.ConnectionState]::Open) {
            $connection.Close()
        }
    }
}

# Check if the directory exists
if (-not (Test-Path -Path $path)) {
	# Create the directory if it does not exist
	New-Item -Path $path -ItemType Directory -Force | Out-Null
	Write-Host "Directory created: $path"
} else {
	Write-Host "Directory already exists: $path"
	# Clear all files in the directory
	Get-ChildItem -Path $path | Remove-Item -Force
	Write-Host "Files cleared in directory: $path"
}

# Call the function with different table names
Invoke-GenerateMergeProcedure -TableName "APPROVAL_TRANSFER_RULE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "BC_CATEGORY" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "BUSINESS_CENTER_ATTR" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_ACADEMIC_LEVEL" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_ACCOMODATION_REQUIRED" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_ACTION_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_ANNOUNCEMENT_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_ATTRIBUTE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_BUSINESS_CENTER" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_CANDIDATE_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_CHKLST_STATUS" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_CLASSIFICATION_GROUP" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_CLASSIFICATION_LEVEL" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_CLASSIFICATION_SUB_GROUP" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_COI_DECLARATION_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_COI_QUESTION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_COMMUNICATION_REQ" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_DEPARTMENT" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_DEPLOYMENT_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_DOCUMENT_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_DOUBLE_BANKING" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_EMAIL_TEMPLATE_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_EMPLOYEE_ROLE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_EMPLOYEE_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_EXCLUSION_OPTION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_FISCAL_YEAR" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_GD_ACCOUNT_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_HR_GUIDE_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_HR_JUSTIFICATION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_HR_REQUEST_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_HRSC_USER_ROLE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_LANG_PROFICIENCY" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_LANGUAGE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_LANGUAGE_LEVEL" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_LEAVE_WITHOUT_PAY" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_MODE_OF_RECEIPT" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_NOTE_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_ORGANIZATION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_PAY_STATUS" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_POSITION_REQUEST_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_PRIORITY_OF_REQUEST" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_PRIORITY_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_REASON_FOR_SLE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_REASON_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_REGION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_RELOCATION_EXPENSE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_REPORT_REQUEST_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_REQUEST_CATEGORY" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_REQUEST_STATUS" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_REQUEST_SUB_CATEGORY" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_SECURITY_CLEARANCE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_SEPARATION_CHCKLST" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_SEPARATION_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_SERVICE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_STAFFING_PROCESS_STATUS" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_STUDENT_PROGRAM" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_SUB_ORGANIZATION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_SUBMITTER_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_SUNSET_FUNDING_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_TENURE_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_TYPE_OF_STAFFING_ACTION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_VERSION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "CD_WORK_TYPE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "EMAIL_TEMPLATE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "GD_ACCOUNT_EMAIL" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "HR_AGREEMENT_TERM" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "MUNICIPALITY" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "OFFICE_SITE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "PROVINCE" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "REQ_STATUS_JUSTIFICATION" -OutputPath "$path"
Invoke-GenerateMergeProcedure -TableName "SEPARATION_CHKLST_TYPE" -OutputPath "$path"
