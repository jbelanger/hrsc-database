BEGIN TRANSACTION;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ATTRIBUTE_ID', N'ATTRIBUTE_NAME', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_ATTRIBUTE]'))
    SET IDENTITY_INSERT [HRSC].[CD_ATTRIBUTE] ON;
INSERT INTO [HRSC].[CD_ATTRIBUTE] ([ATTRIBUTE_ID], [ATTRIBUTE_NAME], [DATE_CREATED], [DATE_UPDATED], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(1 AS bigint), N'Dispatch', '2022-12-07T00:00:00.000', '2022-12-07T00:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(3 AS bigint), N'PreApproval', '2022-12-07T00:00:00.000', '2022-12-07T00:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(4 AS bigint), N'COI', '2022-12-07T00:00:00.000', '2022-12-07T00:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(5 AS bigint), N'SeparationClearance', '2022-12-07T00:00:00.000', '2022-12-07T00:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(6 AS bigint), N'IITB', '2022-12-07T00:00:00.000', '2022-12-07T00:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(7 AS bigint), N'QualityAssurance', '2022-12-07T00:00:00.000', '2022-12-07T00:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(8 AS bigint), N'Finance', '2022-12-07T00:00:00.000', '2022-12-07T00:00:00.000', N'HRSC 4.13', N'HRSC 4.13');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ATTRIBUTE_ID', N'ATTRIBUTE_NAME', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_ATTRIBUTE]'))
    SET IDENTITY_INSERT [HRSC].[CD_ATTRIBUTE] OFF;

UPDATE [HRSC].[CD_BUSINESS_CENTER] SET [EXPIRY_DATE] = '2012-12-04T15:25:20.193'
WHERE [BUSINESS_CENTER_ID] = CAST(50 AS bigint);
SELECT @@ROWCOUNT;



IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ID', N'BUSINESS_CENTER_ACRONYM_EN', N'BUSINESS_CENTER_ACRONYM_FR', N'BUSINESS_CENTER_CODE', N'BUSINESS_CENTER_DESC_EN', N'BUSINESS_CENTER_DESC_FR', N'BUSINESS_CENTER_NAME_EN', N'BUSINESS_CENTER_NAME_FR', N'BUSINESS_CENTER_NAME_SHORT_EN', N'BUSINESS_CENTER_NAME_SHORT_FR', N'BUSINESS_CENTER_PARENT_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_BUSINESS_CENTER]'))
    SET IDENTITY_INSERT [HRSC].[CD_BUSINESS_CENTER] ON;
INSERT INTO [HRSC].[CD_BUSINESS_CENTER] ([BUSINESS_CENTER_ID], [BUSINESS_CENTER_ACRONYM_EN], [BUSINESS_CENTER_ACRONYM_FR], [BUSINESS_CENTER_CODE], [BUSINESS_CENTER_DESC_EN], [BUSINESS_CENTER_DESC_FR], [BUSINESS_CENTER_NAME_EN], [BUSINESS_CENTER_NAME_FR], [BUSINESS_CENTER_NAME_SHORT_EN], [BUSINESS_CENTER_NAME_SHORT_FR], [BUSINESS_CENTER_PARENT_ID], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EXPIRY_DATE], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(124 AS bigint), N'BSI-Disp', N'ISA-Disp', N'BSID', N'Business Solutions Innovation (Dispatch)', N'Innovation des solutions d''affaires (Répartition)', N'Business Solutions Innovation (Dispatch)', N'Innovation des solutions d''affaires (Répartition)', N'BSI Dispatch', N'ISA Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(125 AS bigint), N'BSI-QA', N'ISA-AQ', N'BSIQA', N'Business Solutions Innovation (QA)', N'Innovation des solutions d''affaires (AQ)', N'Business Solutions Innovation (QA)', N'Innovation des solutions d''affaires (AQ)', N'BSI QA', N'ISA AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(126 AS bigint), N'EO-Disp', N'OE-Disp', N'EOD', N'Enterprise Operations (Dispatch)', N'Opérations d''entreprise (Répartition)', N'Enterprise Operations (Dispatch)', N'Opérations d''entreprise (Répartition)', N'EO Dispatch', N'OE Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(127 AS bigint), N'EO-QA', N'OE-AQ', N'EOQA', N'Enterprise Operations (QA)', N'Opérations d''entreprise (AQ)', N'Enterprise Operations (QA)', N'Opérations d''entreprise (AQ)', N'EO QA', N'OE AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(128 AS bigint), N'BSIM-Disp', N'SAGI-Disp', N'BSIMD', N'Business Solutions and Information Management (Dispatch)', N'Solutions d''affaires et gestion de l''information (Répartition)', N'Business Solutions and Information Management (Dispatch)', N'Solutions d''''affaires et gestion de l''information (Répartition)', N'BSIM Dispatch', N'SAGI Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(129 AS bigint), N'BSIM-QA', N'SAGI-AQ', N'BSIMQ', N'Business Solutions and Information Management (QA)', N'Solutions d''''affaires et gestion de l''information (AQ)', N'Business Solutions and Information Management (QA)', N'Solutions d''''affaires et gestion de l''information (AQ)', N'BSIM QA', N'SAGI AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(130 AS bigint), N'SABR-Disp', N'SARA-Disp', N'SABRD', N'Strategy, Architecture and Business Relations (Dispatch)', N'Stratégie, architecture et relations d''affaire (Répartition)', N'Strategy, Architecture and Business Relations (Dispatch)', N'Stratégie, architecture et relations d''affaire (Répartition)', N'SABR Dispatch', N'SARA Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(131 AS bigint), N'SABR-QA', N'SARA-AQ', N'SABQA', N'Strategy, Architecture and Business Relations (QA)', N'Stratégie, architecture et relations d''affaire (AQ)', N'Strategy, Architecture and Business Relations (QA)', N'Stratégie, architecture et relations d''affaire (AQ)', N'SABR QA', N'SARA AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(132 AS bigint), N'BOP-Disp', N'OPDG-Disp', N'BOPD', N'Branch Operations and Planning (Dispatch)', N'Opérations et planification de la direction générale (Répartition)', N'Branch Operations and Planning (Dispatch)', N'Opérations et planification de la direction générale (Répartition)', N'BOP Dispatch', N'OPDG Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(133 AS bigint), N'BOP-QA', N'OPDG-AQ', N'BOPQA', N'Branch Operations and Planning (QA)', N'Opérations et planification de la direction générale (AQ)', N'Branch Operations and Plannings (QA)', N'Opérations et planification de la direction générale (AQ)', N'BOP QA', N'OPDG AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(134 AS bigint), N'CIO-Disp', N'DPI-Disp', N'CIOD', N'Office of CIO (Dispatch)', N'Bureau du DPI (Répartition)', N'Office of CIO (Dispatch)', N'Bureau du DPI (Répartition)', N'CIO Dispatch', N'DPI Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(135 AS bigint), N'CIO-QA', N'DPI-AQ', N'CIOQA', N'Office of CIO (QA)', N'Bureau du DPI (AQ)', N'Office of CIO (QA)', N'Bureau du DPI (AQ)', N'CIO QA', N'DPI AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(136 AS bigint), N'BOS-Disp', N'DOE-Disp', N'BOSD', N'Business Operations Sustainability (Dispatch)', N'Durabilité des opérations d''entreprise (Répartition)', N'Business Operations Sustainability (Dispatch)', N'Durabilité des opérations d''entreprise (Répartition)', N'BOS Dispatch', N'DOE Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(137 AS bigint), N'BOS-QA', N'DOE-AQ', N'BOSQA', N'Business Operations Sustainability (QA)', N'Durabilité des opérations d''entreprise (AQ)', N'Business Operations Sustainability (QA)', N'Durabilité des opérations d''entreprise (AQ)', N'BOS QA', N'DOE AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(138 AS bigint), N'PS-Disp', N'SP-Disp', N'PSD', N'Pensions Solutions (Dispatch)', N'Solutions des pensions (Répartition)', N'Pensions Solutions (Dispatch)', N'Solutions des pensions (Répartition)', N'PS Dispatch', N'SP Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(139 AS bigint), N'PS-QA', N'SP-AQ', N'PSQA', N'Pensions Solutions (QA)', N'Solutions des pensions (AQ)', N'Pensions Solutions (QA)', N'Solutions des pensions (AQ)', N'PS QA', N'SP AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(140 AS bigint), N'EDS-Disp', N'SNE-Disp', N'EDSD', N'Enterprise Digital Solutions (Dispatch)', N'Solutions numériques d''entreprise (Répartition)', N'Enterprise Digital Solutions (Dispatch)', N'Solutions numériques d''entreprise (Répartition)', N'EDS Dispatch', N'SNE Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(141 AS bigint), N'EDS-QA', N'SNE-AQ', N'EDSQA', N'Enterprise Digital Solutions (QA)', N'Solutions numériques d''entreprise (AQ)', N'Enterprise Digital Solutions (QA)', N'Solutions numériques d''entreprise (AQ)', N'EDS QA', N'SNE AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(142 AS bigint), N'SFT', N'EPS', N'SFT', N'Salary Forecast Team', N'Équipe de prévision salariale', N'Salary Forecast Team', N'Équipe de prévision salariale', N'SFT', N'EPS', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(143 AS bigint), N'OII-Disp', N'BIA-Disp', N'OIID', N'Office of Indigenous Initiatives (Dispatch)', N'Bureau des initiatives autochtones (Répartition)', N'Office of Indigenous Initiatives (Dispatch)', N'Bureau des initiatives autochtones (Répartition)', N'OII Dispatch', N'BIA Dispatch', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System'),
(CAST(144 AS bigint), N'OII-QA', N'BIA-AQ', N'OIIQA', N'Office of Indigenous Initiatives (QA)', N'Bureau des initiatives autochtones (AQ)', N'Office of Indigenous Initiatives (QA)', N'Bureau des initiatives autochtones (AQ)', N'OII QA', N'BIA AQ', NULL, '2022-01-17T09:12:09.123', NULL, '2022-12-07T08:49:18.230', NULL, N'HRSC 4.13', N'System');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ID', N'BUSINESS_CENTER_ACRONYM_EN', N'BUSINESS_CENTER_ACRONYM_FR', N'BUSINESS_CENTER_CODE', N'BUSINESS_CENTER_DESC_EN', N'BUSINESS_CENTER_DESC_FR', N'BUSINESS_CENTER_NAME_EN', N'BUSINESS_CENTER_NAME_FR', N'BUSINESS_CENTER_NAME_SHORT_EN', N'BUSINESS_CENTER_NAME_SHORT_FR', N'BUSINESS_CENTER_PARENT_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_BUSINESS_CENTER]'))
    SET IDENTITY_INSERT [HRSC].[CD_BUSINESS_CENTER] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'CANDIDATE_TYPE_ID', N'CANDIDATE_TYPE_CODE', N'CANDIDATE_TYPE_DESC_EN', N'CANDIDATE_TYPE_DESC_FR', N'CANDIDATE_TYPE_NAME_EN', N'CANDIDATE_TYPE_NAME_FR', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_CANDIDATE_TYPE]'))
    SET IDENTITY_INSERT [HRSC].[CD_CANDIDATE_TYPE] ON;
INSERT INTO [HRSC].[CD_CANDIDATE_TYPE] ([CANDIDATE_TYPE_ID], [CANDIDATE_TYPE_CODE], [CANDIDATE_TYPE_DESC_EN], [CANDIDATE_TYPE_DESC_FR], [CANDIDATE_TYPE_NAME_EN], [CANDIDATE_TYPE_NAME_FR], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EXPIRY_DATE], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(1 AS bigint), N'NA', N'Not applicable', N'Non applicable', N'N/A', N'N/A', '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', '2023-01-01T09:00:00.000', NULL, 'HRSC 4.13', 'HRSC 4.13'),
(CAST(2 AS bigint), N'EXGC', N'Candidate is external to the vernment of Canada', N'Candidat provient de l''externe du uvernement du Canada', N'External to the vernment of Canada', N'Externe au uvernement du Canada', '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', '2023-01-01T09:00:00.000', NULL, 'HRSC 4.13', 'HRSC 4.13'),
(CAST(3 AS bigint), N'XESDC', N'Candidate is external to ESDC but from within the vernment of Canada', N'Candidat provient de l''externe de l''EDSC mais au sein du uvernement du Canada', N'External to ESDC but within the vernment of Canada', N'Externe de l''EDSC mais au sein du uvernement du Canada', '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', '2023-01-01T09:00:00.000', NULL, 'HRSC 4.13', 'HRSC 4.13'),
(CAST(4 AS bigint), N'XIITB', N'Candidate is from within ESDC but external to IITB', N'Candidat provient de l''EDSC mais a l''externe de la DGIIT', N'Within ESDC but External to IITB', N'Au sein de l''EDSC mais a l''externe de la DGIIT', '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', '2023-01-01T09:00:00.000', NULL, 'HRSC 4.13', 'HRSC 4.13'),
(CAST(5 AS bigint), N'IIITB', N'Candidate is from Within IITB', N'Candidat provient de la DGIIT', N'Within IITB', N'Au sein de la DGIIT', '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', '2023-01-01T09:00:00.000', NULL, 'HRSC 4.13', 'HRSC 4.13');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'CANDIDATE_TYPE_ID', N'CANDIDATE_TYPE_CODE', N'CANDIDATE_TYPE_DESC_EN', N'CANDIDATE_TYPE_DESC_FR', N'CANDIDATE_TYPE_NAME_EN', N'CANDIDATE_TYPE_NAME_FR', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_CANDIDATE_TYPE]'))
    SET IDENTITY_INSERT [HRSC].[CD_CANDIDATE_TYPE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'EMAIL_TEMPLATE_TYPE_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EMAIL_TEMPLATE_TYPE_CODE', N'EMAIL_TEMPLATE_TYPE_DESC_EN', N'EMAIL_TEMPLATE_TYPE_DESC_FR', N'EMAIL_TEMPLATE_TYPE_NAME_EN', N'EMAIL_TEMPLATE_TYPE_NAME_FR', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_EMAIL_TEMPLATE_TYPE]'))
    SET IDENTITY_INSERT [HRSC].[CD_EMAIL_TEMPLATE_TYPE] ON;
INSERT INTO [HRSC].[CD_EMAIL_TEMPLATE_TYPE] ([EMAIL_TEMPLATE_TYPE_ID], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EMAIL_TEMPLATE_TYPE_CODE], [EMAIL_TEMPLATE_TYPE_DESC_EN], [EMAIL_TEMPLATE_TYPE_DESC_FR], [EMAIL_TEMPLATE_TYPE_NAME_EN], [EMAIL_TEMPLATE_TYPE_NAME_FR], [EXPIRY_DATE], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(58 AS bigint), '2023-01-17T11:25:24.857', NULL, '2019-07-27T11:25:24.857', N'SUBD', N'This e-mail is sent to HR Sub Delegate when a request need to be approve for staffing actions request.', N'Ce courriel est envoyé RH au sous-délégué pour l''approbation d''une demande d''actions de dotation.', N'HR Sub Delegate Approver', N'RH approbateur sous-délégué', NULL, N'HRSC 4.13', NULL),
(CAST(59 AS bigint), '2023-01-17T11:25:24.857', NULL, '2019-07-27T11:25:24.857', N'SUDA', N'This e-mail is sent to Lead and Collaborator when a request beed approved.', N'Ce courriel est envoyé Leader/collaborateurs quand une demande a été approuvé par un RH sous-délégué.', N'HR Sub Delegate Approver has approved a request', N'RH approbateur sous-délégué a approuvé une demande', NULL, N'HRSC 4.13', NULL),
(CAST(60 AS bigint), '2023-01-17T11:25:24.857', NULL, '2019-07-27T11:25:24.857', N'SUDD', N'This e-mail is sent to Lead and Collaborator when a request beed declined.', N'Ce courriel est envoyé Leader/collaborateurs quand une demande a été décliné par un RH sous-délégué.', N'HR Sub Delegate Approver has declined a request', N'RH approbateur sous-délégué a décliné une demande', NULL, N'HRSC 4.13', NULL),
(CAST(61 AS bigint), '2023-01-17T11:25:24.857', NULL, '2019-07-27T11:25:24.857', N'QAWS', N'This e-mail is sent to ITB QA Sub Organization when a request is pending signature.', N'Ce courriel est envoyé à IITB QA sous-organisation quand une demande est en attente de signature.', N'IITB QA Sub Organization receive Email(GD Box) Pending Signature', N'IITB QA sous-organisation reçoit un courriel (GD Box) en attente de signature', NULL, N'HRSC 4.13', NULL),
(CAST(62 AS bigint), '2023-01-17T11:25:24.857', NULL, '2019-07-27T11:25:24.857', N'QASG', N'This e-mail is sent to IITB QA Sub Organization when a request is Resolved.', N'Ce courriel est envoyé à IITB QA sous-organisation quand une demande est résolu.', N'IITB QA Sub Organization receive Email(GD Box) when HRSB Resolve the request', N'IITB QA sous-organisation reçoit un courriel (GD Box) quand HRSB résolue la demande ', NULL, N'HRSC 4.13', NULL),
(CAST(63 AS bigint), '2023-01-17T11:25:24.857', NULL, '2019-07-27T11:25:24.857', N'HRLOE', N'HRLO GdBoxEmail Sub Organization receive Email(GD Box) when Finance (SFT) as resoved their intervention', N'HRLO GdBoxEmail sous-organisation reçoit un courriel (GD Box) quand Finance (SFT) a résolue leur intervention', N'HRLO GdBoxEmail Sub Organization receive Email(GD Box) when Finance (SFT) as resoved their intervention', N'HRLO GdBoxEmail sous-organisation reçoit un courriel (GD Box) quand Finance (SFT) a résolue leur intervention', NULL, N'HRSC 4.13', NULL),
(CAST(64 AS bigint), '2023-01-17T11:25:24.857', NULL, '2019-07-27T11:25:24.857', N'LCIO', N'Lead and Colaborators (HRLO) receive Email when Finance (SFT) resolve their Intervention and HRLO have an intervention open', N'Lead et Colaborateur (HRLO) reçoit un courriel  quand Finance (SFT) a résolue leur intervention et que HRLO ont une intervention ouverte', N'Lead and Colaborators (HRLO) receive Email when Finance (SFT) resolve their Intervention and HRLO have an intervention open', N'Lead et Colaborateur (HRLO) reçoit un courriel  quand Finance (SFT) a résolue leur intervention et que HRLO ont une intervention ouverte', NULL, N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'EMAIL_TEMPLATE_TYPE_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EMAIL_TEMPLATE_TYPE_CODE', N'EMAIL_TEMPLATE_TYPE_DESC_EN', N'EMAIL_TEMPLATE_TYPE_DESC_FR', N'EMAIL_TEMPLATE_TYPE_NAME_EN', N'EMAIL_TEMPLATE_TYPE_NAME_FR', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_EMAIL_TEMPLATE_TYPE]'))
    SET IDENTITY_INSERT [HRSC].[CD_EMAIL_TEMPLATE_TYPE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GD_ACCOUNT_TYPE_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'GD_ACCOUNT_TYPE_CODE', N'GD_ACCOUNT_TYPE_DESC_EN', N'GD_ACCOUNT_TYPE_DESC_FR', N'GD_ACCOUNT_TYPE_NAME_EN', N'GD_ACCOUNT_TYPE_NAME_FR', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_GD_ACCOUNT_TYPE]'))
    SET IDENTITY_INSERT [HRSC].[CD_GD_ACCOUNT_TYPE] ON;
INSERT INTO [HRSC].[CD_GD_ACCOUNT_TYPE] ([GD_ACCOUNT_TYPE_ID], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EXPIRY_DATE], [GD_ACCOUNT_TYPE_CODE], [GD_ACCOUNT_TYPE_DESC_EN], [GD_ACCOUNT_TYPE_DESC_FR], [GD_ACCOUNT_TYPE_NAME_EN], [GD_ACCOUNT_TYPE_NAME_FR], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(8 AS bigint), '2023-01-27T11:16:36.000', NULL, '2022-07-31T11:16:36.000', NULL, N'SFT', NULL, NULL, N'Salary Forecast Team Email When Transfert Request to HRSB', N'Email Équipe de prévision salariale transfert une demande à HRSB', 'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GD_ACCOUNT_TYPE_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'GD_ACCOUNT_TYPE_CODE', N'GD_ACCOUNT_TYPE_DESC_EN', N'GD_ACCOUNT_TYPE_DESC_FR', N'GD_ACCOUNT_TYPE_NAME_EN', N'GD_ACCOUNT_TYPE_NAME_FR', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_GD_ACCOUNT_TYPE]'))
    SET IDENTITY_INSERT [HRSC].[CD_GD_ACCOUNT_TYPE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'HR_JUSTIFICATION_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'HR_JUSTIFICATION_CODE', N'HR_JUSTIFICATION_DESC_EN', N'HR_JUSTIFICATION_DESC_FR', N'HR_JUSTIFICATION_NAME_EN', N'HR_JUSTIFICATION_NAME_FR', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_HR_JUSTIFICATION]'))
    SET IDENTITY_INSERT [HRSC].[CD_HR_JUSTIFICATION] ON;
INSERT INTO [HRSC].[CD_HR_JUSTIFICATION] ([HR_JUSTIFICATION_ID], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EXPIRY_DATE], [HR_JUSTIFICATION_CODE], [HR_JUSTIFICATION_DESC_EN], [HR_JUSTIFICATION_DESC_FR], [HR_JUSTIFICATION_NAME_EN], [HR_JUSTIFICATION_NAME_FR], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(98 AS bigint), '2022-02-01T09:00:00.000', NULL, '2023-02-01T09:00:00.000', NULL, N'RTRMF', N'Please cancel the request due to insufficient funding', N'Veuillez svp annuler la demande en raison de fonds insuffisants', N'Returned by RM - insufficient funding', N'Retourné par RM - financement insuffisant ', N'HRSC 4.13', NULL),
(CAST(99 AS bigint), '2022-02-01T09:00:00.000', NULL, '2023-02-01T09:00:00.000', NULL, N'RTRMC', N'At the client''s request', N'À la demande du client', N'Returned by RM - client request', N'Retourné par RM - demande du client', N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'HR_JUSTIFICATION_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'HR_JUSTIFICATION_CODE', N'HR_JUSTIFICATION_DESC_EN', N'HR_JUSTIFICATION_DESC_FR', N'HR_JUSTIFICATION_NAME_EN', N'HR_JUSTIFICATION_NAME_FR', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[CD_HR_JUSTIFICATION]'))
    SET IDENTITY_INSERT [HRSC].[CD_HR_JUSTIFICATION] OFF;


UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [DEPARTMENT_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(2 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [DEPARTMENT_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(3 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [DEPARTMENT_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(4 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [DEPARTMENT_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(5 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [DEPARTMENT_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(6 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [DEPARTMENT_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(7 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [PSC_PRIORITY_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(9 AS bigint);
SELECT @@ROWCOUNT;




UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [PSC_PRIORITY_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(11 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [PSC_PRIORITY_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(12 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [PSC_PRIORITY_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(13 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [PSC_PRIORITY_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(14 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_PRIORITY_TYPE] SET [PSC_PRIORITY_IND] = CAST(0 AS bit)
WHERE [PRIORITY_TYPE_ID] = CAST(16 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_STUDENT_PROGRAM] SET [SORT_ORDER] = 1
WHERE [STUDENT_PROGRAM_ID] = CAST(7 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_STUDENT_PROGRAM] SET [SORT_ORDER] = 1
WHERE [STUDENT_PROGRAM_ID] = CAST(10 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(151 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(152 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(153 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(154 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'NC-BDG-ISA-BSI-D-GD@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(155 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(156 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'EDSC.DGIIT.OE-EO.IITB.ESDC@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(157 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(158 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(515 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(516 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'EDSC.SAGI.BDG-BSIM.D.ESDC@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(627 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(628 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint)
WHERE [SUB_ORGANIZATION_ID] = CAST(629 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'EDSC.RH.SARA-HR.SABR.ESDC@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(630 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'EDSC.DGIIT.BDG.OPDG-BOP.D.IITB.ESDC@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(635 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'NC-DGIIT-RH-HR-IITB-GD@servicecanada.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(752 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'EDSC.DGIIT.DOE.RH-IITB.BOS.HR.ESDC@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(753 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'NC-BDG-ISA-BSI-D-GD@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(754 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [FORCED_REGION_ID] = CAST(2 AS bigint), [GD_ACCOUNT_EMAIL] = N'EDSC.DGIIT.BGR-RMO.IITB.ESDC@hrsdc-rhdcc.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(755 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_SUB_ORGANIZATION] SET [GD_ACCOUNT_EMAIL] = N'NC-DGIIT-RH-HR-IITB-GD@servicecanada.gc.ca'
WHERE [SUB_ORGANIZATION_ID] = CAST(780 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [SCHEDULE_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(9 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [SCHEDULE_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(10 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [SCHEDULE_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(11 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [EMPLOYMENT_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(12 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [EMPLOYMENT_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(13 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [EMPLOYMENT_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(14 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [EMPLOYMENT_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(15 AS bigint);
SELECT @@ROWCOUNT;



UPDATE [HRSC].[CD_WORK_TYPE] SET [EMPLOYMENT_IND] = CAST(0 AS bit)
WHERE [WORK_TYPE_ID] = CAST(16 AS bigint);
SELECT @@ROWCOUNT;



IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(1 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(2 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(3 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(4 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(5 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(6 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(7 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(8 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(9 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(10 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(11 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(12 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(13 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(14 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(15 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(16 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(17 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(18 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(19 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(20 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(21 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(22 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(23 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(24 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(25 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(26 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(27 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(28 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(29 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(30 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(31 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(32 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(33 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(34 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(35 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(36 AS bigint), CAST(124 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(155 AS bigint), N'HRSC 4.13', NULL),
(CAST(37 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(38 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(39 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(40 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(41 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(42 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(43 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(44 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(45 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(46 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(47 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(48 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(49 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(50 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(51 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(52 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(53 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(54 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(55 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(56 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(57 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(58 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(59 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(60 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(61 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(62 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(63 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(64 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(65 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(66 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(67 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(68 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(69 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(70 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(71 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(72 AS bigint), CAST(126 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(157 AS bigint), N'HRSC 4.13', NULL),
(CAST(73 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(74 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(75 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(76 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(77 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(78 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(79 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(80 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(81 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(82 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(83 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(84 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(85 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(86 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(87 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(88 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(89 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(90 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(91 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(92 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(93 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(94 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(95 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(96 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(97 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(98 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(99 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(100 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(101 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(102 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(103 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(104 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(105 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(106 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(107 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(108 AS bigint), CAST(128 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(627 AS bigint), N'HRSC 4.13', NULL),
(CAST(109 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(110 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(111 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(112 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(113 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(114 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(115 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(116 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(117 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(118 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(119 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(120 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(121 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(122 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(123 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(124 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(125 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(126 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(127 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(128 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(129 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(130 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(131 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(132 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(133 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(134 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(135 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(136 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(137 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(138 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(139 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(140 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(141 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(142 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(143 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(144 AS bigint), CAST(130 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(630 AS bigint), N'HRSC 4.13', NULL),
(CAST(145 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(146 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(147 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(148 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(149 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(150 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(151 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(152 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(153 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(154 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(155 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(156 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(157 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(158 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(159 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(160 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(161 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(162 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(163 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(164 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(165 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(166 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(167 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(168 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(169 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(170 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(171 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(172 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(173 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(174 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(175 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(176 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(177 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(178 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(179 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(180 AS bigint), CAST(132 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(635 AS bigint), N'HRSC 4.13', NULL),
(CAST(181 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(182 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(183 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(184 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(185 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(186 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(187 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(188 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(189 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(190 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(191 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(192 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(193 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(194 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(195 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(196 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(197 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(198 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(199 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(200 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(201 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(202 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(203 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(204 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(205 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(206 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(207 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(208 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(209 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(210 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(211 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(212 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(213 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(214 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(215 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(216 AS bigint), CAST(134 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(752 AS bigint), N'HRSC 4.13', NULL),
(CAST(217 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(218 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(219 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(220 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(221 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(222 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(223 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(224 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(225 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(226 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(227 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(228 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(229 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(230 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(231 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(232 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(233 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(234 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(235 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(236 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(237 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(238 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(239 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(240 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(241 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(242 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(243 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(244 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(245 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(246 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(247 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(248 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(249 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(250 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(251 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL),
(CAST(252 AS bigint), CAST(136 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(753 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(253 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(254 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(255 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(256 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(257 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(258 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(259 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(260 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(261 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(262 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(263 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(264 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(265 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(266 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(267 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(268 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(269 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(270 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(271 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(272 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(273 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(274 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(275 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(276 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(277 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(278 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(279 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(280 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(281 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(282 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(283 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(284 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(285 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(286 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(287 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(288 AS bigint), CAST(138 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(754 AS bigint), N'HRSC 4.13', NULL),
(CAST(289 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(290 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(291 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(292 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(293 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(294 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(295 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(296 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(297 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(298 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(299 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(300 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(301 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(302 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(303 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(304 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(305 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(306 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(307 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(308 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(309 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(310 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(311 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(312 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(313 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(314 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(315 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(316 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(317 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(318 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(319 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(320 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(321 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(322 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(323 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(324 AS bigint), CAST(140 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(755 AS bigint), N'HRSC 4.13', NULL),
(CAST(325 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(291 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(326 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(293 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(327 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(294 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(328 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(295 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(329 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(297 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(330 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(298 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(331 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(299 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(332 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(300 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(333 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(301 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(334 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(302 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(335 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(303 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(336 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(304 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] ON;
INSERT INTO [HRSC].[APPROVAL_TRANSFER_RULE] ([APPROVAL_TRANSFER_RULE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [REQUEST_SUB_CATEGORY_ID], [SUB_ORGANIZATION_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(337 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(305 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(338 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(306 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(339 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(307 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(340 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(308 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(341 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(309 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(342 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(310 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(343 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(311 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(344 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(312 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(345 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(313 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(346 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(319 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(347 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(325 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(348 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(315 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(349 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(316 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(350 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(317 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(351 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(318 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(352 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(337 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(353 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(499 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(354 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(500 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(355 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(498 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(356 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(503 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(357 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(502 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(358 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(505 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(359 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(507 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL),
(CAST(360 AS bigint), CAST(143 AS bigint), '2023-03-24T11:10:25.230', NULL, CAST(785 AS bigint), CAST(783 AS bigint), N'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'APPROVAL_TRANSFER_RULE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'REQUEST_SUB_CATEGORY_ID', N'SUB_ORGANIZATION_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[APPROVAL_TRANSFER_RULE]'))
    SET IDENTITY_INSERT [HRSC].[APPROVAL_TRANSFER_RULE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ATTR_ID', N'ATTRIBUTE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[BUSINESS_CENTER_ATTR]'))
    SET IDENTITY_INSERT [HRSC].[BUSINESS_CENTER_ATTR] ON;
INSERT INTO [HRSC].[BUSINESS_CENTER_ATTR] ([BUSINESS_CENTER_ATTR_ID], [ATTRIBUTE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(1 AS bigint), CAST(1 AS bigint), CAST(124 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(2 AS bigint), CAST(3 AS bigint), CAST(124 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(3 AS bigint), CAST(6 AS bigint), CAST(124 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(4 AS bigint), CAST(3 AS bigint), CAST(125 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(5 AS bigint), CAST(6 AS bigint), CAST(125 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(6 AS bigint), CAST(7 AS bigint), CAST(125 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(7 AS bigint), CAST(1 AS bigint), CAST(126 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(8 AS bigint), CAST(3 AS bigint), CAST(126 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(9 AS bigint), CAST(6 AS bigint), CAST(126 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(10 AS bigint), CAST(3 AS bigint), CAST(127 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(11 AS bigint), CAST(6 AS bigint), CAST(127 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(12 AS bigint), CAST(7 AS bigint), CAST(127 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(13 AS bigint), CAST(1 AS bigint), CAST(128 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(14 AS bigint), CAST(3 AS bigint), CAST(128 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(15 AS bigint), CAST(6 AS bigint), CAST(128 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(16 AS bigint), CAST(3 AS bigint), CAST(129 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(17 AS bigint), CAST(6 AS bigint), CAST(129 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(18 AS bigint), CAST(7 AS bigint), CAST(129 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ATTR_ID', N'ATTRIBUTE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[BUSINESS_CENTER_ATTR]'))
    SET IDENTITY_INSERT [HRSC].[BUSINESS_CENTER_ATTR] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ATTR_ID', N'ATTRIBUTE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[BUSINESS_CENTER_ATTR]'))
    SET IDENTITY_INSERT [HRSC].[BUSINESS_CENTER_ATTR] ON;
INSERT INTO [HRSC].[BUSINESS_CENTER_ATTR] ([BUSINESS_CENTER_ATTR_ID], [ATTRIBUTE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(19 AS bigint), CAST(1 AS bigint), CAST(130 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(20 AS bigint), CAST(3 AS bigint), CAST(130 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(21 AS bigint), CAST(6 AS bigint), CAST(130 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(22 AS bigint), CAST(3 AS bigint), CAST(131 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(23 AS bigint), CAST(6 AS bigint), CAST(131 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(24 AS bigint), CAST(7 AS bigint), CAST(131 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(25 AS bigint), CAST(1 AS bigint), CAST(132 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(26 AS bigint), CAST(3 AS bigint), CAST(132 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(27 AS bigint), CAST(6 AS bigint), CAST(112 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(28 AS bigint), CAST(3 AS bigint), CAST(133 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(29 AS bigint), CAST(6 AS bigint), CAST(133 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(30 AS bigint), CAST(7 AS bigint), CAST(133 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(31 AS bigint), CAST(1 AS bigint), CAST(134 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(32 AS bigint), CAST(3 AS bigint), CAST(134 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(33 AS bigint), CAST(6 AS bigint), CAST(134 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(34 AS bigint), CAST(3 AS bigint), CAST(135 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(35 AS bigint), CAST(6 AS bigint), CAST(135 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(36 AS bigint), CAST(7 AS bigint), CAST(135 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(37 AS bigint), CAST(1 AS bigint), CAST(136 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(38 AS bigint), CAST(3 AS bigint), CAST(136 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(39 AS bigint), CAST(6 AS bigint), CAST(136 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(40 AS bigint), CAST(3 AS bigint), CAST(137 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(41 AS bigint), CAST(6 AS bigint), CAST(137 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(42 AS bigint), CAST(7 AS bigint), CAST(137 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(43 AS bigint), CAST(1 AS bigint), CAST(138 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(44 AS bigint), CAST(3 AS bigint), CAST(138 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(45 AS bigint), CAST(6 AS bigint), CAST(138 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(46 AS bigint), CAST(3 AS bigint), CAST(139 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(47 AS bigint), CAST(6 AS bigint), CAST(139 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(48 AS bigint), CAST(7 AS bigint), CAST(139 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(49 AS bigint), CAST(1 AS bigint), CAST(140 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(50 AS bigint), CAST(3 AS bigint), CAST(140 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(51 AS bigint), CAST(6 AS bigint), CAST(140 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(52 AS bigint), CAST(3 AS bigint), CAST(141 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(53 AS bigint), CAST(6 AS bigint), CAST(141 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(54 AS bigint), CAST(7 AS bigint), CAST(141 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(55 AS bigint), CAST(3 AS bigint), CAST(142 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(56 AS bigint), CAST(6 AS bigint), CAST(142 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(57 AS bigint), CAST(8 AS bigint), CAST(142 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(58 AS bigint), CAST(6 AS bigint), CAST(132 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(59 AS bigint), CAST(6 AS bigint), CAST(143 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(60 AS bigint), CAST(3 AS bigint), CAST(143 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ATTR_ID', N'ATTRIBUTE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[BUSINESS_CENTER_ATTR]'))
    SET IDENTITY_INSERT [HRSC].[BUSINESS_CENTER_ATTR] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ATTR_ID', N'ATTRIBUTE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[BUSINESS_CENTER_ATTR]'))
    SET IDENTITY_INSERT [HRSC].[BUSINESS_CENTER_ATTR] ON;
INSERT INTO [HRSC].[BUSINESS_CENTER_ATTR] ([BUSINESS_CENTER_ATTR_ID], [ATTRIBUTE_ID], [BUSINESS_CENTER_ID], [DATE_CREATED], [DATE_UPDATED], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(61 AS bigint), CAST(1 AS bigint), CAST(143 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(62 AS bigint), CAST(3 AS bigint), CAST(144 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(63 AS bigint), CAST(6 AS bigint), CAST(144 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13'),
(CAST(64 AS bigint), CAST(7 AS bigint), CAST(144 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', N'HRSC 4.13', N'HRSC 4.13');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BUSINESS_CENTER_ATTR_ID', N'ATTRIBUTE_ID', N'BUSINESS_CENTER_ID', N'DATE_CREATED', N'DATE_UPDATED', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[BUSINESS_CENTER_ATTR]'))
    SET IDENTITY_INSERT [HRSC].[BUSINESS_CENTER_ATTR] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'EMAIL_TEMPLATE_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EMAIL_TEMPLATE_BODY_EN', N'EMAIL_TEMPLATE_BODY_FR', N'EMAIL_TEMPLATE_SUBJECT_EN', N'EMAIL_TEMPLATE_SUBJECT_FR', N'EMAIL_TEMPLATE_TYPE_ID', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[EMAIL_TEMPLATE]'))
    SET IDENTITY_INSERT [HRSC].[EMAIL_TEMPLATE] ON;
INSERT INTO [HRSC].[EMAIL_TEMPLATE] ([EMAIL_TEMPLATE_ID], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EMAIL_TEMPLATE_BODY_EN], [EMAIL_TEMPLATE_BODY_FR], [EMAIL_TEMPLATE_SUBJECT_EN], [EMAIL_TEMPLATE_SUBJECT_FR], [EMAIL_TEMPLATE_TYPE_ID], [EXPIRY_DATE], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(10102 AS bigint), '2023-01-19T09:48:57.147', '2023-01-19T09:08:51.403', '2023-01-01T00:00:00.000', CONCAT(CAST(N'Your requests waiting for approval.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'You can view the request online on the HRSC Web Application: http://hrsc-csrh.prv/webforms/clientrequestsdelegate.aspx', nchar(13), nchar(10), nchar(13), nchar(10), N' Thank you for using the Human Resources Services Centre (HRSC) Web Application.', nchar(13), nchar(10), nchar(13), nchar(10), N'If you have any questions or concerns, please contact the lead assigned to your request.'), CONCAT(CAST(N'Votre demande est en attente d''approbation.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'Vous pouvez visualiser les demandes à partir de l’application Web du CSRH : http://hrsc-csrh.prv/webforms/clientrequestsdelegate.aspx', nchar(13), nchar(10), nchar(13), nchar(10), N' Merci d’avoir utilisé l’application web du Centre de services en ressources humaines (CSRH).', nchar(13), nchar(10), nchar(13), nchar(10), N'Pour toute question ou commentaire concernant cette demande, nous vous invitons à contacter le leader assigné à votre demande..'), N'HRSC ID [IDENTIFIER] - Action required: Waiting for approval - [SUBJECT] - Employee:[EMP_NAME]', N'CSRH ID [IDENTIFIER] - Action requise: En attente d''approbation - [SUBJECT] - Employé:[EMP_NAME]', CAST(58 AS bigint), NULL, N'HRSC 4.13', N'HRSC 4.13'),
(CAST(10103 AS bigint), '2023-01-19T09:48:57.147', '2023-01-19T09:08:51.403', '2023-01-01T00:00:00.000', CONCAT(CAST(N'This requests has been approved.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'You can view the request online on the HRSC Web Application: [REQUEST_LINK]'), CONCAT(CAST(N'Cette demande a été approuvée.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'Vous pouvez visualiser les demandes à partir de l’application Web du CSRH : [REQUEST_LINK]'), N'HRSC ID [IDENTIFIER] - Request Approuved - [SUBJECT] - Employee Name:[EMP_NAME]', N'CSRH ID [IDENTIFIER] - Demande approuvée - [SUBJECT] - Nom d''employé:[EMP_NAME]', CAST(59 AS bigint), NULL, N'HRSC 4.13', N'HRSC 4.13'),
(CAST(10104 AS bigint), '2023-01-19T09:48:57.147', '2023-01-19T09:08:51.403', '2023-01-01T00:00:00.000', CONCAT(CAST(N'This requests has been Declined.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'You can view the request online on the HRSC Web Application: [REQUEST_LINK]'), CONCAT(CAST(N'Cette demande a été déclinée.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'Vous pouvez visualiser les demandes à partir de l’application Web du CSRH : [REQUEST_LINK]'), N'HRSC ID [IDENTIFIER] - Request Declined - [SUBJECT] - Employee Name:[EMP_NAME]', N'CSRH ID [IDENTIFIER] - Demande déclinée - [SUBJECT] - Nom d''employé:[EMP_NAME]', CAST(60 AS bigint), NULL, N'HRSC 4.13', N'HRSC 4.13'),
(CAST(10105 AS bigint), '2023-01-19T09:48:57.147', '2023-01-19T09:08:51.403', '2023-01-01T00:00:00.000', CONCAT(CAST(N'This requests is waithing for signature.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'You can view the request online on the HRSC Web Application: [REQUEST_LINK]'), CONCAT(CAST(N'Cette demande est en attente de signature.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'Vous pouvez visualiser les demandes à partir de l’application Web du CSRH : [REQUEST_LINK]'), N'HRSC ID [IDENTIFIER] - Request Pending Signature - [SUBJECT] - Employee:[EMP_NAME]', N'CSRH ID [IDENTIFIER] - Demande en attente de signature - [SUBJECT] - Employé:[EMP_NAME]', CAST(61 AS bigint), NULL, N'HRSC 4.13', N'HRSC 4.13'),
(CAST(10106 AS bigint), '2023-01-19T09:48:57.147', '2023-01-19T09:08:51.403', '2023-01-01T00:00:00.000', CONCAT(CAST(N'This requests is Resolved. ' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'You can view the request online on the HRSC Web Application: [REQUEST_LINK]'), CONCAT(CAST(N'Cette demande est résolue.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'Vous pouvez visualiser les demandes à partir de l’application Web du CSRH : [REQUEST_LINK]'), N'HRSC ID [IDENTIFIER] - Request Resolved - [SUBJECT] - Employee:[EMP_NAME]', N'CSRH ID [IDENTIFIER] - Demande résolue - [SUBJECT] - Employé:[EMP_NAME]', CAST(62 AS bigint), NULL, N'HRSC 4.13', N'HRSC 4.13'),
(CAST(10107 AS bigint), '2023-01-19T09:48:57.147', '2023-01-19T09:08:51.403', '2023-01-01T00:00:00.000', CONCAT(CAST(N'This requests been resolved by SFT. ' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'You can view the request online on the HRSC Web Application: [REQUEST_LINK]'), CONCAT(CAST(N'Cette demande a été résolue par SFT.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N'Vous pouvez visualiser les demandes à partir de l’application Web du CSRH : [REQUEST_LINK]'), N'HRSC ID [IDENTIFIER] - Request Resolve by SFT - [SUBJECT] - Employee:[EMP_NAME]', N'CSRH ID [IDENTIFIER] - Demande Résolue par SFT - [SUBJECT] - Employé:[EMP_NAME]', CAST(63 AS bigint), NULL, N'HRSC 4.13', N'HRSC 4.13'),
(CAST(10108 AS bigint), '2023-01-19T09:48:57.147', '2023-01-19T09:08:51.403', '2023-01-01T00:00:00.000', CONCAT(CAST(N'This requests been resolved by SFT. ' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N' To be able to transfert to HRSB you need resolve your intervent. ', nchar(13), nchar(10), nchar(13), nchar(10), N' You can view the request online on the HRSC Web Application: [REQUEST_LINK]'), CONCAT(CAST(N'Cette demande a été résolue par SFT.' AS nvarchar(max)), nchar(13), nchar(10), nchar(13), nchar(10), N' Pour que la demande soit transférée à HRSB vous devez résoudre votre intervention. ', nchar(13), nchar(10), nchar(13), nchar(10), N' Vous pouvez visualiser les demandes à partir de l’application Web du CSRH : [REQUEST_LINK]'), N'HRSC ID [IDENTIFIER] - Request Resolve by SFT - [SUBJECT] - Employee:[EMP_NAME]', N'CSRH ID [IDENTIFIER] - Demande Résolue par SFT - [SUBJECT] - Employé:[EMP_NAME]', CAST(64 AS bigint), NULL, N'HRSC 4.13', N'HRSC 4.13');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'EMAIL_TEMPLATE_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EMAIL_TEMPLATE_BODY_EN', N'EMAIL_TEMPLATE_BODY_FR', N'EMAIL_TEMPLATE_SUBJECT_EN', N'EMAIL_TEMPLATE_SUBJECT_FR', N'EMAIL_TEMPLATE_TYPE_ID', N'EXPIRY_DATE', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[EMAIL_TEMPLATE]'))
    SET IDENTITY_INSERT [HRSC].[EMAIL_TEMPLATE] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GD_ACCOUNT_EMAIL_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'GD_ACCOUNT_EMAIL', N'GD_ACCOUNT_EMAIL_DESC_EN', N'GD_ACCOUNT_EMAIL_DESC_FR', N'GD_ACCOUNT_EMAIL_NAME_EN', N'GD_ACCOUNT_EMAIL_NAME_FR', N'GD_ACCOUNT_TYPE_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[GD_ACCOUNT_EMAIL]'))
    SET IDENTITY_INSERT [HRSC].[GD_ACCOUNT_EMAIL] ON;
INSERT INTO [HRSC].[GD_ACCOUNT_EMAIL] ([GD_ACCOUNT_EMAIL_ID], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EXPIRY_DATE], [GD_ACCOUNT_EMAIL], [GD_ACCOUNT_EMAIL_DESC_EN], [GD_ACCOUNT_EMAIL_DESC_FR], [GD_ACCOUNT_EMAIL_NAME_EN], [GD_ACCOUNT_EMAIL_NAME_FR], [GD_ACCOUNT_TYPE_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(15 AS bigint), '2023-01-27T11:25:24.857', NULL, '2016-04-21T00:00:00.000', NULL, N'EDSC.DGIIT.SFASalaire-FPSSalary.IITB.ESDC@hrsdc-rhdcc.gc.ca', N'EMAIL SENT TO SFT WHEN INTERVENTION TRANSFERT TO HRSB', N'EMAIL SENT TO SFT WHEN INTERVENTION TRANSFERT TO HRSB', N'FINANCE', N'FINANCE', CAST(8 AS bigint), 'HRSC 4.13', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GD_ACCOUNT_EMAIL_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'GD_ACCOUNT_EMAIL', N'GD_ACCOUNT_EMAIL_DESC_EN', N'GD_ACCOUNT_EMAIL_DESC_FR', N'GD_ACCOUNT_EMAIL_NAME_EN', N'GD_ACCOUNT_EMAIL_NAME_FR', N'GD_ACCOUNT_TYPE_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[GD_ACCOUNT_EMAIL]'))
    SET IDENTITY_INSERT [HRSC].[GD_ACCOUNT_EMAIL] OFF;


IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'REQ_STATUS_JUSTIFICATION_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'HR_JUSTIFICATION_ID', N'REQUEST_STATUS_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[REQ_STATUS_JUSTIFICATION]'))
    SET IDENTITY_INSERT [HRSC].[REQ_STATUS_JUSTIFICATION] ON;
INSERT INTO [HRSC].[REQ_STATUS_JUSTIFICATION] ([REQ_STATUS_JUSTIFICATION_ID], [DATE_CREATED], [DATE_UPDATED], [EFFECTIVE_DATE], [EXPIRY_DATE], [HR_JUSTIFICATION_ID], [REQUEST_STATUS_ID], [USER_CREATED], [USER_UPDATED])
VALUES (CAST(98 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', NULL, NULL, CAST(98 AS bigint), CAST(38 AS bigint), N'HRSC 4.13', N'HRSC 4.13'),
(CAST(99 AS bigint), '2022-12-20T09:00:00.000', '2022-12-20T09:00:00.000', NULL, NULL, CAST(99 AS bigint), CAST(38 AS bigint), N'HRSC 4.13', N'HRSC 4.13');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'REQ_STATUS_JUSTIFICATION_ID', N'DATE_CREATED', N'DATE_UPDATED', N'EFFECTIVE_DATE', N'EXPIRY_DATE', N'HR_JUSTIFICATION_ID', N'REQUEST_STATUS_ID', N'USER_CREATED', N'USER_UPDATED') AND [object_id] = OBJECT_ID(N'[HRSC].[REQ_STATUS_JUSTIFICATION]'))
    SET IDENTITY_INSERT [HRSC].[REQ_STATUS_JUSTIFICATION] OFF;


COMMIT;