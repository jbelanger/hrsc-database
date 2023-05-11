CREATE TABLE [HRSC].[ASRF_ATTACHMENTS] (
    [At_ID]             BIGINT          NOT NULL,
    [At_AttachmentName] NVARCHAR (MAX)  NULL,
    [At_AttachmentData] VARBINARY (MAX) NULL,
    CONSTRAINT [ASRF_Attachments_PK] PRIMARY KEY CLUSTERED ([At_ID] ASC) WITH (FILLFACTOR = 80)
);

