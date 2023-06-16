# Main Pipeline YAML

This YAML pipeline in Azure DevOps is designed to build and deploy the "hrsc-database" database project. It consists of several stages, each responsible for a specific deployment target.

## Parameters
- `GitBranch`: Specifies the Git branch on dev.azure.com. Default value is set to `main`.
- `BlockOnPossibleDataLoss`: Determines whether the deployment should block on possible data loss. Default value is set to `true`.
- `DropObjectsNotInSource`: Specifies whether to drop objects not present in the source during deployment. Default value is set to `true`.
- `DevDeploy`: Determines whether to publish to the DEV (HRSC_DEV2) environment. Default value is set to `true`.
- `TstDeploy`: Determines whether to publish to the TST (HRSC TST2) environment. Default value is set to `false`.
- `UatDeploy`: Determines whether to publish to the UAT (HRSC_UAT) environment. Default value is set to `false`.
- `TrnPackage`: Specifies whether to create an SQL script for Training. Default value is set to `false`.
- `ProdPackage`: Specifies whether to create an SQL script for Production. Default value is set to `false`.

## Variables
- `HRSC`: Refers to a variable group named 'HRSC' which contains the required environment variables.
- `Local.ArtifactName`: Specifies the name of the artifact. Default value is set to `drop`.
- `Local.BuildConfiguration`: Specifies the build configuration. Default value is set to `Release`.
- `Local.ProjectName`: Specifies the project name. Default value is set to `hrsc-database`.
- `buildProjectPath`: Specifies the path to the project's solution file.
- `Local.GitRemote`: Specifies the remote Git repository URL.
- `Local.GitToken`: Specifies the token used for Git authentication.

## Stages
- `Build`: Responsible for building the project.
- `DEV`: Deploys to the DEV (HRSC_DEV2) environment.
- `TST`: Deploys to the TST (HRSC TST2) environment.
- `UAT`: Deploys to the UAT (HRSC_UAT) environment.
- `TRN`: Creates an SQL script for Training.
- `PROD`: Creates an SQL script for Production.

Each stage depends on the successful completion of the previous stage and is conditionally executed based on specific criteria.

## Templates
- `pipeline-job-deploy-template.yml`: A reusable template for deploying to a specific environment.
- `pipeline-job-publishartifact-template.yml`: A reusable template for creating an SQL script for a specific environment.


# pipeline-job-deploy-template.yml

This YAML template file `pipeline-job-deploy-template.yml` is designed to deploy the SSDT (SQL Server Data Tools) project to a specific environment. It performs the following steps:

## Steps
1. ExtractFiles: This task extracts files from the build artifact, which is a zip file generated in a previous build step. The extracted files are placed in the specified destination folder.

2. CmdLine: This task generates a publish preview and a database script using SqlPackage.exe. It executes the following commands:
   - SqlPackage.exe /action:DeployReport: Generates a publish preview and outputs a DeploymentReport.xml file.
   - SqlPackage.exe /action:script: Generates a database script and outputs a DbScript.sql file.
\

3. PowerShell: This task executes the generated database script on the target database using the Invoke-Sqlcmd cmdlet. The execution results are stored in an ExecutionResults.txt file.

4. ArchiveFiles: This task creates a zip archive for the generated SQL script. It includes all the files in the $(Build.ArtifactStagingDirectory)/publish folder, excluding the root folder.

5. PublishBuildArtifacts: This task publishes the created zip archive containing the SQL script to the Azure Pipelines artifact container. The artifact is named based on the target environment, specified by the ${{ parameters.Environment }} variable.

These steps ensure that the database script is generated, executed on the target database, and published as an artifact, allowing for further deployment or inspection in the pipeline.

## Parameters
- `Environment`: Specifies the target deployment environment.
- `VariableGroup`: Refers to the variable group associated with the target environment.
- `BlockOnPossibleDataLoss`: Determines whether the deployment should block on possible data loss. Default value is set to `true`.
- `DropObjectsNotInSource`: Specifies whether to drop objects not present in the source during deployment. Default value is set to `false`.

## Jobs
- `deployment`: Represents the deployment job.
  - `workspace`: Defines the workspace configuration.
  - `displayName`: Specifies the display name of the deployment job.
  - `environment`: Refers to the target deployment environment.
  - `variables`: Refers to the variable group associated with the environment.
  - `strategy`: Defines the deployment strategy.
    - `runOnce`: Specifies that the deployment should run only once.
      - `deploy`: Represents the deployment steps.
        - `checkout`: Checks out the source code.
        - `PowerShell`: Installs the latest SqlPackage globally using a PowerShell script.
        - `ExtractFiles`: Extracts files from the build artifact.
        - `CmdLine`: Generates a publish preview and a database script using SqlPackage.exe.
        - `PowerShell`: Executes the script on the database using Invoke-Sqlcmd.
        - `ArchiveFiles`: Creates a zip archive for the SQL script.
        - `PublishBuildArtifacts`: Publishes the SQL script to the Azure Pipelines artifact container.

Please note that certain parameters and variables used in this template, such as `$(DbDeployConnectionString)`, are expected to be defined in the variable group associated with the target environment.

This template can be included and customized within different stages of the main pipeline to facilitate deployment to various environments.