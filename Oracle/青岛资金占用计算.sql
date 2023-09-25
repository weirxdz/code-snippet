with fr_v_verifydetail_ys as (
  select psn.code 业务员编码,psn.name 业务员名称,
      t.pk_verifydetail 核销明细表主键,
       h.pk_recbill 应收单主键,
       b.pk_recitem 应收单表体主键,
       substr(saleorder_b.dbilldate,1,10) 销售订单日期,
       substr(ar_gatheritem.billdate, 1, 10) 收款日期,
       orgs.name 公司,
       dept.name 销售部门,
       substr(t.busidate, 1, 10) 处理日期,
       h.billno 应收单号,
       t.billno2 收款单号,
       bd_balatype.name 结算方式,
       t.scomment 摘要,
       t.busiflag 处理标志,
       t.redflag 红冲标志,
       costorg.name 成本域,
       case costorg.name
         when '保龄宝生物股份有限公司本部' then
          '自产'
         when '国际业务部成本域' then
          'OEM'
         when '三库同建成本域' then
          'OEM'
       end 是否OEM,
       so_org.name 销售组织,
       cust_class.name 客户基本分类,
       cust.code 客户编码,
       cust.name 客户名称,
       m.code 物料编码,
       m.name 物料名称,
       m.materialspec 规格型号,
       b.local_money_de 借方本币金额,
       case
         when invoice_b.cunitid = '0001Z0100000000000XI' or
              invoice_b.cunitid = '1001B3100000000D26QT' then
          b.quantity_de / 1000
         when invoice_b.cunitid = '0001Z0100000000000XK' then
          b.quantity_de
         else
          0
       end 借方数量,
       t.local_money_de 借方处理本币金额,
       case
         when invoice_b.cunitid = '0001Z0100000000000XI' or
              invoice_b.cunitid = '1001B3100000000D26QT' then
          t.quantity_de / 1000
         when invoice_b.cunitid = '0001Z0100000000000XK' then
          t.quantity_de
         else
          0
       end 借方处理数量,
       case
         when saleorder_b.cunitid = '0001Z0100000000000XI' or
              saleorder_b.cunitid = '1001B3100000000D26QT' then
          decode(saleorder_b.vbdef17, '~', 0, saleorder_b.vbdef17) * 1000
         when saleorder_b.cunitid = '0001Z0100000000000XK' then
          decode(saleorder_b.vbdef17, '~', 0, saleorder_b.vbdef17)
         else
          0
       end 主本币含税采购单价,
       b.rate 汇率,
       saleorder_b.vbdef18 海运费原币金额,
       saleorder_b.vbdef19 港杂空运本币吨运费,
       decode(h.src_syscode,
              0,
              '应收系统',
              3,
              '销售系统',
              16,
              '内部交易',
              19,
              '库存系统',
              h.src_syscode) 单据来源系统
    from arap_verifydetail t --核销明细表
    left join org_dept dept on t.pk_deptid = dept.pk_dept--销售部门
    left join org_orgs orgs on t.pk_org = orgs.pk_org --财务组织
    left join ar_recbill h on t.pk_bill = h.pk_recbill --应收单主表
    left join bd_psndoc psn on t.pk_psndoc = psn.pk_psndoc
    left join ar_recitem b on t.pk_item = b.pk_recitem --应收单子表
    left join ar_gatheritem ar_gatheritem on t.pk_item2 = ar_gatheritem.pk_gatheritem --收款单行
    left join bd_balatype bd_balatype on ar_gatheritem.pk_balatype = bd_balatype.pk_balatype --结算方式
    left join bd_material m on t.material= m.pk_material --物料
    left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --物料基本分类
    left join bd_customer cust on t.customer = cust.pk_customer --客户
    left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --客户基本分类
    left join org_orgs so_org on b.so_org = so_org.pk_org --销售组织
    left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
    left join so_squareinv_b so_squareinv_b on djs.csalesquarebid = so_squareinv_b.csalesquarebid --销售发票待结算单子实体
    left join org_orgs costorg on so_squareinv_b.ccostorgid = costorg.pk_org --成本域
    left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
    left join so_saleorder_b saleorder_b on invoice_b.cfirstbid = saleorder_b.csaleorderbid --销售订单子表
    where t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
          and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
          and substr(saleorder_b.dbilldate,1,10) >= '2023-01-01'
          and orgs.name = '青岛保龄宝进出口有限公司'
          and saleorder_b.dr=0
          and substr(t.busidate, 1, 10) >= '2023-01-01' and substr(t.busidate, 1, 10) <= substr(to_char(sysdate,'yyyy-mm-dd'),1,10)
),
fr_v_verifydetail_ys as (
  select 
       psn.code 业务员编码,psn.name 业务员名称,
       substr(so_saleorder_b.dbilldate,1,10) 销售订单日期, 
       so_saleorder_b.csaleorderbid 销售订单行主键, 
       so_saleorder_b.csaleorderid 销售订单主键,
       po_order_b.pk_order 采购订单主键, 
       po_order_b.pk_order_b 采购订单行主键,
       substr(invoice_b.dbilldate,1,10) 采购发票日期,
       v.billno 应付单号,
       v.billno2 付款单号,
       substr(p.billdate,1,10) 付款单日期,
       p.local_money_de 本币付款价税合计,p.local_notax_de 本币付款无税金额
from so_saleorder_b so_saleorder_b
left join po_order_b po_order_b on so_saleorder_b.csaleorderbid = po_order_b.csourcebid and nvl( po_order_b.dr,0) = 0
left join po_invoice_b invoice_b on po_order_b.pk_order_b = invoice_b.cfirstbid and nvl(invoice_b.dr,0) = 0
left join ap_payableitem item on invoice_b.pk_invoice_b = item.top_itemid and nvl(item.dr,0) = 0
left join arap_verifydetail v on item.pk_payableitem = v.pk_item and nvl(v.dr,0) = 0
left join bd_psndoc psn on v.pk_psndoc = psn.pk_psndoc
left join ap_payitem p on v.pk_item2 = p.pk_payitem and nvl(p.dr,0) = 0
where nvl( so_saleorder_b.dr,0) = 0  
      and po_order_b.pk_order is not null 
      and substr(so_saleorder_b.dbilldate,1,10) >= '2023-01-01'
      and so_saleorder_b.pk_org = '0001B31000000039DYB9'
)
