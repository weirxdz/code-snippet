select h.billno 单据号,h.def15 提单号,substr(b.def17,1,10) 提单日期,substr(h.billdate,1,10)  单据日期 ,case when b.def17 = '~' then substr(h.billdate,1,10) else substr(b.def17,1,10) end 起算日期 ,i.name 收款协议 ,nvl(ich.paymentday,0) 账期 ,TO_CHAR(case when b.def17 = '~' then TO_DATE(h.billdate, 'YYYY-MM-DD HH24:MI:SS') else TO_DATE(b.def17, 'YYYY-MM-DD HH24:MI:SS') end , 'YYYY-MM-DD') 到期日,d.name 部门,p.name  业务员,c.name 客户名称, m.code 物料编码,m.name  物料名称 ,b.quantity_de 数量 ,bd_currtype.name 原币币种 ,b.money_de 借方原币金额 ,b.money_bal 原币余额 ,b.local_money_bal 本币余额,h.billstatus  单据状态,round(sysdate - (case when b.def17 = '~' then TO_DATE(h.billdate, 'YYYY-MM-DD HH24:MI:SS') else TO_DATE(b.def17, 'YYYY-MM-DD HH24:MI:SS') end),0) 日期差,s.name 公司名称,s.pk_org 公司主键

from ar_recitem b
left join ar_recbill h on b.pk_recbill = h.pk_recbill
inner join bd_currtype on b.pk_currtype = bd_currtype.pk_currtype
left join bd_material m on b.material = m.pk_material
left join bd_customer c on b.customer = c.pk_customer
left join bd_psndoc p on b.pk_psndoc = p.pk_psndoc
left join org_dept d on b.pk_deptid = d.pk_dept
left join bd_income i on b.pk_payterm = i.pk_income
left join bd_incomech ich on i.pk_income = ich.pk_payment
left join org_orgs s on h.pk_org = s.pk_org
where b.money_bal <> 0
      and b.pk_currtype <> '1002Z0100000000001K1'
      and h.billstatus = 1
      and s.pk_org <> '0001B31000000048Q71R'
      
      
      
      ;
      
      select t.pk_currtype,t.name
from bd_currtype t
;
SELECT DATEDIFF('2023-07-11', '2021-09-01') FROM dual;
;
select distinct h.billstatus from ar_recbill h 

;
select * from bd_incomech

select distinct h.vdef15, b.vbdef17
from so_saleinvoice_b b--销售发票子表
left join so_saleinvoice h on b.csaleinvoiceid = h.csaleinvoiceid--销售发票
;

select datediff('2023-07-11','2023-07-01') from dual
