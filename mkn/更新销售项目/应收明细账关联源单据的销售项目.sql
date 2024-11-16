SELECT b.AutoID ,b.SBVID,b.iSOsID ,b.iDLsID ,b.isaleoutid , dlb.AutoID , sob.AutoID  ,b.cItemCode ,b.cItem_class ,b.cItemName ,b.cItem_CName ,dlb.cItemCode ,dlb.cItem_class ,dlb.cItemName ,dlb.cItem_CName 
FROM SaleBillVouch h
INNER JOIN SaleBillVouchs b ON b.SBVID = h.SBVID 
LEFT JOIN SO_SODetails sob ON b.iSOsID = sob.AutoID 
LEFT JOIN DispatchLists dlb ON b.iDLsID = dlb.iDLsID  
WHERE h.cSBVCode = 'XSPP202401290050'
;

EXEC UpdateSoDetailsItemCode;

-- 应收明细账
SELECT t.Auto_ID 明细账主键,t.iPeriod 期间,t.cVouchID 单据Id,t.cPerson 业务员Id,t.cCode 会计科目编码,t.cItem_Class 项目大类,t.cItemCode 项目编码,t.cItemName 项目名称,t.cDigest 摘要,t.cOrderNo 订单编号,soh.cMemo 订单备注,soh.cdefine11 订单项目编码,soh.cdefine12 订单项目名称,t.cDLCode 发货单号,dlh.cMemo 发货单备注,dlh.cDefine11 发货单表头项目编码,dlh.cDefine12 发货单表头项目名称,sbh.cDefine11 发票表头项目编码,sbh.cDefine12 发票表头项目名称,t.idlsid 发货单子表Id,t.iBVid 发票子表主键,svb.cItem_class ,svb.cItem_CName ,svb.cItemCode ,svb.cItemName  
FROM Ar_Detail t
LEFT JOIN DispatchLists dlb ON t.iDLsID = dlb.iDLsID 
LEFT JOIN DispatchList dlh ON dlb.DLID = dlh.DLID 
LEFT JOIN SaleBillVouchs svb ON t.iBVid = svb.AutoID 
LEFT JOIN SaleBillVouch sbh ON svb.SBVID = sbh.SBVID
--LEFT JOIN rdrecords32 r ON svb.
LEFT JOIN SO_SODetails sob ON svb.iSOsID = sob.iSOsID 
LEFT JOIN SO_SOMain soh ON sob.ID = soh.ID 
WHERE t.cVouchType = '27' -- AND sbh.cSBVCode = 'XSPP202405030001'
	AND t.cItemCode IS NULL 
;
-- 发票表体项目非空
SELECT t.Auto_ID 明细账主键,t.iPeriod 期间,t.cVouchID 单据Id,t.cPerson 业务员Id,t.cCode 会计科目编码,t.cItem_Class 项目大类,t.cItemCode 项目编码,t.cItemName 项目名称,t.cDigest 摘要,t.cOrderNo 订单编号,soh.cMemo 订单备注,soh.cdefine11 订单项目编码,soh.cdefine12 订单项目名称,t.cDLCode 发货单号,dlh.cMemo 发货单备注,dlh.cDefine11 发货单表头项目编码,dlh.cDefine12 发货单表头项目名称,sbh.cDefine11 发票表头项目编码,sbh.cDefine12 发票表头项目名称,t.idlsid 发货单子表Id,t.iBVid 发票子表主键,svb.cItem_class ,svb.cItem_CName ,svb.cItemCode ,svb.cItemName  
FROM Ar_Detail t
LEFT JOIN DispatchLists dlb ON t.iDLsID = dlb.iDLsID 
LEFT JOIN DispatchList dlh ON dlb.DLID = dlh.DLID 
LEFT JOIN SaleBillVouchs svb ON t.iBVid = svb.AutoID 
LEFT JOIN SaleBillVouch sbh ON svb.SBVID = sbh.SBVID
--LEFT JOIN rdrecords32 r ON svb.
LEFT JOIN SO_SODetails sob ON svb.iSOsID = sob.iSOsID 
LEFT JOIN SO_SOMain soh ON sob.ID = soh.ID 
WHERE t.cVouchType = '27' -- AND sbh.cSBVCode = 'XSPP202405030001'
	AND t.cItemCode IS NULL --AND svb.cItemCode IS NOT NULL 
;
--UPDATE Ar_Detail
--SET  cItemCode = svb.cItemCode, cItemName = svb.cItemName, cItem_Class = svb.cItem_class
--FROM Ar_Detail t
--LEFT JOIN SaleBillVouchs svb ON t.iBVid = svb.AutoID 
--WHERE t.cVouchType = '27' 
--	AND t.cItemCode IS NULL 
--	AND svb.cItemCode IS NOT NULL 
--;
-- 应收明细账中的单据类型，27 销售发票，48 应收收款，49 应收付款，R0 其他应收
SELECT DISTINCT t.cVouchType 
FROM Ar_Detail t 
;
SELECT f.citemcode,f.citemname,f.citemcode FROM fitemss01 f 北京城市副中心站交通枢纽工程02标

;
-- 更新销售发票 XSPP202405030001
--UPDATE b
--SET b.cItem_class = '01',b.cItem_CName = '销售项目',b.cItemCode = '0154',b.cItemName = '北京城市副中心站交通枢纽工程02标' 
--FROM SaleBillVouchs b
--INNER JOIN SaleBillVouch h ON b.SBVID = h.SBVID 
--WHERE h.cSBVCode = 'XSPP202405030001'
--;
SELECT cItem_class,cItem_CName,cItemCode,cItemName FROM SaleBillVouchs WHERE AutoID = 1000004344;
SELECT *
FROM SaleBillVouchs b
INNER JOIN SaleBillVouch h ON b.SBVID = h.SBVID 
WHERE h.cSBVCode = 'XSPP202405030001'


-- 更新应收明细账
--UPDATE Ar_Detail SET cItem_Class = '01',cItemCode  = '0154',cItemName = '北京城市副中心站交通枢纽工程02标' WHERE cVouchID = 'XSPP202405030001'

;
-- 应收明细账
SELECT t.Auto_ID 明细账主键,t.iPeriod 期间,t.cVouchID 单据Id,t.cPerson 业务员Id,t.cCode 会计科目编码,t.cItem_Class 项目大类,t.cItemCode 项目编码,t.cItemName 项目名称,t.cDigest 摘要,t.cOrderNo 订单编号,soh.cMemo 订单备注,soh.cdefine11 订单项目编码,soh.cdefine12 订单项目名称,t.cDLCode 发货单号,dlh.cMemo 发货单备注,dlh.cDefine11 发货单表头项目编码,dlh.cDefine12 发货单表头项目名称,sbh.cDefine11 发票表头项目编码,sbh.cDefine12 发票表头项目名称,t.idlsid 发货单子表Id,t.iBVid 发票子表主键,svb.cItem_class ,svb.cItem_CName ,svb.cItemCode ,svb.cItemName  
FROM Ar_Detail t
LEFT JOIN DispatchLists dlb ON t.iDLsID = dlb.iDLsID 
LEFT JOIN DispatchList dlh ON dlb.DLID = dlh.DLID 
LEFT JOIN SaleBillVouchs svb ON t.iBVid = svb.AutoID 
LEFT JOIN SaleBillVouch sbh ON svb.SBVID = sbh.SBVID
LEFT JOIN SO_SODetails sob ON svb.iSOsID = sob.iSOsID 
LEFT JOIN SO_SOMain soh ON sob.ID = soh.ID 
WHERE t.cVouchType = '27' 
 AND sbh.cSBVCode = 'XSPP202410140012'
--AND svb.cItemCode IS NULL 
;
SELECT * FROM Ar_Detail t WHERE t.cItem_Class = '01';
--UPDATE Ar_Detail SET cItem_Class = '00' WHERE cItem_Class = '01';