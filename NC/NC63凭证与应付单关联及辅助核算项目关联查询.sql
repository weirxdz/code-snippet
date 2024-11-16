-- NC63凭证与应付单关联及辅助核算项目关联查询
SELECT h.BILLNO ,bm.NAME ,od.NAME ,b.LOCAL_NOTAX_CR ,b.PK_DEPTID 
FROM ap_payableitem b 
LEFT JOIN BD_MARBASCLASS bm ON b.def6 = bm.PK_MARBASCLASS 
LEFT JOIN ORG_DEPT od ON b.PK_DEPTID = od.PK_DEPT 
LEFT JOIN ap_payablebill h ON b.pk_payablebill = h.pk_payablebill
LEFT JOIN fip_relation rec_relation  ON h.pk_payablebill = rec_relation.src_relationid
LEFT JOIN gl_voucher rec_voucher  ON rec_relation.des_relationid = rec_voucher.pk_voucher
WHERE rec_voucher.num = 1819 AND rec_voucher."YEAR" = 2024 AND rec_voucher.PERIOD = 5 
AND od.NAME = '美洲区' AND bm.NAME = '固态聚葡萄糖系列'
;
SELECT f.F1,od.NAME ,f.F16,bm.NAME ,gd.debitamount 
FROM gl_voucher g
INNER JOIN GL_DETAIL gd ON g.PK_VOUCHER = gd.PK_VOUCHER 
LEFT JOIN gl_docfree1 f ON gd.ASSID = f.ASSID 
LEFT JOIN ORG_DEPT od ON f.F1 = od.PK_DEPT -- 部门
LEFT JOIN BD_MARBASCLASS bm ON f.f16 = bm.PK_MARBASCLASS -- 物料基本分类
WHERE g.num = 1819 AND g."YEAR" = 2024 AND g.PERIOD = 5 
;
SELECT * FROM gl_docfree1
