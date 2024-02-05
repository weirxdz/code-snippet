-- 凭证信息查询语句
select a.pk_org,b.code,b.name,a.year 年度,a.period 期间,c.name 凭证类别,a.prepareddate 制单日期,a.num 凭证号,
a.CREATOR 创建人ID,d.USER_NAME 创建人,a.PK_PREPARED 制单人id,e.user_name 制单人,a.MODIFIER 修改人ID,F.user_name 修改人,
a.PK_CHECKED 审核人ID，g.user_name 审核人,a.PK_MANAGER 记账人id,h.user_name 记账人
from Gl_voucher a
left join org_orgs b on b.pk_org=A.PK_ORG
left join bd_vouchertype c on c.pk_vouchertype=a.pk_vouchertype
left join sm_user d on a.CREATOR=D.CUSERID
left join sm_user E on a.PK_PREPARED=E.CUSERID
left join sm_user F on a.MODIFIER=F.CUSERID
left join sm_user G on a.PK_CHECKED=G.CUSERID
left join sm_user h on a.PK_MANAGER=h.cuserid
where a.pk_org in (select pk_org from org_orgs where code='blb01') and a.period<>'00' 
order by a.year,a.period,a.num
;

SELECT t.SPZT,t.VOUCHERTAG ,APPROVER, BBHL, BBJE, BUSITYPE, BZBM, CASHITEM, CASHPROJ, CHECKTYPE, CJKBBJE, CJKYBJE, CREATIONTIME, CREATOR, CUSTACCOUNT, CUSTOMER, DEPTID, DEPTID_V, DJBH, DJDL, DJLXBM, DJRQ, DJZT, DR, DWBM, DWBM_V, FJZS, FKYHZH, FLEXIBLE_FLAG, FREECUST, FYDEPTID, FYDEPTID_V, FYDWBM, FYDWBM_V, GLOBALBBHL, GLOBALBBJE, GLOBALCJKBBJE, GLOBALHKBBJE, GLOBALZFBBJE, GROUPBBHL, GROUPBBJE, GROUPCJKBBJE, GROUPHKBBJE, GROUPZFBBJE, HBBM, HKBBJE, HKYBJE, ISCHECK, ISCOSTSHARE, ISEXPAMT, JKBXR, JOBID, JSFS, JSH, JSR, JSRQ, KJND, KJQJ, MNGACCID, MODIFIEDTIME, MODIFIER, OFFICIALPRINTDATE, OFFICIALPRINTUSER, OPERATOR, PAYDATE, PAYFLAG, PAYMAN, PJH, PK_CASHACCOUNT, PK_CHECKELE, PK_FIORG, PK_GROUP, PK_ITEM, PK_JKBX, PK_ORG, PK_ORG_V, PK_PAYORG, PK_PAYORG_V, PK_PCORG, PK_PCORG_V, PK_RESACOSTCENTER, PROJECTTASK, QCBZ, QZZT, RECEIVER, REIMRULE, SHRQ, SKYHZH, SPZT, START_PERIOD, SXBZ, SZXMID, TOTAL, TOTAL_PERIOD, TS, YBJE, ZFBBJE, ZFYBJE, ZY, ZYX1, ZYX10, ZYX11, ZYX12, ZYX13, ZYX14, ZYX15, ZYX16, ZYX17, ZYX18, ZYX19, ZYX2, ZYX20, ZYX21, ZYX22, ZYX23, ZYX24, ZYX25, ZYX26, ZYX27, ZYX28, ZYX29, ZYX3, ZYX30, ZYX4, ZYX5, ZYX6, ZYX7, ZYX8, ZYX9, CENTER_DEPT, ISCUSUPPLIER, ISMASHARE, PK_BRAND, PK_PROLINE, SRCBILLTYPE, SRCTYPE, PAYTARGET, TBB_PERIOD, VOUCHERTAG
FROM ER_BXZB t;

SELECT distinct t.SPZT,t.VOUCHERTAG 
FROM ER_BXZB t;

SELECT AMOUNT, BBJE, BBYE, CJKBBJE, CJKYBJE, DEFITEM1, DEFITEM10, DEFITEM11, DEFITEM12, DEFITEM13, DEFITEM14, DEFITEM15, DEFITEM16, DEFITEM17, DEFITEM18, DEFITEM19, DEFITEM2, DEFITEM20, DEFITEM21, DEFITEM22, DEFITEM23, DEFITEM24, DEFITEM25, DEFITEM26, DEFITEM27, DEFITEM28, DEFITEM29, DEFITEM3, DEFITEM30, DEFITEM31, DEFITEM32, DEFITEM33, DEFITEM34, DEFITEM35, DEFITEM36, DEFITEM37, DEFITEM38, DEFITEM39, DEFITEM4, DEFITEM40, DEFITEM41, DEFITEM42, DEFITEM43, DEFITEM44, DEFITEM45, DEFITEM46, DEFITEM47, DEFITEM48, DEFITEM49, DEFITEM5, DEFITEM50, DEFITEM6, DEFITEM7, DEFITEM8, DEFITEM9, DR, GLOBALBBJE, GLOBALBBYE, GLOBALCJKBBJE, GLOBALHKBBJE, GLOBALZFBBJE, GROUPBBJE, GROUPBBYE, GROUPCJKBBJE, GROUPHKBBJE, GROUPZFBBJE, HKBBJE, HKYBJE, JOBID, PK_BUSITEM, PK_CHECKELE, PK_ITEM, PK_JKBX, PK_PCORG, PK_PCORG_V, PK_REIMTYPE, PK_RESACOSTCENTER, PROJECTTASK, ROWNO, SRCBILLTYPE, SRCTYPE, SZXMID, TABLECODE, TS, YBJE, YBYE, YJYE, ZFBBJE, ZFYBJE, PK_BRAND, PK_MTAPP_DETAIL, PK_PROLINE, CUSTACCOUNT, CUSTOMER, DEPTID, DWBM, FREECUST, HBBM, JKBXR, PAYTARGET, RECEIVER, SKYHZH
FROM ER_BUSITEM;

SELECT APPROVER, BBHL, BBJE, BBYE, BUSITYPE, BZBM, CASHITEM, CASHPROJ, CHECKTYPE, CONTRASTENDDATE, CREATIONTIME, CREATOR, CUSTACCOUNT, CUSTOMER, DEPTID, DEPTID_V, DJBH, DJDL, DJLXBM, DJRQ, DJZT, DR, DWBM, DWBM_V, FJZS, FKYHZH, FREECUST, FYDEPTID, FYDEPTID_V, FYDWBM, FYDWBM_V, GLOBALBBHL, GLOBALBBJE, GLOBALBBYE, GLOBALHKBBJE, GLOBALZFBBJE, GROUPBBHL, GROUPBBJE, GROUPBBYE, GROUPHKBBJE, GROUPZFBBJE, HBBM, HKBBJE, HKYBJE, ISCHECK, JKBXR, JOBID, JSFS, JSH, JSR, JSRQ, KJND, KJQJ, LOANTYPE, MNGACCID, MODIFIEDTIME, MODIFIER, OFFICIALPRINTDATE, OFFICIALPRINTUSER, OPERATOR, PAYDATE, PAYFLAG, PAYMAN, PJH, PK_CASHACCOUNT, PK_CHECKELE, PK_FIORG, PK_GROUP, PK_ITEM, PK_JKBX, PK_ORG, PK_ORG_V, PK_PAYORG, PK_PAYORG_V, PK_PCORG, PK_PCORG_V, PK_RESACOSTCENTER, PROJECTTASK, QCBZ, QZZT, REIMRULE, SHRQ, SKYHZH, SPZT, SXBZ, SZXMID, TOTAL, TS, YBJE, YBYE, YJYE, ZFBBJE, ZFYBJE, ZHRQ, ZPXE, ZY, ZYX1, ZYX10, ZYX11, ZYX12, ZYX13, ZYX14, ZYX15, ZYX16, ZYX17, ZYX18, ZYX19, ZYX2, ZYX20, ZYX21, ZYX22, ZYX23, ZYX24, ZYX25, ZYX26, ZYX27, ZYX28, ZYX29, ZYX3, ZYX30, ZYX4, ZYX5, ZYX6, ZYX7, ZYX8, ZYX9, CENTER_DEPT, ISCUSUPPLIER, ISMASHARE, PK_BRAND, PK_PROLINE, RECEIVER, SRCBILLTYPE, SRCTYPE, VOUCHERTAG
FROM ER_JKZB;

SELECT AMOUNT, BBJE, BBYE, CJKBBJE, CJKYBJE, DEFITEM1, DEFITEM10, DEFITEM11, DEFITEM12, DEFITEM13, DEFITEM14, DEFITEM15, DEFITEM16, DEFITEM17, DEFITEM18, DEFITEM19, DEFITEM2, DEFITEM20, DEFITEM21, DEFITEM22, DEFITEM23, DEFITEM24, DEFITEM25, DEFITEM26, DEFITEM27, DEFITEM28, DEFITEM29, DEFITEM3, DEFITEM30, DEFITEM31, DEFITEM32, DEFITEM33, DEFITEM34, DEFITEM35, DEFITEM36, DEFITEM37, DEFITEM38, DEFITEM39, DEFITEM4, DEFITEM40, DEFITEM41, DEFITEM42, DEFITEM43, DEFITEM44, DEFITEM45, DEFITEM46, DEFITEM47, DEFITEM48, DEFITEM49, DEFITEM5, DEFITEM50, DEFITEM6, DEFITEM7, DEFITEM8, DEFITEM9, DR, GLOBALBBJE, GLOBALBBYE, GLOBALCJKBBJE, GLOBALHKBBJE, GLOBALZFBBJE, GROUPBBJE, GROUPBBYE, GROUPCJKBBJE, GROUPHKBBJE, GROUPZFBBJE, HKBBJE, HKYBJE, JOBID, PK_BUSITEM, PK_CHECKELE, PK_ITEM, PK_JKBX, PK_PCORG, PK_PCORG_V, PK_REIMTYPE, PK_RESACOSTCENTER, PROJECTTASK, ROWNO, SRCBILLTYPE, SRCTYPE, SZXMID, TABLECODE, TS, YBJE, YBYE, YJYE, ZFBBJE, ZFYBJE, PK_BRAND, PK_MTAPP_DETAIL, PK_PROLINE, CUSTACCOUNT, CUSTOMER, DEPTID, DWBM, FREECUST, HBBM, JKBXR, PAYTARGET, RECEIVER, SKYHZH
FROM ER_BUSITEM;

