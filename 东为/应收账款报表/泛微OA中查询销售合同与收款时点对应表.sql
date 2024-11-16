WITH d AS (
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt1
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt3
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt5
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt7
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt9
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt11
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt13
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM formtable_main_83_dt15)
SELECT t.id, t.requestId, t.sqr, t.sqrq, t.htbh,  t.htmc,t.htje , t.htqdrq, t.htqddd, t.htksrq, t.htjsrq, t.jhrq,  t.xmbm, t.xmmc,  t.mpxq, t.khmc,t.shdz,d.cplb, d.fktj,m.name ,d.bz,d.ywbl,d.yqts,d.fkbl
FROM formtable_main_83 t
LEFT JOIN d ON t.id = d.mainid
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
;
SELECT ush.id,ush.requestId,ush.zbid,ush.htbh,ush.htmc,ush.xmbm,ush.xmmc,ush.u8xsddid,ush.u8xsddh,h.htje 
FROM ecology.dbo.uf_saleorderdetails ush
LEFT JOIN ecology.dbo.formtable_main_83 h ON ush.zbid = h.id AND ush.requestId = h.requestId 
WHERE ush.xmbm <> '0100001' AND ush.xmbm <> '0100099'
;
SELECT * FROM uf_saleorderdetails_dt2 usd 
;
SELECT h.cVouchType ,h.cVouchID ,h.cDigest ,h.cDefine11 ,h.cItemCode ,b.cXm  ,b.cItemName ,h.*
FROM Ap_CloseBill  h
INNER JOIN Ap_CloseBills b ON h.iID = b.iID 
LEFT JOIN Customer c ON h.cDwCode = c.cCusCode 
WHERE h.cFlag = 'AR' AND b.cXm <> '0100001' AND b.cXm <> '0100099'
;
-- 按项目汇总收款金额
SELECT b.cXm  ,b.cItemName ,SUM(b.iAmt) AS 收款金额
FROM Ap_CloseBill  h
INNER JOIN Ap_CloseBills b ON h.iID = b.iID 
WHERE h.cFlag = 'AR' AND b.cXm <> '0100001' AND b.cXm <> '0100099'
GROUP BY b.cXm  ,b.cItemName
;
SELECT DISTINCT cVouchType,cFlag FROM Ap_CloseBill
;;
-- 
WITH d AS (
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt1
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt3
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt5
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt7
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt9
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt11
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt13
		UNION ALL 
		SELECT id, mainid, yqts, ywbl, bz, sl, cplb, fkbl, fkje, fktj
		FROM ecology.dbo.formtable_main_83_dt15)
SELECT ush.id,ush.requestId,ush.zbid,ush.htbh,ush.htmc,ush.htqdrq ,ush.xmbm,ush.xmmc,ush.u8xsddid,ush.u8xsddh,t.htje ,d.cplb, d.fktj,m.name ,d.bz,d.ywbl,d.yqts,d.fkbl
FROM ecology.dbo.uf_saleorderdetails ush
LEFT JOIN ecology.dbo.formtable_main_83 t ON ush.zbid = t.id AND ush.requestId = t.requestId 
LEFT JOIN d ON t.id = d.mainid
LEFT JOIN ecology.dbo.mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
WHERE ush.xmbm <> '0100001' AND ush.xmbm <> '0100099'


;
SELECT d.mainid,d.id, d.cplb,d.fktj, COALESCE(d.yqts,0) yqts, COALESCE(d.ywbl,0) ywbl, COALESCE(d.fkbl,0) fkbl, COALESCE(d.fkje,0) fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt1 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
UNION all
SELECT d.mainid,d.id, d.cplb,d.fktj, d.yqts, d.ywbl, d.fkbl, d.fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt3 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
UNION all
SELECT d.mainid,d.id, d.cplb,d.fktj, d.yqts, d.ywbl, d.fkbl, d.fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt3 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
UNION all
SELECT d.mainid,d.id, d.cplb,d.fktj, d.yqts, d.ywbl, d.fkbl, d.fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt7 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
UNION all
SELECT d.mainid,d.id, d.cplb,d.fktj, d.yqts, d.ywbl, d.fkbl, d.fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt9 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
UNION all
SELECT d.mainid,d.id, d.cplb,d.fktj, d.yqts, d.ywbl, d.fkbl, d.fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt11 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
UNION all
SELECT d.mainid,d.id, d.cplb,d.fktj, d.yqts, d.ywbl, d.fkbl, d.fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt13 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
UNION all
SELECT d.mainid,d.id, d.cplb,d.fktj, d.yqts, d.ywbl, d.fkbl, d.fkje, d.sl, d.bz, 0,m.name ,''
FROM formtable_main_83_dt15 d
LEFT JOIN mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25

;
WITH d AS (
		SELECT id, mainid, htzbid, cplb, fktj, yqts, ywbl, fkbl, fkje, sl, bz, dr, fktjzbid, yssx
		FROM uf_saleorderdetails_dt1) 
SELECT ush.id,ush.requestId,ush.zbid,ush.htbh,ush.htmc,ush.htqdrq ,ush.xmbm,ush.xmmc,ush.u8xsddid,ush.u8xsddh,ush.htje ,d.cplb,s.name , d.fktj,d.fktjzbid ,d.bz,d.ywbl,d.yqts,d.fkbl,d.fkje,d.yssx
FROM ecology.dbo.uf_saleorderdetails ush
LEFT JOIN ecology.dbo.formtable_main_83 t ON ush.zbid = t.id AND ush.requestId = t.requestId 
LEFT JOIN d ON t.id = d.mainid
LEFT JOIN ecology.dbo.mode_selectitempagedetail m ON d.fktj = m.disorder AND m.mainid = 25
LEFT JOIN ecology.dbo.mode_selectitempagedetail s ON d.cplb -1 = s.disorder AND s.mainid = 24
WHERE ush.xmbm <> '0100001' AND ush.xmbm <> '0100099';

SELECT t.disorder,t.name,CONCAT(t.disorder,'   ',t.name) AS id
FROM mode_selectitempagedetail t 
WHERE t.mainid = 24
ORDER BY t.disorder
;
-- 收款节点
SELECT t.disorder,t.name ,t.*
FROM mode_selectitempagedetail t 
WHERE t.mainid = 25
ORDER BY t.disorder
;
-- 产品发货，收款节点为 1
/**
 * 关联物流发货流程
 * 按项目号关联
 * 如果项目号不对，需要修正合同上的项目号
 * 发货流程的项目号也需要修正
 */
-- 发货开始xxxxxxxxxx发货用U8的发货单
WITH d AS (
	SELECT citemid ,u8gldh ,shrq COLLATE Latin1_General_BIN AS ishrq , fhrq COLLATE Latin1_General_BIN AS  ifhrq 
	FROM formtable_main_88 h
	WHERE h.citemid IS NOT NULL AND h.citemid <> '' AND h.citemid <> '0100001'
	)
SELECT citemid ,min(ifhrq) fhrq 
FROM d 
GROUP BY citemid 
;
-- 收货
WITH d AS (
	SELECT citemid ,u8gldh ,shrq COLLATE Latin1_General_BIN AS ishrq , fhrq COLLATE Latin1_General_BIN AS  ifhrq 
	FROM formtable_main_88 h
	WHERE h.citemid IS NOT NULL AND h.citemid <> '' AND h.citemid <> '0100001'
	)
SELECT citemid ,max(ishrq) shrq 
FROM d 
GROUP BY citemid 
;
SELECT  citemid ,u8gldh ,shrq COLLATE Latin1_General_BIN AS ishrq , fhrq COLLATE Latin1_General_BIN AS  ifhrq 
	FROM formtable_main_88 h
	WHERE h.citemid IS NOT NULL AND h.citemid <> '' AND h.citemid <> '0100001'
