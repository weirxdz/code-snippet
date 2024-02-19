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
SELECT DISTINCT glvou.num,gl.yearv, gl.periodv,smuser.user_code, smuser.user_name,glvou.billmaker,glvou.pk_system,glvou.discardflag,gl.assid,accsubj.code subjcode,accsubj.name subjname,gl.creditamount,gl.debitamount,
(CASE WHEN accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306') THEN gl.creditamount
      ELSE gl.debitamount
  END) fs,
gl_docfree1.f1,org_dept_v.code deptcode,org_dept_v.name deptname,org_dept_v.pk_org,org.code orgcode,org.name orgname,org_dept_v.pk_group,grp.code grpcode,grp.name grpname 
FROM gl_docfree1 INNER JOIN org_dept_v  ON gl_docfree1.f1=org_dept_v.pk_dept 
INNER JOIN org_orgs_v org ON org.pk_org=org_dept_v.pk_org 
INNER JOIN org_group grp ON grp.pk_group=gl_docfree1.pk_group AND grp.pk_group=org_dept_v.pk_group
Inner JOIN gl_detail gl ON gl.assid=gl_docfree1.assid
INNER JOIN bd_account accsubj ON accsubj.pk_account=gl.pk_account
INNER JOIN gl_voucher glvou ON glvou.pk_voucher=gl.pk_voucher
inner join sm_user smuser on smuser.cuserid=glvou.billmaker
WHERE gl_docfree1.f1<>'NN/A' AND gl_docfree1.f1<>'~'
 AND nvl(org_dept_v.dr,0)=0 AND nvl(gl_docfree1.dr,0)=0
 AND nvl(org.dr,0)=0 AND nvl(grp.dr,0)=0
 AND nvl(gl.dr,0)=0 AND nvl(accsubj.dr,0)=0
 AND glvou.pk_system IN (/*'GL','IA',*/'erm')
 AND glvou.discardflag='N'
 AND gl.yearv>=2015 AND gl.periodv>'00'
 AND accsubj.code IN ('221101','22110301','22110302','22110303','22110304','22110305','22110306','50010301','500108','510104','51010903','510110','510115','510116','510117','510118','510125','53010101','53010104', '5301010903','53010110','53010115','660104','66010903','660110','660113','660118','660119','660120','660123','660204','66020903','660210','660215', '660218','660223','660224')
 
 ;
SELECT sum(er_busitem.amount) amount_sum, er_reimtype.name name, er_reimtype.code code, bd_inoutbusiclass.name name_1, substr(substr(er_bxzb.djrq, 1, 10), 0, 4) yearv, substr(substr(er_bxzb.djrq, 1, 10), 6, 2) periodv, substr(er_bxzb.djrq, 1, 10) djrq, substr(substr(er_bxzb.djrq, 1, 10), 9, 2) djrq_day, er_bxzb.spzt spzt, org_financeorg.name name_2, org_financeorg.code code_1, org_group.name name_3, org_group.code code_2, org_dept.code code_3, org_dept.name name_4, er_bxzb.djbh djbh FROM er_busitem er_busitem LEFT JOIN er_reimtype er_reimtype ON er_busitem.pk_reimtype = er_reimtype.pk_reimtype LEFT JOIN bd_inoutbusiclass bd_inoutbusiclass ON er_busitem.szxmid = bd_inoutbusiclass.pk_inoutbusiclass INNER JOIN er_bxzb er_bxzb ON er_busitem.pk_jkbx = er_bxzb.pk_jkbx LEFT JOIN org_financeorg org_financeorg ON er_bxzb.pk_org = org_financeorg.pk_financeorg LEFT JOIN org_group org_group ON org_financeorg.pk_group = org_group.pk_group LEFT JOIN org_dept org_dept ON er_bxzb.deptid = org_dept.pk_dept GROUP BY er_reimtype.name, er_reimtype.code, bd_inoutbusiclass.name, substr(substr(er_bxzb.djrq, 1, 10), 0, 4), substr(substr(er_bxzb.djrq, 1, 10), 6, 2), substr(er_bxzb.djrq, 1, 10), substr(substr(er_bxzb.djrq, 1, 10), 9, 2), er_bxzb.spzt, org_financeorg.name, org_financeorg.code, org_group.name, org_group.code, org_dept.code, org_dept.name, er_bxzb.djbh
;
SELECT DISTINCT pk_system FROM gl_voucher WHERE dr = 0
 ;