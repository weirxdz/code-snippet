-- 销售费用、管理费用、财务费用 明细
SELECT --g.iflag ,
	CASE LEFT(g.ccode,4) WHEN '6601' THEN '销售费用' WHEN '6602' THEN '管理费用' WHEN '6603' THEN '财务费用' END 费用类别,g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.cdigest 摘要,f.citemcode 销售项目编码,f.citemname 销售项目名称
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('6602','6601','6603') 
	AND g.cdigest <> '期间损益结转' 
	AND g.iyear = 2024
	AND g.iperiod >= 1 AND g.iperiod <= 9
--	AND g.cdigest LIKE '%记账%'
ORDER BY g.iyear ,g.iperiod,g.ccode

;
-- 安装工资和安装费用明细
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.cdigest 摘要,f.citemcode 销售项目编码,f.citemname 销售项目名称
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE g.ccode IN ('640102','640104','640103') 
	AND g.cdigest <> '期间损益结转' 
	AND g.iyear = 2024 
	AND g.iperiod >= 1 AND g.iperiod <= 9
ORDER BY g.iyear ,g.iperiod,g.ccode
;
-- 安装工资和安装费用明细
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.cdigest 摘要,f.citemcode 销售项目编码,f.citemname 销售项目名称
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE g.ccode IN ('640103','640104') 
	AND g.cdigest <> '期间损益结转' 
	AND g.iyear = 2024 
	AND g.iperiod >= 3 AND g.iperiod = 8
ORDER BY g.iyear ,g.iperiod,g.ccode
;
-- 产品成本未对应到项目的明细
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.cdigest 摘要,f.citemcode 销售项目编码,f.citemname 销售项目名称,g.coutsysname 
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE g.ccode IN ('640101') 
	AND g.cdigest <> '期间损益结转' 
	AND g.iyear = 2024 AND g.iperiod = 9
	AND g.citem_id = '0100001'
ORDER BY g.iyear ,g.iperiod,g.ccode


--
-- 制造费用明细
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.cdigest 摘要-- ,f.citemcode 销售项目编码,f.citemname 销售项目名称
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss00 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('5101') 
--	AND g.cdigest <> '期间损益结转' 
	AND g.md <> 0
	AND g.iyear = 2024 
	AND g.iperiod >= 1 AND g.iperiod <= 9
ORDER BY g.iyear ,g.iperiod,g.ccode