
-- 费用科目凭证方向
-- 应该为借方红数，错入为贷方金额了
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.md 借方金额,g.mc 贷方金额,g.cdigest 摘要
FROM GL_accvouch g
WHERE LEFT(g.ccode,4) IN ('6601','6602','6603') AND g.cdigest <> '期间损益结转' AND g.mc <> 0
;

-- 其他业务收入科目凭证方向
-- 应该是贷方金额，错入为 借方红数了
SELECT g.iyear 年度,g.iperiod 月份,g.ino_id 凭证号,g.md 借方金额,g.mc 贷方金额,g.cdigest 摘要
FROM GL_accvouch g
WHERE g.ccode IN ('6051') AND g.cdigest <> '期间损益结转'  AND g.mc = 0
;