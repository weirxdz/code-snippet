SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.mc 贷方金额,g.cdigest 摘要,f.citemcode 销售项目编码,f.citemname 销售项目名称
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss01 f ON g.citem_id = f.citemcode 
WHERE g.ccode IN ('500103','500102','500101') 
	AND g.cdigest <> '期间损益结转' 
	AND g.iyear = 2024 
--	AND g.iperiod >= 3 AND g.iperiod = 9
	AND g.ccode = '500103'
ORDER BY g.iyear ,g.iperiod,g.ccode
;

SELECT * FROM GL_accvouch
;
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.mc 贷方金额,g.cdigest 摘要,f.citemcode 销售项目编码,f.citemname 销售项目名称
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss01 f ON g.citem_id = f.citemcode 
WHERE g.ccode IN ('540101','540102') 
	AND g.cdigest <> '期间损益结转' 
	AND g.iyear = 2024 
--	AND g.iperiod >= 3 AND g.iperiod = 9
ORDER BY g.iyear ,g.iperiod,g.ccode
;

SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.ccode 会计科目编码,c.ccode_name 科目名称,g.md 借方金额,g.mc 贷方金额,g.cdigest 摘要,f.citemcode 销售项目编码,f.citemname 销售项目名称,g.*
FROM GL_accvouch g
LEFT JOIN code c ON g.ccode = c.ccode AND g.iyear = c.iyear 
LEFT JOIN fitemss01 f ON g.citem_id = f.citemcode 
WHERE LEFT(g.ccode,4) IN ('5601') 
	AND g.cdigest <> '期间损益结转' 
	AND g.iyear = 2024 
--	AND g.iperiod >= 3 AND g.iperiod = 9
ORDER BY g.iyear ,g.iperiod,g.ccode
;
SELECT h.dVouchDate ,h.cDigest ,h.cDefine8 是否统计,h.cdefine10 ,h.cdefine11 项目编号,f.citemname 项目名称,b.iAmt  金额,h.cPZNum 
FROM Ap_CloseBills b
INNER JOIN Ap_CloseBill h ON b.iID = h.iID 
LEFT JOIN fitemss01 f ON h.cdefine11 = f.citemcode 
WHERE h.cFlag = 'AP'AND h.cdefine8 = '是' 
	AND h.cdefine11 <> '333'