--100
USE ufdata_100_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'100' AS accid,-- 账套号
	'option-1721291887209' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );
	
	--200--100
USE ufdata_200_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'200' AS accid,-- 账套号
	'option-1721291887210' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );

--300
USE ufdata_300_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'300' AS accid,-- 账套号
	'option-1721291887211' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );
	
--400
USE ufdata_400_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'400' AS accid,-- 账套号
	'option-1721291887212' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );
	
	--500
USE ufdata_500_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'500' AS accid,-- 账套号
	'option-1721291887213' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );
--600
USE ufdata_600_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'600' AS accid,-- 账套号
	'option-1721291887214' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );

--610
USE ufdata_610_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'610' AS accid,-- 账套号
	'option-1721291887215' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );

--700
USE ufdata_700_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'700' AS accid,-- 账套号
	'option-1721291887216' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );

--800
USE ufdata_800_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'800' AS accid,-- 账套号
	'option-1721291887217' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );

--900
USE ufdata_900_2024;
CREATE VIEW v_NE_ExpenVouch AS 
SELECT
	'900' AS accid,-- 账套号
	'option-1721291887218' AS company,-- 所属公司
	h.ID as id,-- 费用报销单主表主键
	h.Code AS djbh ,-- 报销单号
	h.ExpenseDate ddate ,-- 报销日期
	CASE WHEN h.IsOverBudget = 0 THEN 'option-1720776024475' WHEN h.IsOverBudget = 1 THEN 'option-1720776024474' END AS isOverBudget  , -- 是否超预算
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
	h.AgentID AS cMaker,-- 制单人
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );