BEGIN
	BEGIN/*定义变量*/
    declare @sdate VARCHAR(100)
		declare @iyear int
		declare @iperiod int
		declare @iday int
		declare @sdate_y VARCHAR(100)
		declare @sdate_m VARCHAR(100)
		declare @sdate_y_0 VARCHAR(100)
		declare @sdate_m_0 VARCHAR(100)
		declare @edate varchar(100)
		declare @edate_0 varchar(100)
	END
	BEGIN/*变量赋值计算*/
		set @sdate = '${查询日期}'
		set @iyear = YEAR(@sdate)
		set @iperiod = month(@sdate)
		set @iday = DAY(@sdate)
		if @iperiod = 11  and @iday >25
			begin
				set @sdate_m= CONVERT(varchar(100),DATEADD(day,26 - DAY(@SDATE),@SDATE), 23)
				set @sdate_y= CONVERT(varchar(100),DATEADD(day,26 - DAY(@SDATE),@SDATE), 23)
				set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,DATEADD(day,26 - DAY(@SDATE),@SDATE)), 23)
				set @sdate_y_0= CONVERT(varchar(100),DATEADD(yy,-1,DATEADD(day,26 - DAY(@SDATE),@SDATE)), 23)
				SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
				SET @EDATE = @SDATE
			end
		else if @iperiod = 12
			begin
				set @sdate_m= CONVERT(varchar(100),dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE)), 23)
				set @sdate_y= CONVERT(varchar(100),dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE)), 23)
				set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE))), 23)
				set @sdate_y_0= CONVERT(varchar(100),DATEADD(yy,-1,dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE))), 23)
				SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
				SET @EDATE = @SDATE
			end
		else if @iperiod = 1 and @iday <= 25
			begin
				set @sdate_m= CONVERT(varchar(100),DATEADD(day,1 - DAY(@SDATE),@SDATE), 23)
				set @sdate_y= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-1)+'-11-26'), 23)
				set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,DATEADD(day,1 - DAY(@SDATE),@SDATE)), 23)
				set @sdate_y_0= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-2)+'-11-26'), 23)
				SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
				SET @EDATE = @SDATE
			end
		else if @iperiod >= 1 and @iperiod <= 11
			begin
				if @iday <= 25 and @iperiod <> 1
					begin
						set @sdate_m= CONVERT(varchar(100),dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE)), 23)
						set @sdate_y= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-1)+'-11-26'), 23)
						set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE))), 23)
						set @sdate_y_0= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-2)+'-11-26'), 23)
						SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
						SET @EDATE = @SDATE
					end
				else if @iday >25 and @iperiod <> 11
					begin
						set @sdate_m= CONVERT(varchar(100),DATEADD(day,26 - DAY(@SDATE),@SDATE), 23)
						set @sdate_y= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-1)+'-11-26'), 23)
						set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,DATEADD(day,26 - DAY(@SDATE),@SDATE)), 23)
						set @sdate_y_0= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-2)+'-11-26'), 23)
						SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
						SET @EDATE = @SDATE
					end
			end
	END
	BEGIN
		with #销售开单 as (
			SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.INATSUM ELSE 0 END)  AS 当月客户开单,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.INATSUM ELSE 0 END)  AS 当年客户开单,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.INATSUM ELSE 0 END)  AS 同期客户开单,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.INATSUM ELSE 0 END)  AS 去年客户开单,

				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DDATE, 23) <= @edate AND H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  as 当月客户折半费用,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate AND H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  as 当年客户折半费用,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 AND H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  as 同期客户折半费用,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 AND H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  as 去年客户折半费用,

				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN ISNULL(Y.溢价费用,0) else 0 end) as 当月客户产品溢价,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN ISNULL(Y.溢价费用,0) else 0 end) as 当年客户产品溢价,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN ISNULL(Y.溢价费用,0) else 0 end) as 同期客户产品溢价,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN ISNULL(Y.溢价费用,0) else 0 end) as 去年客户产品溢价,

				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.INATSUM - (CASE WHEN H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  ELSE 0 END) as 当月客户收入,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.INATSUM - (CASE WHEN H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  ELSE 0 END) as 当年客户收入,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.INATSUM - (CASE WHEN H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  ELSE 0 END) as 同期客户收入,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.INATSUM - (CASE WHEN H.cSTCode IN('02','03') AND b.iTaxUnitPrice >= 78 THEN 0.5*(B.INATSUM - ISNULL(Y.溢价费用,0)) ELSE 0.00 END)  ELSE 0 END) as 去年客户收入
				FROM SALEBILLVOUCHS B
				LEFT JOIN SALEBILLVOUCH H ON B.SBVID = H.SBVID
				left join fr_dim_cust_dept cd on H.CCUSCODE = cd.CCUSCODE
				left join xshbmdy x on cd.cdepcode = x.bmbm
				LEFT JOIN INVENTORY M ON B.CINVCODE = M.CINVCODE
				LEFT JOIN (
					SELECT h.ddate,h.CDEPCODE,h.CCUSCODE,M.CINVNAME,sum(B.INATSUM) as 溢价费用
					FROM SALEBILLVOUCHS B
					LEFT JOIN SALEBILLVOUCH H ON B.SBVID = H.SBVID
					LEFT JOIN INVENTORY M ON B.CINVCODE = M.CINVCODE
					LEFT JOIN CUSTOMER CUST ON H.CCUSCODE = CUST.CCUSCODE
					where LEFT(B.CINVCODE,2) in('84','86') AND m.cInvCode <> '84110001'
						AND (CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 or CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate) AND(H.CCUSCODE not in( '010124004'/*市场部（古）*/, '040000717'/*四川圆明园*/) or CUST.CCUSCODE is null)
						and 1=1
					group by h.ddate,h.CDEPCODE,h.CCUSCODE,M.CINVNAME
				) Y ON m.CINVNAME = Y.CINVNAME AND H.DDATE = Y.DDATE AND h.CDEPCODE = Y.CDEPCODE AND h.CCUSCODE = Y.CCUSCODE
				where (CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0
							or CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate)
						AND H.CCUSCODE not in( '010124004'-- 市场部（古）
																	, '040000717'-- 四川圆明园
																	)
						AND LEFT(B.CINVCODE,1) = '5'
				group by x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
		),
		#客户收入 as (
			select t.大区编码,t.维度部门编码,t.维度客户编码,
					t.当月客户收入 as 当月客户收入,t.当年客户收入 as 当年客户收入,t.同期客户收入 as 同期客户收入,t.去年客户收入 as 去年客户收入
				FROM #销售开单 as t
		),
		#部门收入 as (
			select t.大区编码,t.维度部门编码,
					sum(t.当月客户收入) as 当月部门收入,sum(t.当年客户收入) as 当年部门收入,sum(t.同期客户收入) as 同期部门收入,sum(t.去年客户收入) as 去年部门收入
				FROM #销售开单 as t
				group by t.大区编码,t.维度部门编码
		),
		#大区收入 as (
			select t.大区编码,
					sum(t.当月客户收入) as 当月大区收入,sum(t.当年客户收入) as 当年大区收入,sum(t.同期客户收入) as 同期大区收入,sum(t.去年客户收入) as 去年大区收入
				FROM #销售开单 as t
				group by t.大区编码
		),
		#总收入 as (
			select sum(t.当月客户收入) as 当月总收入,sum(t.当年客户收入) as 当年总收入,sum(t.同期客户收入) as 同期总收入,sum(t.去年客户收入) as 去年总收入
				FROM #销售开单 as t
		),
		
		#销售费用 as(
			SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
				sum(case when CONVERT(varchar(100), T.DBILL_DATE, 23) >= @sdate_m AND CONVERT(varchar(100), T.DBILL_DATE, 23) <= @edate THEN T.MD - T.MC ELSE 0 END) AS 当月客户费用,
				sum(case when CONVERT(varchar(100), T.DBILL_DATE, 23) >= @sdate_y AND CONVERT(varchar(100), T.DBILL_DATE, 23) <= @edate THEN T.MD - T.MC ELSE 0 END) AS 当年客户费用,
				sum(case when CONVERT(varchar(100), T.DBILL_DATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), T.DBILL_DATE, 23) <= @edate_0 THEN T.MD - T.MC ELSE 0 END) AS 同期客户费用,
				sum(case when CONVERT(varchar(100), T.DBILL_DATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), T.DBILL_DATE, 23) <= @edate_0 THEN T.MD - T.MC ELSE 0 END) AS 去年客户费用
				FROM GL_ACCVOUCH T
				LEFT JOIN CODE C ON  T.CCODE = C.CCODE AND T.IYEAR = C.IYEAR
				left join fr_dim_cust_dept as cd on T.CCUS_ID = cd.ccuscode--凭证客户在维度表内
				left join xshbmdy x on ISNULL(cd.cdepcode,T.CDEPT_ID) = x.bmbm
				WHERE LEFT(C.CCODE,4) = '5501'
					AND T.CDIGEST <> '期间损益结转'
					AND ((CONVERT(varchar(100), T.DBILL_DATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), T.DBILL_DATE, 23) <= @edate_0) OR (CONVERT(varchar(100), T.DBILL_DATE, 23) >= @sdate_y AND CONVERT(varchar(100), T.DBILL_DATE, 23) <= @edate))
					AND T.IPERIOD >= 1 AND T.IPERIOD <= 12
					-- 20231019 排除两个客户，需要考虑客户为空的情况
					AND (t.CCUS_ID not in( '010124004'-- 市场部（古）
															, '040000717' -- 四川圆明园
															) 
							or t.CCUS_ID is null)
				group by x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
		),
		#客户销售费用 as (
			SELECT t.大区编码,t.维度部门编码,t.维度客户编码,
				t.当月客户费用 AS 当月客户费用,				t.当年客户费用 AS 当年客户费用,				t.同期客户费用 AS 同期客户费用,				t.去年客户费用 AS 去年客户费用
				FROM #销售费用 as t
		),
		#部门销售费用 as (
			SELECT t.大区编码,t.维度部门编码,
				SUM(CASE WHEN ISNULL(bmsr.当月部门收入,0) <> 0 THEN t.当月客户费用 ELSE 0 END) AS 当月部门费用,
				SUM(CASE WHEN ISNULL(bmsr.当年部门收入,0) <> 0 THEN t.当年客户费用 ELSE 0 END) AS 当年部门费用,
				SUM(CASE WHEN ISNULL(bmsr.同期部门收入,0) <> 0 THEN t.同期客户费用 ELSE 0 END) AS 同期部门费用,
				SUM(CASE WHEN ISNULL(bmsr.去年部门收入,0) <> 0 THEN t.去年客户费用 ELSE 0 END) AS 去年部门费用
				FROM #销售费用 as t
				LEFT JOIN #部门收入 as bmsr on t.维度部门编码 = bmsr.维度部门编码
				LEFT JOIN #大区收入 as dqsr on t.大区编码 = dqsr.大区编码
				WHERE ISNULL(t.维度客户编码,0) = 0 AND ISNULL(t.维度部门编码,0) <> 0
				GROUP by t.大区编码,t.维度部门编码
		),
		#大区销售费用 as (
			SELECT t.大区编码,
				SUM(CASE WHEN ISNULL(bmsr.当月部门收入,0) = 0 AND ISNULL(dqsr.当月大区收入,0) <> 0 THEN t.当月客户费用 ELSE 0 END) AS 当月大区费用,
				SUM(CASE WHEN ISNULL(bmsr.当年部门收入,0) = 0 AND ISNULL(dqsr.当年大区收入,0) <> 0 THEN t.当年客户费用 ELSE 0 END) AS 当年大区费用,
				SUM(CASE WHEN ISNULL(bmsr.同期部门收入,0) = 0 AND ISNULL(dqsr.同期大区收入,0) <> 0 THEN t.同期客户费用 ELSE 0 END) AS 同期大区费用,
				SUM(CASE WHEN ISNULL(bmsr.去年部门收入,0) = 0 AND ISNULL(dqsr.去年大区收入,0) <> 0 THEN t.去年客户费用 ELSE 0 END) AS 去年大区费用
				FROM #销售费用 as t
				LEFT JOIN #部门收入 as bmsr on t.维度部门编码 = bmsr.维度部门编码
				LEFT JOIN #大区收入 as dqsr on t.大区编码 = dqsr.大区编码
				WHERE ISNULL(t.维度客户编码,0) = 0 AND ISNULL(t.维度部门编码,0) <> 0
				group by t.大区编码
		),
		#公共销售费用 as (
			SELECT
				SUM(CASE WHEN ISNULL(当月部门收入,0) = 0 AND ISNULL(当月大区收入,0) = 0 or t.维度部门编码 is NULL THEN t.当月客户费用 ELSE 0 END) AS 当月公共费用,
				SUM(CASE WHEN ISNULL(当年部门收入,0) = 0 AND ISNULL(当年大区收入,0) = 0 or t.维度部门编码 is NULL  THEN t.当年客户费用 ELSE 0 END) AS 当年公共费用,
				SUM(CASE WHEN ISNULL(同期部门收入,0) = 0 AND ISNULL(同期大区收入,0) = 0 or t.维度部门编码 is NULL  THEN t.同期客户费用 ELSE 0 END) AS 同期公共费用,
				SUM(CASE WHEN ISNULL(去年部门收入,0) = 0 AND ISNULL(去年大区收入,0) = 0 or t.维度部门编码 is NULL  THEN t.去年客户费用 ELSE 0 END) AS 去年公共费用
				FROM #销售费用 as t
				LEFT JOIN #部门收入 as bmsr on t.维度部门编码 = bmsr.维度部门编码
				LEFT JOIN #大区收入 as dqsr on t.大区编码 = dqsr.大区编码
				WHERE ISNULL(t.维度客户编码,0) = 0
		),
		#现金回款_details as (
			SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
				  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 当月现金回款,
				  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 当年现金回款,
				  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate_0 THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 同期现金回款,
				  SUM(CASE WHEN CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate_0 THEN (CASE WHEN sbvb.iNatSum is NULL THEN B.IAMT ELSE ad.icamount END) ELSE 0 END) AS 去年现金回款
				FROM AP_CLOSEBILLS AS B
				LEFT JOIN AP_CLOSEBILL AS H ON B.IID = H.IID
				left join fr_dim_cust_dept cd on B.CCUSVEN = cd.CCUSCODE
				left join xshbmdy x on cd.cdepcode = x.bmbm
				left join ar_detail ad on H.cVouchID = ad.cvouchid and ad.ccode is null AND isnull(ad.ibvid,0) <> 0
				LEFT JOIN SaleBillVouchs sbvb ON ad.ibvid = sbvb.autoid
				WHERE ISNULL(H.CDEFINE9,'') <> '押金' /*只取非押金类的记录*/
					AND LEFT(H.CSSCODE,1) IN (1,2)/*结算方式,只取现金结算和银行结算的*/
					-- AND (H.COPERATOR = '张超' AND h.cCancelNo is NULL or H.COPERATOR = '宋现涛' AND h.cCancelNo is NULL or h.cCancelNo is not NULL)-- 20230427 现金回款增加宋现涛
					AND (h.cCancelNo is NULL and H.COPERATOR in ('张超','宋现涛','李洪波','周志华') or h.cCancelNo is not NULL) -- 增加周志华做的收款单 20241202
					AND left(ISNULL(sbvb.cInvCode, '5'),1) = '5'/*如果关联发票,只取存货编码以5开头的记录*/
					AND B.CCUSVEN not in( '010124004'/*市场部（古）*/, '040000717'/*四川圆明园*/)
					and (CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate_0
						or CONVERT(varchar(100), H.DVOUCHDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DVOUCHDATE, 23) <= @edate)
					AND (h.vt_id = '8055' and h.cvouchtype = 49 or h.vt_id = '8052' and h.cvouchtype = 48)
				  AND H.cVouchID <> '0000000744'
				GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
      union ALL
      -- 20230427 增加指定为现金收款的凭证记录
      SELECT x.dqbm as 大区编码,x.xshdq as 大区,x.bmbm AS 维度部门编码,x.xshbm AS 维度部门名称,cd.CCUSCODE AS 维度客户编码,cd.CCUSNAME AS 维度客户名称,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_m AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate THEN g.mc - g.md ELSE 0 END) AS 当月现金回款,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_y AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate THEN g.mc - g.md ELSE 0 END) AS 当年现金回款,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_m_0 AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate_0 THEN g.mc - g.md ELSE 0 END) AS 同期现金回款,
        SUM(CASE WHEN CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_y_0 AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate_0 THEN g.mc - g.md ELSE 0 END ) AS 去年现金回款
      FROM gl_accvouch AS g
        left join fr_dim_cust_dept cd on g.ccus_id = cd.CCUSCODE
        left join xshbmdy x on cd.cdepcode = x.bmbm
      WHERE 1=1
        -- 20231019 排除两个客户，需要考虑客户为空的情况
				AND (g.CCUS_ID not in( '010124004'-- 市场部（古）
														, '040000717' -- 四川圆明园
														) 
						or g.CCUS_ID is null)
        and (CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_y_0 AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate_0
          or CONVERT(varchar(100), g.dbill_date, 23) >= @sdate_y AND CONVERT(varchar(100), g.dbill_date, 23) <= @edate)
        and g.iyear > '2022'
        and (
          -- 应收冲应付
          g.ccode_equal = '212101'	and g.ccode  = '1131'
          -- 应收并帐
          or 
          g.ccode_equal = '1131'and g.ccode  = '1131'
          )
        and g.cDefine1 = 'Y'
      GROUP BY x.dqbm,x.xshdq,x.bmbm,x.xshbm,cd.CCUSCODE,cd.CCUSNAME
		),
    #现金回款 as (
      SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称,
			  sum(当月现金回款) as 当月现金回款,sum(当年现金回款) as 当年现金回款,sum(同期现金回款) as 同期现金回款,sum(去年现金回款) as 去年现金回款
			FROM #现金回款_details
      group by 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称
    ),
		#DIM as (
			SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称 FROM #销售费用
				union
				SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称 FROM #销售开单
				union
				SELECT 大区编码,大区,维度部门编码,维度部门名称,维度客户编码,维度客户名称 FROM #现金回款
		)
		SELECT t.大区编码,t.大区,t.维度部门编码,t.维度部门名称,t.维度客户编码,t.维度客户名称,
			isnull(khfy.当月客户费用,0)
				+	case when isnull(bmfy.当月部门费用,0) <> 0 AND isnull(bmsr.当月部门收入,0) <> 0 then bmfy.当月部门费用*isnull(kd.当月客户收入,0)/bmsr.当月部门收入 else 0 end
				+ case when isnull(dqfy.当月大区费用,0) <> 0 and isnull(dqsr.当月大区收入,0) <> 0 then dqfy.当月大区费用*isnull(kd.当月客户收入,0)/dqsr.当月大区收入 else 0 END
				+ case when isnull(ggfy.当月公共费用,0) <> 0 then ggfy.当月公共费用*isnull(kd.当月客户收入,0)/zsr.当月总收入 else 0 end as 当月费用,
			isnull(khfy.同期客户费用,0)
				+	case when isnull(bmfy.同期部门费用,0) <> 0 AND isnull(bmsr.同期部门收入,0) <> 0 then bmfy.同期部门费用*isnull(kd.同期客户收入,0)/bmsr.同期部门收入 else 0 end
				+ case when isnull(dqfy.同期大区费用,0) <> 0 and isnull(dqsr.同期大区收入,0) <> 0 then dqfy.同期大区费用*isnull(kd.同期客户收入,0)/dqsr.同期大区收入 else 0 END
				+ case when isnull(ggfy.同期公共费用,0) <> 0 then ggfy.同期公共费用*isnull(kd.同期客户收入,0)/zsr.同期总收入 else 0 end as 同期费用,
			isnull(khfy.当年客户费用,0)
				+	case when isnull(bmfy.当年部门费用,0) <> 0 AND isnull(bmsr.当年部门收入,0) <> 0 then bmfy.当年部门费用*isnull(kd.当年客户收入,0)/bmsr.当年部门收入 else 0 end
				+ case when isnull(dqfy.当年大区费用,0) <> 0 and isnull(dqsr.当年大区收入,0) <> 0 then dqfy.当年大区费用*isnull(kd.当年客户收入,0)/dqsr.当年大区收入 else 0 END
				+ case when isnull(ggfy.当年公共费用,0) <> 0 then ggfy.当年公共费用*isnull(kd.当年客户收入,0)/zsr.当年总收入 else 0 end as 当年费用,
			isnull(khfy.去年客户费用,0)
				+	case when isnull(bmfy.去年部门费用,0) <> 0 AND isnull(bmsr.去年部门收入,0) <> 0 then bmfy.去年部门费用*isnull(kd.去年客户收入,0)/bmsr.去年部门收入 else 0 end
				+ case when isnull(dqfy.去年大区费用,0) <> 0 and isnull(dqsr.去年大区收入,0) <> 0 then dqfy.去年大区费用*isnull(kd.去年客户收入,0)/dqsr.去年大区收入 else 0 END
				+ case when isnull(ggfy.去年公共费用,0) <> 0 then ggfy.去年公共费用*isnull(kd.去年客户收入,0)/zsr.去年总收入 else 0 end as 去年费用,
			khfy.当月客户费用,khfy.同期客户费用,khfy.当年客户费用,khfy.去年客户费用,
			bmfy.当月部门费用,bmfy.同期部门费用,bmfy.当年部门费用,bmfy.去年部门费用,
			dqfy.当月大区费用,dqfy.同期大区费用,dqfy.当年大区费用,dqfy.去年大区费用,
			ggfy.当月公共费用,ggfy.同期公共费用,ggfy.当年公共费用,ggfy.去年公共费用,
			kd.当月客户开单,kd.同期客户开单,kd.当年客户开单,kd.去年客户开单,
			kd.当月客户折半费用,kd.同期客户折半费用,kd.当年客户折半费用,kd.去年客户折半费用,
			kd.当月客户产品溢价,kd.同期客户产品溢价,kd.当年客户产品溢价,kd.去年客户产品溢价,
			kd.当月客户收入,kd.同期客户收入,kd.当年客户收入,kd.去年客户收入,
			bmsr.当月部门收入,bmsr.同期部门收入,bmsr.当年部门收入,bmsr.去年部门收入,
			dqsr.当月大区收入,dqsr.同期大区收入,dqsr.当年大区收入,dqsr.去年大区收入,
			zsr.当月总收入,zsr.同期总收入,zsr.当年总收入,zsr.去年总收入,
			xj.当月现金回款,xj.同期现金回款,xj.当年现金回款,xj.去年现金回款
		FROM #DIM as t
		LEFT JOIN #客户销售费用 as khfy on t.大区编码 = khfy.大区编码 AND t.维度部门编码 = khfy.维度部门编码 AND t.维度客户编码 =  khfy.维度客户编码
		LEFT JOIN #部门销售费用 as bmfy on t.大区编码 = bmfy.大区编码 AND t.维度部门编码 = bmfy.维度部门编码
		LEFT JOIN #大区销售费用 as dqfy on t.大区编码 = dqfy.大区编码
		LEFT JOIN #公共销售费用 as ggfy on 1 = 1
		LEFT JOIN #销售开单 as kd on t.大区编码 = kd.大区编码 AND t.维度部门编码 = kd.维度部门编码 AND t.维度客户编码 =  kd.维度客户编码
		LEFT JOIN #部门收入 as bmsr on t.大区编码 = bmsr.大区编码 AND t.维度部门编码 = bmsr.维度部门编码
		LEFT JOIN #大区收入 as dqsr on t.大区编码 = dqsr.大区编码
		LEFT JOIN #总收入 as zsr on 1 = 1
		LEFT JOIN #现金回款 as xj on t.大区编码 = xj.大区编码 AND t.维度部门编码 = xj.维度部门编码 AND t.维度客户编码 =  xj.维度客户编码
		WHERE ISNULL(khfy.当年客户费用,0) <> 0 or ISNULL(khfy.去年客户费用,0) <> 0 or ISNULL(kd.当年客户开单,0) <> 0 or ISNULL(kd.去年客户开单,0) <> 0
			or ISNULL(xj.当年现金回款,0) <> 0 or ISNULL(xj.去年现金回款,0) <> 0
		order by t.大区编码,t.维度部门编码,t.维度客户编码
	END
END
