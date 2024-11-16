SELECT h.vbillcode 订单号,
       u.user_name 制单人,
       substr(b.dbilldate, 1, 10) 订单日期,
       decode(h.vdef16,'1001B310000000026FZB','是','否') 是否季度合同,
       cust.name 客户名称,
       m.code 物料编码,
       m.name 物料名称,
       b.nnum 主数量,
       b.vbdef16 是否审核,
       b.vbdef11 差额,
       b.nprice 主本币无税单价,
       b.vbdef6 预估吨运费,
       b.vbdef7 预估回桶吨运费,
       b.vbdef17 主本币采购单价,
       b.vbdef18 海运费金额_原币,
       b.vbdef19 港杂空运吨运费_人民币,
       pd.main_ingredient1 主料名称1,pd.k_ratio1 主料单耗1,fm1.main_ingredient_cost 主料成本1,pd.main_ingredient2 主料名称2,pd.k_ratio2 主料单耗2,fm2.main_ingredient_cost 主料成本2,pd.residue 辅料电汽金额,
       b.prodcost 裸品成本,
       b.packing_cost 包装成本,
       b.pallet_cost 托盘成本,
       b.burden_cost 制造费用,
       b.labour_cost 人工费用,
       b.deprecost 折旧费用,
       b.burden_a 辅助部门制费,
       b.profit_t 吨目标利润,
       b.ex_factory_price 出厂指导价,
       psn.name 业务员,b.VDEF21 订单毛利,b.vdef22 订单毛利率,pd.ISPRICE_AUDIT ,pd.ISPRICE_AUDIT_TMP 
  FROM so_saleorder_b b
  LEFT JOIN so_saleorder h    ON b.csaleorderid = h.csaleorderid
  left join bd_material m    on b.cmaterialid = m.pk_material
  left join org_orgs orgs    on h.pk_org = orgs.pk_org
  left join bd_psndoc psn    on h.cemployeeid = psn.pk_psndoc
  left join sm_user u    on h.billmaker = u.cuserid
  left join bd_customer cust    on h.ccustomerid = cust.pk_customer
  left join fr_product_details pd on m.code = pd.prodcode
  left join fr_main_ingredient fm1 on pd.main_ingredient1 = fm1.main_ingredient
  left join fr_main_ingredient fm2 on pd.main_ingredient2 = fm2.main_ingredient
 WHERE h.dr = 0   AND b.dr = 0 and h.VBILLCODE IN ('2024020068','2024020068')
 ;
 
select  pd.prodcode,pd.prodname,pd.spec,
       nvl(pd.k_ratio1,0)*nvl(mi1.main_ingredient_cost,0)+nvl(pd.k_ratio2,0)*nvl(mi2.main_ingredient_cost,0)+nvl(pd.residue,0) prod_cost,
       nvl(pd.k_ratio1,0)*nvl(mi1.quarter_price,0)+nvl(pd.k_ratio2,0)*nvl(mi2.quarter_price,0)+nvl(pd.residue,0) prod_cost_quarter,
       pd.packing_cost,pd.exp_packing_cost,pd.turnover_cost,pd.pallet_cost,pd.exp_tax,pd.isprice_audit,pd.profit_t,pd.export_profit_t,pd.ex_factory_price from  fr_product_details pd
left join fr_main_ingredient mi1 on pd.main_ingredient1=mi1.main_ingredient
left join fr_main_ingredient mi2 on pd.main_ingredient2=mi2.main_ingredient
where pd.prodcode in ('100410001','100420004')