-- 费用申请单相关查询
-- 费用申请单子表
SELECT * FROM NE_CostApply_Sub ;
-- 费用申请单主表
SELECT h.ID,h.Code ,h.ApplyDate 申请日期,h.EntryDate 录入日期 ,h.AuditDateTime 审核时间 ,h.AuditorID  审核人 ,h.ApplicantID 申请人     ,h.Used 用途,h.ApplyMoney  金额  ,h.EntryID 录入人 ,h.SpreadDeptID 费用承担部门 ,h.AuditState  审核状态 ,h.IVerifyState 单据审核状态 ,h.AuditDate 审核日期       FROM NE_CostApply h;

-- 费用申请单增加字段
ALTER TABLE UFDATA_999_2024.dbo.NE_CostApply ADD wxOaState nvarchar(200) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'推送状态', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaState';
ALTER TABLE UFDATA_999_2024.dbo.NE_CostApply ADD wxOaSpNo nvarchar(20) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'企微审批编号', 'schema', N'dbo', 'table', N'NE_CostApply', 'column', N'wxOaSpNo';
ALTER TABLE UFDATA_999_2024.dbo.NE_CostApply ADD wxOaDate datetime2(0) NULL;
-- 费用申请单视图查询语句
SELECT * FROM v_NE_CostApply;
DROP VIEW v_NE_CostApply;
CREATE VIEW v_NE_CostApply AS 
SELECT
	'999' AS accid,-- 账套号
	h.ID as id,-- 费用申请单主表主键
	h.Code AS djbh ,-- 申请单号
	h.ApplyDate ddate ,-- 申请日期
	h.IsOverBudget   AS IsOverBudget  , -- 是否超预算
	d.cDepName AS deptname,-- 部门
	c.cCusName AS custname,-- 客户名称
	p.cPersonName AS clerkname, -- 业务员名称
	isnull(hp.cPsnPostAddr,'XiaoTong') AS cPsnPostAddr,-- 业务员账号
	COALESCE(UU.cUserEmail,'XiaoTong') AS wxId,-- 申请人，对应企业微信里的申请人
	UU.cUserEmail AS cUserEmail,-- 制单人账号
	h.Used ,-- 用途
	h.VouchState ,--单据状态
	h.wxOaState,
	h.EntryID   ,-- 经办人
	h.AuditorID ,-- 审核人
	h.AuditDate -- 审核日期
FROM
	NE_CostApply  h
	LEFT JOIN Department d ON h.SpreadDeptID  = d.cDepCode
	LEFT JOIN Customer c ON h.CusCode  = c.cCusCode
	LEFT JOIN Person p ON h.ApplicantID  = p.cPersonCode -- 申请人
	LEFT JOIN hr_hi_person hp ON h.ApplicantID  = hp.cPsn_Num 
	LEFT JOIN UA_User uu ON h.EntryID  = UU.cUser_Id 
WHERE
	1 = 1 
	AND (h.VouchState < 4) 
	AND (h.AuditorID IS NULL OR h.AuditorID = '')
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )

	;
-- 费用申请单子表查询视图
SELECT * FROM v_NE_CostApply_sub;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
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