# HRSC Database Project

![Government of Canada](https://img.shields.io/badge/Government%20of%20Canada-Official-red) ![SQL Server](https://img.shields.io/badge/SQL%20Server-2016+-blue) ![SSDT](https://img.shields.io/badge/SSDT-Database%20Project-green)

## Overview

The **HRSC Database Project** is the foundational data layer for the Government of Canada's Human Resources Service Center (HRSC) application. This SQL Server Data Tools (SSDT) project manages the complete database schema, stored procedures, functions, and reference data for the enterprise HR workflow system serving all federal departments and agencies.

### Key Statistics
- **124 Tables** - Comprehensive data model covering all HR operations
- **200+ Stored Procedures** - Business logic enforcement and data operations
- **50+ Code Tables** - Government-specific reference data and lookup values
- **Multi-Schema Architecture** - Organized by functional domains
- **Bilingual Support** - English/French government compliance built-in

## 🏛️ Government Context

This database project supports the Government of Canada's digital transformation initiative for HR services, providing:

- **Federal Government Compliance** - Adherence to Treasury Board Secretariat guidelines
- **Official Languages Act Support** - Bilingual data structures throughout
- **Canadian Government Classification System** - Full integration with GC job classification
- **Security Clearance Integration** - Support for government security levels
- **Multi-Departmental Operations** - Scalable architecture for all federal agencies

## 🏗️ Database Architecture

The database follows domain-driven design principles with clear functional boundaries:

```
┌─────────────────────────────────────────────────────────────┐
│                      HRSC Database                         │
├─────────────────────────────────────────────────────────────┤
│  HRSC Schema - Core Business Entities                      │
│  ├── HR_REQUEST (Central workflow table)                   │
│  ├── EMPLOYEE (AD-integrated employee data)                │
│  ├── POSITION (Government job classifications)             │
│  ├── STAFFING_PROCESS (Recruitment workflows)              │
│  └── 50+ Code Tables (CD_* reference data)                 │
├─────────────────────────────────────────────────────────────┤
│  HRSC_APP Schema - Application Logic                       │
│  ├── 200+ Stored Procedures (Business operations)          │
│  ├── Functions (Data transformations & calculations)       │
│  └── User Defined Types (Reusable data structures)         │
├─────────────────────────────────────────────────────────────┤
│  HRSC_AGENT Schema - Integration Services                  │
│  └── Data Transfer Procedures (External system sync)       │
├─────────────────────────────────────────────────────────────┤
│  Security Schema - Access Control                          │
│  ├── Logins & Users (Application service accounts)         │
│  ├── Roles & Permissions (Role-based access control)       │
│  └── Row-Level Security (Protected request filtering)      │
└─────────────────────────────────────────────────────────────┘
```

## 🎯 Core Business Domains

### HR Request Management
The central workflow engine managing all HR service requests:

- **`HR_REQUEST`** - Master table with 45+ fields covering the complete request lifecycle
- **`HR_REQUEST_INTERVENTION`** - Workflow steps and business center assignments
- **`HR_REQUEST_APPROVAL`** - Multi-level approval processes with delegation support
- **`HR_REQUEST_STATUS`** - Audit trail and status history tracking
- **`HR_REQUEST_NOTE`** - Communication and documentation throughout the process

### Employee Services
Comprehensive employee data management with government integration:

- **`EMPLOYEE`** - AD-integrated employee profiles with bilingual support
- **`EMPLOYEE_ROLE_FOR_REQUEST`** - Dynamic role assignments per request
- **`EMPLOYEE_SUB_DELEGATED`** - Delegation hierarchies and approval chains
- **`EMPLOYEE_PREVIOUS_POSITION`** - Career history and mobility tracking

### Position & Classification Management
Government job classification and position management:

- **`POSITION`** - Government position definitions with classification codes
- **`POSITION_CLASSIFICATION`** - Canadian government job classification integration
- **`POSITION_LANGUAGE_PROFILE`** - Official languages requirements per position
- **`STAFFING_PROCESS`** - Recruitment and staffing workflow management

### Reference Data Management
Extensive lookup tables supporting government operations:

- **Request Types** - `CD_HR_REQUEST_TYPE`, `CD_REQUEST_CATEGORY`, `CD_REQUEST_SUB_CATEGORY`
- **Organizational Structure** - `CD_ORGANIZATION`, `CD_SUB_ORGANIZATION`, `CD_BUSINESS_CENTER`
- **Geographic Data** - `CD_REGION`, `PROVINCE`, `MUNICIPALITY`, `OFFICE_SITE`
- **Classification Data** - `CD_CLASSIFICATION_GROUP`, `CD_CLASSIFICATION_LEVEL`, `CD_TENURE_TYPE`
- **Language Support** - `CD_LANGUAGE`, `CD_LANGUAGE_LEVEL`, `CD_LANG_PROFICIENCY`

## 🚀 Getting Started

### Prerequisites

- **SQL Server 2016+** or **SQL Server Express 2016+**
- **Visual Studio 2019+** with SQL Server Data Tools (SSDT)
- **SqlPackage.exe** (included with SSDT or available separately)
- **Windows Authentication** or **SQL Server Authentication** configured

### Database Deployment

#### Option 1: Visual Studio SSDT
1. Open `src/hrsc-database.sqlproj` in Visual Studio
2. Right-click the project → **Publish**
3. Configure target connection and publish profile
4. Click **Publish** to deploy

#### Option 2: SqlPackage Command Line
```bash
# Deploy to local development environment
SqlPackage.exe /Action:Publish /SourceFile:hrsc-database.dacpac /PublishProfile:local-dev.publish.xml

# Deploy with custom connection string
SqlPackage.exe /Action:Publish /SourceFile:hrsc-database.dacpac /TargetConnectionString:"Data Source=server;Initial Catalog=HRSC;Integrated Security=true"

# Generate deployment script only
SqlPackage.exe /Action:Script /SourceFile:hrsc-database.dacpac /TargetConnectionString:"connection string" /OutputPath:deployment-script.sql
```

#### Option 3: Azure DevOps Pipeline
The project includes ready-to-use Azure DevOps pipeline templates:
- **Build Stage** - Compiles SSDT project and creates DACPAC
- **Deploy Stages** - Environment-specific deployments (DEV/TST/UAT)
- **Production Stages** - Script generation for controlled production releases

### Environment Configuration

#### Local Development Setup
```xml
<!-- Update local-dev.publish.xml -->
<TargetConnectionString>
  Data Source=localhost\SQLEXPRESS;Initial Catalog=HRSC_DEV;Integrated Security=True
</TargetConnectionString>
```

#### Reference Data Seeding
Reference data is automatically populated in non-production environments via the PostDeployment script. For production environments, reference data seeding is disabled to preserve data integrity.

## 🔧 Development Workflow

### Building the Database Project

```bash
# Restore any dependencies
nuget restore src/hrsc-database.sln

# Build the SSDT project
msbuild src/hrsc-database.sqlproj /p:Configuration=Release

# Create DACPAC package
msbuild src/hrsc-database.sqlproj /p:Configuration=Release /t:Build
```

### Working with Schema Changes

#### Adding New Tables
1. Create SQL file in appropriate schema folder (`src/HRSC/Tables/`)
2. Follow existing naming conventions and include audit fields
3. Add file to `hrsc-database.sqlproj`
4. Update seed data if reference table

#### Modifying Stored Procedures
1. Locate procedure in `src/HRSC_APP/Stored Procedures/`
2. Follow existing parameter naming patterns (`@parameter_name`)
3. Include proper error handling and transaction management
4. Test with reference data in lower environments

#### Reference Data Updates
1. Modify MERGE scripts in `src/Scripts/Seed/`
2. Ensure MERGE handles INSERT/UPDATE scenarios
3. Test deployment impact on existing data
4. Remember production excludes automatic seeding

### Database Standards & Conventions

#### Naming Conventions
- **Tables**: `UPPER_CASE_WITH_UNDERSCORES`
- **Stored Procedures**: `usp_PascalCase_Action` (e.g., `usp_Employee_Insert`)
- **Functions**: `PascalCase` (e.g., `GetEmployeeName`)
- **Code Tables**: `CD_` prefix (e.g., `CD_REQUEST_STATUS`)
- **Indexes**: Descriptive names with `_I` suffix for foreign keys

#### Standard Patterns
- **Primary Keys**: `IDENTITY(1,1)` with `BIGINT` type
- **Foreign Keys**: `[TABLE]_[REFERENCED_TABLE]_FK` naming pattern
- **Audit Fields**: `USER_CREATED`, `DATE_CREATED`, `USER_UPDATED`, `DATE_UPDATED`
- **Indexes**: `FILLFACTOR = 80` for most, `95` for high-performance scenarios

## 🔒 Security Architecture

### Authentication & Access Control
- **Application Access**: `HRSC_USER` and `HRSC_DAD` service accounts
- **Read-Only Access**: `HRSCREADER1` and `HRSCREADER2` for reporting
- **Custom Roles**: `db_executor` role for stored procedure execution
- **Row-Level Security**: Implemented for protected HR requests

### Data Protection Features
- **Audit Trails**: Complete change tracking on all critical tables
- **Soft Deletes**: Data retention through status flags rather than physical deletion
- **Access Logging**: Transaction logging for compliance and troubleshooting
- **Encrypted Connections**: SSL/TLS enforcement for all database connections

## 🚀 Deployment Environments

### Environment Strategy
The database supports a comprehensive deployment pipeline:

| Environment | Purpose | Database Name | Seeding | Notes |
|-------------|---------|---------------|---------|-------|
| **Local Dev** | Developer workstations | `HRSC_DEV` | ✅ Full | SQL Express compatible |
| **DEV** | Development integration | `HRSC_DEV2` | ✅ Full | Continuous deployment |
| **TST** | Automated testing | `HRSC_TST2` | ✅ Full | Test data scenarios |
| **UAT** | User acceptance testing | `HRSC_UAT` | ✅ Limited | Production-like data |
| **TRN** | Training environment | `HRSC_TRN` | ❌ None | Script-based deployment |
| **PROD** | Production | `HRSC_PROD` | ❌ None | Manual deployment only |

### Deployment Profiles
- **`local-dev.publish.xml`** - Local SQL Express development
- **`INT-TST-UAT.publish.xml`** - Lower environment deployments
- **`PROD-TRN.publish.xml`** - Production script generation

### CI/CD Pipeline Integration
```yaml
# Azure DevOps Pipeline Stages
Build:
  - NuGet restore
  - MSBuild compilation
  - DACPAC creation
  - Artifact publishing

Deploy (DEV/TST/UAT):
  - Automated deployment
  - Post-deployment validation
  - Integration testing

Production (TRN/PROD):
  - Script generation
  - Manual review process
  - Controlled deployment
```

## 📊 Integration with HRSC Web Application

This database serves as the foundational data layer for the comprehensive HRSC web application, which includes:

### Application Architecture Integration
- **Hrsc.Data** - Entity Framework 6 integration with this database
- **Hrsc.Core** - Domain models mapping to database entities
- **Hrsc.Services** - Business logic leveraging stored procedures
- **HRSC-CSRH** - Web application providing user interface

### Data Access Patterns
- **Read Operations** - Entity Framework 6 with optimized queries
- **Write Operations** - Stored procedures ensuring business rule enforcement
- **Caching Layer** - Multi-level caching for performance optimization
- **Transaction Management** - Unit of Work pattern with proper isolation

## 🌍 Government Compliance Features

### Official Languages Act Compliance
- **Bilingual Data Structures** - Tables support English/French content
- **Cultural Formatting** - Date/time formatting per language requirements
- **Translation Support** - `TRANSLATION` table for dynamic content
- **Language Profiles** - Employee and position language requirements

### Government Standards Integration
- **Treasury Board Guidelines** - Data classification and retention compliance
- **Privacy Act Compliance** - Personal information protection measures
- **Security Clearance Integration** - Government security level support
- **Federal Identity Management** - Active Directory integration support

## 🛠️ Troubleshooting

### Common Issues

#### Deployment Failures
```bash
# Check for blocking locks
SELECT * FROM sys.dm_exec_requests WHERE blocking_session_id <> 0

# Verify connection string format
SqlPackage.exe /Action:Publish /SourceFile:hrsc-database.dacpac /TargetConnectionString:"Data Source=server;Initial Catalog=database;Integrated Security=true"
```

#### Reference Data Issues
```sql
-- Check seeding script execution
SELECT * FROM HRSC_TRANSACTION_LOG WHERE TRANSACTION_TYPE = 'SEED'

-- Verify code table population
SELECT COUNT(*) FROM HRSC.CD_REQUEST_STATUS
```

#### Performance Issues
```sql
-- Check index usage
SELECT * FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID()

-- Monitor stored procedure performance
SELECT * FROM sys.dm_exec_procedure_stats WHERE database_id = DB_ID()
```

## 📚 Documentation

### Database Documentation
- **[CLAUDE.md](CLAUDE.md)** - Claude Code development guidance
- **[Wiki Documentation](docs/wiki/)** - Comprehensive setup and deployment guides
- **[Azure DevOps Pipeline Guide](docs/wiki/ADO-Pipelines.md)** - CI/CD implementation details

### Related Projects
- **Web Application** - See `README_HRSC_WEB.md` for full application context
- **Entity Framework Models** - Domain model mapping in `Hrsc.Data` project
- **Business Logic** - Service layer implementation in `Hrsc.Services`

## 🤝 Contributing

### Development Standards
- **Government Compliance** - All changes must maintain bilingual and accessibility support
- **Security First** - Security review required for all schema changes
- **Testing Required** - Comprehensive testing in lower environments before production
- **Documentation** - Update documentation for any architectural changes

### Code Review Process
1. **Schema Review** - Database architect approval for structural changes
2. **Security Review** - Security team validation for access control changes
3. **Performance Review** - DBA validation for index and query optimization
4. **Government Compliance** - Ensure adherence to federal standards

## 📞 Support

### Technical Support Channels
- **Database Issues** - Internal DBA team
- **Deployment Issues** - DevOps team via Azure DevOps
- **Application Integration** - Development team leads
- **Government Compliance** - Architecture review board

### Emergency Procedures
- **Production Issues** - Follow government incident response procedures
- **Data Recovery** - Coordinate with backup and recovery team
- **Security Incidents** - Immediate escalation to security operations center

---

## 📄 License

This database project is developed for the Government of Canada and contains proprietary government business logic and data structures. Usage is restricted to authorized government personnel and contractors working on the HRSC system.

---

*This database serves as the foundational data layer for the Government of Canada's Human Resources Service Center, enabling efficient, secure, and compliant HR service delivery across all federal departments and agencies.*