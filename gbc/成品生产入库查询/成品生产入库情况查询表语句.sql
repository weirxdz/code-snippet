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
		SELECT i.CINVCODE 产品编码,i.CINVname 产品名称,i.cinvstd 规格型号,m.一级系列,m.二级系列,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) = @edate THEN B.iQuantity  ELSE 0 END) AS 当日生产入库,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.iQuantity  ELSE 0 END) AS 当月生产入库,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate THEN B.iQuantity  ELSE 0 END) AS 当年生产入库,
			  SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_m_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.iQuantity  ELSE 0 END) AS 同期生产入库,
				SUM(CASE WHEN CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0 THEN B.iQuantity  ELSE 0 END) AS 去年生产入库
        FROM rdrecords10  B
        LEFT JOIN rdrecord10  H ON B.id = H.id
        LEFT JOIN inventory i ON b.CINVCODE = i.CINVCODE
        LEFT JOIN bi对照表 m ON i.CINVCODE = m.产品编码
        WHERE left(B.CINVCODE,1)='5'
          and (CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y_0 AND CONVERT(varchar(100), H.DDATE, 23) <= @edate_0
            or CONVERT(varchar(100), H.DDATE, 23) >= @sdate_y AND CONVERT(varchar(100), H.DDATE, 23) <= @edate)          
          ${if(len(一级系列) == 0," "," and m.一级编码 in ('" + 一级系列 + "')")} ${if(len(二级系列) == 0," "," and m.二级编码 in ('" + 二级系列 + "')")}  ${if(len(产品编码) == 0," "," and m.产品编码 in ('" + 产品编码 + "')")}
        GROUP BY i.CINVCODE ,i.CINVname ,i.cinvstd ,m.一级系列,m.二级系列
	END
end