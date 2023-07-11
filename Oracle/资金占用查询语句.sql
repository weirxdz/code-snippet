with fr_v_verifydetail_ys as (
  select psn.name 业务员,t.pk_verifydetail 核销明细表主键,
       h.pk_recbill 应收单主键,
       b.pk_recitem 应收单表体主键,
       saleout_b.cgeneralbid 出库单主键,
       saleout_h.vbillcode 销售出库单号,
       substr(saleout_b.dbizdate, 1, 10) 出库日期,
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
       sfst.name 是否售桶,
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
       pd.prodclass_y 产品类型,
       pd.prodname_y 产品名称,
       case
         when b.money_de <> b.notax_de then
          0
         when b.money_de = b.notax_de then
          pd.exp_tax
       end 不予免征税率,
       saleorder_b.packing_cost 包装成本,
       saleorder_b.pallet_cost 托盘成本,
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
    left join fr_product_details pd on m.code = pd.prodcode --产品成本信息明细
    left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
    left join so_squareinv_b so_squareinv_b on djs.csalesquarebid = so_squareinv_b.csalesquarebid --销售发票待结算单子实体
    left join org_orgs costorg on so_squareinv_b.ccostorgid = costorg.pk_org --成本域
    left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
    left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --销售出库单子表
    left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --销售出库单表头
    left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --是否售桶自定义项
    left join so_delivery_b so_delivery_b on saleout_b.csourcebillbid = so_delivery_b.cdeliverybid --发货单子表
    left join so_saleorder_b saleorder_b on so_delivery_b.csrcbid = saleorder_b.csaleorderbid --销售订单子表
    where /*substr(t.busidate,1,10)>='' and substr(t.busidate,1,10)<='' and */t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
          and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
          and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
          and orgs.name = '保龄宝生物股份有限公司本部'
          and saleorder_b.dr=0
          and substr(t.busidate, 1, 10) >= '2023-01-01' and substr(t.busidate, 1, 10) <= '2023-06-09 16:50:33'

union all
select psn.name 业务员,t.pk_verifydetail 核销明细表主键,h.pk_recbill 应收单主键,b.pk_recitem 应收单表体主键,saleout_b.cgeneralbid 出库单主键,saleout_h.vbillcode 销售出库单号,substr(saleout_b.dbizdate,1,10) 出库日期,substr(ar_gatheritem.billdate,1,10) 收款日期, orgs.name 公司,dept.name 销售部门, substr(t.busidate,1,10) 处理日期 ,h.billno 应收单号,t.billno2 收款单号,bd_balatype.name 结算方式,t.scomment 摘要,t.busiflag 处理标志,t.redflag 红冲标志,sfst.name 是否售桶,
       costorg.name 成本域,case costorg.name when '保龄宝生物股份有限公司本部' then '自产' when '国际业务部成本域' then 'OEM' when '三库同建成本域' then 'OEM' end  是否OEM,so_org.name 销售组织,cust_class.name 客户基本分类,cust.code 客户编码,cust.name 客户名称,
       pd.prodcode 物料编码,pd.prodname 物料名称,pd.spec 规格型号,pd.prodclass_y 产品类型,pd.prodname_y 产品名称,
       case  when b.money_de <> b.notax_de then 0 when b.money_de = b.notax_de then  pd.exp_tax end 不予免征税率,
       saleorder_b.packing_cost 包装成本,saleorder_b.pallet_cost 托盘成本,
       b.local_money_de 借方本币金额,
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then b.quantity_de / 1000
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  b.quantity_de   else      0
       end        借方数量,
       t.local_money_de 借方处理本币金额,
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then t.quantity_de / 1000
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  t.quantity_de   else      0
       end 借方处理数量,
       case  when saleorder_b.cunitid = '0001Z0100000000000XI' or saleorder_b.cunitid = '1001B3100000000D26QT' then decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17) * 1000
       when saleorder_b.cunitid = '0001Z0100000000000XK'  then  decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17)  else      0
       end  主本币含税采购单价,
       b.rate 汇率,
       saleorder_b.vbdef18 海运费原币金额,
       saleorder_b.vbdef19 港杂空运本币吨运费,
       decode(h.src_syscode,0,'应收系统',3,'销售系统',16,'内部交易',19,'库存系统',h.src_syscode) 单据来源系统
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
  left join fr_product_details pd on m.code = pd.prodcode --产品成本信息明细
  left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
  left join so_squareinv_b so_squareinv_b on djs.csalesquarebid = so_squareinv_b.csalesquarebid --销售发票待结算单子实体
  left join org_orgs costorg on so_squareinv_b.ccostorgid = costorg.pk_org --成本域
  left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
  left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --销售出库单子表
  left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --销售出库单表头
  left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --是否售桶自定义项
  --left join so_delivery_b so_delivery_b on saleout_b.csourcebillbid = so_delivery_b.cdeliverybid
  left join so_saleorder_b saleorder_b on saleout_b.csourcebillbid = saleorder_b.csaleorderbid --销售订单子表
  where /*substr(t.busidate,1,10)>='' and substr(t.busidate,1,10)<='' and */t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
        and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
        and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
        and orgs.name = '保龄宝生物股份有限公司本部'
        and saleorder_b.dr=0
        and substr(t.busidate, 1, 10) >= '2023-01-01' and substr(t.busidate, 1, 10) <= '2023-06-09 16:50:33'
),
fr_zj as (
  select distinct 出库单主键 from fr_v_verifydetail_ys
),
fr_v_zjyf as (
  select t.zj 主键, t.dbizdate 出库日期, sum(t.ftyfje) 直接运费
    from (select b.cgeneralbid zj,
                substr(b.dbizdate, 1, 10) dbizdate,
                b.nnum cksl,
                dm_b.nnum yssl,
                to_number(case
                            when dm_b.pk_org = '0001B3100000004AG5D0' AND dm_b.vbdef10 <> '~' then
                              dm_b.vbdef10
                            else
                              dm_b.vbdef18
                          end) yfje,
                case
                  when b.nnum < dm_b.nnum then
                    to_number(case
                                when dm_b.pk_org = '0001B3100000004AG5D0' AND dm_b.vbdef10 <> '~' then
                                dm_b.vbdef10
                                else
                                dm_b.vbdef18
                              end) * b.nnum / dm_b.nnum
                  else
                    to_number(case
                                when dm_b.pk_org = '0001B3100000004AG5D0' AND dm_b.vbdef10 <> '~' then
                                dm_b.vbdef10
                                else
                                dm_b.vbdef18
                              end) * 1.00
                end ftyfje
            from ic_saleout_b b
            left join ic_saleout_h h
              on b.cgeneralhid = h.cgeneralhid
            left join so_delivery_b so_d_b
              on b.csourcebillbid = so_d_b.cdeliverybid
            left join dm_delivbill_b dm_b
              on so_d_b.cdeliverybid = dm_b.csrcbid
          where b.dr = 0
            and h.dr = 0
            and so_d_b.dr = 0
            and dm_b.dr = 0
            and b.nnum > 0
            and substr(b.dbizdate, 1, 10) >= '2017-01-01'
            and b.cgeneralbid in (select 出库单主键 from fr_zj)
          union all
          select b.cgeneralbid zj,
                substr(b.dbizdate, 1, 10) dbizdate,
                b.nnum cksl,
                dm_b.nnum yssl,
                to_number(case
                            when dm_b.pk_org = '0001B3100000004AG5D0' AND dm_b.vbdef10 <> '~' then
                              dm_b.vbdef10
                            else
                              dm_b.vbdef18
                          end) yfje,
                case
                  when b.nnum < dm_b.nnum then
                    to_number(case
                                when dm_b.pk_org = '0001B3100000004AG5D0' AND dm_b.vbdef10 <> '~' then
                                dm_b.vbdef10
                                else
                                dm_b.vbdef18
                              end) * b.nnum / dm_b.nnum
                  else
                    to_number(case
                                when dm_b.pk_org = '0001B3100000004AG5D0' AND dm_b.vbdef10 <> '~' then
                                dm_b.vbdef10
                                else
                                dm_b.vbdef18
                              end) * 1.00
                end ftyfje
            from ic_saleout_b b
            left join ic_saleout_h h
              on b.cgeneralhid = h.cgeneralhid
            left join dm_delivbill_b dm_b
              on b.cgeneralbid = dm_b.csrcbid
          where b.dr = 0
            and h.dr = 0
            and dm_b.dr = 0
            and b.nnum > 0
            and substr(b.dbizdate, 1, 10) >= '2017-01-01'
            and b.cgeneralbid in (select 出库单主键 from fr_zj)) t
    group by t.zj, t.dbizdate
 ),
t2 as (-- 当期有核销客户的回桶运费
  SELECT distinct
    cust.code 客户编码, sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over(partition by cust.code)  客户汇总回桶运费,sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over() 客户回桶运费总额
    FROM dm_delivbill_b b
    left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
    LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
    left join bd_customer cust on b.casscustid=cust.pk_customer
    WHERE h.dr = 0  AND b.dr = 0  AND m.name = '塑料桶'
        and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<='2023-06-09 16:50:33'
),
t2_1 as (
  SELECT distinct  sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over() 无核销客户的回桶运费
    FROM dm_delivbill_b b
    left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
    LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
    left join bd_customer cust on b.casscustid=cust.pk_customer
    WHERE h.dr = 0  AND b.dr = 0  AND m.name = '塑料桶'
      and cust.code not in (select distinct cust.code 客户编码
    from arap_verifydetail t --核销明细表
    left join org_orgs orgs on t.pk_org = orgs.pk_org --财务组织
    left join ar_recbill h on t.pk_bill = h.pk_recbill --应收单主表
    left join ar_recitem b on t.pk_item = b.pk_recitem --应收单字表
    left join bd_material m on t.material= m.pk_material --物料
    left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --物料基本分类
    left join bd_customer cust on t.customer = cust.pk_customer --客户
    left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --客户基本分类
    left join org_orgs so_org on b.so_org = so_org.pk_org --销售组织
    left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
    left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
    left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --销售出库单子表
    left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --销售出库单表头
    left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --是否售桶自定义项

    where substr(t.busidate,1,10)>='2023-01-01' and substr(t.busidate,1,10)<='2023-06-09 16:50:33' and t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
          and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
          and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
          and orgs.name = '保龄宝生物股份有限公司本部'
          and b.dr=0)
      and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<='2023-06-09 16:50:33'
),
t31 as (
  SELECT
    dept.name 销售部门,prod.prodname_y 产品名称,prod.prodclass_y 产品类别,m.code 物料编码,m.name 物料名称,m.materialspec 规格,to_number(case when b.pk_org = '0001B3100000004AG5D0' then b.vbdef10 else b.vbdef18 end) 运费金额
    FROM dm_delivbill h
    INNER JOIN dm_delivbill_b b    ON h.cdelivbill_hid = b.cdelivbill_hid
    LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
    LEFT JOIN bd_stordoc stordoc    ON b.creceivestoreid = stordoc.pk_stordoc
    left join bd_material m on b.cinventoryid=m.pk_material
    left join fr_product_details prod on m.code=prod.prodcode
    left join bd_customer cust on b.casscustid = cust.pk_customer
    left join org_dept dept on b.vbdef20 = dept.pk_dept
    WHERE h.dr = 0  AND b.dr = 0  AND meta.billtypename = '库存调拨出库单'  AND (stordoc.name = '华南办事处仓库' or stordoc.name = '东北办事处仓库')
      and substr(h.dbilldate,1,10)>='2023-01-01' and substr(h.dbilldate,1,10)<='2023-06-09 16:50:33'
),
t3 as (-- 调拨运费
  select t31.销售部门 销售部门,sum(t31.运费金额)  部门调拨运费 from t31 group by t31.销售部门
),
t4 as (-- 到客户的退货运费
  SELECT
  distinct cust.code 客户编码, sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over(partition by cust.code)  按客户汇总退货运费,sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over()  客户退货运费总额
    FROM dm_delivbill_b b
    left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
    LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
    left join bd_customer cust on b.casscustid=cust.pk_customer
    LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
    WHERE h.dr = 0  AND b.dr = 0 AND meta.billtypename IS NULL  AND m.name <> '塑料桶'
        and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<='2023-06-09 16:50:33'
),
t4_1 as (
  SELECT distinct  dept.name 部门, sum(to_number(case when b.pk_org = '0001B3100000004AG5D0' and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over(partition by dept.name)  部门汇总退货运费
                FROM dm_delivbill_b b
                left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
                LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
                left join bd_customer cust on b.casscustid=cust.pk_customer
                left join bd_custclass custclass on cust.pk_custclass = custclass.pk_custclass
                LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
                left join org_dept dept on b.vbdef20 = dept.pk_dept
                WHERE h.dr = 0  AND b.dr = 0 AND meta.billtypename IS NULL  AND m.name <> '塑料桶'
                  and cust.code not in (select distinct cust.code 客户编码
                from arap_verifydetail t --核销明细表
                left join org_dept dept on t.pk_deptid = dept.pk_dept--销售部门
                left join org_orgs orgs on t.pk_org = orgs.pk_org --财务组织
                left join ar_recbill h on t.pk_bill = h.pk_recbill --应收单主表
                left join ar_recitem b on t.pk_item = b.pk_recitem --应收单字表
                left join bd_material m on t.material= m.pk_material --物料
                left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --物料基本分类
                left join bd_customer cust on t.customer = cust.pk_customer --客户
                left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --客户基本分类
                left join org_orgs so_org on b.so_org = so_org.pk_org --销售组织
                left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --销售发票待结算明细
                left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --销售发票子表
                left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --销售出库单子表
                left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --销售出库单表头
                left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --是否售桶自定义项

                where substr(t.busidate,1,10)>='2023-01-01' and substr(t.busidate,1,10)<='2023-06-09 16:50:33' and t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
                      and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--来源于销售系统
                      and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
                      and orgs.name = '保龄宝生物股份有限公司本部'
                      and b.dr=0)
                 and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<='2023-06-09 16:50:33'
),
t5 as (
  select distinct cust.code 客户编码, cust.name 客户名称,m.code 物料编码, m.name 物料名称, sum(t.local_money_de) over(partition by cust.code,m.code ) 按客户物料汇总处理金额
             from arap_verifydetail t
                left join ar_recitem recitem on t.pk_item = recitem.pk_recitem
                left join ar_recbill recbill on recitem.pk_recbill = recbill.pk_recbill
                left join bd_inoutbusiclass szxm on recitem.pk_subjcode = szxm.pk_inoutbusiclass
                left join bd_material m on recitem.material = m.pk_material
                left join bd_customer cust on recitem.ordercubasdoc = cust.pk_customer
                left join org_dept dept on recitem.pk_deptid = dept.pk_dept

                where substr(t.busidate,1,10)>='2023-01-01' and substr(t.busidate,1,10)<='2023-06-09 16:50:33' and szxm.name ='运费（产品、回桶、出口）'
                      and recitem.pk_org = '0001B3100000000028GW'
),
t_st as (
  select distinct b.cgeneralbid 出库单主键,s.name orgname,st.name storename
    from ic_saleout_b b
    left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid
    left join org_orgs s on h.pk_org = s.pk_org
    left join bd_stordoc st on h.cwarehouseid = st.pk_stordoc
    where b.dr = 0 and h.dr = 0 and s.dr = 0 and st.dr = 0 and b.cgeneralbid in (select 出库单主键 from fr_zj )
),
fr_details as (
  select t.核销明细表主键,
       t.应收单表体主键,
       t.出库单主键,
       t.销售出库单号,
       t.出库日期,
       t.收款日期,
       t.公司,
       t.销售部门,
       t.业务员,
       t.处理日期,
       t.应收单号,
       t.收款单号,
       t.结算方式,
       t.摘要,
       t.处理标志,
       t.红冲标志,
       t.是否售桶,
       t.成本域,
       t.是否OEM,
       t.销售组织,
       t.客户基本分类,
       t.客户编码,
       t.客户名称,
       t.物料编码,
       t.物料名称,
       t.规格型号,
       t.产品类型,
       t.产品名称,
       t.不予免征税率,
       t.包装成本,
       t.托盘成本,
       t.借方本币金额,
       t.借方数量,
       t.借方处理本币金额,
       t.借方处理数量,
       t.主本币含税采购单价,
       t.汇率,
       t.单据来源系统,
       t1.主键,
       t1.直接运费,t_st.orgname  库存组织名称,t_st.storename  仓库名称,
       round(t1.直接运费 * t.借方处理数量 / t.借方数量, 6) 直接运费分摊金额,
       t2.客户汇总回桶运费,
       case  when t.是否售桶 = '周转桶' then  t.借方处理数量  else 0 end 周转业务处理数量,
       sum(case when t.是否售桶 = '周转桶' then  t.借方处理数量 else 0 end) over(partition by t.客户编码) 按客户汇总周转业务处理数量,
       sum(case when t.是否售桶 = '周转桶' then  t.借方处理数量 else 0 end) over() 汇总周转业务处理数量,
       case when sum(case when t.是否售桶 = '周转桶' then t.借方处理数量 else 0 end) over(partition by t.客户编码) = 0 then 0 else round(t.借方处理数量 * t2.客户汇总回桶运费 / sum(case when t.是否售桶 = '周转桶' then t.借方处理数量 else 0 end) over(partition by t.客户编码), 6) end 客户分摊回桶运费,
       t2.客户回桶运费总额,
       t2_1.无核销客户的回桶运费,
       round(t2_1.无核销客户的回桶运费 * (case when t.是否售桶 = '周转桶' then t.借方处理数量 else 0 end) / (sum(case when t.是否售桶 = '周转桶' then t.借方处理数量 else 0 end) over()),6) 无核销客户分摊回桶运费,
       sum(t.借方处理数量) over(partition by t.销售部门) 按部门汇总处理数量,
       t3.部门调拨运费,round(t3.部门调拨运费*t.借方处理数量/(sum(t.借方处理数量) over(partition by t.销售部门)) ,6) 分摊调拨运费,
       t4.按客户汇总退货运费,
       sum(t.借方处理数量) over(partition by t.客户编码) 按客户汇总处理数量,
       round(t4.按客户汇总退货运费 * t.借方处理数量 / sum(t.借方处理数量)over(partition by t.客户编码),6) 客户分摊退货运费,
       t4_1.部门汇总退货运费,
       round(t4_1.部门汇总退货运费 * t.借方处理数量 /(sum(t.借方处理数量) over(partition by t.销售部门)),6) 按部门分摊退货运费,
       t5.按客户物料汇总处理金额 代垫海运费处理金额,
       sum(t.借方处理本币金额)over(partition by t.客户编码,t.物料编码) 处理金额按客户物料汇总
  from fr_v_verifydetail_ys t
  left join fr_v_zjyf t1 on t.出库单主键 = t1.主键
  left join t2 on t.客户编码 = t2.客户编码
  left join t2_1 on 1=1
  left join t3 on t.销售部门 = t3.销售部门
  left join t4 on t.客户编码 = t4.客户编码
  left join t4_1 on t.销售部门 = t4_1.部门
  left join t5 on t.客户编码 = t5.客户编码 and t.物料编码 = t5.物料编码
  left join t_st on t.出库单主键 = t_st.出库单主键
)
select t.核销明细表主键,
       t.应收单表体主键,
       t.出库单主键,
       t.销售出库单号,
       t.出库日期,
       t.收款日期,
       t.公司,
       t.销售部门,
       t.业务员,
       t.处理日期,
       t.应收单号,
       t.收款单号,
       t.结算方式,
       t.摘要,
       t.处理标志,
       t.红冲标志,
       t.是否售桶,
       t.成本域,
       t.是否OEM,
       t.销售组织,
       t.客户基本分类,
       t.客户编码,
       t.客户名称,
       t.物料编码,
       t.物料名称,
       t.规格型号,
       t.产品类型,
       t.产品名称,
       t.不予免征税率,
       t.包装成本,
       t.托盘成本,
       t.借方本币金额,
       t.借方数量,
       t.借方处理本币金额,
       t.借方处理数量,
       t.主本币含税采购单价,
       t.汇率,
       t.单据来源系统,t.直接运费,t.库存组织名称,t.仓库名称,
       t.直接运费分摊金额,
       t.客户汇总回桶运费,
       t.周转业务处理数量,
       t.按客户汇总周转业务处理数量,
       t.汇总周转业务处理数量,
       t.客户分摊回桶运费,
       t.客户回桶运费总额,
       t.无核销客户的回桶运费,
       t.无核销客户分摊回桶运费,
       t.按部门汇总处理数量,
       t.部门调拨运费,t.分摊调拨运费,
       t.按客户汇总退货运费,
       t.按客户汇总处理数量,
       t.客户分摊退货运费,
       t.部门汇总退货运费,
       t.按部门分摊退货运费,
       t.代垫海运费处理金额,
       t.处理金额按客户物料汇总,
       round(t.直接运费分摊金额+t.客户分摊回桶运费+t.无核销客户分摊回桶运费+t.分摊调拨运费+t.客户分摊退货运费+t.按部门分摊退货运费,2) 运费汇总,
       round(t.借方处理数量*t.主本币含税采购单价*0.8547,2) 采购金额,
       round(t.借方处理本币金额* t.代垫海运费处理金额/t.处理金额按客户物料汇总,2) 分摊后的代垫运费
from fr_details t
