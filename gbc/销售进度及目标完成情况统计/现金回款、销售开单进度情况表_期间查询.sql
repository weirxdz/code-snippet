BEGIN
	BEGIN/*定义变量*/
    declare @sdate VARCHAR(100)
    declare @sdate_0 VARCHAR(100)
		declare @edate varchar(100)
		declare @edate_0 varchar(100)
    declare @syear int
    declare @smonth int
    declare @syear_0 int
    declare @smonth_0 int
    declare @eyear int
    declare @emonth int
    declare @eyear_0 int
    declare @emonth_0 int
	END
	BEGIN/*变量赋值计算*/
		
		set @sdate = '${查询日期起}'
		set @sdate_0 = CONVERT(varchar(100),dateadd(YY,-1,@sdate), 23)
		set @edate = '${查询日期至}'
		set @edate_0 = CONVERT(varchar(100),dateadd(YY,-1,@edate), 23)
    if month(@sdate) = 11 and day(@sdate) > 25 or month(@sdate) = 12 
      begin
        set @syear = year(@sdate) + 1
        set @smonth = 0
        set @syear_0 = year(@sdate) 
        set @smonth_0 = 0
      end
    else if day(@sdate) <= 25
      begin
        set @syear = year(@sdate) 
        set @smonth = month(@sdate)
        set @syear_0 = year(@sdate)-1 
        set @smonth_0 = month(@sdate)
      end
    else if day(@sdate) > 25
      begin
        set @syear = year(@sdate) 
        set @smonth = month(@sdate)+1
        set @syear_0 = year(@sdate) -1
        set @smonth_0 = month(@sdate)+1
      end
    if month(@edate) = 11 and day(@edate) > 25 or month(@edate) = 12 
      begin
        set @eyear = year(@edate) + 1
        set @emonth = 0
        set @eyear_0 = year(@edate) 
        set @emonth_0 = 0
      end
    else if day(@edate) <= 25
      begin
        set @eyear = year(@edate) 
        set @emonth = month(@edate)
        set @eyear_0 = year(@edate)-1 
        set @emonth_0 = month(@edate)
      end
    else if day(@edate) > 25
      begin
        set @eyear = year(@edate) 
        set @emonth = month(@edate)+1
        set @eyear_0 = year(@edate) -1
        set @emonth_0 = month(@edate)+1
      end
	END
	BEGIN/*查询*/
		with #销售开单 as (
			SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) = @edate THEN B.INATSUM ELSE 0 END) AS 当日销售开单,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.INATSUM ELSE 0 END) AS 当月销售开单,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.INATSUM ELSE 0 END) AS 同期销售开单
			FROM SALEBILLVOUCHS B
			LEFT JOIN SALEBILLVOUCH H ON B.SBVID = H.SBVID
			left join fr_dim_cust_dept cd on H.CCUSCODE = cd.CCUSCODE
			left join xshbmdy x on cd.cdepcode = x.bmbm
			WHERE left(B.CINVCODE,1)='5'
				AND H.CCUSCODE not in( '010124004'/*市场部（古）*/, '040000717'/*四川圆明园*/)
				and (CONVERT(varchar(100), H.DDATE, 23) >= @sdate_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0
					or CONVERT(varchar(100), H.DDATE, 23) >= @sdate AND CONVERT(varchar(100), H.DDATE, 23) <= @edate)
				AND h.cSBVCode <> '202303270002'-- 20230331 单独排除调账的一张现结发票
			GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
		),
		#现金收款_details as (
			SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) = @edate THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 当日现金收款,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 当月现金收款,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_0 AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate_0 THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 同期现金收款
			FROM AP_CLOSEBILLS AS B
			LEFT JOIN AP_CLOSEBILL AS H ON B.IID = H.IID
			left join fr_dim_cust_dept cd on B.CCUSVEN = cd.CCUSCODE
			left join xshbmdy x on cd.cdepcode = x.bmbm
			left join ar_detail ad on H.cVouchID = ad.cvouchid and ad.ccode is null AND isnull(ad.ibvid,0) <> 0
			LEFT JOIN SaleBillVouchs sbvb ON ad.ibvid = sbvb.autoid
			WHERE ISNULL(H.CDEFINE9,'') <> '押金' /*只取非押金类的记录*/
				AND LEFT(H.CSSCODE,1) IN (1,2)/*结算方式，只取现金结算和银行结算的*/
				-- AND (H.COPERATOR = '张超' AND h.cCancelNo is NULL or H.COPERATOR = '宋现涛' AND h.cCancelNo is NULL or h.cCancelNo is not NULL)-- 20230427 现金回款增加宋现涛
        AND (h.cCancelNo is NULL and H.COPERATOR in ('张超','宋现涛','李洪波','周志华') or h.cCancelNo is not NULL) -- 增加周志华做的收款单 20241202
				AND left(ISNULL(sbvb.cInvCode, '5'),1) = '5'/*如果关联发票，只取存货编码以5开头的记录*/
				AND B.CCUSVEN not in( '010124004'/*市场部（古）*/, '040000717'/*四川圆明园*/)
				and (CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_0 AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate_0
					or CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate)
				AND (h.vt_id = '8055' and h.cvouchtype = 49 or h.vt_id = '8052' and h.cvouchtype = 48)
				AND H.cVouchID <> '0000000744'
        AND isnull(H.cDefine2,'N') <> 'Y' -- 20230726 增加排除统计的收款单标识
			GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
      union ALL
      -- 20230427 增加指定为现金收款的凭证记录
      SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) = @edate THEN g.mc - g.md ELSE 0 END) AS 当日现金收款,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate THEN g.mc - g.md ELSE 0 END) AS 当月现金收款,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_0 AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate_0 THEN g.mc - g.md ELSE 0 END) AS 同期现金收款
      FROM gl_accvouch AS g
        left join fr_dim_cust_dept cd on g.ccus_id = cd.CCUSCODE
        left join xshbmdy x on cd.cdepcode = x.bmbm
      WHERE 1=1
        and g.ccus_id not in( '010124004'-- 市场部（古）-
                            , '040000717'-- 四川圆明园
                            )
        and (CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_0 AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate_0
          or CONVERT(varchar(100), g.dbill_date, 23) >= @sdate AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate)
        and g.iyear > '2022'
        -- and (
        --   -- 应收冲应付
        --   g.ccode_equal = '212101'	and g.ccode  = '1131'
        --   -- 应收并帐
        --   or 
        --   g.ccode_equal = '1131'and g.ccode  = '1131'
        --   )
        and g.cDefine1 = 'Y'
      GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
      union ALL
      -- 手工录入的收款信息 20230525
      select x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
        SUM(CASE WHEN CONVERT(varchar(100), t.ddate, 23) = @edate THEN t.nmny  ELSE 0 END) AS 当日现金收款,
        SUM(CASE WHEN CONVERT(varchar(100), t.ddate, 23) >= @sdate AND CONVERT(varchar(100), t.ddate, 23) <= @edate THEN t.nmny ELSE 0 END) AS 当月现金收款,
        SUM(CASE WHEN CONVERT(varchar(100), t.ddate, 23) >= @sdate_0 AND CONVERT(varchar(100), t.ddate, 23) <= @edate_0 THEN t.nmny ELSE 0 END) AS 同期现金收款
      from FR_CASH_SALESIN_ALTERLIST t 
        left join fr_dim_cust_dept cd on t.customercode = cd.CCUSCODE
        left join xshbmdy x on cd.cdepcode = x.bmbm
      WHERE 1=1
        and t.customercode not in( '010124004'-- 市场部（古）-
                            , '040000717'-- 四川圆明园
                            )
        and (CONVERT(varchar(100), t.ddate, 23) >= @sdate_0 AND CONVERT(varchar(100), t.ddate, 23) <= @edate_0
          or CONVERT(varchar(100), t.ddate, 23) >= @sdate AND CONVERT(varchar(100), t.ddate, 23) <= @edate)
      GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
    ),
    #现金收款 as (
      SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称,
			  sum(当日现金收款) as 当日现金收款,sum(当月现金收款) as 当月现金收款,sum(同期现金收款) as 同期现金收款
			FROM #现金收款_details
      group by 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称
    ),
		#销售回款_details as (
			SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 当月销售回款,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_0 AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate_0 THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 同期销售回款
			FROM AP_CLOSEBILLS AS B
			LEFT JOIN AP_CLOSEBILL AS H ON B.IID = H.IID
			left join fr_dim_cust_dept cd on B.CCUSVEN = cd.CCUSCODE
			left join xshbmdy x on cd.cdepcode = x.bmbm
			left join ar_detail ad on H.cVouchID = ad.cvouchid and ad.ccode is null AND isnull(ad.ibvid,0) <> 0
			LEFT JOIN SaleBillVouchs sbvb ON ad.ibvid = sbvb.autoid
			WHERE ISNULL(H.CDEFINE9,'') <> '押金' /*只取非押金类的记录*/
				-- AND LEFT(H.CSSCODE,1) IN (1,2)/*结算方式，只取现金结算和银行结算的*/
				-- AND H.COPERATOR = '张超'/*只取收款单制单人为张超的记录*/
				AND left(ISNULL(sbvb.cInvCode, '5'),1) = '5'/*如果关联发票，只取存货编码以5开头的记录*/
				AND B.CCUSVEN not in( '010124004'/*市场部（古）*/, '040000717'/*四川圆明园*/)
				and (CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_0 AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate_0
					or CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate)
				AND (h.vt_id = '8055' and h.cvouchtype = 49 or h.vt_id = '8052' and h.cvouchtype = 48)
				AND H.cVouchID <> '0000000744'
        AND isnull(H.cDefine2,'N') <> 'Y' -- 20230726 增加排除统计的收款单标识
			GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
      union ALL
      -- 20230427 增加指定为现金收款的凭证记录
      SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate THEN g.mc - g.md ELSE 0 END) AS 当月销售回款,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_0 AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate_0 THEN g.mc - g.md ELSE 0 END) AS 同期销售回款
      FROM gl_accvouch AS g
        left join fr_dim_cust_dept cd on g.ccus_id = cd.CCUSCODE
        left join xshbmdy x on cd.cdepcode = x.bmbm
      WHERE 1=1
        and g.ccus_id not in( '010124004'-- 市场部（古）-
                            , '040000717'-- 四川圆明园
                            )
        and (CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_0 AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate_0
          or CONVERT(varchar(100), g.dbill_date, 23) >= @sdate AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate)
        and g.iyear > '2022'
        -- and (
        --   -- 应收冲应付
        --   g.ccode_equal = '212101'	and g.ccode  = '1131'
        --   -- 应收并帐
        --   or 
        --   g.ccode_equal = '1131'and g.ccode  = '1131'
        --   )
        and g.cDefine1 = 'Y'
      GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
      union ALL
      -- 手工录入的收款信息 20230525
      select x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
        SUM(CASE WHEN CONVERT(varchar(100), t.ddate, 23) >= @sdate AND CONVERT(varchar(100), t.ddate, 23) <= @edate THEN t.nmny ELSE 0 END) AS 当月销售回款,
        SUM(CASE WHEN CONVERT(varchar(100), t.ddate, 23) >= @sdate_0 AND CONVERT(varchar(100), t.ddate, 23) <= @edate_0 THEN t.nmny ELSE 0 END) AS 同期销售回款
      from FR_CASH_SALESIN_ALTERLIST t 
        left join fr_dim_cust_dept cd on t.customercode = cd.CCUSCODE
        left join xshbmdy x on cd.cdepcode = x.bmbm
      WHERE 1=1
        and t.customercode not in( '010124004'-- 市场部（古）-
                            , '040000717'-- 四川圆明园
                            )
        and (CONVERT(varchar(100), t.ddate, 23) >= @sdate_0 AND CONVERT(varchar(100), t.ddate, 23) <= @edate_0
          or CONVERT(varchar(100), t.ddate, 23) >= @sdate AND CONVERT(varchar(100), t.ddate, 23) <= @edate)
      GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
		),
    #销售回款 as (
      SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称,
			  sum(当月销售回款) as 当月销售回款,sum(同期销售回款) as 同期销售回款
			FROM #销售回款_details
      group by 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称
    ),
		#目标 as(
			select x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
	      sum(case when st.年度 >= @syear and st.期间 >= @smonth and st.年度 <= @eyear and st.期间 <= @emonth then isnull(st.月度目标,0) else 0 end) as 当月目标,
				sum(case when st.年度 >= @syear_0 and st.期间 >= @smonth_0 and st.年度 <= @eyear_0 and st.期间 <= @emonth_0 then isnull(st.月度目标,0) else 0 end) as 同期目标
      from fr_Sales_cash_target as st
			left join fr_dim_cust_dept cd on st.客户名称 = isnull(cd.ccusname,'新客户')
			left join xshbmdy x on cd.cdepcode = x.bmbm
      where 1=1 and st.客户名称 <> '待开发'
      group by x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
      union ALL 
      select x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,st.客户编码  AS 维度客户编码,st.客户名称  AS 维度客户名称,
	      sum(case when st.年度 >= @syear and st.期间 >= @smonth and st.年度 <= @eyear and st.期间 <= @emonth then isnull(st.月度目标,0) else 0 end) as 当月目标,
				sum(case when st.年度 >= @syear_0 and st.期间 >= @smonth_0 and st.年度 <= @eyear_0 and st.期间 <= @emonth_0 then isnull(st.月度目标,0) else 0 end) as 同期目标
      from fr_Sales_cash_target as st  
      left join xshbmdy x on st.部门编码  = x.bmbm
      where st.客户名称 = '待开发'
      group by x.dqbm,x.xshdq,x.bmbm,x.xshbm,st.客户编码,st.客户名称),
		#dim as (
			SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称 FROM #销售开单
			union
			SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称 FROM #现金收款
			union
			SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称 FROM #销售回款
			union
			SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称 FROM #目标
		)

		SELECT #dim.大区编码,#dim.大区,#dim.维度部门编码,#dim.维度部门名称,#dim.维度客户编码,#dim.维度客户名称,
			#目标.当月目标,#目标.同期目标,
			#销售回款.当月销售回款,#销售回款.同期销售回款,
			#现金收款.当日现金收款,#现金收款.当月现金收款,#现金收款.同期现金收款,
			#销售开单.当日销售开单,#销售开单.当月销售开单,#销售开单.同期销售开单
		 	FROM #dim
			left join #销售开单 on ISNULL(#dim.大区编码,'未匹配') = ISNULL(#销售开单.大区编码,'未匹配') and ISNULL(#dim.维度部门编码,'未匹配') = ISNULL(#销售开单.维度部门编码,'未匹配') and ISNULL(#dim.维度客户编码,'未匹配') = ISNULL(#销售开单.维度客户编码,'未匹配')
			left join #现金收款 on ISNULL(#dim.大区编码,'未匹配') = ISNULL(#现金收款.大区编码,'未匹配') and ISNULL(#dim.维度部门编码,'未匹配') = ISNULL(#现金收款.维度部门编码,'未匹配') and ISNULL(#dim.维度客户编码,'未匹配') = ISNULL(#现金收款.维度客户编码,'未匹配')
			left join #销售回款 on ISNULL(#dim.大区编码,'未匹配') = ISNULL(#销售回款.大区编码,'未匹配') and ISNULL(#dim.维度部门编码,'未匹配') = ISNULL(#销售回款.维度部门编码,'未匹配') and ISNULL(#dim.维度客户编码,'未匹配') = ISNULL(#销售回款.维度客户编码,'未匹配')
			left join #目标 on ISNULL(#dim.大区编码,'未匹配') = ISNULL(#目标.大区编码,'未匹配') and ISNULL(#dim.维度部门编码,'未匹配') = ISNULL(#目标.维度部门编码,'未匹配') and ISNULL(#dim.维度客户编码,'未匹配') = ISNULL(#目标.维度客户编码,'未匹配')
			WHERE 1=1
				and (
					('2' in (select  级别 from fr_user where user_code='${fine_username}') and #dim.大区 in (select 二级机构 from fr_user where user_code='${fine_username}'))
					or (#dim.大区 in (select 二级机构 from fr_user where user_code='${fine_username}') and '3' in (select  级别 from fr_user where user_code='${fine_username}') )
					or((select distinct 级别 from fr_user where user_code='${fine_username}') ='1' and 1=1) )
			order by isnull(#dim.大区编码,999) ,#dim.大区,#dim.维度部门编码,#dim.维度部门名称,#dim.维度客户编码,#dim.维度客户名称
	END

END
