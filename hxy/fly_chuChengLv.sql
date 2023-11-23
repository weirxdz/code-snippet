USE [UFDATA_777_2021]
GO
/****** Object:  StoredProcedure [dbo].[fly_chuChengLv]    Script Date: 11/23/2023 11:42:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER             PROCEDURE [dbo].[fly_chuChengLv] @dDate_start varchar(10),@dDate_end varchar(10)
/**,@renwuhao varchar(30)
2019-04-18：修改了损耗率的值为空白时报错：从数据类型 varchar 转换为 numeric 时出错
*/
AS
DECLARE @SQL VARCHAR(4000)
BEGIN
create table #FlyTable0
(
	任务号 varchar(50)
)

--查询任务号开始------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
set @SQL = '
insert into #FlyTable0 select
rdrecords10.cdefine22 as 任务号
from rdrecords10
Left JOIN rdrecord10 ON rdrecords10.ID = rdrecord10.ID
Left JOIN Inventory ON rdrecords10.cInvCode = Inventory.cInvCode
where (rdrecords10.cdefine22 is not null and (Inventory.cInvCode like ''05%'' or Inventory.cInvCode like ''07%'')) '
if(isnull(@dDate_start,'')<>'')
begin
set @SQL = @SQL + 'AND (rdrecord10.dDate >= '''+@dDate_start+''') '
end
if(isnull(@dDate_end,'')<>'')
begin
set @SQL = @SQL + 'AND (rdrecord10.dDate <= '''+@dDate_end+''') '
end
/*if(isnull(@renwuhao,'')<>'')
BEGIN
set @SQL = @SQL + 'AND (rdrecords10.cdefine22 = '''+@renwuhao+''') '
END*/
exec (@SQL)
--查询任务号结束-
--查询数据开始--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------######################
select distinct
	y.任务号,
	y.产品编码,y.产品名称,y.产品规格,
	y.领用原料重量,
	y.明细入库重量,
	y.产出入库重量,
	y.损耗重量,
	y.出成率,
	y.损耗率,
  y.合理损耗上限,
	y.合理损耗下限,
	(case
		when (y.损耗率 <= y.合理损耗上限 AND y.损耗率 >= y.合理损耗下限) then '合理'
		when (y.损耗率 < y.合理损耗下限) then '节约'
		when (y.损耗率 > y.合理损耗上限) then '浪费'
	end) as 结果,
	(case
		when (y.损耗率 <= y.合理损耗上限 AND y.损耗率 >= y.合理损耗下限) then 0
		when (y.损耗率 < y.合理损耗下限) then (y.损耗重量-(y.产出入库重量*(y.合理损耗下限/100)))
		when (y.损耗率 > y.合理损耗上限) then (y.损耗重量-(y.产出入库重量*(y.合理损耗上限/100)))
	end) as 超标准损耗重量,
	y.一次通过率,
	y.标准单价,
	(case
		when (y.损耗率 <= y.合理损耗上限 AND y.损耗率 >= y.合理损耗下限) then 0.00
		when (y.损耗率 < y.合理损耗下限) then ((y.损耗重量-(y.产出入库重量*(y.合理损耗下限/100)))*isnull(y.标准单价,0.00))
		when (y.损耗率 > y.合理损耗上限) then ((y.损耗重量-(y.产出入库重量*(y.合理损耗上限/100)))*isnull(y.标准单价,0.00))
	end) as 损耗金额
from (SELECT LT0.任务号 as 任务号,LT00.产品编码 as 产品编码,LT00.产品名称 as 产品名称,LT00.产品规格 as 产品规格,LT1.领用原料重量 as 领用原料重量,
			LT00.明细入库重量 as 明细入库重量,LT0.产出入库重量 as 产出入库重量,LT0.一次通过重量 as 一次通过重量,
			(LT1.领用原料重量-LT0.产出入库重量) as 损耗重量, 
CASE WHEN LT1.领用原料重量 IS NULL OR LT1.领用原料重量 = '' OR LT1.领用原料重量 = 0 THEN 0 ELSE CAST((cast(LT0.产出入库重量/LT1.领用原料重量 as decimal(20,6))*100) as decimal(20,2)) END as 出成率,
CASE WHEN LT1.领用原料重量 IS NULL OR LT1.领用原料重量 = ''  OR LT1.领用原料重量 = 0 THEN 100 ELSE isnull(CAST((1-CAST(((LT0.产出入库重量/LT1.领用原料重量)) as decimal(20,6)))*100 as decimal(20,2)),0) END 损耗率,
isnull(LT2.合理损耗上限,0) as 合理损耗上限,isnull(LT2.合理损耗下限,0) as 合理损耗下限,
'' as 结果,0 as 超标准损耗重量,
CASE WHEN LT1.领用原料重量 IS NULL OR LT1.领用原料重量 = '' OR LT1.领用原料重量 = 0  THEN 0 ELSE CAST(((LT0.一次通过重量/LT1.领用原料重量)*100) as decimal(20,2))END  as 一次通过率,
isnull(cast(x.平均单价 as decimal(20,6)),0)  as 标准单价,
0 as 损耗金额
--#################################################################################
FROM (
select #FlyTable00.任务号 as 任务号,--#FlyTable00.产品编码 as 产品编码,#FlyTable00.产品名称 as 产品名称,#FlyTable00.产品规格 as 产品规格,
--sum(#FlyTable00.产出入库重量)  as 明细入库重量,
sum(#FlyTable00.产出入库重量)  as 产出入库重量,
sum(#FlyTable00.一次通过重量)  as 一次通过重量
from (select
rdrecords10.cdefine22 as 任务号,Inventory.cInvCode as 产品编码,
				Inventory.cInvName as 产品名称,
				Inventory.cInvStd as 产品规格,
(case
	when (Inventory.cComUnitCode = '001') then rdrecords10.iquantity
	when (Inventory.cComUnitCode <> '001') then ((rdrecords10.iquantity * Inventory.iInvWeight)/1000)
end) as 产出入库重量,
(case
	when (Inventory.cComUnitCode = '001' and ((Inventory.cInvCCode LIKE '05%' AND Inventory.cInvCCode NOT LIKE '0596%' AND Inventory.cInvCCode NOT LIKE '0597%' AND Inventory.cInvCCode NOT LIKE '0598%' AND Inventory.cInvCCode NOT LIKE '0599%') OR Inventory.cInvCCode LIKE '07%')) then rdrecords10.iquantity
	when (Inventory.cComUnitCode <> '001'and ((Inventory.cInvCCode LIKE '05%' AND Inventory.cInvCCode NOT LIKE '0596%' AND Inventory.cInvCCode NOT LIKE '0597%' AND Inventory.cInvCCode NOT LIKE '0598%' AND Inventory.cInvCCode NOT LIKE '0599%') OR Inventory.cInvCCode LIKE '07%')) then ((rdrecords10.iquantity * Inventory.iInvWeight)/1000)
end) as 一次通过重量
from rdrecords10

Left JOIN rdrecord10 ON rdrecords10.ID = rdrecord10.ID
Left JOIN Inventory ON rdrecords10.cInvCode = Inventory.cInvCode
where (rdrecords10.cdefine22 in (select 任务号 from #FlyTable0) and (Inventory.cInvCode like '05%' or Inventory.cInvCode like '07%')) ) AS #FlyTable00 
group by #FlyTable00.任务号 --,#FlyTable00.产品编码 ,#FlyTable00.产品名称,#FlyTable00.产品规格
) AS LT0

LEFT JOIN(
select #FlyTable00.任务号 as 任务号,#FlyTable00.产品编码 as 产品编码,#FlyTable00.产品名称 as 产品名称,#FlyTable00.产品规格 as 产品规格,
sum(#FlyTable00.产出入库重量)  as 明细入库重量 --,
--sum(#FlyTable00.产出入库重量)  as 产出入库重量,
--sum(#FlyTable00.一次通过重量)  as 一次通过重量
from (
select
rdrecords10.cdefine22 as 任务号,Inventory.cInvCode as 产品编码,
				Inventory.cInvName as 产品名称,
				Inventory.cInvStd as 产品规格,
(case
	when (Inventory.cComUnitCode = '001') then rdrecords10.iquantity
	when (Inventory.cComUnitCode <> '001') then ((rdrecords10.iquantity * Inventory.iInvWeight)/1000)
end) as 产出入库重量,
(case
	when (Inventory.cComUnitCode = '001' and ((Inventory.cInvCCode LIKE '05%' AND Inventory.cInvCCode NOT LIKE '0596%' AND Inventory.cInvCCode NOT LIKE '0597%' AND Inventory.cInvCCode NOT LIKE '0598%' AND Inventory.cInvCCode NOT LIKE '0599%') OR Inventory.cInvCCode LIKE '07%')) then rdrecords10.iquantity
	when (Inventory.cComUnitCode <> '001'and ((Inventory.cInvCCode LIKE '05%' AND Inventory.cInvCCode NOT LIKE '0596%' AND Inventory.cInvCCode NOT LIKE '0597%' AND Inventory.cInvCCode NOT LIKE '0598%' AND Inventory.cInvCCode NOT LIKE '0599%') OR Inventory.cInvCCode LIKE '07%')) then ((rdrecords10.iquantity * Inventory.iInvWeight)/1000)
end) as 一次通过重量
from rdrecords10

Left JOIN rdrecord10 ON rdrecords10.ID = rdrecord10.ID
Left JOIN Inventory ON rdrecords10.cInvCode = Inventory.cInvCode
where (rdrecords10.cdefine22 in (select 任务号 from #FlyTable0) and (Inventory.cInvCode like '05%' or Inventory.cInvCode like '07%')) ) AS #FlyTable00 
group by #FlyTable00.任务号,#FlyTable00.产品编码 ,#FlyTable00.产品名称,#FlyTable00.产品规格
) AS LT00 ON LT0.任务号 = LT00.任务号
left join FR_CPNRW_PRICE_001 as x on LT00.产品编码 = x.产品编码
left join (
select #FlyTable01.任务号 as 任务号,
sum(#FlyTable01.领用原料重量) as 领用原料重量
from (select
				rdrecord11.cDefine1 as 任务号,
				
(case
	when (Inventory.cComUnitCode = '001') then rdrecords11.iquantity
	when (Inventory.cComUnitCode <> '001') then ((rdrecords11.iquantity * Inventory.iInvWeight)/1000)
end) as 领用原料重量
from rdrecords11
Left JOIN rdrecord11 ON rdrecords11.ID = rdrecord11.ID
Left JOIN Inventory ON rdrecords11.cInvCode = Inventory.cInvCode
where rdrecord11.cDefine1 in (select 任务号 from #FlyTable0) AND Inventory.cInvCCode NOT LIKE '02%') AS #FlyTable01 
group by #FlyTable01.任务号) AS LT1 ON LT0.任务号 = LT1.任务号
left join (
select #FlyTable011.任务号 as 任务号,
max(isnull(#FlyTable011.合理损耗上限,0)) as 合理损耗上限,
max(isnull(#FlyTable011.合理损耗下限,0)) as 合理损耗下限
from (select
rdrecord11.cDefine1 as 任务号,
CASE WHEN rdrecord11.cdefine9 IS NULL OR rdrecord11.cdefine9 ='' THEN 0 ELSE 100*(1.0-CAST(rdrecord11.cdefine9 as decimal(20,6))) END as 合理损耗上限,
CASE WHEN rdrecord11.cdefine2 IS NULL OR rdrecord11.cdefine2 ='' THEN 0 ELSE 100*(1.0- CAST(rdrecord11.cdefine2 as decimal(20,6))) END as 合理损耗下限
from rdrecords11
Left JOIN rdrecord11 ON rdrecords11.ID = rdrecord11.ID
where rdrecord11.cDefine1 in (select 任务号 from #FlyTable0) and isnull(rdrecord11.cPsPcode,'') <> '') AS #FlyTable011
group by #FlyTable011.任务号) AS LT2 ON LT0.任务号 = LT2.任务号) as y
drop table #FlyTable0


END



