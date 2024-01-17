-- NC65 后台sql查询科目余额表
select org_accountingbook.code                                                         账簿编码,
       org_accountingbook.name                                                         账簿名称,
       bd_accasoa.dispname                                                             科目名称,
       bd_account.code                                                                 科目编码,
       sum(case when adjustperiod = '00' then gl_detail.localdebitamount else 0 end)   期初借方,
       sum(case when adjustperiod = '00' then gl_detail.localcreditamount else 0 end)  期初贷方,
       sum(case when adjustperiod = '12' then gl_detail.localdebitamount else 0 end)   借方发生,
       sum(case when adjustperiod = '12' then gl_detail.localcreditamount else 0 end)  贷方发生,
       sum(case
               when adjustperiod > '00' and adjustperiod <= '12' then gl_detail.localdebitamount
               else 0 end)                                                             借方累计,
       sum(case
               when adjustperiod > '00' and adjustperiod <= '12' then gl_detail.localcreditamount
               else 0 end)                                                             贷方累计,
       sum(case when adjustperiod <= '12' then gl_detail.localdebitamount else 0 end)  借方期末,
       sum(case when adjustperiod <= '12' then gl_detail.localcreditamount else 0 end) 贷方期末
from gl_detail gl_detail,
     org_accountingbook,
     bd_accasoa,
     bd_account
where gl_detail.pk_accountingbook = org_accountingbook.pk_accountingbook
  and gl_detail.pk_accasoa = bd_accasoa.pk_accasoa
  and bd_accasoa.pk_account = bd_account.pk_account
  --参数根据自己实际情况取变更
  and gl_detail.yearv = '2022'--年
  and gl_detail.adjustperiod >= '00'
  and gl_detail.adjustperiod <= '12'
  and org_accountingbook.code = '101-0004'--账簿编号
  and gl_detail.discardflagv <> 'Y'
  and gl_detail.dr <> 1
  and gl_detail.voucherkindv <> 255
  and gl_detail.tempsaveflag <> 'Y'
  and gl_detail.voucherkindv <> 5
group by gl_detail.pk_accasoa, gl_detail.pk_accountingbook, gl_detail.yearv, org_accountingbook.code,
         org_accountingbook.name, bd_accasoa.dispname, bd_account.code
