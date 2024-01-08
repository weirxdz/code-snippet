-- 推送企业微信审批的单据视图
-- 销售订单主表视图
CREATE VIEW v_so_main AS 
SELECT
	h.ID as id,
	h.cSOCode ,
	h.dDate ,
	h.cDefine8 AS sfqk, -- 是否欠款
	h.cDefine11 AS projectcode ,-- 项目编码
	h.cDefine12 AS projectname,-- 项目名称
	d.cDepName AS salesdeptname,-- 销售部门
	c.cCusName AS custname,-- 客户名称
	p.cPersonName AS clerkname, -- 业务员名称
	isnull(hp.cPsnPostAddr,'XiaoTong') AS cPsnPostAddr,-- 业务员账号
	isnull(UU.cUserEmail,'XiaoTong') AS wxId,-- 申请人，对应企业微信里的申请人
	UU.cUserEmail AS cUserEmail,-- 制单人账号
	h.cMemo ,-- 销售订单备注
	h.iStatus ,
	h.wxOaState,
	h.cMaker ,
	h.cVerifier ,
	h.dverifydate 
FROM
	SO_SOMain h
	LEFT JOIN Department d ON h.cDepCode = d.cDepCode
	LEFT JOIN Customer c ON h.cCusCode = c.cCusCode
	LEFT JOIN Person p ON h.cPersonCode = p.cPersonCode
	LEFT JOIN hr_hi_person hp ON h.cPersonCode = hp.cPsn_Num 
	LEFT JOIN UA_User uu ON H.cMaker = UU.cUser_Name  
WHERE
	1 = 1 
	AND (h.iStatus = 0 OR h.iStatus IS NULL)  -- AND convert(varchar(10),h.dDate,120) >= '2023-05-20' -- 开始同步日期，接口只处理此日期之后的记录
	
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );

-- 销售订单子表视图
CREATE VIEW v_so_main_b AS 
SELECT
	b.id,
	b.cInvCode ,
	i.cInvName ,
	i.cInvStd ,-- 存货规格型号
	b.iQuantity,
	b.iTaxUnitPrice,
	b.iSum AS amount 
FROM
	SO_SODetails b
	INNER JOIN Inventory i ON b.cInvCode = i.cInvCode
	INNER JOIN SO_SOMain h ON b.ID = h.ID AND h.cVerifier IS NOT NULL ;
	
-- 发货单主表视图
CREATE  VIEW dbo.v_DispatchList
AS
SELECT
	h.DLID AS id, -- 发货单主键
	h.cSOCode AS soCode,-- 销售订单号
	h.cDLCode,-- 发货单号
	h.dDate,-- 发货单日期
	h.cDefine8 AS sfqk,-- 是否欠款
	d.cDepName AS salesdeptname,-- 销售部门名称
	c.cCusName AS custname,-- 客户名称
	p.cPersonName AS clerkname,-- 业务员名称
	h.cDefine11 AS projectcode, -- 销售项目编码
	h.cDefine12 AS projectname, -- 销售项目名称
	-- ISNULL(hp.cPsnPostAddr,N'aChenJieZhongNuoTongFeng18005343') AS wxId, 	
	isnull(UU.cUserEmail,'XiaoTong') AS wxId,-- 申请人，对应企业微信里的申请人
	h.cMemo,-- 单据备注
	h.wxOaState,-- 
	h.cMaker,-- 制单人名称
	h.cVerifier,-- 审核人名称
	hp.cPsnPostAddr,-- 业务员账号
	uu.cUserEmail,-- 制单人账号
	h.dverifydate
FROM
	dbo.DispatchList AS h
LEFT OUTER JOIN dbo.Department AS d ON	h.cDepCode = d.cDepCode
LEFT OUTER JOIN dbo.Customer AS c ON	h.cCusCode = c.cCusCode
LEFT OUTER JOIN dbo.Person AS p ON	h.cPersonCode = p.cPersonCode
LEFT OUTER JOIN dbo.hr_hi_person AS hp ON	h.cPersonCode = hp.cPsn_Num
LEFT OUTER JOIN dbo.UA_User AS uu ON	h.cMaker = uu.cUser_Name
WHERE 1 = 1
	AND (h.wxOaState IS NULL OR h.wxOaState = '' );
-- 发货单子表视图
CREATE VIEW v_DispatchList_b AS 
	SELECT
	b.DLID AS id,
	b.cInvCode ,
	i.cInvStd ,-- 存货规格型号	
	i.cInvName ,
	b.iQuantity ,
	b.iSum 
	FROM	DispatchLists b
	INNER JOIN Inventory i ON b.cInvCode = i.cInvCode
	INNER JOIN DispatchList h ON b.DLID = h.DLID AND h.cVerifier IS NULL ;
-- 请购单主表视图
CREATE VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	hp.cPsnPostAddr,
	uu.cUserEmail,
	ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
	h.cMemo,
	h.wxOaState,
	h.cMaker,
	h.cVerifier,
	h.cAuditDate,
	h.cAuditTime,
	h.iverifystateex
FROM
	dbo.PU_AppVouch AS h
LEFT OUTER JOIN dbo.Department AS d ON	h.cDepCode = d.cDepCode
LEFT OUTER JOIN  dbo.Person AS p ON	h.cPersonCode = p.cPersonCode
LEFT OUTER JOIN dbo.hr_hi_person AS hp ON	h.cPersonCode = hp.cPsn_Num
LEFT OUTER JOIN  dbo.UA_User AS uu ON	h.cMaker = uu.cUser_Name
WHERE 1 = 1
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );

-- 请购单子表视图
CREATE VIEW v_PU_AppVouch_b AS 
	SELECT
	b.ID AS id,
	b.cInvCode ,
	i.cInvName,
	i.cInvStd,-- 规格型号
	b.fQuantity  ,
	b.dRequirDate 
FROM
	PU_AppVouchs b
	INNER JOIN Inventory i ON b.cInvCode = i.cInvCode
	INNER JOIN PU_AppVouch h ON b.ID = h.ID AND h.cVerifier IS NOT NULL ;
	
-- 采购订单主表视图
CREATE VIEW dbo.v_po_main
AS
SELECT
	h.POID AS id,
	h.cPOID,
	h.dPODate,
	v.cVenName,
	CASE
		WHEN v.cVenDefine1 = '捷顺' THEN 'option-1704179228351'
		WHEN v.cVenDefine1 = '启原' THEN 'option-1704179228352'
		ELSE 'option-1704179280344'
	END AS cVenDefine1,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	ISNULL(hp.cPsnPostAddr,	N'XiaoTong'	) AS cPsnPostAddr,
	uu.cUserEmail,
	h.cDefine8 AS sfwg,
	ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
	h.cMemo,
	h.wxOaState,
	h.cMaker,
	h.cVerifier,
	h.cAuditDate,
	h.cAuditTime,
	h.iverifystateex
FROM
	dbo.PO_Pomain AS h
LEFT OUTER JOIN dbo.Department AS d ON	h.cDepCode = d.cDepCode
LEFT OUTER JOIN dbo.Vendor AS v ON	h.cVenCode = v.cVenCode
LEFT OUTER JOIN dbo.Person AS p ON	h.cPersonCode = p.cPersonCode
LEFT OUTER JOIN dbo.hr_hi_person AS hp ON	h.cPersonCode = hp.cPsn_Num
LEFT OUTER JOIN dbo.UA_User AS uu ON	h.cMaker = uu.cUser_Name
WHERE  1 = 1
	AND (		h.cVerifier IS NULL	)
	AND (		h.wxOaState IS NULL			OR                h.wxOaState = ''	);
-- 采购订单子表视图
CREATE VIEW v_po_main_b AS 
SELECT
	b.POID AS poId,
	b.cInvCode,
	i.cInvName,
	i.cInvStd  ,-- 规格型号
	b.iQuantity ,
	b.iTaxPrice AS taxPrice,
	b.iSum AS amount 
FROM
	PO_Podetails b
	INNER JOIN Inventory i ON b.cInvCode = i.cInvCode
	INNER JOIN PO_Pomain h ON b.POID = h.POID AND h.cVerifier IS NOT NULL ;
-- 采购订单存货采购分类视图
CREATE VIEW v_po_main_sub AS 
SELECT DISTINCT
	h.POID AS poId,
	CASE WHEN i.cInvDefine1 = '彩涂板' THEN	'option-1704179289115'
			 WHEN i.cInvDefine1 = '镀锌板' THEN	'option-1704179289116'
			 WHEN i.cInvDefine1 = '硅晶板' THEN	'option-1704179331095'
			 WHEN i.cInvDefine1 = '其他' THEN	'option-1704179378618'
	END AS subClass -- 存货采购分类
FROM
	PO_Podetails b
INNER JOIN PO_Pomain h ON h.POID = b.POID AND h.cVerifier IS NULL 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode;
-- 付款申请单主表视图
CREATE VIEW v_AP_ApplyPayVouch AS 
SELECT
	h.pID as id,
	h.cVouchID,
	h.dVouchDate,
	d.cDepName AS deptname,-- U8申请部门
	p.cPersonName AS clerkname,-- U8申请人
	isnull(UU.cUserEmail, 'XiaoTong') AS wxId, -- 申请人账号
	pp.cPsnPostAddr AS fkspr,-- 付款审批人
	UU.cUserEmail AS cUserEmail, -- 制单人账号
	h.cDigest AS cDigest, --备注
	h.wxOaState,
	h.cOperator, -- 制单人名称
	h.cCheckMan,-- 审核人名称
	h.dverifydate, -- 审核日期
	h.dverifysystime-- 审核时间
FROM
	AP_ApplyPayVouch h
LEFT JOIN Department d ON h.cDepCode = d.cDepCode
LEFT JOIN Person p ON h.cPerson = p.cPersonCode
LEFT JOIN hr_hi_person hp ON h.cPerson = hp.cPsn_Num
LEFT JOIN hr_hi_person pp ON h.cDefine9 = pp.cPsn_Num
LEFT JOIN UA_User uu ON H.cOperator = UU.cUser_Name
WHERE
	1 = 1-- h.iStatus = 0 -- AND convert(varchar(10),h.dVouchDate,120) >= '2023-05-20' -- 开始同步日期，接口只处理此日期之后的记录
	
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' );
-- 付款申请单子表视图
CREATE VIEW v_AP_ApplyPayVouch_b AS 
SELECT
	b.pid AS id,
	b.cInvCode ,
	i.cInvName,
	i.cInvStd  ,
	b.iApplyAmt 
FROM
	AP_ApplyPayVouchs b
	left JOIN Inventory i ON b.cInvCode = i.cInvCode
	INNER JOIN AP_ApplyPayVouch h ON b.PID = h.PID AND h.cCheckMan IS NOT NULL  ;

