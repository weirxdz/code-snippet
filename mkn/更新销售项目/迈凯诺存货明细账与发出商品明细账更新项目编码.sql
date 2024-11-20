SELECT --t.cOppHead  ,sum(t.iAOutPrice)
t.AutoID ,t.cBillCode ,t.cBusType ,t.iYear ,t.iMonth ,t.cVouCode 出库单号,t.ID 出库单行主键,t.iPZID 出库单主键,t.cWhCode 仓库编码,t.cAccDep 部门编码,d.cDepName 部门名称,t.cInvCode 存货编码,i.cInvName  存货名称,i.cInvStd 规格,cu.cComUnitName 单位,t.iOutCost 发出单价,t.iAOutQuantity  发出数量 ,t.iAOutPrice  发出金额  ,t.iPZDate 凭证日期,t.cPZtype 凭证类别,t.cPZdigest 摘要,t.cPZID ,t.iPZID ,t.cVouType ,t.cInvHead 存货科目编码,c1.ccode_name 存货科目,t.cOppHead  对方科目编码 ,c2.ccode_name 对方科目,t.cMaker 制单人  ,t.cHandler  经手人  ,t.cAccounter  记账人, r.cDefine11 ,t.cItem_class ,t.cItemCode ,t.cItemCName -- ,t.*  
FROM IA_Subsidiary t
INNER JOIN code c1 ON t.cInvHead = c1.ccode AND t.iYear = c1.iyear 
INNER JOIN code c2 ON t.cOppHead = c2.ccode AND t.iYear = c2.iyear 
INNER JOIN Inventory i ON t.cInvCode = i.cInvCode 
LEFT JOIN Department d ON t.cAccDep = d.cDepCode 
LEFT JOIN ComputationUnit cu ON i.cComUnitCode = cu.cComunitCode 
LEFT JOIN rdrecord32 r ON t.iPZID = r.ID 
WHERE 1=1
--AND t.cPZID = '2024IA0000000000883'
AND t.iYear = 2024 AND 
--AND t.cpzid = '2024IA0000000001938'
--AND t.iMonth = 4
--AND t.cBusType  IN ('普通销售')
;
SELECT DISTINCT t.cBusType FROM IA_Subsidiary t;
--XSPP202405030001
;
SELECT --t.cOppHead  ,sum(t.iAOutPrice)
t.AutoID ,t.cBusType ,t.iYear ,t.iMonth ,t.cVouCode 出库单号,t.ID 出库单行主键,t.iPZID 出库单主键,t.cWhCode 仓库编码,t.cAccDep 部门编码,d.cDepName 部门名称,t.cInvCode 存货编码,i.cInvName  存货名称,i.cInvStd 规格,cu.cComUnitName 单位,t.iOutCost 发出单价,t.iAOutQuantity  发出数量 ,t.iAOutPrice  发出金额  ,t.iPZDate 凭证日期,t.cPZtype 凭证类别,t.cPZdigest 摘要,t.cPZID ,t.iPZID ,t.cVouType ,t.cInvHead 存货科目编码,c1.ccode_name 存货科目,t.cOppHead  对方科目编码 ,c2.ccode_name 对方科目,t.cMaker 制单人  ,t.cHandler  经手人  ,t.cAccounter  记账人, r.cDefine11 ,t.cItem_class ,t.cItemCode ,t.cItemCName -- ,t.*  
FROM IA_Subsidiary t
INNER JOIN code c1 ON t.cInvHead = c1.ccode AND t.iYear = c1.iyear 
INNER JOIN code c2 ON t.cOppHead = c2.ccode AND t.iYear = c2.iyear 
INNER JOIN Inventory i ON t.cInvCode = i.cInvCode 
LEFT JOIN Department d ON t.cAccDep = d.cDepCode 
LEFT JOIN ComputationUnit cu ON i.cComUnitCode = cu.cComunitCode 
LEFT JOIN rdrecord32 r ON t.iPZID = r.ID 
WHERE 1=1
--AND t.cPZID = '2024IA0000000000883'
AND t.iYear = 2024 AND t.cItemCode IS NULL 
--AND t.iMonth = 4
AND t.cBusType  IN ('普通销售')
;
SELECT * FROM IA_Subsidiary t WHERE t.cBusCode = 'XSPP202405030001';
SELECT sbv.SBVID FROM SaleBillVouch sbv WHERE sbv.cSBVCode = 'XSPP202405030001';
SELECT t.AutoID FROM SaleBillVouchs t WHERE t.SBVID  = '1000000342';
SELECT   t.cSrcVouType , t.cBusCode ,t.cBillCode,t.InID , t.OutID ,t.iEnID ,t.cItemCode,t.cItem_class,t.cItemCName  FROM IA_EnSubsidiary t WHERE t.OutID IS NOT NULL AND t.iEnID = '1000000342';
-- UPDATE IA_EnSubsidiary SET cItem_class = '01',cItemCode = '0154' WHERE iEnID = '1000000342' AND cVouCode = 'XSPP202405030001'
--UPDATE t 
--SET t.cItem_class = '01',t.cItemCName = '销售项目',t.cItemCode = b.cItemCode 
--FROM IA_EnSubsidiary t
--LEFT JOIN SaleBillVouchs b ON t.OutID = b.AutoID AND t.iEnID = b.SBVID 
--WHERE t.iEnID IS NOT NULL -- AND t.cItemCode IS NULL 
--;
--UPDATE t 
--SET t.cName = f.citemname 
--FROM IA_EnSubsidiary t
--LEFT JOIN fitemss01 f ON t.cItemCode = f.citemcode 
--WHERE t.iEnID IS NOT NULL 
--;

SELECT t.cSrcVouType , t.cBusCode ,t.cBillCode,t.InID , t.OutID ,t.iEnID ,t.cItemCode,t.cItem_class,t.cItemCName ,t.cName ,b.AutoID ,b.SBVID ,b.cItemCode ,b.cItem_class ,b.cItemName ,b.cItem_CName 
FROM IA_EnSubsidiary t
inner JOIN SaleBillVouchs b ON t.OutID = b.AutoID AND t.iEnID = b.SBVID 
WHERE t.cItemCode IS NULL --AND b.cItemCode IS NOT NULL 
;
--UPDATE IA_EnSubsidiary 
--SET cItemCode = b.cItemCode ,cName = b.cItemName, cItem_class = b.cItem_class ,cItemCName = b.cItem_CName 
--FROM IA_EnSubsidiary t
--inner JOIN SaleBillVouchs b ON t.OutID = b.AutoID AND t.iEnID = b.SBVID 
--WHERE t.cItemCode IS NULL AND b.cItemCode IS NOT NULL 
;
SELECT * FROM IA_EnSubsidiary WHERE cItem_class = '00'
;
SELECT * FROM IA_Subsidiary WHERE cItem_class = '01';
--UPDATE IA_EnSubsidiary SET cItem_class = '00' WHERE cItem_class = '01'
--UPDATE IA_Subsidiary SET cItem_class = '00' WHERE cItem_class = '01'
