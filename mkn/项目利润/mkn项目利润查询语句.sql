with i_p_d as (-- 主营业务收入
	SELECT b.citemcode 项目编码,sum(b.iMoney) 收入
		FROM SaleBillVouch h
		INNER JOIN SaleBillVouchs b ON h.SBVID = b.SBVID
		WHERE 1=1
--		AND CONVERT(varchar,b.dSignDate, 23) >= '${开始日期}' AND CONVERT(varchar,b.dSignDate, 23) <= '${截至日期}'
		GROUP BY b.citemcode
		union all 
		SELECT t.projectCode 项目编码,sum(t.amount) 收入
		FROM DataAdjustmentRecords t
		WHERE t.category = '收入'
		AND t.projectCode <> '0100001'
--		AND t.operationDate >= '${开始日期}' AND t.operationDate <= '${截至日期}'
		GROUP BY t.projectCode
		),
	i_p as (
		select 项目编码,sum(收入) 收入 from i_p_d group by 项目编码
	),
	cm_p_d AS (-- 可归集到项目的材料成本分项
		-- 存货核算部分
		SELECT t.cItemCode 项目编码,sum(t.iAOutPrice) 材料成本
		FROM IA_Subsidiary t
		WHERE 1=1
		AND t.cOppHead = '540102'
		and t.cItemCode <> '0100001' and t.cItemCode is not null	
--		AND CONVERT(varchar,t.iPZDate , 23) >= '${开始日期}' AND CONVERT(varchar,t.iPZDate , 23) <= '${截至日期}'
		GROUP BY t.cItemCode
		UNION ALL 
		-- 总账制单部分
		SELECT g.citem_id  项目编码,sum(g.md) 材料成本
		FROM GL_accvouch g
		WHERE g.ccode = '640101' 
			AND g.cdigest <> '期间损益结转' 
			AND COALESCE(g.iflag,0) <> 1
			AND g.coutsysname IS NULL
			and g.citem_id <> '0100001' and g.citem_id is not null	
			AND CONVERT(varchar,g.dbill_date , 23) >= '${开始日期}' AND CONVERT(varchar,g.dbill_date , 23) <= '${截至日期}'
		GROUP BY g.citem_id
		union all 
		SELECT t.projectCode 项目编码,sum(t.amount) 材料成本
		FROM DataAdjustmentRecords t
		WHERE t.category = '成本'
		AND t.projectCode <> '0100001'
		AND t.operationDate >= '${开始日期}' AND t.operationDate <= '${截至日期}'
		GROUP BY t.projectCode
		),
	cm_p as (--可归集到项目的材料成本
		SELECT 项目编码,sum(材料成本 ) 材料成本		FROM cm_p_d 	GROUP BY 项目编码
		),
	cm_np_d as (
		--需要分摊的材料成本,
		SELECT sum(t.iAOutPrice ) 待分摊材料成本
		FROM IA_Subsidiary t
		WHERE 1=1
		AND t.cOppHead = '640101'
		and (t.cItemCode = '0100001' or t.cItemCode is null)
		AND t.cRdCode IN (11,12,16)--可以统计的有 cRdCode\cRdName:11销售出库、16其他出库、12附件发货出库
		AND t.cBusType <> '组装出库'
		AND CONVERT(varchar,t.iPZDate , 23) >= '${开始日期}' AND CONVERT(varchar,t.iPZDate , 23) <= '${截至日期}'
		union all 
		SELECT sum(t.amount) 待分摊材料成本
		FROM DataAdjustmentRecords t
		WHERE t.category = '成本'
		AND t.projectCode = '0100001'
		AND t.operationDate >= '${开始日期}' AND t.operationDate <= '${截至日期}'
		GROUP BY t.projectCode
		),
	cm_np AS (
		SELECT sum(待分摊材料成本) 待分摊材料成本 FROM cm_np_d
		),
	ci_p as (--可归集到项目的安装费
		SELECT g.citem_id  项目编码,sum(g.md) 安装费
		FROM GL_accvouch g
		WHERE g.ccode in( '640102','640103','640104')-- 202411062142
		AND g.cdigest <> '期间损益结转'
		AND COALESCE(g.iflag,0) <> 1
		AND g.citem_id <> '0100001' AND g.citem_id IS NOT NULL 
		AND CONVERT(varchar,g.dbill_date , 23) >= '${开始日期}' AND CONVERT(varchar,g.dbill_date , 23) <= '${截至日期}'
		GROUP BY g.citem_id
	),
	ci_np as (--需要分摊的安装费
		SELECT sum(g.md) 待分摊安装费
		FROM GL_accvouch g
		WHERE g.ccode in( '640102','640103','640104') --202411062142
		AND g.cdigest <> '期间损益结转'
		AND COALESCE(g.iflag,0) <> 1
		AND (g.citem_id = '0100001' or g.citem_id IS NULL) 
		AND CONVERT(varchar,g.dbill_date , 23) >= '${开始日期}' AND CONVERT(varchar,g.dbill_date , 23) <= '${截至日期}'
	),
	s_p_d as (--可归集到项目的销售费用
		SELECT g.citem_id  项目编码,sum(g.md) 销售费用
		FROM GL_accvouch g
		WHERE LEFT(g.ccode,4) = '6601'
		AND g.cdigest <> '期间损益结转'
		AND COALESCE(g.iflag,0) <> 1
		AND g.citem_id <> '0100001'
		AND CONVERT(varchar,g.dbill_date , 23) >= '${开始日期}' AND CONVERT(varchar,g.dbill_date , 23) <= '${截至日期}'
		GROUP BY g.citem_id	
		union all 
		SELECT t.projectCode 项目编码,sum(t.amount) 销售费用
		FROM DataAdjustmentRecords t
		WHERE t.category = '费用'
		AND t.projectCode <> '0100001'
		AND t.operationDate >= '${开始日期}' AND t.operationDate <= '${截至日期}'
		GROUP BY t.projectCode
	),
	s_p as (
		select 项目编码,sum(销售费用) 销售费用 from s_p_d group by 项目编码
	),
	s_np_d as (--需分摊的销售费用
		-- 总账部分
		SELECT sum(g.md) 待分摊销售费用
		FROM GL_accvouch g
		WHERE LEFT(g.ccode,4) = '6601'
		AND g.cdigest <> '期间损益结转'
		AND COALESCE(g.iflag,0) <> 1
		AND (g.citem_id = '0100001' OR g.citem_id IS NULL )
		AND CONVERT(varchar,g.dbill_date , 23) >= '${开始日期}' AND CONVERT(varchar,g.dbill_date , 23) <= '${截至日期}'
		UNION ALL 
		-- 办公用品领用进入到主营业务成本的部分
		SELECT sum(t.iAOutPrice ) 待分摊销售费用
		FROM IA_Subsidiary t
		WHERE 1=1
		AND t.cOppHead = '640101'	
		AND t.cRdCode = 19 --进入到主营业务成本的办公用品出库需要调整到销售费用里
		AND CONVERT(varchar,t.iPZDate , 23) >= '${开始日期}' AND CONVERT(varchar,t.iPZDate , 23) <= '${截至日期}'
		union all 
		SELECT sum(t.amount) 待分摊销售费用
		FROM DataAdjustmentRecords t
		WHERE t.category = '费用'
		AND t.projectCode = '0100001'
		AND t.operationDate >= '${开始日期}' AND t.operationDate <= '${截至日期}'
		GROUP BY t.projectCode
	),
	s_np AS (
		SELECT sum(待分摊销售费用) 待分摊销售费用 FROM s_np_d
	),
	m_p as (-- 可归集到项目的管理费用
	SELECT g.citem_id  项目编码,sum(g.md) 管理费用
	FROM GL_accvouch g
	WHERE g.ccode IN ('660216','660217','660218','660219','660220','660221','660222','660223','660224','660225','660226','660229') 
	AND g.cdigest <> '期间损益结转'
	AND COALESCE(g.iflag,0) <> 1
	AND g.citem_id <> '0100001' AND g.citem_id IS NOT NULL 
	AND CONVERT(varchar,g.dbill_date , 23) >= '${开始日期}' AND CONVERT(varchar,g.dbill_date , 23) <= '${截至日期}'
	GROUP BY g.citem_id
	),
	m_np as (-- 需分摊的管理费用
	SELECT sum(g.md) 待分摊管理费用
	FROM GL_accvouch g
	WHERE g.ccode IN ('660216','660217','660218','660219','660220','660221','660222','660223','660224','660225','660226','660229') 
	AND g.cdigest <> '期间损益结转'
	AND COALESCE(g.iflag,0) <> 1
	AND (g.citem_id = '0100001' or g.citem_id IS  NULL )
	AND CONVERT(varchar,g.dbill_date , 23) >= '${开始日期}' AND CONVERT(varchar,g.dbill_date , 23) <= '${截至日期}'
	),
	tax as (-- 税额，用作分摊管理费用税费的系数
	SELECT h.cDefine11 项目编码,sum(b.iTax) 税额
	FROM SaleBillVouch h
	INNER JOIN SaleBillVouchs b ON h.SBVID = b.SBVID 
	WHERE 1=1
	AND CONVERT(varchar,b.dSignDate, 23) >= '${开始日期}' AND CONVERT(varchar,b.dSignDate, 23) <= '${截至日期}'
	GROUP BY h.cDefine11
	),
	item_list as (
	select 项目编码 from i_p 
	UNION
	select 项目编码 from cm_p 
	UNION
	select 项目编码 from ci_p 
	UNION
	select 项目编码 from s_p 
	UNION
	select 项目编码 from m_p 
	UNION
	select 项目编码 from tax 
	),
  item_person as (
  SELECT   
    t.cDefine11 项目编码, 
    STUFF((  
        SELECT DISTINCT ',' + p.cpersonname
        FROM SaleBillVouch t2 
        INNER JOIN Person p ON t2.cPersonCode = p.cPersonCode
        WHERE t2.cDefine11 = t.cDefine11  
        FOR XML PATH('')), 1, 1, '') AS PersonCodes  
    FROM  SaleBillVouch t 
    GROUP BY  t.cDefine11
  )
	select x.citemccode,x.cItemCname ,x.项目编码,x.项目名称,x.PersonCodes 负责人,x.收入,x.总收入,x.材料成本,x.待分摊材料成本,x.安装费,x.待分摊安装费,x.销售费用,x.待分摊销售费用,x.管理费用,x.待分摊管理费用,x.税额,x.总税额,
	round(COALESCE(x.待分摊材料成本,0)*COALESCE(x.收入,0)/x.总收入,4) 分摊材料成本,
	round(COALESCE(x.待分摊安装费,0)*COALESCE(x.收入,0)/x.总收入,4) 分摊安装费,
	round(COALESCE(x.待分摊销售费用,0)*COALESCE(x.收入,0)/x.总收入,4) 分摊销售费用,
	round(COALESCE(x.待分摊管理费用,0)*COALESCE(x.税额,0)/x.总税额,4) 分摊管理费用,
	round(COALESCE(x.收入,0)-COALESCE(x.材料成本,0)-COALESCE(x.待分摊材料成本,0)*COALESCE(x.收入,0)/COALESCE(x.总收入,0)-COALESCE(x.安装费,0)-COALESCE(x.待分摊安装费,0)*COALESCE(x.收入,0)/COALESCE(x.总收入,0)-COALESCE(x.销售费用,0)-COALESCE(x.待分摊销售费用,0)*COALESCE(x.收入,0)/COALESCE(x.总收入,0)-COALESCE(x.管理费用,0)-COALESCE(x.待分摊管理费用,0)*COALESCE(x.税额,0)/COALESCE(x.总税额,0),2) 项目利润
	from (
		select f.citemccode,fc.cItemCname ,t.项目编码,f.citemname 项目名称,p.PersonCodes,i_p.收入,sum(i_p.收入)over() 总收入,cm_p.材料成本,cm_np.待分摊材料成本,ci_p.安装费,ci_np.待分摊安装费,s_p.销售费用,s_np.待分摊销售费用,m_p.管理费用,m_np.待分摊管理费用,tax.税额,sum(tax.税额) over() 总税额
		from item_list t
		left join fitemss00 f on t.项目编码 = f.citemcode
		INNER JOIN fitemss00class fc ON f.citemccode = fc.cItemCcode 
		left join i_p on t.项目编码 = i_p.项目编码
		left join cm_p on t.项目编码 = cm_p.项目编码
		left join ci_p on t.项目编码 = ci_p.项目编码
		left join s_p on t.项目编码 = s_p.项目编码
		left join m_p on t.项目编码 = m_p.项目编码
		left join tax on t.项目编码 = tax.项目编码
		left join cm_np on 1=1
		left join ci_np on 1=1
		left join s_np on 1=1
		left join m_np on 1=1
    left join item_person p on t.项目编码 = p.项目编码
	)x