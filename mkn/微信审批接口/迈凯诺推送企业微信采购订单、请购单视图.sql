-- 迈凯诺推送企业微信采购订单主表视图
-- 100
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872597249' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
    AND h.POID IN (SELECT t.POID 
      FROM PO_Pomain t 
      INNER JOIN PO_Podetails d ON t.POID = d.POID 
      WHERE d.cSource IS NOT NULL 
      GROUP BY t.POID)
	;
-- 110 山西浩洋
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872693577' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
    AND h.POID IN (SELECT t.POID 
      FROM PO_Pomain t 
      INNER JOIN PO_Podetails d ON t.POID = d.POID 
      WHERE d.cSource IS NOT NULL 
      GROUP BY t.POID)
	;
-- 120 精筑再生资源
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1731049621401' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
    AND h.POID IN (SELECT t.POID 
      FROM PO_Pomain t 
      INNER JOIN PO_Podetails d ON t.POID = d.POID 
      WHERE d.cSource IS NOT NULL 
      GROUP BY t.POID)
	;
-- 400 华筑
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872597250' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
	;
-- 500 防火
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872642580' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
	;
	-- 510 深圳防火
	CREATE VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1731032404548' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	);
-- 600 耐火
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872648008' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
	;
-- 610 四川耐火
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872653168' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
	;
-- 700 众诺
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872673224' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
	;
-- 800 华筑
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872682130' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
	;
-- 900 西部
	ALTER VIEW v_po_main AS 
	SELECT
		h.POID AS id,
		h.cPOID,
		'option-1725872687688' company,
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
		h.cDefine12 AS xsxm,
		ISNULL(uu.cUserEmail,N'XiaoTong') AS wxId,
		REPLACE(REPLACE(h.cMemo,'
	',' '),'  ',' ') AS cMemo,-- replace 处理换行符为空格，嵌套一遍是为了把连续的两个空格处理为一个空格
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
		AND v.cVenName <> '山东迈凯诺安防科技有限公司'-- 20240909 子公司从迈凯诺购买的采购订单，不用推企业微信审核
		AND (		h.cVerifier IS NULL	or h.cVerifier = '')
		AND (		h.wxOaState IS NULL			OR   h.wxOaState = ''	)
	;

-- 采购订单子表视图
ALTER VIEW v_po_main_b AS 
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
	INNER JOIN PO_Pomain h ON b.POID = h.POID -- AND (h.cVerifier IS NOT NULL OR h.cVerifier = '')
;
-- 采购订单子表子视图
CREATE VIEW v_po_main_sub AS 
SELECT DISTINCT
	h.POID AS poId,
	CASE WHEN i.cInvDefine1 = '彩涂板' THEN	'option-1704179289115'
			 WHEN i.cInvDefine1 = '镀锌板' THEN	'option-1704179289116'
			 WHEN i.cInvDefine1 = '硅晶板' THEN	'option-1704179331095'
			 else 'option-1704179378618'
	END AS subClass -- 存货采购分类
FROM
	PO_Podetails b
INNER JOIN PO_Pomain h ON h.POID = b.POID -- AND (h.cVerifier IS NULL OR  h.cVerifier = '')
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode
;

;
-- 迈凯诺推送企业微信请购单视图
-- 100 迈凯诺
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872116718' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 110 山西浩洋
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872238432' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 120 精筑再生资源
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1731049542832' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 400 华筑
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872116719' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 500 防火
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872173374' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 510 深圳防火
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1731033749903' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 600 耐火
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872179442' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 610 四川耐火
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872208768' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 700 众诺
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872218136' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 800 江浙
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872224712' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 900 西部
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1725872233728' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 100 迈凯诺
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1712624639923' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');
-- 100 迈凯诺
ALTER VIEW dbo.v_PU_AppVouch
AS
SELECT
	h.ID,'option-1712624639923' company,
	h.cCode,
	h.dDate,
	d.cDepName AS deptname,
	p.cPersonName AS clerkname,
	h.cDefine8 AS sfwg,
	h.cDefine12 AS xsxm,
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
	AND ( h.wxOaState IS NULL OR h.wxOaState = '' )
	AND (h.cVerifier IS NULL OR h.cVerifier = '');

-- 请购单子视图
create VIEW v_PU_AppVouch_b AS 
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
	INNER JOIN PU_AppVouch h ON b.ID = h.ID -- AND (h.cVerifier IS NOT NULL OR h.cVerifier = '')
	;