# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an HRSC (Human Resources Service Center) database project using SQL Server Data Tools (SSDT). It manages HR requests, employee data, staffing processes, and related workflows for a government organization.

### Core Components
- **HR_REQUEST** - Central workflow table
- **EMPLOYEE** - AD-integrated employee data
- **50+ code tables** - Reference data
- **Complex approval and intervention workflows**

### Development Workflow
- **Build** via MSBuild/Visual Studio SSDT
- **Deploy** using SqlPackage.exe with environment-specific profiles
- **Azure DevOps CI/CD** with multi-stage deployments
- **Automated reference data seeding** for non-production environments

## Project Structure

- **`src/HRSC/`** - Main database schema containing tables, stored procedures, and functions
- **`src/HRSC_APP/`** - Application-specific functions and stored procedures
- **`src/HRSC_AGENT/`** - Agent-specific stored procedures for data transfer operations
- **`src/Security/`** - Database security objects (logins, users, roles, permissions)
- **`src/Scripts/Seed/`** - Reference data scripts for lookup tables
- **`docs/wiki/`** - Project documentation including deployment guides and reference data info

## Key Database Components

### Core Entities
- **`HR_REQUEST`** - Central table for all HR requests with 45+ fields including status, priority, and metadata
- **`EMPLOYEE`** - Employee information with AD integration, language preferences, and contact details
- **`HR_REQUEST_INTERVENTION`** - Workflow interventions and assignments for requests
- **`STAFFING_PROCESS`** - Staffing-related processes and classifications
- **`POSITION`** - Position definitions with language profiles and communication requirements

### Code Tables (Lookup Data)
The database contains 50+ code tables prefixed with `CD_` that store reference data like:
- Request types, categories, and statuses
- Languages, regions, and organizations
- Employee roles and business centers
- Security clearances and tenure types

### Key Schemas
- **`HRSC`** - Main schema containing tables and user-defined types
- **`HRSC_APP`** - Application functions and stored procedures (200+ objects)
- **`HRSC_AGENT`** - Data transfer operations

## Development Commands

### Build and Deploy
```bash
# Build the database project (requires Visual Studio/SSDT)
msbuild src/hrsc-database.sln /p:Configuration=Release

# Deploy to local development environment
SqlPackage.exe /Action:Publish /SourceFile:hrsc-database.dacpac /PublishProfile:local-dev.publish.xml
```

### Database Deployment Profiles
- **`local-dev.publish.xml`** - Local development SQL Express deployment
- **`INT-TST-UAT.publish.xml`** - Integration, test, and UAT environments  
- **`PROD-TRN.publish.xml`** - Production and training environments

### Reference Data Management
Reference data is automatically seeded on non-production environments via the PostDeployment script. Production environments exclude this seeding for data integrity.

## Important Conventions

### Naming Patterns
- Tables: `UPPER_CASE_WITH_UNDERSCORES`
- Stored procedures: `usp_PascalCase_Action` (e.g., `usp_Employee_Insert`)
- Functions: `PascalCase` (e.g., `GetEmployeeName`)
- Code tables: `CD_` prefix (e.g., `CD_REQUEST_STATUS`)
- Indexes: Descriptive names with `_I` suffix for foreign keys

### Database Standards
- Primary keys use `IDENTITY(1,1)` with `BIGINT` type
- Foreign key constraints follow pattern: `[TABLE]_[REFTABLE]_FK`
- Audit fields: `USER_CREATED`, `DATE_CREATED`, `USER_UPDATED`, `DATE_UPDATED`
- Use `FILLFACTOR = 80` for most indexes, `95` for specific performance indexes

### Security Model
- Application access through `HRSC_USER` and `HRSC_DAD` logins
- Read-only access via `HRSCREADER1` and `HRSCREADER2`
- Custom `db_executor` role for stored procedure execution
- Row-level security implemented for protected requests

## CI/CD Pipeline

The project uses Azure DevOps with multi-stage deployment:
- **Build** - Compiles SSDT project and creates DACPAC
- **DEV/TST/UAT** - Automated deployments to lower environments
- **TRN/PROD** - Creates deployment scripts for manual production releases

Key pipeline parameters:
- `BlockOnPossibleDataLoss` - Controls data loss protection (default: true)
- `DropObjectsNotInSource` - Removes objects not in source (default: true)
- Environment-specific deployment flags for each stage

## Working with the Database

### Adding New Tables
1. Create table SQL file in appropriate schema folder under `src/HRSC/Tables/`
2. Follow existing naming conventions and include audit fields
3. Add foreign key constraints and indexes as needed
4. Update `hrsc-database.sqlproj` to include the new file

### Modifying Stored Procedures
1. Locate procedure in `src/HRSC_APP/Stored Procedures/`
2. Follow existing parameter and naming patterns
3. Include proper error handling and transaction management
4. Test against reference data in lower environments

### Reference Data Updates
1. Modify seed scripts in `src/Scripts/Seed/`
2. Use MERGE statements to handle updates safely
3. Test deployment to ensure data integrity
4. Remember that production excludes automatic seeding

## Key Relationships

The database models complex HR workflows with these primary relationships:
- HR_REQUEST → Multiple intervention and approval workflows
- EMPLOYEE → Role assignments and business center access
- STAFFING_PROCESS → Position classifications and language profiles
- Request categorization through hierarchical category/subcategory structure

When working with this database, always consider the impact on active HR requests and ensure proper testing in lower environments before production deployment.