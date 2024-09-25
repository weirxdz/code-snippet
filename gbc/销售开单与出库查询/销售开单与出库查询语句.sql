-- 查询语句
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
    declare @syear int
    declare @smonth int
    declare @syear_0 int
    declare @smonth_0 int
	END
	BEGIN/*变量赋值计算*/
  	set @sdate = '${查询日期}'
		--set @sdate = '2024-09-20'
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
				set @syear= @iyear + 1
				set @smonth = 0
        set @syear_0= @iyear
				set @smonth_0 = 0
			end
		else if @iperiod = 12
			begin
				set @sdate_m= CONVERT(varchar(100),dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE)), 23)
				set @sdate_y= CONVERT(varchar(100),dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE)), 23)
				set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE))), 23)
				set @sdate_y_0= CONVERT(varchar(100),DATEADD(yy,-1,dateadd(dd,-day(dateadd(month,-1,@SDATE))+26,dateadd(month,-1,@SDATE))), 23)
				SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
				SET @EDATE = @SDATE
        set @syear= @iyear + 1
        set @smonth = 0
        set @syear_0= @iyear
        set @smonth_0 = 0
			end
		else if @iperiod = 1 and @iday <= 25
			begin
				set @sdate_m= CONVERT(varchar(100),DATEADD(day,1 - DAY(@SDATE),@SDATE), 23)
				set @sdate_y= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-1)+'-11-26'), 23)
				set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,DATEADD(day,1 - DAY(@SDATE),@SDATE)), 23)
				set @sdate_y_0= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-2)+'-11-26'), 23)
				SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
				SET @EDATE = @SDATE
        set @syear= @iyear
        set @smonth = @iperiod
        set @syear_0= @iyear - 1
        set @smonth_0 = @iperiod
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
            set @syear= @iyear
            set @smonth = @iperiod
            set @syear_0= @iyear - 1
            set @smonth_0 = @iperiod
					end
				else if @iday >25 and @iperiod <> 11
					begin
						set @sdate_m= CONVERT(varchar(100),DATEADD(day,26 - DAY(@SDATE),@SDATE), 23)
						set @sdate_y= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-1)+'-11-26'), 23)
						set @sdate_m_0= CONVERT(varchar(100),DATEADD(yy,-1,DATEADD(day,26 - DAY(@SDATE),@SDATE)), 23)
						set @sdate_y_0= CONVERT(varchar(100),CONVERT(date,convert(nvarchar(4),@iyear-2)+'-11-26'), 23)
						SET @EDATE_0 = CONVERT(varchar(100),dateadd(YY,-1,@SDATE), 23)
						SET @EDATE = @SDATE
            set @syear= @iyear
            set @smonth = @iperiod + 1
            set @syear_0= @iyear - 1
            set @smonth_0 = @iperiod + 1
					end
			end
	END
	BEGIN/*查询*/
		with #销售开单 as (
			SELECT i.CINVCODE 产品编码,i.CINVname 产品名称,i.cinvstd 规格型号,m.一级系列,m.二级系列,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) = @edate THEN B.iQuantity  ELSE 0 END) AS 当日销售开单,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.iQuantity  ELSE 0 END) AS 当月销售开单,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.iQuantity  ELSE 0 END) AS 当年销售开单,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.iQuantity  ELSE 0 END) AS 同期销售开单,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.iQuantity  ELSE 0 END) AS 去年销售开单
        FROM SALEBILLVOUCHS B
        LEFT JOIN SALEBILLVOUCH H ON B.SBVID = H.SBVID
        LEFT JOIN inventory i ON b.CINVCODE = i.CINVCODE
        LEFT JOIN bi对照表 m ON i.CINVCODE = m.产品编码
        WHERE left(B.CINVCODE,1)='5'
          AND H.CCUSCODE not in( '010124004'/*市场部（古）*/, '040000717'/*四川圆明园*/)
          and (CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0
            or CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate)
          AND h.cSBVCode <> '202303270002'-- 20230331 单独排除调账的一张现结发票         
          ${if(len(一级系列) == 0," "," and m.一级编码 in ('" + 一级系列 + "')")} ${if(len(二级系列) == 0," "," and m.二级编码 in ('" + 二级系列 + "')")}  ${if(len(产品编码) == 0," "," and m.产品编码 in ('" + 产品编码 + "')")}
        GROUP BY i.CINVCODE ,i.CINVname ,i.cinvstd ,m.一级系列,m.二级系列
		),
		#销售出库 as (
			SELECT i.CINVCODE 产品编码,i.CINVname 产品名称,i.cinvstd 规格型号,m.一级系列,m.二级系列,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) = @edate THEN B.iQuantity  ELSE 0 END) AS 当日销售出库,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.iQuantity  ELSE 0 END) AS 当月销售出库,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.iQuantity  ELSE 0 END) AS 当年销售出库,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.iQuantity  ELSE 0 END) AS 同期销售出库,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.iQuantity  ELSE 0 END) AS 去年销售出库
        FROM rdrecords32 B
        LEFT JOIN rdrecord32 H ON B.id = H.id
        LEFT JOIN inventory i ON b.CINVCODE = i.CINVCODE
        LEFT JOIN bi对照表 m ON i.CINVCODE = m.产品编码
        WHERE left(B.CINVCODE,1)='5'
          AND H.CCUSCODE not in( '010124004'/*市场部（古）*/, '040000717'/*四川圆明园*/)
          and (CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0
            or CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate)          
          ${if(len(一级系列) == 0," "," and m.一级编码 in ('" + 一级系列 + "')")} ${if(len(二级系列) == 0," "," and m.二级编码 in ('" + 二级系列 + "')")}  ${if(len(产品编码) == 0," "," and m.产品编码 in ('" + 产品编码 + "')")}
        GROUP BY i.CINVCODE ,i.CINVname ,i.cinvstd ,m.一级系列,m.二级系列
    ),
    #dim AS (
      SELECT 产品编码,产品名称,规格型号,一级系列,二级系列 FROM #销售开单
      UNION 
      SELECT 产品编码,产品名称,规格型号,一级系列,二级系列 FROM #销售出库
    )

		SELECT d.产品编码,d.产品名称,d.规格型号,d.一级系列,d.二级系列 ,s.当日销售开单, s.当月销售开单, s.当年销售开单, s.同期销售开单, s.去年销售开单,t.当日销售出库, t.当月销售出库, t.当年销售出库, t.同期销售出库, t.去年销售出库
    from #dim d
    LEFT JOIN #销售开单 s ON d.产品编码 = s.产品编码
    LEFT JOIN #销售出库 t ON d.产品编码 = t.产品编码
	END
end