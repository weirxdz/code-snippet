-- 推送企业微信审核需要对U8数据库表增加的列
ALTER TABLE UFDATA_110_2024.dbo.AP_ApplyPayVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_110_2024.dbo.AP_ApplyPayVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_110_2024.dbo.AP_ApplyPayVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaDate';

ALTER TABLE UFDATA_120_2024.dbo.AP_ApplyPayVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_120_2024.dbo.AP_ApplyPayVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_120_2024.dbo.AP_ApplyPayVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaDate';

SELECT * FROM UFDATA_110_2024.dbo.AP_ApplyPayVouch;
ALTER TABLE UFDATA_510_2024.dbo.AP_ApplyPayVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_510_2024.dbo.AP_ApplyPayVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_510_2024.dbo.AP_ApplyPayVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'AP_ApplyPayVouch', 'column', N'wxOaDate';


ALTER TABLE UFDATA_110_2024.dbo.PU_AppVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_110_2024.dbo.PU_AppVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_110_2024.dbo.PU_AppVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaDate';

ALTER TABLE UFDATA_120_2024.dbo.PU_AppVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_120_2024.dbo.PU_AppVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_120_2024.dbo.PU_AppVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaDate';

ALTER TABLE UFDATA_510_2024.dbo.PU_AppVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_510_2024.dbo.PU_AppVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_510_2024.dbo.PU_AppVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaDate';

ALTER TABLE UFDATA_610_2024.dbo.PU_AppVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_610_2024.dbo.PU_AppVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_610_2024.dbo.PU_AppVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaDate';

ALTER TABLE UFDATA_800_2024.dbo.PU_AppVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_800_2024.dbo.PU_AppVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_800_2024.dbo.PU_AppVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaDate';

ALTER TABLE UFDATA_900_2024.dbo.PU_AppVouch ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_900_2024.dbo.PU_AppVouch ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_900_2024.dbo.PU_AppVouch ADD wxOaDate datetime2 NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PU_AppVouch', 'column', N'wxOaDate';


ALTER TABLE UFDATA_110_2024.dbo.PO_Pomain ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaState';
ALTER TABLE UFDATA_110_2024.dbo.PO_Pomain ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_110_2024.dbo.PO_Pomain ADD wxOaDate datetime2 NULL;
EXEC UFDATA_110_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaDate';

ALTER TABLE UFDATA_120_2024.dbo.PO_Pomain ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaState';
ALTER TABLE UFDATA_120_2024.dbo.PO_Pomain ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_120_2024.dbo.PO_Pomain ADD wxOaDate datetime2 NULL;
EXEC UFDATA_120_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaDate';


ALTER TABLE UFDATA_510_2024.dbo.PO_Pomain ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaState';
ALTER TABLE UFDATA_510_2024.dbo.PO_Pomain ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_510_2024.dbo.PO_Pomain ADD wxOaDate datetime2 NULL;
EXEC UFDATA_510_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaDate';

ALTER TABLE UFDATA_610_2024.dbo.PO_Pomain ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaState';
ALTER TABLE UFDATA_610_2024.dbo.PO_Pomain ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_610_2024.dbo.PO_Pomain ADD wxOaDate datetime2 NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaDate';

ALTER TABLE UFDATA_800_2024.dbo.PO_Pomain ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaState';
ALTER TABLE UFDATA_800_2024.dbo.PO_Pomain ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_800_2024.dbo.PO_Pomain ADD wxOaDate datetime2 NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaDate';

ALTER TABLE UFDATA_900_2024.dbo.PO_Pomain ADD wxOaState nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'推送微信状态', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaState';
ALTER TABLE UFDATA_900_2024.dbo.PO_Pomain ADD wxOaSpNo nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批单号', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_900_2024.dbo.PO_Pomain ADD wxOaDate datetime2 NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'微信审批时间', 'schema', N'dbo', 'table', N'PO_Pomain', 'column', N'wxOaDate';