select -- 销售订单信息
 ob.csaleorderbid 销售订单行主键, ob.csaleorderid 销售订单主键, ob.carorgid 销售财务组织主键, sale_fi_org.code 销售财务组织编码, sale_fi_org.name 销售财务组织名称, oh.vbillcode 订单号, substr(ob.dbilldate, 1, 10) 订单日期, cust.code 客户编码, cust.name 客户名称, d.code 销售部门编码, d.name 销售部门名称, p.code 业务员编码, p.name 业务员名称, ct.name 销售订单原币, ct_sa.name 销售组织本币,
 ob.cmaterialid 物料主键, m.code 物料编码, m.name 物料名称, ob.vbdef4 产品名称, ob.nnum 销售订单主数量, ob.nprice 销售订单主无税单价,ob.nmny 销售订单无税金额, st_org.code 出库组织编码, st_org.name 出库组织名称,
 -- 出库信息-xg应收
 db.cdeliverybid 发货单行主键, db.cdeliveryid 发货单主键, db.nnum 发货主数量, cb.cgeneralbid 库存销售出库单行主键, cb.cgeneralhid 库存销售出库单主键, substr(cb.dbizdate, 1, 10) 出库日期, ch.vbillcode 出库单号, st_fi_org.name 出库财务组织, cb.nnum 出库主数量, cb.nprice 出库无税单价, cb.nmny 出库无税金额, ct2.name 出库原币, ct1.name 出库本币, ivb.csaleinvoicebid 销售发票行主键, ivb.csaleinvoiceid 销售发票主键, ivb.nmny 无税金额, ivb.nnum 发票主数量, ivb.nprice 发票单价, ivb.ntaxmny 发票价税合计, 
 recitem_xg.pk_recbill 客户应收单主键, recitem_xg.pk_recitem 客户应收单行主键, recitem_xg.billno 客户应收单号,recitem_xg.quantity_de 应收数量, recitem_xg.local_money_bal 客户应收单本币余额, recitem_xg.local_money_de 客户应收单本币价税合计, recitem_xg.local_notax_de 客户应收单本币无税金额, recitem_xg.local_price 客户应收单本币无税单价, recitem_xg.local_taxprice 客户应收单本币含税单价, recitem_xg.money_bal 客户应收单原币余额, recitem_xg.money_de 客户应收单原币价税合计, recitem_xg.notax_de 客户应收单原币无税金额, recitem_xg.price 客户应收单原币无税单价, ct3.name 客户应收单原币, ct4.name 客户应收单本币,
 --xg销售成本
 i5b.cbill_bid 销售成本结转单行主键, i5b.cbillid 销售成本结转单主键, i5b.nnum 销售成本结转单数量, i5b.nprice 销售成本结转单价,i5b.nmny 销售成本结转单金额, 
 -- 内部结算信息-blb应收
 tb.vbillcode 内部交易单号, substr(tb.dbilldate, 1, 10) 内部结算日期, tb_fi_org.name 内部结算财务组织, ct5.name 内部结算组织本币, ct6.name 结算币种, tb.nnumber 结算应收数量, tb.nmny 结算应收本币无税金额, tb.nprice 结算应收本币无税单价, tb.ntaxmny 结算应收本币价税合计, tb.ntaxprice 结算应收本币含税单价, recitem.billdate 内部应收日期, recitem.billno 内部应收单号, recitem.local_money_bal 内部应收本币余额, recitem.local_money_de 内部应收本币价税合计, recitem.local_notax_de 内部应收本币无税金额, recitem.local_price 内部应收本币无税单价, recitem.local_taxprice 内部应收本币含税单价, recitem.money_bal 内部应收原币余额, recitem.money_de 内部应收原币价税合计, recitem.notax_de 内部应收原币无税金额, recitem.pk_recbill 内部应收主键, recitem.pk_recitem 内部应收行主键, recitem.price 内部应收原币无税单价, recitem.taxprice 内部应收原币含税单价,
 -- 内部结算信息-blb成本
 ijb.cbill_bid, ijb.cbillid, ijh.vbillcode 调拨出库单号, substr(ijh.dbilldate, 1, 10) 调拨出库日期,ijb.nnum 内部调出数量, ijb.nprice 内部调出成本, ijb.nmny 内部调出金额
-- , 
-- -- 内部结算信息-xg应付
-- payableitem.billdate, payableitem.billno, payableitem.local_money_bal, payableitem.local_money_cr, payableitem.local_notax_cr, payableitem.local_price, payableitem.local_tax_cr, payableitem.local_taxprice, payableitem.money_bal, payableitem.money_cr, payableitem.notax_cr, payableitem.price, payableitem.taxprice,
-- -- 内部结算信息-xg调入成本
-- ijb.cbill_bid, ijb.cbillid, ijh.vbillcode, substr(ijh.dbilldate, 1, 10), ijb.nmny, ijb.nnum, ijb.nprice, 1
from so_saleorder_b ob
left join bd_material m on ob.cmaterialid = m.pk_material
inner join so_saleorder oh on ob.csaleorderid = oh.csaleorderid
inner join org_financeorg sale_fi_org on ob.carorgid = sale_fi_org.pk_financeorg -- 销售订单表体应收财务组织
inner join bd_customer cust on oh.ccustomerid = cust.pk_customer
inner join org_dept d on oh.cdeptid = d.pk_dept
inner join bd_psndoc p on oh.cemployeeid = p.pk_psndoc
inner join bd_currtype ct on oh.corigcurrencyid  = ct.pk_currtype
inner join org_orgs sa_org on oh.pk_org = sa_org.pk_org
inner join bd_currtype ct_sa on sa_org.pk_currtype = ct_sa.pk_currtype
inner join bd_billtype bt on oh.ctrantypeid = bt.pk_billtypeid
left join so_delivery_b db on ob.csaleorderbid = db.csrcbid  and nvl(db.dr,0) = 0
left join ic_saleout_b cb on db.cdeliverybid = cb.csourcebillbid  and nvl(cb.dr,0) = 0
inner join ic_saleout_h ch on cb.cgeneralhid = ch.cgeneralhid and nvl(ch.dr,0) = 0
inner join org_stockorg st_org on cb.pk_org = st_org.pk_stockorg
inner join org_financeorg st_fi_org on st_org.pk_financeorg = st_fi_org.pk_financeorg
inner join bd_currtype ct1 on cb.ccurrencyid = ct1.pk_currtype
inner join bd_currtype ct2 on cb.corigcurrencyid = ct2.pk_currtype
-- 发票、销售成本结转单、应收单
left join so_saleinvoice_b ivb on cb.cgeneralbid = ivb.csrcbid and  nvl(ivb.dr,0) = 0 
left join so_squareinv_d ivd on ivb.csaleinvoicebid = ivd.csquarebillbid and  nvl(ivd.dr,0) = 0 and ivd.fsquaretype in (4,5,6)-- 结算类型，0=无，1=确认应收，2=暂估应收，3=回冲应收，4=成本结算，5=发出商品，6=出库对冲，7=差额传应收，8=出库对冲传发出商品，
left join ia_i5bill_b i5b on ivd.csalesquaredid = i5b.csrcbid and  nvl(i5b.dr,0) = 0
-- 发票关联应收单
left join so_squareinv_b sqb on ivb.csaleinvoicebid = sqb.csquarebillbid and  nvl(sqb.dr,0) = 0 
left join so_squareinv_d sqd on sqb.csalesquarebid = sqd.csalesquarebid and  nvl(sqd.dr,0) = 0 and sqd.fsquaretype = 1
left join ar_recitem recitem_xg on sqd.csalesquaredid = recitem_xg.top_itemid and  nvl(recitem_xg.dr,0) = 0 
inner join bd_currtype ct3 on recitem_xg.pk_currtype = ct3.pk_currtype -- 应收单原币
inner join org_orgs xg_recitem_org on recitem_xg.pk_org = xg_recitem_org.pk_org
inner join bd_currtype ct4 on xg_recitem_org.pk_currtype = ct4.pk_currtype -- 应收组织本币
-- 内部结算清单、应收、应付、调拨出、调拨入
left join to_settlelist_b tb on cb.cgeneralbid = tb.csrcbid and nvl(tb.dr,0) = 0
inner join org_orgs tb_fi_org on tb.pk_org = tb_fi_org.pk_org
inner join bd_currtype ct5 on tb_fi_org.pk_currtype = ct5.pk_currtype
left join to_settlelist_bb tbb on tb.cbill_bid = tbb.cbill_bid and nvl(tbb.dr,0) = 0 
inner join bd_currtype ct6 on tbb.ccurrencyid = ct6.pk_currtype
left join ar_recitem recitem on tbb.cbill_bbid = recitem.top_itemid and nvl(recitem.dr,0) = 0
left join ap_payableitem payableitem on tbb.cbill_bbid = payableitem.top_itemid and nvl(payableitem.dr,0) = 0
left join ia_ijbill_b ijb on tbb.cbill_bbid = ijb.csrcbid and nvl(ijb.dr,0) = 0 
inner join ia_ijbill ijh on ijb.cbillid = ijh.cbillid and nvl(ijh.dr,0) = 0 
left join ia_iibill_b iib on tbb.cbill_bbid = iib.csrcbid and nvl(iib.dr,0) = 0
inner join ia_iibill iih on iib.cbillid = iih.cbillid and nvl(iih.dr,0) = 0 
where ob.dr = 0 
      and oh.vtrantypecode = '30-Cxx-21'
      and oh.vbillcode = '2023045552'
      
      
      
;
select b.ccurrencyid,ct1.code, ct1.name,b.corigcurrencyid,ct2.code, ct2.name ,b.*
from ic_saleout_b b
inner join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid
inner join bd_currtype ct1 on b.ccurrencyid = ct1.pk_currtype

inner join bd_currtype ct2 on b.corigcurrencyid = ct2.pk_currtype
where h.vbillcode = '2023043178'
;

select *
from ia_ijbill_b b
inner join ia_ijbill h on b.cbillid = h.cbillid
where h.vbillcode = 'IJ2023042700062683'

;
select b.csrcbid,
       b.csrcid,
       b.csrctrantype,t.cbillid, t.ccurrencyid, t.dr, c.name, corigcurrencyid, c1.name, bb.ccurrencyid, 
       bb.cbill_bbid, bb.cbill_bid, bb.cbillid, bb.nexchangerate, bb.nsettleinmny, 
       bb.ntaxprice, bb.ntaxmny, bb.norigtaxprice, bb.ninexchangerate
from to_settlelist t
inner join to_settlelist_b b on t.cbillid = b.cbillid
inner join to_settlelist_bb bb on b.cbill_bid = bb.cbill_bid
left join bd_currtype c on t.ccurrencyid = c.pk_currtype
left join bd_currtype c1 on t.corigcurrencyid = c1.pk_currtype
where t.vbillcode = '5F2023042700000001'
      and bb.dr = 0;
      
select b.top_billid,
       b.top_billtype,
       b.top_itemid,
       b.top_tradetype,b.src_billid,
                       b.src_billtype,
                       b.src_itemid,
                       b.src_tradetype
from ar_recitem b
inner join ar_recbill h on b.pk_recbill = h.pk_recbill
where h.billno = '2023040160'
;

select b.top_billid,
       b.top_billtype,
       b.top_itemid,
       b.top_tradetype,b.src_billid,
                       b.src_billtype,
                       b.src_itemid,
                       b.src_tradetype
from ap_payableitem b
inner join ap_payablebill h on b.pk_payablebill = h.pk_payablebill
where h.billno = '2023040327'
;

select t.
from org_orgs t
