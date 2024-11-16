-- 销售费用中项目明细账
SELECT t.i_id,t.iyear 年度,t.iperiod 月份,t.ino_id 凭证号,f.citemcode 项目编码,f.citemname 项目名称,t.ccode 科目编码,c.ccode_name 科目名称,t.cdigest 摘要,t.md 费用,t.cbill 制单人,r.autoID ,r.operationDate ,r.personCode ,r.personName ,r.amount ,r.remarks 
FROM gl_accvouch t
LEFT JOIN fitemss00 f ON t.citem_id = f.citemcode 
INNER JOIN code c ON t.ccode = c.ccode AND t.iyear = c.iyear 
LEFT JOIN fr_gl_personRecords r ON t.i_id = r.i_id AND r.dr = 0
WHERE LEFT(t.ccode,4) = '6601'
	AND t.cdigest <>'期间损益结转'
	AND t.citem_id = '0100001'
	AND t.iyear = 2024 AND t.iperiod = 9
;
-- 制造费用
SELECT t.iyear 年度,t.iperiod 月份,t.ino_id 凭证号,d.cDepCode 部门编码,d.cDepName 部门名称,t.ccode 科目编码,c.ccode_name 科目名称,t.cdigest 摘要,t.md 费用,t.cbill 制单人
FROM gl_accvouch t
LEFT JOIN Department d ON t.cdept_id  = d.cDepCode 
left JOIN code c ON t.ccode = c.ccode AND t.iyear = c.iyear 
WHERE LEFT(t.ccode,4) = '5101'
	AND t.cdigest <>'期间损益结转'
	AND t.iyear = 2024 AND t.iperiod IN( 5,6)