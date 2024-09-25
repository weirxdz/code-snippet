-- 数字化车间 出酒率、取优率 计算
with #A as (
	-- 取产成品入库单数据，计算查询期间内，生产日期、车间、班组、班次、酒坛号、入库数量
		-- 产成品入库单表体自定义项（cdefine23）是酒坛号，计算每个坛子的入库量
	-- 关联生产计划表，生产计划表记录了每个班次的窖池号，默认按每个窖池一吨计算
		-- 产成品入库单表体的 IMOSEQ 与 bzjh1 的班组号对应，产成品入库单表头自定义项（cdefine4，生产日期）与 bzjh1 的出入库时间 对应
		-- bzjh1 与 bzjh2 的 出入池时间 、 bzjh1 与 bzjh2 的 班次 字段对应，同时限制 bzjh2 的 入池窖池号飞空 且 bzjh2 的 是否回糟  不等于 '是'
	SELECT RDS10.autoid ,RD10.cdefine4 AS 生产日期,RD10.DDATE AS 入库日期,bzjh2.[入池窖池号],RDS10.cdefine23 as 原始坛子号,RDS10.CINVCODE,RDS10.IQUANTITY as 数量,
		CASE when len(RDS10.cdefine23) >3 THEN left(RDS10.cdefine23,3) ELSE '' END 第一个坛子号,
		CASE when len(RDS10.cdefine23) >3 and isnull(CHARINDEX('；',RDS10.cdefine23),0) <> 0 THEN substring(RDS10.cdefine23,(isnull(CHARINDEX('/',RDS10.cdefine23),0)+1),isnull(CHARINDEX('；',RDS10.cdefine23),0)-isnull(CHARINDEX('/',RDS10.cdefine23),0)-1)  when len(RDS10.cdefine23) >3 and isnull(CHARINDEX('；',RDS10.cdefine23),0) = 0 then RDS10.IQUANTITY/2 ELSE 0 END 第一个坛子入库量,
		CASE when len(RDS10.cdefine23) >3 THEN substring(RDS10.cdefine23,CHARINDEX('；',RDS10.cdefine23)+1,3) ELSE '' END 第二个坛子号,
		CASE when len(RDS10.cdefine23) >3 and isnull(CHARINDEX('；',RDS10.cdefine23),0) <> 0 THEN substring(RDS10.cdefine23,(CHARINDEX('/',RDS10.cdefine23,10)+1),CHARINDEX('；',RDS10.cdefine23)-CHARINDEX('/',RDS10.cdefine23)-1) when len(RDS10.cdefine23) >3 and isnull(CHARINDEX('；',RDS10.cdefine23),0) = 0 then RDS10.IQUANTITY/2 ELSE 0 END 第二个坛子入库量,
		bzjh1.[车间] AS 车间名称,bzjh1.[班组],bzjh1.[班次]
		FROM RDRECORDS10 AS RDS10 
		LEFT JOIN RDRECORD10 AS RD10 ON RDS10.ID = RD10.ID
		LEFT JOIN WAREHOUSE AS WH1 ON  RD10.CWHCODE = WH1.CWHCODE
		LEFT JOIN bzjh1 ON RDS10.IMOSEQ=CAST(bzjh1.[班组] as INT) AND LEFT(CONVERT(NVARCHAR, RD10.cdefine4,120),10) = bzjh1.[出入池时间]
		LEFT JOIN bzjh2 ON bzjh1.[出入池时间] = bzjh2.[出入池时间] AND bzjh1.[班次] = bzjh2.[班次] AND bzjh2.[入池窖池号] IS NOT NULL AND bzjh2.[是否回糟] <> '是'
		WHERE -- RD10.CSOURCE = '生产订单' AND 
			LEFT(CONVERT(NVARCHAR, RD10.cdefine4,120),10) >= LEFT(CONVERT(NVARCHAR, @DBDATE,120),10) AND LEFT(CONVERT(NVARCHAR, RD10.cdefine4,120),10) <= LEFT(CONVERT(NVARCHAR, @DEDATE,120),10) 
		AND WH1.CWHNAME = '原酒库' 
		--AND RDS10.cdefine23 is not NULL
		AND bzjh2.[入池窖池号] IS NOT NULL
		ORDER BY RDS10.IMOSEQ DESC
		),
	#B as (
	--计算 生产日期、入库日期、车间名称、班组、班次、入池窖池号、原始坛子号、坛子号、CINVCODE、入库数量
	-- 主要是把同一个产成品入库单行的两坛子号数据列转行
	SELECT #A.生产日期,#A.入库日期,#A.车间名称,#A.班组,#A.[班次],#A.autoid,#A.入池窖池号,#A.原始坛子号,
		CASE WHEN len(#A.第一个坛子号)<1 THEN isnull(#A.原始坛子号,0) ELSE #A.第一个坛子号 END AS 坛子号,#A.CINVCODE,
		CASE WHEN len(#A.第一个坛子号)<3 THEN #A.数量 ELSE CAST(#A.第一个坛子入库量 as DECIMAL(20,2)) END AS 入库数量
	FROM #A 
	union all 
	SELECT #A.生产日期,#A.入库日期,#A.车间名称,#A.班组,#A.[班次],#A.autoid,#A.入池窖池号,#A.原始坛子号,
		CASE WHEN len(#A.第二个坛子号)<1 THEN isnull(#A.原始坛子号,0) ELSE #A.第二个坛子号 END AS 坛子号,#A.CINVCODE,
		CASE WHEN len(#A.第二个坛子号)<3 THEN #A.数量 ELSE CAST(#A.第二个坛子入库量 as DECIMAL(20,2)) END AS 入库数量
	FROM #A 
	WHERE LEN(#A.第二个坛子号) >1
	),
	#C as (
	-- 计算各等级酒的产量
	SELECT B.生产日期,B.入库日期,B.车间名称,B.班组,B.[班次],B.入池窖池号,b.坛子号,b.原始坛子号,m.cinvcode,m.cinvname,
	B1.COUNT_JC,ROUND(B.入库数量/B1.COUNT_JC,2)  AS 窖池产量,
	CASE WHEN M.CINVNAME = '五粮一级' THEN ROUND(B.入库数量/B1.COUNT_JC,2) ELSE 0 END AS 优级酒产量,
		CASE WHEN M.CINVNAME = '五粮二级' THEN ROUND(B.入库数量/B1.COUNT_JC,2) ELSE 0 END AS 一级酒产量,
		CASE WHEN M.CINVNAME = '五粮三级' THEN ROUND(B.入库数量/B1.COUNT_JC,2) ELSE 0 END AS 二级酒产量
	FROM #B AS B
	LEFT JOIN Inventory as m on b.cinvcode = m.cinvcode
	LEFT JOIN (SELECT T.AUTOID,T.坛子号,COUNT(T.入池窖池号) AS COUNT_JC FROM #B AS T GROUP BY T.AUTOID,T.坛子号) AS B1 
		ON B.AUTOID = B1.AUTOID AND B.坛子号 = B1.坛子号
	ORDER BY B.班组,B.入池窖池号,b.坛子号
	),
	#D as (
	-- 按 生产日期、入库日期、车间名称、班组、班次、入池窖池号 汇总各等级酒的产量
	SELECT #C.生产日期,#C.入库日期,#C.车间名称,#C.班组,#C.[班次],#C.入池窖池号,
	SUM(#C.优级酒产量) AS 优级酒产量,
	SUM(#C.一级酒产量) AS 一级酒产量,
	SUM(#C.二级酒产量) AS 二级酒产量
	FROM #C
	GROUP BY  #C.生产日期,#C.入库日期,#C.车间名称,#C.班组,#C.[班次],#C.入池窖池号
	),
	#E as (
	-- 按 班组、窖池号、生产日期 对产量数据排序
	SELECT #D.生产日期,#D.入库日期,#D.车间名称,#D.班组,#D.[班次],#D.入池窖池号,#D.优级酒产量,#D.一级酒产量,#D.二级酒产量,
	row_number() OVER(PARTITION  BY #D.班组,#D.入池窖池号 ORDER BY #D.生产日期 DESC) as rn
	FROM #D
	)
-- 计算 最近15个班次的出酒率、取优率
select y.班次,y.优级酒产量,y.一级酒产量,y.二级酒产量,y.出酒率,y.取优率
from (SELECT top 15 X.班次,sum(X.优级酒产量) as 优级酒产量,sum(X.一级酒产量) as 一级酒产量,sum(X.二级酒产量) as 二级酒产量,COUNT(x.入池窖池号) as 入池窖池个数,(sum(X.优级酒产量)+sum(X.一级酒产量)+sum(X.二级酒产量))/ (COUNT(x.入池窖池号)*1000) as 出酒率,(sum(X.优级酒产量)+sum(X.一级酒产量))/(sum(X.优级酒产量)+sum(X.一级酒产量)+sum(X.二级酒产量)) as 取优率
		FROM (SELECT TOP 72  RIGHT(CONVERT(NVARCHAR,T1.生产日期,12),6)+T2.班次 as 班次, T2.入池窖池号 ,
								T2.优级酒产量,T2.一级酒产量,T2.二级酒产量
					FROM #E AS T1
					LEFT JOIN (SELECT #E.车间名称,#E.班组,#E.[班次],#E.入池窖池号,
														SUM(#E.优级酒产量) AS 优级酒产量,
														SUM(#E.一级酒产量) AS 一级酒产量,
														SUM(#E.二级酒产量) AS 二级酒产量
											FROM #E GROUP BY #E.车间名称,#E.班组,#E.[班次],#E.入池窖池号)
							AS T2 ON T1.车间名称 = T2.车间名称 AND T1.班组 = T2.班组 AND T1.[班次] = T2.班次 AND T1.入池窖池号 = T2.入池窖池号
					WHERE T1.RN = 1
					ORDER BY T1.生产日期 DESC) as X
		group BY X.班次
		ORDER BY X.班次 desc)as y
order by y.班次

