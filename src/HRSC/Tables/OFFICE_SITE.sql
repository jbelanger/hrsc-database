﻿CREATE TABLE [HRSC].[OFFICE_SITE] (
    [OFFICE_SITE_ID]      [HRSC].[IDENTIFIER_BIGINT] IDENTITY (1, 1) NOT NULL,
    [OFFICE_SITE_NUMBER]  VARCHAR (10)               NOT NULL,
    [OFFICE_SITE_NAME]    [HRSC].[TEXT_250]          NULL,
    [BUILDING_NAME]       [HRSC].[TEXT_250]          NULL,
    [STREET_NUMBER]       VARCHAR (20)               NULL,
    [STREET_NAME]         VARCHAR (100)              NULL,
    [POSTAL_CODE]         VARCHAR (7)                NULL,
    [EFFECTIVE_DATE]      DATETIME                   NULL,
    [EXPIRY_DATE]         DATETIME                   NULL,
    [USER_CREATED]        [HRSC].[TEXT_60]           NOT NULL,
    [DATE_CREATED]        [HRSC].[DEFAULT_SYSDATE]   DEFAULT (getdate()) NOT NULL,
    [USER_UPDATED]        [HRSC].[TEXT_60]           NULL,
    [DATE_UPDATED]        DATETIME                   NULL,
    [MUNICIPALITY_ID]     [HRSC].[IDENTIFIER_BIGINT] NULL,
    [OFFICE_SITE_NAME_FR] [HRSC].[TEXT_250]          NULL,
    CONSTRAINT [OFFSITE_PK] PRIMARY KEY CLUSTERED ([OFFICE_SITE_ID] ASC) WITH (FILLFACTOR = 80)
);

