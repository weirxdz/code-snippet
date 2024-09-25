-- 报销单增加字段
-- 100
ALTER TABLE UFDATA_100_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_100_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_100_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_100_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_100_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 200
ALTER TABLE UFDATA_200_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_200_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_200_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_200_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_200_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 300
ALTER TABLE UFDATA_300_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_300_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_300_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_300_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_300_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 400
ALTER TABLE UFDATA_400_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_400_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_400_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_400_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_400_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 500
ALTER TABLE UFDATA_500_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_500_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_500_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_500_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_500_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 600
ALTER TABLE UFDATA_600_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_600_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_600_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_600_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_600_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 610
ALTER TABLE UFDATA_610_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_610_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_610_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 700
ALTER TABLE UFDATA_700_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_700_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_700_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_700_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_700_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 800
ALTER TABLE UFDATA_800_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_800_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_800_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 900
ALTER TABLE UFDATA_900_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_900_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_900_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 费用申请单增加字段
-- 100
ALTER TABLE UFDATA_100_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_100_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_100_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_100_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_100_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 200
ALTER TABLE UFDATA_200_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_200_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_200_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_200_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_200_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 300
ALTER TABLE UFDATA_300_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_300_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_300_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_300_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_300_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 400
ALTER TABLE UFDATA_400_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_400_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_400_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_400_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_400_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 500
ALTER TABLE UFDATA_500_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_500_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_500_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_500_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_500_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 600
ALTER TABLE UFDATA_600_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_600_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_600_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_600_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_600_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 610
ALTER TABLE UFDATA_610_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_610_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_610_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 700
ALTER TABLE UFDATA_700_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_700_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_700_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_700_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_700_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 800
ALTER TABLE UFDATA_800_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_800_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_800_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;

-- 900
ALTER TABLE UFDATA_900_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_900_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_900_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;