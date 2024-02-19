-- 凭证信息查询语句
select a.pk_org,b.code,b.name,a.year 年度,a.period 期间,c.name 凭证类别,a.prepareddate 制单日期,a.num 凭证号,
a.CREATOR 创建人ID,d.USER_NAME 创建人,a.PK_PREPARED 制单人id,e.user_name 制单人,a.MODIFIER 修改人ID,F.user_name 修改人,
a.PK_CHECKED 审核人ID，g.user_name 审核人,a.PK_MANAGER 记账人id,h.user_name 记账人
from Gl_voucher a
inner join gl_detail t 
left join org_orgs b on b.pk_org=A.PK_ORG
left join bd_vouchertype c on c.pk_vouchertype=a.pk_vouchertype
left join sm_user d on a.CREATOR=D.CUSERID
left join sm_user E on a.PK_PREPARED=E.CUSERID
left join sm_user F on a.MODIFIER=F.CUSERID
left join sm_user G on a.PK_CHECKED=G.CUSERID
left join sm_user h on a.PK_MANAGER=h.cuserid
where a.pk_org in (select pk_org from org_orgs where code='blb01') and a.period<>'00' 
order by a.year,a.period,a.num;

SELECT ADDCLASS, ADJUSTPERIOD, APPROVER, ATTACHMENT, BILLMAKER, CHECKEDDATE, CONTRASTFLAG, CONVERTFLAG, CREATIONTIME, CREATOR, DELETECLASS, DETAILMODFLAG, DISCARDFLAG, DR, ERRMESSAGE, ERRMESSAGEH, EXPLANATION, FREE1, FREE10, FREE2, FREE3, FREE4, FREE5, FREE6, FREE7, FREE8, FREE9, ISDIFFLAG, MODIFIEDTIME, MODIFIER, MODIFYCLASS, MODIFYFLAG, NUM, OFFERVOUCHER, PERIOD, PK_ACCOUNTINGBOOK, PK_CASHER, PK_CHECKED, PK_GROUP, PK_MANAGER, PK_ORG, PK_ORG_V, PK_PREPARED, PK_SETOFBOOK, PK_SOURCEPK, PK_SYSTEM, PK_VOUCHER, PK_VOUCHERTYPE, PREACCOUNTFLAG, PREPAREDDATE, SIGNDATE, SIGNFLAG, TALLYDATE, TEMPSAVEFLAG, TOTALCREDIT, TOTALCREDITGLOBAL, TOTALCREDITGROUP, TOTALDEBIT, TOTALDEBITGLOBAL, TOTALDEBITGROUP, TS, VOUCHERKIND, "YEAR"
FROM GL_VOUCHER;
SELECT ACCOUNTCODE, ADJUSTPERIOD, ASSID, BANKACCOUNT, BILLTYPE, BUSIRECONNO, CHECKDATE, CHECKNO, CHECKSTYLE, CONTRASTFLAG, CONVERTFLAG, CREDITAMOUNT, CREDITQUANTITY, DEBITAMOUNT, DEBITQUANTITY, DETAILINDEX, DIRECTION, DISCARDFLAGV, DR, ERRMESSAGE, ERRMESSAGE2, ERRMESSAGEH, EXCRATE1, EXCRATE2, EXCRATE3, EXCRATE4, EXPLANATION, FRACCREDITAMOUNT, FRACDEBITAMOUNT, FREE1, FREE10, FREE2, FREE3, FREE4, FREE5, FREE6, FREE7, FREE8, FREE9, GLOBALCREDITAMOUNT, GLOBALDEBITAMOUNT, GROUPCREDITAMOUNT, GROUPDEBITAMOUNT, INNERBUSDATE, INNERBUSNO, ISDIFFLAG, LOCALCREDITAMOUNT, LOCALDEBITAMOUNT, MODIFYFLAG, NETBANKFLAG, NOV, OPPOSITESUBJ, PERIODV, PK_ACCASOA, PK_ACCCHART, PK_ACCOUNT, PK_ACCOUNTINGBOOK, PK_CURRTYPE, PK_DETAIL, PK_GROUP, PK_INNERORG, PK_INNERSOB, PK_MANAGERV, PK_OFFERDETAIL, PK_ORG, PK_ORG_V, PK_OTHERCORP, PK_OTHERORGBOOK, PK_PREPAREDV, PK_SETOFBOOK, PK_SOURCEPK, PK_SYSTEMV, PK_UNIT, PK_UNIT_V, PK_VOUCHER, PK_VOUCHERTYPEV, PREPAREDDATEV, PRICE, RECIEPTCLASS, SIGNDATEV, TEMPSAVEFLAG, TS, UNITNAME, VERIFYDATE, VERIFYNO, VOUCHERKINDV, YEARV
FROM GL_DETAIL;

SELECT * FROM gl_freevalue;
SELECT * FROM gl_docfree1;

SELECT t.freevalueid freevalueid, t.valuecode valuecode, t. valuename FROM gl_freevalue t
;

SELECT b.pk_accasoa pk_accasoa, h.pk_org pk_org, h.period period, h.year iyear, substr(h.prepareddate, 1, 10) prepareddate, h.num num, h.pk_vouchertype pk_vouchertype, b.direction direction, decode(b.direction, 'D', b.pk_accasoa, '') pk_accasoa_d, decode(b.direction, 'C', b.pk_accasoa, '') pk_accasoa_c, b.detailindex detailindex, b.explanation explanation, b.localdebitamount localdebitamount, b.localcreditamount localcreditamount, h.pk_setofbook pk_setofbook 
FROM gl_detail b 
LEFT JOIN gl_voucher h ON (b.pk_voucher = h.pk_voucher)

;
-- 凭证取费用科目发生
SELECT  org.code 组织编码,org.name 组织名称,org_dept_v.code 部门编码,org_dept_v.name 部门名称,glvou.num 凭证号,gl.yearv 年度, gl.periodv 月份, smuser.user_name 制单人,glvou.pk_system 制单系统,glvou.discardflag 作废标识,accsubj.code 科目编码,a.name 科目名称,CASE WHEN a.def1 = '~' THEN a.name else a.def1 end 预算项目,CASE WHEN a.def2 = '~' THEN a.name else a.def2 end 预算控制项目,gl.creditamount 贷方金额,gl.debitamount 借方金额,
CASE WHEN accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306') THEN gl.creditamount ELSE gl.debitamount  END AS 费用发生额
FROM gl_docfree1 
INNER JOIN org_dept_v  ON gl_docfree1.f1=org_dept_v.pk_dept 
INNER JOIN org_orgs_v org ON org.pk_org=org_dept_v.pk_org 
INNER JOIN org_group grp ON grp.pk_group=gl_docfree1.pk_group AND grp.pk_group=org_dept_v.pk_group
Inner JOIN gl_detail gl ON gl.assid=gl_docfree1.assid
INNER JOIN bd_account accsubj ON accsubj.pk_account=gl.pk_account
INNER JOIN bd_accasoa a ON accsubj.PK_ACCOUNT = a.pk_account
INNER JOIN gl_voucher glvou ON glvou.pk_voucher=gl.pk_voucher
inner join sm_user smuser on smuser.cuserid=glvou.billmaker
WHERE gl_docfree1.f1<>'NN/A' AND gl_docfree1.f1<>'~'
 AND nvl(org_dept_v.dr,0)=0 AND nvl(gl_docfree1.dr,0)=0
 AND nvl(org.dr,0)=0 AND nvl(grp.dr,0)=0
 AND nvl(gl.dr,0)=0 AND nvl(accsubj.dr,0)=0
 AND glvou.discardflag='N'
 AND gl.yearv>=2015 AND gl.periodv>'00'
 AND substr(accsubj.code,1,4) IN ('5101','5301','6601','6602')
 ;
-- 凭证取费用科目发生汇总
SELECT  org.code 组织编码,org.name 组织名称,org_dept_v.code 部门编码,org_dept_v.name 部门名称,CASE WHEN a.def1 = '~' THEN a.name else a.def1 end 预算项目,CASE WHEN a.def2 = '~' THEN a.name else a.def2 end 预算控制项目,
sum(CASE WHEN accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306') THEN gl.creditamount ELSE gl.debitamount  END) AS 费用发生额
FROM gl_docfree1 
INNER JOIN org_dept_v  ON gl_docfree1.f1=org_dept_v.pk_dept 
INNER JOIN org_orgs_v org ON org.pk_org=org_dept_v.pk_org 
INNER JOIN org_group grp ON grp.pk_group=gl_docfree1.pk_group AND grp.pk_group=org_dept_v.pk_group
Inner JOIN gl_detail gl ON gl.assid=gl_docfree1.assid
INNER JOIN bd_account accsubj ON accsubj.pk_account=gl.pk_account
INNER JOIN bd_accasoa a ON accsubj.PK_ACCOUNT = a.pk_account
INNER JOIN gl_voucher glvou ON glvou.pk_voucher=gl.pk_voucher
inner join sm_user smuser on smuser.cuserid=glvou.billmaker
WHERE gl_docfree1.f1<>'NN/A' AND gl_docfree1.f1<>'~'
 AND nvl(org_dept_v.dr,0)=0 AND nvl(gl_docfree1.dr,0)=0
 AND nvl(org.dr,0)=0 AND nvl(grp.dr,0)=0
 AND nvl(gl.dr,0)=0 AND nvl(accsubj.dr,0)=0
 AND glvou.discardflag='N'
 AND gl.yearv>=2015 AND gl.periodv>'00'
 AND substr(accsubj.code,1,4) IN ('5101','5301','6601','6602')
GROUP BY org.code ,org.name ,org_dept_v.code ,org_dept_v.name ,CASE WHEN a.def1 = '~' THEN a.name else a.def1 end ,CASE WHEN a.def2 = '~' THEN a.name else a.def2 end 
;

SELECT * FROM ORG_DEPT od WHERE od.PK_DEPT = '1001B31000000003C75T'
;


;
SELECT DISTINCT pk_system FROM gl_voucher WHERE dr = 0
 ;
-- 报销单
SELECT  CASE WHEN org_dept.def3 = '~' THEN  org_financeorg.name ELSE org_dept.def3 END  组织名称,CASE WHEN org_dept.def4 = '~' THEN  org_dept.name ELSE org_dept.def4 END 部门名称, bd_inoutbusiclass.code 收支项目编码, bd_inoutbusiclass.name 收支项目名称,CASE WHEN bd_inoutbusiclass.def1 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def1 END  预算项目, CASE WHEN bd_inoutbusiclass.def2 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def2 END  预算控制项目, substr(er_bxzb.djrq, 1, 4) 年度, substr(er_bxzb.djrq, 6, 2) 月份, substr(er_bxzb.djrq, 1, 10) 单据日期, substr(er_bxzb.djrq,9,2) djrq_day,er_busitem.amount 费用发生额,er_busitem.BBYE 费用余额,er_bxzb.DJBH 
FROM er_busitem er_busitem 
LEFT JOIN er_reimtype er_reimtype ON er_busitem.pk_reimtype = er_reimtype.pk_reimtype 
LEFT JOIN bd_inoutbusiclass bd_inoutbusiclass ON er_busitem.szxmid = bd_inoutbusiclass.pk_inoutbusiclass 
INNER JOIN er_bxzb er_bxzb ON er_busitem.pk_jkbx = er_bxzb.pk_jkbx 
LEFT JOIN org_financeorg org_financeorg ON er_bxzb.pk_org = org_financeorg.pk_financeorg 
LEFT JOIN org_group org_group ON org_financeorg.pk_group = org_group.pk_group 
LEFT JOIN org_dept org_dept ON er_bxzb.fydeptid  = org_dept.pk_dept 
LEFT JOIN fip_relation r ON er_bxzb.PK_JKBX = SUBSTR(r.src_relationid,1,20) AND r.src_system  = 'erm' AND er_bxzb.DJBH = r.SRC_FREEDEF1 
WHERE er_busitem.dr = 0 -- er_bxzb.fydeptid <> '1001B31000000003C75T' -- 公共费用分摊部门的报销单到结转单取数;这个条件没用了；有一个"公司行政费用"的部门破坏规则了
	AND r.DES_BILLTYPE IS NULL 
	AND bd_inoutbusiclass.code NOT IN ('67')
	AND er_bxzb.PK_JKBX NOT IN (SELECT DISTINCT pk_jkbx FROM er_cshare_detail )
	AND substr(er_bxzb.djrq, 1, 10) >= '${STARTDATE}'
	AND substr(er_bxzb.djrq, 1, 10) <= '${ENDDATE}'
UNION ALL 
-- 费用结转
SELECT  CASE WHEN org_dept.def3 = '~' THEN  org_financeorg.name ELSE org_dept.def3 END  组织名称,CASE WHEN org_dept.def4 = '~' THEN  org_dept.name ELSE org_dept.def4 END  部门名称,bd_inoutbusiclass.code 收支项目编码, bd_inoutbusiclass.name 收支项目名称,CASE WHEN bd_inoutbusiclass.def1 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def1 END  预算项目, CASE WHEN bd_inoutbusiclass.def2 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def2 END  预算控制项目, substr(er_bxzb.djrq, 1, 4) 年度, substr(er_bxzb.djrq, 6, 2) 月份, substr(er_bxzb.djrq, 1, 10) 单据日期, substr(er_bxzb.djrq, 9, 2) djrq_day, er_busitem.assume_amount  费用发生额,er_busitem.assume_amount  费用余额,
 er_bxzb.djbh djbh 
FROM er_cshare_detail er_busitem 
LEFT JOIN bd_inoutbusiclass bd_inoutbusiclass ON er_busitem.pk_iobsclass  = bd_inoutbusiclass.pk_inoutbusiclass 
INNER JOIN er_bxzb er_bxzb ON er_busitem.pk_jkbx = er_bxzb.pk_jkbx 
LEFT JOIN org_financeorg org_financeorg ON er_bxzb.pk_org = org_financeorg.pk_financeorg 
LEFT JOIN org_group org_group ON org_financeorg.pk_group = org_group.pk_group 
LEFT JOIN org_dept org_dept ON er_busitem.assume_dept = org_dept.pk_dept -- 费用承担部门
LEFT JOIN fip_relation r ON er_bxzb.PK_JKBX = SUBSTR(r.src_relationid,1,20) AND r.src_system  = 'erm' AND er_bxzb.DJBH = r.SRC_FREEDEF1 
WHERE er_busitem.dr = 0 --er_bxzb.fydeptid = '1001B31000000003C75T' -- 公共费用分摊部门的报销单到结转单取数;这个条件没用了；有一个"公司行政费用"的部门破坏规则了
	AND r.DES_BILLTYPE IS NULL 
	AND bd_inoutbusiclass.code NOT IN ('67')	
	AND substr(er_bxzb.djrq, 1, 10) >= '${STARTDATE}'
	AND substr(er_bxzb.djrq, 1, 10) <= '${ENDDATE}'
UNION ALL 
-- 借款单
SELECT  CASE WHEN org_dept.def3 = '~' THEN  org_financeorg.name ELSE org_dept.def3 END  组织名称,CASE WHEN org_dept.def4 = '~' THEN  org_dept.name ELSE org_dept.def4 END  部门名称,bd_inoutbusiclass.code 收支项目编码, bd_inoutbusiclass.name 收支项目名称,CASE WHEN bd_inoutbusiclass.def1 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def1 END  预算项目, CASE WHEN bd_inoutbusiclass.def2 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def2 END  预算控制项目, substr(er_bxzb.djrq, 1, 4) 年度, substr(er_bxzb.djrq, 6, 2) 月份, substr(er_bxzb.djrq, 1, 10) 单据日期, substr(er_bxzb.djrq,9,2) djrq_day,er_busitem.amount 费用发生额,er_busitem.BBYE 费用余额, er_bxzb.djbh djbh 
FROM er_busitem er_busitem 
LEFT JOIN er_reimtype er_reimtype ON er_busitem.pk_reimtype = er_reimtype.pk_reimtype 
LEFT JOIN bd_inoutbusiclass bd_inoutbusiclass ON er_busitem.szxmid = bd_inoutbusiclass.pk_inoutbusiclass 
INNER JOIN ER_JKZB er_bxzb ON er_busitem.pk_jkbx = er_bxzb.pk_jkbx 
LEFT JOIN org_financeorg org_financeorg ON er_bxzb.pk_org = org_financeorg.pk_financeorg 
LEFT JOIN org_group org_group ON org_financeorg.pk_group = org_group.pk_group 
LEFT JOIN org_dept org_dept ON er_bxzb.deptid = org_dept.pk_dept 
WHERE er_busitem.dr = 0	
	AND er_busitem.BBYE <> 0
	AND substr(er_bxzb.djrq, 1, 10) >= '${STARTDATE}'
	AND substr(er_bxzb.djrq, 1, 10) <= '${ENDDATE}'
UNION ALL
-- 凭证取费用科目发生汇总
SELECT CASE WHEN org_dept_v.def3 = '~' THEN  org.name ELSE org_dept_v.def3 END  组织名称,CASE WHEN org_dept_v.def4 = '~' THEN  org_dept_v.name ELSE org_dept_v.def4 END  部门名称,accsubj.code 收支项目编码, a.name 收支项目名称,CASE WHEN a.def1 = '~' THEN a.name ELSE a.def1 END  预算项目, CASE WHEN a.def2 = '~' THEN a.name ELSE a.def2 END  预算控制项目, gl.yearv 年度, gl.periodv 月份, substr(glvou.prepareddate, 1, 10) 单据日期, substr(glvou.prepareddate,9,2) djrq_day,CASE WHEN accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306') THEN gl.creditamount ELSE gl.debitamount  END 费用发生额,CASE WHEN accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306') THEN gl.creditamount ELSE gl.debitamount  END 费用余额, gl.yearv||gl.periodv||glvou.num  djbh 
FROM gl_docfree1 
INNER JOIN org_dept_v  ON gl_docfree1.f1=org_dept_v.pk_dept 
INNER JOIN org_orgs_v org ON org.pk_org=org_dept_v.pk_org 
INNER JOIN org_group grp ON grp.pk_group=gl_docfree1.pk_group AND grp.pk_group=org_dept_v.pk_group
Inner JOIN gl_detail gl ON gl.assid=gl_docfree1.assid
INNER JOIN bd_account accsubj ON accsubj.pk_account=gl.pk_account
INNER JOIN bd_accasoa a ON accsubj.PK_ACCOUNT = a.pk_account
INNER JOIN gl_voucher glvou ON glvou.pk_voucher=gl.pk_voucher
inner join sm_user smuser on smuser.cuserid=glvou.billmaker
WHERE gl_docfree1.f1<>'NN/A' AND gl_docfree1.f1<>'~'
	AND nvl(org_dept_v.dr,0)=0 AND nvl(gl_docfree1.dr,0)=0
	AND nvl(org.dr,0)=0 AND nvl(grp.dr,0)=0
	AND nvl(gl.dr,0)=0 AND nvl(accsubj.dr,0)=0
	AND glvou.discardflag='N'
	AND gl.yearv>=2015 AND gl.periodv > '00' AND gl.periodv <= '12'
	AND substr(accsubj.code,1,4) IN ('5101','5301','6601','6602') 
	AND substr(glvou.prepareddate, 1, 10) >= '${STARTDATE}'
	AND substr(glvou.prepareddate, 1, 10) <= '${ENDDATE}'
;
-- 费用分摊表
SELECT * FROM er_cshare_detail
;



;
SELECT DISTINCT  t.dr,t.*--,substr(t.src_relationid,1,20)
FROM fip_relation t
WHERE t.dr = 0 
	AND t. src_system  = 'erm'
	AND t.SRC_FREEDEF1 = '264X2023081001726'
--	AND t.src_relationid = '1001B31000000000ONJG_1'
--ORDER BY t.src_relationid
;
SELECT t.DJBH  FROM ER_BXZB t WHERE t.PK_JKBX = '1001B31000000000ONJG'

;
--DROP TABLE budget_fee_2024;
CREATE TABLE budget_fee_2024 (
	id NUMBER PRIMARY KEY,
    category_class VARCHAR2(20) NOT NULL,
    cost_center VARCHAR2(20) NOT NULL,
    business_unit VARCHAR2(20) NOT NULL,
    division VARCHAR2(20) NOT NULL,
    dept VARCHAR2(30) NOT NULL,    
    category VARCHAR2(50) NOT NULL,
    iyear VARCHAR2(4) NOT NULL,    
    imonth VARCHAR2(2) NOT NULL,
    amount NUMBER(10, 2) NOT NULL,
    tatol_amount NUMBER(10, 2) NOT NULL
);
CREATE SEQUENCE budget_fee_2024_id_seq
START WITH 1
INCREMENT BY 1
;
CREATE TRIGGER budget_fee_2024_id_seq
BEFORE INSERT ON budget_fee_2024
FOR EACH ROW
BEGIN
    SELECT budget_fee_2024_id_seq.NEXTVAL INTO :new.id FROM dual;
END;

WITH X AS (
		-- 报销单
		SELECT  CASE WHEN org_dept.def3 = '~' THEN  org_financeorg.name ELSE org_dept.def3 END  组织名称,CASE WHEN org_dept.def4 = '~' THEN  org_dept.name ELSE org_dept.def4 END 部门名称, bd_inoutbusiclass.code 收支项目编码, bd_inoutbusiclass.name 收支项目名称,CASE WHEN bd_inoutbusiclass.def1 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def1 END  预算项目, CASE WHEN bd_inoutbusiclass.def2 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def2 END  预算控制项目, substr(er_bxzb.djrq, 1, 4) 年度, substr(er_bxzb.djrq, 6, 2) 月份, substr(er_bxzb.djrq, 1, 10) 单据日期, substr(er_bxzb.djrq,9,2) djrq_day,er_busitem.amount 费用发生额,er_busitem.BBYE 费用余额,er_bxzb.DJBH 
		FROM er_busitem er_busitem 
		LEFT JOIN er_reimtype er_reimtype ON er_busitem.pk_reimtype = er_reimtype.pk_reimtype 
		LEFT JOIN bd_inoutbusiclass bd_inoutbusiclass ON er_busitem.szxmid = bd_inoutbusiclass.pk_inoutbusiclass 
		INNER JOIN er_bxzb er_bxzb ON er_busitem.pk_jkbx = er_bxzb.pk_jkbx 
		LEFT JOIN org_financeorg org_financeorg ON er_bxzb.pk_org = org_financeorg.pk_financeorg 
		LEFT JOIN org_group org_group ON org_financeorg.pk_group = org_group.pk_group 
		LEFT JOIN org_dept org_dept ON er_bxzb.fydeptid  = org_dept.pk_dept 
		LEFT JOIN fip_relation r ON er_bxzb.PK_JKBX = SUBSTR(r.src_relationid,1,20) AND r.src_system  = 'erm' AND er_bxzb.DJBH = r.SRC_FREEDEF1 
		WHERE er_busitem.dr = 0 -- er_bxzb.fydeptid <> '1001B31000000003C75T' -- 公共费用分摊部门的报销单到结转单取数;这个条件没用了；有一个"公司行政费用"的部门破坏规则了
			AND r.DES_BILLTYPE IS NULL 
			AND bd_inoutbusiclass.code NOT IN ('67')
			AND er_bxzb.PK_JKBX NOT IN (SELECT DISTINCT pk_jkbx FROM er_cshare_detail )
			AND org_financeorg.NAME = '保龄宝生物股份有限公司本部'
			AND substr(er_bxzb.djrq, 1, 10) >= '${STARTDATE}'
			AND substr(er_bxzb.djrq, 1, 10) <= '${ENDDATE}'
		UNION ALL 
		-- 费用结转
		SELECT  CASE WHEN org_dept.def3 = '~' THEN  org_financeorg.name ELSE org_dept.def3 END  组织名称,CASE WHEN org_dept.def4 = '~' THEN  org_dept.name ELSE org_dept.def4 END  部门名称,bd_inoutbusiclass.code 收支项目编码, bd_inoutbusiclass.name 收支项目名称,CASE WHEN bd_inoutbusiclass.def1 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def1 END  预算项目, CASE WHEN bd_inoutbusiclass.def2 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def2 END  预算控制项目, substr(er_bxzb.djrq, 1, 4) 年度, substr(er_bxzb.djrq, 6, 2) 月份, substr(er_bxzb.djrq, 1, 10) 单据日期, substr(er_bxzb.djrq, 9, 2) djrq_day, er_busitem.assume_amount  费用发生额,er_busitem.assume_amount  费用余额,
		 er_bxzb.djbh djbh 
		FROM er_cshare_detail er_busitem 
		LEFT JOIN bd_inoutbusiclass bd_inoutbusiclass ON er_busitem.pk_iobsclass  = bd_inoutbusiclass.pk_inoutbusiclass 
		INNER JOIN er_bxzb er_bxzb ON er_busitem.pk_jkbx = er_bxzb.pk_jkbx 
		LEFT JOIN org_financeorg org_financeorg ON er_bxzb.pk_org = org_financeorg.pk_financeorg 
		LEFT JOIN org_group org_group ON org_financeorg.pk_group = org_group.pk_group 
		LEFT JOIN org_dept org_dept ON er_busitem.assume_dept = org_dept.pk_dept -- 费用承担部门
		LEFT JOIN fip_relation r ON er_bxzb.PK_JKBX = SUBSTR(r.src_relationid,1,20) AND r.src_system  = 'erm' AND er_bxzb.DJBH = r.SRC_FREEDEF1 
		WHERE er_busitem.dr = 0 --er_bxzb.fydeptid = '1001B31000000003C75T' -- 公共费用分摊部门的报销单到结转单取数;这个条件没用了；有一个"公司行政费用"的部门破坏规则了
			AND r.DES_BILLTYPE IS NULL 
			AND bd_inoutbusiclass.code NOT IN ('67')	
			AND org_financeorg.NAME = '保龄宝生物股份有限公司本部'
			AND substr(er_bxzb.djrq, 1, 10) >= '${STARTDATE}'
			AND substr(er_bxzb.djrq, 1, 10) <= '${ENDDATE}'
		UNION ALL 
		-- 借款单
		SELECT  CASE WHEN org_dept.def3 = '~' THEN  org_financeorg.name ELSE org_dept.def3 END  组织名称,CASE WHEN org_dept.def4 = '~' THEN  org_dept.name ELSE org_dept.def4 END  部门名称,bd_inoutbusiclass.code 收支项目编码, bd_inoutbusiclass.name 收支项目名称,CASE WHEN bd_inoutbusiclass.def1 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def1 END  预算项目, CASE WHEN bd_inoutbusiclass.def2 = '~' THEN bd_inoutbusiclass.name ELSE bd_inoutbusiclass.def2 END  预算控制项目, substr(er_bxzb.djrq, 1, 4) 年度, substr(er_bxzb.djrq, 6, 2) 月份, substr(er_bxzb.djrq, 1, 10) 单据日期, substr(er_bxzb.djrq,9,2) djrq_day,er_busitem.amount 费用发生额,er_busitem.BBYE 费用余额, er_bxzb.djbh djbh 
		FROM er_busitem er_busitem 
		LEFT JOIN er_reimtype er_reimtype ON er_busitem.pk_reimtype = er_reimtype.pk_reimtype 
		LEFT JOIN bd_inoutbusiclass bd_inoutbusiclass ON er_busitem.szxmid = bd_inoutbusiclass.pk_inoutbusiclass 
		INNER JOIN ER_JKZB er_bxzb ON er_busitem.pk_jkbx = er_bxzb.pk_jkbx 
		LEFT JOIN org_financeorg org_financeorg ON er_bxzb.pk_org = org_financeorg.pk_financeorg 
		LEFT JOIN org_group org_group ON org_financeorg.pk_group = org_group.pk_group 
		LEFT JOIN org_dept org_dept ON er_bxzb.deptid = org_dept.pk_dept 
		WHERE er_busitem.dr = 0	
			AND er_busitem.BBYE <> 0
			AND org_financeorg.NAME = '保龄宝生物股份有限公司本部'
			AND substr(er_bxzb.djrq, 1, 10) >= '${STARTDATE}'
			AND substr(er_bxzb.djrq, 1, 10) <= '${ENDDATE}'
		UNION ALL
		-- 凭证取费用科目发生汇总
		SELECT CASE WHEN org_dept_v.def3 = '~' THEN  org.name ELSE org_dept_v.def3 END  组织名称,CASE WHEN org_dept_v.def4 = '~' THEN  org_dept_v.name ELSE org_dept_v.def4 END  部门名称,accsubj.code 收支项目编码, a.name 收支项目名称,CASE WHEN a.def1 = '~' THEN a.name ELSE a.def1 END  预算项目, CASE WHEN a.def2 = '~' THEN a.name ELSE a.def2 END  预算控制项目, gl.yearv 年度, gl.periodv 月份, substr(glvou.prepareddate, 1, 10) 单据日期, substr(glvou.prepareddate,9,2) djrq_day,CASE WHEN accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306') THEN gl.creditamount ELSE gl.debitamount  END 费用发生额,CASE WHEN accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306') THEN gl.creditamount ELSE gl.debitamount  END 费用余额, gl.yearv||gl.periodv||glvou.num  djbh 
		FROM gl_docfree1 
		INNER JOIN org_dept_v  ON gl_docfree1.f1=org_dept_v.pk_dept 
		INNER JOIN org_orgs_v org ON org.pk_org=org_dept_v.pk_org 
		INNER JOIN org_group grp ON grp.pk_group=gl_docfree1.pk_group AND grp.pk_group=org_dept_v.pk_group
		Inner JOIN gl_detail gl ON gl.assid=gl_docfree1.assid
		INNER JOIN bd_account accsubj ON accsubj.pk_account=gl.pk_account
		INNER JOIN bd_accasoa a ON accsubj.PK_ACCOUNT = a.pk_account
		INNER JOIN gl_voucher glvou ON glvou.pk_voucher=gl.pk_voucher
		inner join sm_user smuser on smuser.cuserid=glvou.billmaker
		WHERE gl_docfree1.f1<>'NN/A' AND gl_docfree1.f1<>'~'
			AND nvl(org_dept_v.dr,0)=0 AND nvl(gl_docfree1.dr,0)=0
			AND nvl(org.dr,0)=0 AND nvl(grp.dr,0)=0
			AND nvl(gl.dr,0)=0 AND nvl(accsubj.dr,0)=0
			AND glvou.discardflag='N'
			AND org.NAME = '保龄宝生物股份有限公司本部'
			AND gl.yearv>=2015 AND gl.periodv > '00' AND gl.periodv <= '12'
			AND substr(accsubj.code,1,4) IN ('5101','5301','6601','6602') 
			AND substr(glvou.prepareddate, 1, 10) >= '${STARTDATE}'
			AND substr(glvou.prepareddate, 1, 10) <= '${ENDDATE}'
	)
SELECT T.CATEGORY_CLASS, T.COST_CENTER, T.BUSINESS_UNIT, T.DIVISION, T.DEPT, T.CATEGORY, SUM(T.AMOUNT) AS AMOUNT ,SUM(NVL(X.费用余额,0))
FROM BUDGET_FEE_2024 T
LEFT JOIN X ON T.CATEGORY = X.预算项目 AND T.DEPT = X.部门名称
WHERE T.IYEAR = substr('${ENDDATE}',1,4)
	AND T.IMONTH <= substr('${ENDDATE}',6,2)
GROUP BY T.CATEGORY_CLASS, T.COST_CENTER, T.BUSINESS_UNIT, T.DIVISION, T.DEPT, T.CATEGORY

;
;