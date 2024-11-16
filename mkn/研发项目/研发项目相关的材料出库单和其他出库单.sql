
-- 研发支出的材料出库单
SELECT t.AutoID ,t.cBusType ,t.iYear ,t.iMonth ,t.cVouCode 出库单号,t.ID 出库单行主键,t.iPZID 出库单主键,t.cWhCode 仓库编码,t.cAccDep 部门编码,d.cDepName 部门名称,t.cInvCode 存货编码,i.cInvName  存货名称,i.cInvStd 规格,cu.cComUnitName 单位,t.iOutCost 发出单价,t.iAOutQuantity  发出数量 ,t.iAOutPrice  发出金额  ,t.iPZDate 凭证日期,t.cPZtype 凭证类别,t.cPZdigest 摘要,t.cPZID ,t.cVouType ,t.cInvHead 存货科目编码,c1.ccode_name 存货科目,t.cOppHead  对方科目编码 ,c2.ccode_name 对方科目,t.cMaker 制单人  ,t.cHandler  经手人  ,t.cAccounter  记账人   
FROM IA_Subsidiary t
INNER JOIN code c1 ON t.cInvHead = c1.ccode AND t.iYear = c1.iyear 
INNER JOIN code c2 ON t.cOppHead = c2.ccode AND t.iYear = c2.iyear 
INNER JOIN Inventory i ON t.cInvCode = i.cInvCode 
LEFT JOIN Department d ON t.cAccDep = d.cDepCode 
LEFT JOIN ComputationUnit cu ON i.cComUnitCode = cu.cComunitCode 
WHERE cvoutype = '11' AND t.cOppHead = '430102'
	AND t.iyear = 2024
	AND t.imonth >= 1 AND t.imonth <= 8
;
-- 研发支出的其他出库单
SELECT t.AutoID ,t.cBusType ,t.iYear ,t.iMonth ,t.cVouCode 出库单号,t.ID 出库单行主键,t.iPZID 出库单主键,t.cWhCode 仓库编码,t.cAccDep 部门编码,d.cDepName 部门名称,t.cInvCode 存货编码,i.cInvName  存货名称,i.cInvStd 规格,cu.cComUnitName 单位,t.iOutCost 发出单价,t.iAOutQuantity  发出数量 ,t.iAOutPrice  发出金额  ,t.iPZDate 凭证日期,t.cPZtype 凭证类别,t.cPZdigest 摘要,t.cPZID ,t.cVouType ,t.cInvHead 存货科目编码,c1.ccode_name 存货科目,t.cOppHead  对方科目编码 ,c2.ccode_name 对方科目,t.cMaker 制单人  ,t.cHandler  经手人  ,t.cAccounter  记账人   
FROM IA_Subsidiary t
INNER JOIN code c1 ON t.cInvHead = c1.ccode AND t.iYear = c1.iyear 
INNER JOIN code c2 ON t.cOppHead = c2.ccode AND t.iYear = c2.iyear 
INNER JOIN Inventory i ON t.cInvCode = i.cInvCode 
LEFT JOIN Department d ON t.cAccDep = d.cDepCode 
LEFT JOIN ComputationUnit cu ON i.cComUnitCode = cu.cComunitCode 
WHERE cvoutype = '09' AND t.cOppHead = '430102'
	AND t.iyear = 2024
	AND t.imonth >= 1 AND t.imonth <= 8
;