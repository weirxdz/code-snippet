WITH xsdd_details AS (
	SELECT
		h.ID, 
		h.cDefine11 项目编码,
		h.cDefine12 项目名称,
		h.cSTCode 销售类型编码,
		h.dDate 单据日期 ,
		h.cSOCode 销售订单号 ,
		h.cCusCode 客户编码 ,
		c.cCusName 客户名称,
		h.cDefine10 内部客户,
		h.cDepCode 部门编码 ,
		h.cPersonCode 业务员编码 ,
		h.cSCCode 发运方式编码 ,
		h.cCusOAddress 客户地址,
		h.cexch_name 币种名称 ,
		h.iExchRate 汇率,
		h.iTaxRate 表头税率 ,
		h.iMoney,
		h.cMemo 备注 ,
		h.iStatus 状态,
		h.cMaker 制单人 ,
		h.cVerifier 审核人,
		h.cDefine8 是否物流,
		h.cDefine9 是否承担运费,
		h.iVTid 模板ID,
		h.cBusType 业务类型,
		b.AutoID,
		b.cDefine34 产品类别,
		b.cInvCode 存货编码,
		b.cInvName 存货名称,
		b.cCusInvName 客户存货名称,
		u.cComUnitName 主计量单位,
		b.iQuantity 主数量,
		b.iNum 辅数量,
		b.iMoney 无税金额,
		b.iTax 税额,
		b.iSum 价税合计,
		b.iFHQuantity 累计发货主数量,
		b.iFHNum 累计发货辅数量,
		b.iFHMoney 累计发货金额,
		b.iKPQuantity 累计开票主数量,
		b.iKPNum 累计开票辅数量,
		b.iKPMoney 累计开票金额,
		b.cMemo 订单行备注,
		b.iTaxRate 订单行税率,
		b.cItem_class 项目大类编码,
		b.cItem_CName 项目大类名称,
		b.cItemCode 表体项目编码,
		b.cItemName 表体项目名称,
		b.iInvExchRate,
		b.bgift 赠品标识
		FROM
			SO_SOMain as h
		INNER JOIN SO_SODetails b ON h.ID = b.ID 
		INNER JOIN Inventory m ON b.cInvCode = m.cInvCode 
		INNER JOIN ComputationUnit u ON  m.cComUnitCode = u.cComunitCode
		INNER JOIN customer c ON h.cCusCode = c.cCusCode 
	--WHERE h.dDate >= '${{sdate}' AND h.dDate <= '${{edate}'
		),
	U8dd AS (
		SELECT d.id,d.销售订单号,d.项目编码,d.项目名称, COALESCE(d.产品类别,9) 产品类别,sum(d.价税合计) 订单金额
		FROM xsdd_details d
		GROUP BY d.id,d.销售订单号,d.项目编码,d.项目名称,d.产品类别
		),
	d AS (
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt1
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt3
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt5
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt7
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt9
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt11
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt13
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt15)
	OAHT AS ()


