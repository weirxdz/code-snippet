-- 成本对象 取产成品入库单记录，以生产订单行主键、存货编码、存货批次为主键构建成本对象生产明细表
-- 成本对象为 存货编码+存货批次
SELECT b.autoid ,h.cCode ,d.cDepCode ,d.cDepName ,d.bDepEnd ,b.iMPoIds ,b.cInvCode,b.cBatch ,B.iQuantity  ,ob.BomId ,CAST(COALESCE(bb.Define1,'0') AS decimal(22,6)) 标准人工制费,CAST(COALESCE(bb.Define2 ,'0') AS decimal(22,6)) 焊缝长度,CAST(COALESCE(bb.Define3 ,'0') AS decimal(22,6)) 浇筑体积
FROM rdrecords10 b 
INNER JOIN rdrecord10 h ON b.ID = h.ID 
INNER JOIN mom_orderdetail ob ON b.iMPoIds = ob.MoDId 
LEFT JOIN bom_bom bb ON ob.BomId = bb.BomId 
LEFT JOIN Department d ON h.cDepCode = d.cDepCode 
;
-- 检查生产入库单的部门是否正确
SELECT h.ID ,h.cCode,h.cRdCode,t.cRdName  ,d.cDepCode ,d.cDepName ,d.bDepEnd ,h.cMemo ,h.cDefine11 ,h.cDefine12 ,h.dDate ,h.dVeriDate 
FROM  rdrecord10 h 
LEFT JOIN Department d ON h.cDepCode = d.cDepCode
LEFT JOIN Rd_Style t ON h.cRdCode = t.cRdCode 
WHERE h.dDate >= '2024-01-01' AND h.dDate <= '2024-01-31'
ORDER BY h.dVeriDate 
;
-- 检查材料出库单的部门是否正确
SELECT h.ID ,h.cCode,h.cRdCode,t.cRdName  ,d.cDepCode ,d.cDepName ,d.bDepEnd ,h.cMemo ,h.cDefine11 ,h.cDefine12 ,h.dDate ,h.dVeriDate 
FROM  rdrecord11 h 
LEFT JOIN Department d ON h.cDepCode = d.cDepCode
LEFT JOIN Rd_Style t ON h.cRdCode = t.cRdCode 
WHERE h.dDate >= '2024-01-01' AND h.dDate <= '2024-01-31'
ORDER BY d.cDepCode ,h.dVeriDate 
;
--
--SELECT h.ID ,h.cCode,h.cRdCode,t.cRdName  ,d.cDepCode ,d.cDepName ,d.bDepEnd ,h.cMemo ,h.cDefine11 ,h.cDefine12 ,h.dDate ,h.dVeriDate 
--FROM  rdrecord11 h 
--LEFT JOIN Department d ON h.cDepCode = d.cDepCode
--LEFT JOIN Rd_Style t ON h.cRdCode = t.cRdCode 
--WHERE h.dDate >= '2024-01-01' AND h.dDate <= '2024-01-31' AND h.cDepCode = '0605'
--ORDER BY d.cDepCode ,h.dVeriDate 
--;
--UPDATE rdrecord11 SET cDepCode = '0602' WHERE id IN (1000006828,1000006830)
--;
-- 检查其他入库单的部门是否正确
SELECT h.ID ,h.cCode ,h.cRdCode,t.cRdName ,d.cDepCode ,d.cDepName ,d.bDepEnd ,h.cMemo ,h.cDefine11 ,h.cDefine12 ,h.dDate ,h.dVeriDate 
FROM  rdrecord08 h 
LEFT JOIN Department d ON h.cDepCode = d.cDepCode
LEFT JOIN Rd_Style t ON h.cRdCode = t.cRdCode 
WHERE h.dDate >= '2024-01-01' AND h.dDate <= '2024-01-31'
ORDER BY h.dVeriDate 
;
-- 检查其他出库单的部门是否正确
SELECT h.ID ,h.cCode ,h.cRdCode,t.cRdName  ,d.cDepCode ,d.cDepName ,d.bDepEnd ,h.cMemo ,h.cDefine11 ,h.cDefine12 ,h.dDate ,h.dVeriDate 
FROM  rdrecord09 h 
LEFT JOIN Department d ON h.cDepCode = d.cDepCode
LEFT JOIN Rd_Style t ON h.cRdCode = t.cRdCode 
WHERE h.dDate >= '2024-01-01' AND h.dDate <= '2024-01-31'
ORDER BY h.dVeriDate 
;
-- 检查销售出库单的部门是否正确
SELECT h.ID ,h.cCode ,h.cRdCode,t.cRdName ,d.cDepCode ,d.cDepName ,d.bDepEnd ,h.cMemo ,h.cDefine11 ,h.cDefine12 ,h.dDate ,h.dVeriDate 
FROM  rdrecord32 h 
LEFT JOIN Department d ON h.cDepCode = d.cDepCode
LEFT JOIN Rd_Style t ON h.cRdCode = t.cRdCode 
WHERE h.dDate >= '2024-01-01' AND h.dDate <= '2024-01-31'
ORDER BY h.dVeriDate 
;
SELECT h.cCode ,b.cInvCode,b.cBatch ,B.iQuantity  ,b.iMPoIds 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
WHERE H.cCode in( '202312080006','202312080007','202312080008')

;
SELECT * FROM v_mom_moallocate_rpt
;
SELECT * FROM rdrecord10
;

-- 直接材料
SELECT rkb.AutoID 入库单行主键,h.MoCode 生产订单号,b.MoDId 生产订单子表主键,b.MoId 生产订单主键,b.PartId ,rkb.cInvCode 产品编码,
-- c.InvCode AS 材料编码,c.Qty ,c.IssQty ,b.BomId ,
rkh.cCode 入库单号,rkh.cDepCode 入库部门编码,rkb.cBatch ,rkb.iQuantity 入库数量,rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,i.cInvDefine1,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost 材料单价,rb.iprice 材料成本
FROM mom_orderdetail b
INNER JOIN mom_order h ON b.MoId = h.MoId 
INNER JOIN mom_moallocate c ON b.MoDId = c.MoDId 
LEFT JOIN rdrecords10 AS rkb ON b.MoDId = rkb.iMPoIds 
LEFT JOIN rdrecord10 AS rkh ON rkb.ID = rkh.ID 
LEFT JOIN rdrecords11 rb ON c.AllocateId = rb.iMPoIds 
LEFT JOIN rdrecord11 rh ON rb.ID = rh.ID 
INNER JOIN Inventory i ON rb.cInvCode = i.cInvCode 
WHERE 1=1 
	AND rkh.cCode IS NOT null
	 AND h.MoCode = '202312310156'
	-- AND rkh.cCode = ''
;
-- 分摊材料
-- 需要区分焊接材料210101\210102、商砼材料0201\0202\0203\0204、其他材料
-- 材料出库单上需要填写领料部门
SELECT h.cCode ,b.cInvCode,i.cInvName ,b.cBatch ,B.iQuantity  ,b.iMPoIds ,h.cSource ,h.cDepCode ,d.cDepName ,d.bDepEnd ,b.iUnitCost 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT  JOIN department d ON h.cDepCode = d.cDepCode 
WHERE 1=1 
	--AND H.cCode in( '202312080006','202312080007','202312080008')
	AND h.cSource = '库存'
	
;
-- 焊接材料210101\210102
SELECT b.AutoID 出库行主键,h.cCode 出库单号,d2.cDepCode 车间编码,d2.cDepName 车间名称,h.cDepCode 部门编码,d.cDepName 部门名称,b.cInvCode 材料编码,i.cInvName 材料名称,i.cInvDefine1 材料级次,isnull(b.cBatch,'-') 材料批号,B.iQuantity  出库数量,b.iUnitCost 材料单价,b.iPrice 材料成本
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT  JOIN department d ON h.cDepCode = d.cDepCode 
LEFT JOIN Department d2 ON left(h.cDepCode,2) = d2.cDepCode 
WHERE 1=1 
	AND ic.cInvCCode IN ('210101','210102')
	AND h.cSource = '库存'
	AND h.dDate >= '${月初日期}' AND h.dDate <= '${月末日期}'
;
-- 商砼材料0201\0202\0203\0204
SELECT h.cCode ,b.cInvCode,i.cInvName ,ic.cInvCCode ,ic.cInvCName ,i.cInvDefine1,b.cBatch ,B.iQuantity  ,b.iMPoIds ,h.cSource ,h.cDepCode ,d.cDepName ,d.bDepEnd ,b.iUnitCost 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT  JOIN department d ON h.cDepCode = d.cDepCode 
WHERE 1=1 
	AND ic.cInvCCode IN ('0201','0202','0203','0204')
	AND h.cSource = '库存'
;
-- 	其他材料-人防门车间办公室 ，按1：6：3向“下料机加班组”、“焊接班组”、“预制班组”分配
SELECT h.cCode ,b.cInvCode,i.cInvName ,ic.cInvCCode ,ic.cInvCName,i.cInvDefine1 ,b.cBatch ,B.iQuantity  ,b.iMPoIds ,h.cSource ,h.cDepCode ,d.cDepName ,d.bDepEnd ,b.iUnitCost 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT  JOIN department d ON h.cDepCode = d.cDepCode 
WHERE 1=1 
	AND ic.cInvCCode NOT IN ('210101','210102','0201','0202','0203','0204')
	AND h.cSource = '库存'
	AND d.cDepName = '人防门车间办公室'
;
-- 	其他材料-人防门下料机加班组、人防门焊接班组、人防门预制班组
-- 系统中有 人防门机加班组，需要问一下做什么用，跟人防门下料机加班组有什么关系
SELECT h.cCode ,b.cInvCode,i.cInvName ,ic.cInvCCode ,ic.cInvCName,i.cInvDefine1  ,b.cBatch ,B.iQuantity  ,b.iMPoIds ,h.cSource ,h.cDepCode ,d.cDepName ,d.bDepEnd ,b.iUnitCost 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT  JOIN department d ON h.cDepCode = d.cDepCode 
WHERE 1=1 
	AND ic.cInvCCode NOT IN ('210101','210102','0201','0202','0203','0204')
	AND h.cSource = '库存'
	AND d.cDepName IN ('人防门下料机加班组','人防门焊接班组','人防门预制班组')
;
-- 其他材料 通风车间办公室 暂时按1：1：1：1向“消防风管班组”、“人防风管班组”、“消防风机风阀班组”、“人防风机风阀班组”分配
SELECT h.cCode ,b.cInvCode,i.cInvName ,ic.cInvCCode ,ic.cInvCName ,b.cBatch ,B.iQuantity  ,b.iMPoIds ,h.cSource ,h.cDepCode ,d.cDepName ,d.bDepEnd ,b.iUnitCost 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT  JOIN department d ON h.cDepCode = d.cDepCode 
WHERE 1=1 
	AND ic.cInvCCode NOT IN ('210101','210102','0201','0202','0203','0204')
	AND h.cSource = '库存'
	AND d.cDepName IN ('通风车间办公室')
;
-- 其他材料 “消防风管班组”、“人防风管班组”、“消防风机风阀班组”、“人防风机风阀班组”分配
SELECT h.cCode ,b.cInvCode,i.cInvName ,ic.cInvCCode ,ic.cInvCName,i.cInvDefine1  ,b.cBatch ,B.iQuantity  ,b.iMPoIds ,h.cSource ,h.cDepCode ,d.cDepName ,d.bDepEnd ,b.iUnitCost 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT  JOIN department d ON h.cDepCode = d.cDepCode 
WHERE 1=1 
	AND ic.cInvCCode NOT IN ('210101','210102','0201','0202','0203','0204')
	AND h.cSource = '库存'
	AND d.cDepName IN ('人防通风班组','消防通风班组','消防风机风阀班组')
;

-- 存货单价
SELECT iOriCost ,iUnitCost ,fACost 
FROM RdRecord01 h
INNER JOIN rdrecords01 b ON h.ID = b.ID 
WHERE h.cCode = '202312060049'
;
-- IA_Subsidiary 存货明细账
SELECT * FROM IA_Subsidiary 

-- 总账制造费用取数
SELECT t.i_id 分录主键,t.iyear 年度,t.iperiod 期间,t.iYPeriod 年月,t.ccode 科目编码,c.ccode_name 科目名称,d2.cDepCode 车间编码,d2.cDepName 车间名称,t.cdept_id 部门编码,d.cDepName 部门名称,d.bDepEnd  是否末级部门,t.md  借方金额,t.mc 贷方金额,t.cdigest 摘要,t.coutsysname  来源系统 
FROM GL_accvouch t 
INNER JOIN Department d ON t.cdept_id = d.cDepCode 
LEFT JOIN Department d2 ON left(d.cdepcode,2) = d2.cDepCode 
INNER JOIN code c ON t.ccode = c.ccode AND c.iyear = t.iyear
WHERE LEFT(t.ccode ,4) = '5101'
	AND t.cdept_id <> '16'
AND t.iyear = 2023 AND t.iperiod = 12
;

CREATE TABLE TT.dbo.总账制造费用明细表 (
	分录主键 int NULL,
	年度 int NULL,
	月份 int NULL,
	年月 int NULL,
	科目编码 nvarchar(12) COLLATE Chinese_PRC_CI_AS NULL,
	科目名称 nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
	车间编码 nvarchar(10) COLLATE Chinese_PRC_CI_AS NULL,
	车间名称 nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
	部门编码 nvarchar(12) COLLATE Chinese_PRC_CI_AS NULL,
	部门名称 nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
	来源系统 nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
	摘要 nvarchar(120) COLLATE Chinese_PRC_CI_AS NULL,
	借方金额 decimal(22,6) NULL,
	贷方金额 decimal(22,6) NULL
);
-- 制费从凭证取数；其中有一些其他的材料出库单，做凭证到制造费用，
-- 费用凭证的发生数仅能录入借方，负数可以录入借方红字
-- 两天做完
USE ufdata_105_2023;
SELECT h.cCode ,b.bCosting ,b.iMatSettleState ,b.iMoney ,b.iSOutQuantity ,b.iSQuantity ,b.impcost  ,b.*
FROM rdrecords01 b 
LEFT JOIN RdRecord01 h ON b.ID = h.ID 
WHERE h.cCode = '202312020002'
;

USE ufdata_104_2023;
SELECT h.cCode ,b.bCosting ,b.iMatSettleState ,b.iMoney ,b.iSOutQuantity ,b.iSQuantity ,b.impcost  ,b.*
FROM rdrecords01 b 
LEFT JOIN RdRecord01 h ON b.ID = h.ID 
WHERE h.cCode = '202312020002'
;
USE ufdata_103_2023;
SELECT rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost,rb.iprice ,rb.cbaccounter ,rb.*
FROM rdrecords11 rb 
LEFT JOIN rdrecord11 rh ON rb.ID = rh.ID 
WHERE rh.cCode = 'CLCK202312140003'
;
USE ufdata_104_2023;
SELECT rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost,rb.iprice ,rb.cbaccounter ,rb.*
FROM rdrecords11 rb 
LEFT JOIN rdrecord11 rh ON rb.ID = rh.ID 
WHERE rh.cCode = 'CLCK202312140003'
;

-- QTCK202312140003
USE ufdata_103_2023;
SELECT rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost,rb.iprice ,rb.cbaccounter ,rb.*
FROM rdrecords09 rb 
LEFT JOIN rdrecord09 rh ON rb.ID = rh.ID 
WHERE rh.cCode = 'QTCK202312140003'
;
-- QTCK202312140003
USE ufdata_104_2023;
SELECT rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost,rb.iprice ,rb.cbaccounter ,rb.*
FROM rdrecords09 rb 
LEFT JOIN rdrecord09 rh ON rb.ID = rh.ID 
WHERE rh.cCode = 'QTCK202312140003'
;
-- CLCK202312190043
USE ufdata_103_2023;
SELECT rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost,rb.iprice ,rb.cbaccounter ,rb.*
FROM rdrecords11 rb 
LEFT JOIN rdrecord11 rh ON rb.ID = rh.ID 
WHERE rh.cCode = 'CLCK202312190043'
;
-- CLCK202312190043
USE ufdata_104_2023;
SELECT rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost,rb.iprice ,rb.cbaccounter ,rb.*
FROM rdrecords11 rb 
LEFT JOIN rdrecord11 rh ON rb.ID = rh.ID 
WHERE rh.cCode = 'CLCK202312190043'
;
USE ufdata_105_2023;
SELECT rh.cCode 出库单号,rb.cInvCode AS 出库单材料编码,rb.cBatch ,rb.iQuantity 出库数量,rb.iUnitCost,rb.iprice ,rb.cbaccounter ,rb.*
FROM rdrecords11 rb 
LEFT JOIN rdrecord11 rh ON rb.ID = rh.ID 
WHERE rh.cCode = 'CLCK202312140003'
;

-- 
SELECT h.cCode ,h.dDate ,h.dVeriDate  FROM RdRecord01 h WHERE h.dVeriDate > '2024-12-01';
--UPDATE RdRecord01 SET dVeriDate = dDate WHERE dVeriDate > '2024-12-01';
SELECT h.cCode ,h.dDate ,h.dVeriDate  FROM RdRecord08 h WHERE h.dVeriDate > '2024-12-01';
SELECT h.cCode ,h.dDate ,h.dVeriDate  FROM RdRecord09 h WHERE h.dVeriDate > '2024-12-01';
SELECT h.cCode ,h.dDate ,h.dVeriDate  FROM RdRecord10 h WHERE h.dVeriDate > '2024-12-01';
SELECT h.cCode ,h.dDate ,h.dVeriDate  FROM RdRecord11 h WHERE h.dVeriDate > '2024-12-01';
--UPDATE RdRecord11 SET dVeriDate = dDate WHERE dVeriDate > '2024-12-01';
SELECT h.cCode ,h.dDate ,h.dVeriDate  FROM RdRecord32 h WHERE h.dVeriDate > '2024-12-01';
SELECT h.cCode ,h.dDate ,h.dVeriDate  FROM RdRecord34 h WHERE h.dVeriDate > '2024-12-01';


SELECT t.部门编码, t.部门名称,sum(t.材料成本) 材料成本
FROM 焊接材料明细表 t 
WHERE 1=1 -- t.年度 = year('${月初日期}') AND t.月份 = MONTH('${月末日期}')
	AND t.部门名称 IN ('人防门下料机加班组','人防门焊接班组','人防门预制班组','人防通风班组','消防通风班组','消防风机风阀班组')
group by t.部门编码, t.部门名称
;

select b.bomid,define1,define2,define3,ParentId ,BP.InvCode 
from bom_bom b 
left join bom_parent p on b.bomid=p.bomid
LEFT JOIN bas_part bp ON p.ParentId = BP.PartId 
where define1 is null and version=20
;
SELECT b.BomId ,b.*
FROM Bom_opcomponent b
LEFT JOIN bom_bom h ON b.BomId = h.BomId 
LEFT JOIN bom_parent bp ON h.BomId = bp.BomId 
LEFT JOIN bas_part bp2 ON bp.ParentId = bp2.PartId 
WHERE bp2.InvCode in( '5102080202','5101010115')
