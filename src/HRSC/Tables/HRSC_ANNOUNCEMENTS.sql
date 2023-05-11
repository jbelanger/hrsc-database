CREATE TABLE [HRSC].[HRSC_ANNOUNCEMENTS] (
    [HRSC_ANNOUNCEMENTS_ID]       BIGINT                     IDENTITY (1, 1) NOT NULL,
    [HRSC_ANNOUNCEMENTS_SBJCT_EN] NVARCHAR (100)             NOT NULL,
    [HRSC_ANNOUNCEMENTS_SBJCT_FR] NVARCHAR (100)             NOT NULL,
    [HRSC_ANNOUNCEMENTS_EN]       NVARCHAR (4000)            NULL,
    [HRSC_ANNOUNCEMENTS_FR]       NVARCHAR (4000)            NULL,
    [ACTIVE_IND]                  BIT                        NULL,
    [DRAFT_IND]                   BIT                        NOT NULL,
    [EFFECTIVE_DATE]              DATETIME                   NOT NULL,
    [EXPIRY_DATE]                 DATETIME                   NULL,
    [USER_CREATED]                NVARCHAR (120)             NOT NULL,
    [USER_UPDATED]                NVARCHAR (120)             NULL,
    [DATE_CREATED]                DATETIME                   DEFAULT (getdate()) NOT NULL,
    [DATE_UPDATED]                DATETIME                   NULL,
    [ANNOUNCEMENT_TYPE_ID]        [HRSC].[IDENTIFIER_BIGINT] NULL,
    CONSTRAINT [HRSCANCM_PK] PRIMARY KEY CLUSTERED ([HRSC_ANNOUNCEMENTS_ID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [HRSCANCM_ANNTP_FK] FOREIGN KEY ([ANNOUNCEMENT_TYPE_ID]) REFERENCES [HRSC].[CD_ANNOUNCEMENT_TYPE] ([ANNOUNCEMENT_TYPE_ID])
);

