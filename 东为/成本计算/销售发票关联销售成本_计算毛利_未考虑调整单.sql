SELECT --t.cOppHead  ,sum(t.iAOutPrice)
/*t.AutoID ,t.cBusType ,t.cVouType ,*/t.iYear ,t.iMonth ,t.cVouCode 销售发票号,/*t.ID 销售发票行主键,t.iPZID 发票主键,*/t.cWhCode 仓库编码,/*t.cAccDep 部门编码,d.cDepName 部门名称,*/t.cInvCode 存货编码,i.cInvName  存货名称,i.cInvStd 规格,cu.cComUnitName 单位,t.iOutCost 发出单价,t.iAOutQuantity  发出数量 ,t.iAOutPrice  发出金额 ,sbv.iTaxUnitPrice 发票含税单价 ,sbv.iUnitPrice  发票无含税单价 , sbv.iMoney  发票无税金额, sbv.iSum 发票价税合计金额-- ,t.iPZDate 凭证日期,t.cPZtype 凭证类别,t.cPZdigest 摘要,t.cPZID ,t.iPZID ,t.cVouType ,t.cInvHead 存货科目编码,c1.ccode_name 存货科目,t.cOppHead  对方科目编码 ,c2.ccode_name 对方科目,t.cMaker 制单人  ,t.cHandler  经手人  ,t.cAccounter  记账人
FROM IA_Subsidiary t
INNER JOIN code c1 ON t.cInvHead = c1.ccode AND t.iYear = c1.iyear 
INNER JOIN code c2 ON t.cOppHead = c2.ccode AND t.iYear = c2.iyear 
INNER JOIN Inventory i ON t.cInvCode = i.cInvCode 
LEFT JOIN Department d ON t.cAccDep = d.cDepCode 
LEFT JOIN ComputationUnit cu ON i.cComUnitCode = cu.cComunitCode 
--LEFT JOIN rdrecord32 r ON t.iPZID = r.ID 
LEFT JOIN SaleBillVouchs sbv ON t.ID = sbv.AutoID 
WHERE 1=1
--AND t.cPZID = '2024IA0000000000883'
AND t.iYear = 2024 --AND t.cItemCode IS NULL 
--AND t.iMonth = 4
AND t.cBusType  IN ('普通销售')
;
-- 1000000576
SELECT *
FROM SaleBillVouchs b
INNER JOIN SaleBillVouch h ON b.SBVID = h.SBVID
WHERE h.cSBVCode = '0000000133'
;

SELECT * FROM IA_Subsidiary t