-- 销售费用中项目明细账
SELECT t.iyear 年度,t.iperiod 月份,t.ino_id 凭证号,f.citemcode 项目编码,f.citemname 项目名称,t.ccode 科目编码,c.ccode_name 科目名称,t.cdigest 摘要,t.md 费用,t.cbill 制单人
FROM gl_accvouch t
LEFT JOIN fitemss00 f ON t.citem_id = f.citemcode 
INNER JOIN code c ON t.ccode = c.ccode AND t.iyear = c.iyear 
WHERE LEFT(t.ccode,4) = '6601'
	AND t.cdigest <>'期间损益结转'
	AND t.iyear = 2024 AND t.iperiod = 3
;
-- 管理费用中项目明细账
SELECT t.iyear 年度,t.iperiod 月份,t.ino_id 凭证号,f.citemcode 项目编码,f.citemname 项目名称,t.ccode 科目编码,c.ccode_name 科目名称,t.cdigest 摘要,t.md 费用,t.cbill 制单人
FROM gl_accvouch t
LEFT JOIN fitemss00 f ON t.citem_id = f.citemcode 
INNER JOIN code c ON t.ccode = c.ccode AND t.iyear = c.iyear 
WHERE LEFT(t.ccode,4) = '6602'
	AND t.cdigest <>'期间损益结转'
	AND t.iyear = 2024 AND t.iperiod = 3