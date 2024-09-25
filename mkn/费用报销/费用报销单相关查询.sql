-- 费用报销单相关查询
-- 费用申请单子表
SELECT * FROM NE_CostApply_Sub ;
-- 费用申请单主表
SELECT * FROM NE_CostApply ;
-- 费用报销单子表
SELECT b.ID,b.ExpenseVouchID,ec.cExpCName 费用分类,ei.cExpName 费用项目 ,b.ExpenseMoney 报销金额,b.Memo 说明,b.VouchMoney  申请单金额,b.ItemClassID,f.citemname  销售项目,v.cVenName 供应商,d.cDepName 费用承担部门  
FROM NE_ExpenseVouch_Sub b
INNER JOIN  NE_ExpenVouch h ON b.ExpenseVouchID = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4
;
-- 费用报销单主表
SELECT h.ID,h.AutoID,h.Code,h.ExpenseDate,h.ExpenserID,h.ExpenseMoney 报销金额,h.IVerifyState,h.DeptID,h.Used,h.AuditorID,h.AuditDateTime,h.AuditState,h.AuditInfo,h.AuditDate,h.Auditor,h.IsAudit,h.VouchState ,h.SpreadDeptID ,h.CostApplyID,h.CostApplyCode FROM NE_ExpenVouch h;
-- 报销单增加字段
ALTER TABLE UFDATA_999_2024.dbo.NE_ExpenVouch ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaState';
ALTER TABLE UFDATA_999_2024.dbo.NE_ExpenVouch ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_ExpenVouch', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_999_2024.dbo.NE_ExpenVouch ADD wxOaDate datetime2(0) NULL;

-- 费用申请单增加字段
ALTER TABLE UFDATA_999_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_999_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_999_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;
-- 费用报销单视图查询语句
SELECT * FROM v_NE_ExpenVouch;
DROP VIEW v_NE_ExpenVouch;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'999' AS accid,-- 账套号
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	h.IsOverBudget   AS IsOverBudget  , -- 是否超预算
	h.CostApplyCode AS sqdh,-- 申请单号
	d.cDepName AS deptname,-- 部门
	c.cCusName AS custname,-- 客户名称
	p.cPersonName AS clerkname, -- 业务员名称
	isnull(hp.cPsnPostAddr,'XiaoTong') AS cPsnPostAddr,-- 业务员账号
	COALESCE(UU.cUserEmail,'XiaoTong') AS wxId,-- 申请人，对应企业微信里的申请人
	UU.cUserEmail AS cUserEmail,-- 制单人账号
	h.Used ,-- 用途
	h.VouchState ,--单据状态
	h.wxOaState,
	h.AgentID  ,-- 经办人
	h.AuditorID ,-- 审核人
	h.AuditDate -- 审核日期
FROM
	NE_ExpenVouch  h
	LEFT JOIN Department d ON h.DeptID  = d.cDepCode
	LEFT JOIN Customer c ON h.CusCode  = c.cCusCode
	LEFT JOIN Person p ON h.ExpenserID  = p.cPersonCode
	LEFT JOIN hr_hi_person hp ON h.ExpenserID  = hp.cPsn_Num 
	LEFT JOIN UA_User uu ON h.AgentID = UU.cUser_Id 
WHERE
	1 = 1 
	AND (h.VouchState < 4) 
	AND (h.AuditorID IS NULL OR h.AuditorID = '')
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )

	;
-- 费用报销单子表查询视图
SELECT * FROM v_NE_ExpenVouch_sub;
CREATE VIEW v_NE_ExpenVouch_sub AS 
SELECT
	b.ID, -- 费用报销单子表主键
	b.ExpenseVouchID,-- 费用报销单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ExpenseMoney ,--报销金额
	b.Memo ,--行说明
	b.VouchMoney ,--申请单金额
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_ExpenseVouch_Sub b
INNER JOIN  NE_ExpenVouch h ON b.ExpenseVouchID = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4

;
SELECT uu.cUser_Id,uu.cUserEmail FROM UA_User uu
;
SELECT * FROM ExpItemClass;
SELECT * FROM ExpenseItem;