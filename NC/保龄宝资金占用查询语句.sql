with fr_v_verifydetail_ys as (
  select psn.name ҵ��Ա,t.pk_verifydetail ������ϸ������,
       h.pk_recbill Ӧ�յ�����,
       b.pk_recitem Ӧ�յ���������,
       saleout_b.cgeneralbid ���ⵥ����,
       saleout_h.vbillcode ���۳��ⵥ��,
       substr(saleout_b.dbizdate, 1, 10) ��������,
       substr(ar_gatheritem.billdate, 1, 10) �տ�����,
       orgs.name ��˾,
       dept.name ���۲���,
       substr(t.busidate, 1, 10) ��������,
       h.billno Ӧ�յ���,
       t.billno2 �տ��,
       bd_balatype.name ���㷽ʽ,
       t.scomment ժҪ,
       t.busiflag �����־,
       t.redflag ����־,
       sfst.name �Ƿ���Ͱ,
       costorg.name �ɱ���,
       case costorg.name
         when '���䱦����ɷ����޹�˾����' then
          '�Բ�'
         when '����ҵ�񲿳ɱ���' then
          'OEM'
         when '����ͬ���ɱ���' then
          'OEM'
       end �Ƿ�OEM,
       so_org.name ������֯,
       cust_class.name �ͻ���������,
       cust.code �ͻ�����,
       cust.name �ͻ�����,
       m.code ���ϱ���,
       m.name ��������,
       m.materialspec ����ͺ�,
       pd.prodclass_y ��Ʒ����,
       pd.prodname_y ��Ʒ����,
       case
         when b.money_de <> b.notax_de then
          0
         when b.money_de = b.notax_de then
          pd.exp_tax
       end ��������˰��,
       saleorder_b.packing_cost ��װ�ɱ�,
       saleorder_b.pallet_cost ���̳ɱ�,
       b.local_money_de �跽���ҽ��,
       case
         when invoice_b.cunitid = '0001Z0100000000000XI' or
              invoice_b.cunitid = '1001B3100000000D26QT' then
          b.quantity_de / 1000
         when invoice_b.cunitid = '0001Z0100000000000XK' then
          b.quantity_de
         else
          0
       end �跽����,
       t.local_money_de �跽�����ҽ��,
       case
         when invoice_b.cunitid = '0001Z0100000000000XI' or
              invoice_b.cunitid = '1001B3100000000D26QT' then
          t.quantity_de / 1000
         when invoice_b.cunitid = '0001Z0100000000000XK' then
          t.quantity_de
         else
          0
       end �跽��������,
       case
         when saleorder_b.cunitid = '0001Z0100000000000XI' or
              saleorder_b.cunitid = '1001B3100000000D26QT' then
          decode(saleorder_b.vbdef17, '~', 0, saleorder_b.vbdef17) * 1000
         when saleorder_b.cunitid = '0001Z0100000000000XK' then
          decode(saleorder_b.vbdef17, '~', 0, saleorder_b.vbdef17)
         else
          0
       end �����Һ�˰�ɹ�����,
       b.rate ����,
       saleorder_b.vbdef18 ���˷�ԭ�ҽ��,
       saleorder_b.vbdef19 ���ӿ��˱��Ҷ��˷�,
       decode(h.src_syscode,
              0,
              'Ӧ��ϵͳ',
              3,
              '����ϵͳ',
              16,
              '�ڲ�����',
              19,
              '���ϵͳ',
              h.src_syscode) ������Դϵͳ
    from arap_verifydetail t --������ϸ��
    left join org_dept dept on t.pk_deptid = dept.pk_dept--���۲���
    left join org_orgs orgs on t.pk_org = orgs.pk_org --������֯
    left join ar_recbill h on t.pk_bill = h.pk_recbill --Ӧ�յ�����
    left join bd_psndoc psn on t.pk_psndoc = psn.pk_psndoc
    left join ar_recitem b on t.pk_item = b.pk_recitem --Ӧ�յ��ӱ�
    left join ar_gatheritem ar_gatheritem on t.pk_item2 = ar_gatheritem.pk_gatheritem --�տ��
    left join bd_balatype bd_balatype on ar_gatheritem.pk_balatype = bd_balatype.pk_balatype --���㷽ʽ
    left join bd_material m on t.material= m.pk_material --����
    left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --���ϻ�������
    left join bd_customer cust on t.customer = cust.pk_customer --�ͻ�
    left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --�ͻ���������
    left join org_orgs so_org on b.so_org = so_org.pk_org --������֯
    left join fr_product_details pd on m.code = pd.prodcode --��Ʒ�ɱ���Ϣ��ϸ
    left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --���۷�Ʊ��������ϸ
    left join so_squareinv_b so_squareinv_b on djs.csalesquarebid = so_squareinv_b.csalesquarebid --���۷�Ʊ�����㵥��ʵ��
    left join org_orgs costorg on so_squareinv_b.ccostorgid = costorg.pk_org --�ɱ���
    left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --���۷�Ʊ�ӱ�
    left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --���۳��ⵥ�ӱ�
    left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --���۳��ⵥ��ͷ
    left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --�Ƿ���Ͱ�Զ�����
    left join so_delivery_b so_delivery_b on saleout_b.csourcebillbid = so_delivery_b.cdeliverybid --�������ӱ�
    left join so_saleorder_b saleorder_b on so_delivery_b.csrcbid = saleorder_b.csaleorderbid --���۶����ӱ�
    where /*substr(t.busidate,1,10)>='' and substr(t.busidate,1,10)<='' and */t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
          and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--��Դ������ϵͳ
          and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
          and orgs.name = '���䱦����ɷ����޹�˾����'
          and saleorder_b.dr=0
          and substr(t.busidate, 1, 10) >= '2023-01-01' and substr(t.busidate, 1, 10) <= substr(to_char(sysdate,'yyyy-mm-dd'),1,10)

union all
select psn.name ҵ��Ա,t.pk_verifydetail ������ϸ������,h.pk_recbill Ӧ�յ�����,b.pk_recitem Ӧ�յ���������,saleout_b.cgeneralbid ���ⵥ����,saleout_h.vbillcode ���۳��ⵥ��,substr(saleout_b.dbizdate,1,10) ��������,substr(ar_gatheritem.billdate,1,10) �տ�����, orgs.name ��˾,dept.name ���۲���, substr(t.busidate,1,10) �������� ,h.billno Ӧ�յ���,t.billno2 �տ��,bd_balatype.name ���㷽ʽ,t.scomment ժҪ,t.busiflag �����־,t.redflag ����־,sfst.name �Ƿ���Ͱ,
       costorg.name �ɱ���,case costorg.name when '���䱦����ɷ����޹�˾����' then '�Բ�' when '����ҵ�񲿳ɱ���' then 'OEM' when '����ͬ���ɱ���' then 'OEM' end  �Ƿ�OEM,so_org.name ������֯,cust_class.name �ͻ���������,cust.code �ͻ�����,cust.name �ͻ�����,
       pd.prodcode ���ϱ���,pd.prodname ��������,pd.spec ����ͺ�,pd.prodclass_y ��Ʒ����,pd.prodname_y ��Ʒ����,
       case  when b.money_de <> b.notax_de then 0 when b.money_de = b.notax_de then  pd.exp_tax end ��������˰��,
       saleorder_b.packing_cost ��װ�ɱ�,saleorder_b.pallet_cost ���̳ɱ�,
       b.local_money_de �跽���ҽ��,
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then b.quantity_de / 1000
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  b.quantity_de   else      0
       end        �跽����,
       t.local_money_de �跽�����ҽ��,
       case  when invoice_b.cunitid = '0001Z0100000000000XI' or invoice_b.cunitid = '1001B3100000000D26QT' then t.quantity_de / 1000
       when invoice_b.cunitid = '0001Z0100000000000XK'  then  t.quantity_de   else      0
       end �跽��������,
       case  when saleorder_b.cunitid = '0001Z0100000000000XI' or saleorder_b.cunitid = '1001B3100000000D26QT' then decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17) * 1000
       when saleorder_b.cunitid = '0001Z0100000000000XK'  then  decode(saleorder_b.vbdef17,'~',0,saleorder_b.vbdef17)  else      0
       end  �����Һ�˰�ɹ�����,
       b.rate ����,
       saleorder_b.vbdef18 ���˷�ԭ�ҽ��,
       saleorder_b.vbdef19 ���ӿ��˱��Ҷ��˷�,
       decode(h.src_syscode,0,'Ӧ��ϵͳ',3,'����ϵͳ',16,'�ڲ�����',19,'���ϵͳ',h.src_syscode) ������Դϵͳ
  from arap_verifydetail t --������ϸ��
  left join org_dept dept on t.pk_deptid = dept.pk_dept--���۲���
  left join org_orgs orgs on t.pk_org = orgs.pk_org --������֯
  left join ar_recbill h on t.pk_bill = h.pk_recbill --Ӧ�յ�����
  left join bd_psndoc psn on t.pk_psndoc = psn.pk_psndoc
  left join ar_recitem b on t.pk_item = b.pk_recitem --Ӧ�յ��ӱ�
  left join ar_gatheritem ar_gatheritem on t.pk_item2 = ar_gatheritem.pk_gatheritem --�տ��
  left join bd_balatype bd_balatype on ar_gatheritem.pk_balatype = bd_balatype.pk_balatype --���㷽ʽ
  left join bd_material m on t.material= m.pk_material --����
  left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --���ϻ�������
  left join bd_customer cust on t.customer = cust.pk_customer --�ͻ�
  left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --�ͻ���������
  left join org_orgs so_org on b.so_org = so_org.pk_org --������֯
  left join fr_product_details pd on m.code = pd.prodcode --��Ʒ�ɱ���Ϣ��ϸ
  left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --���۷�Ʊ��������ϸ
  left join so_squareinv_b so_squareinv_b on djs.csalesquarebid = so_squareinv_b.csalesquarebid --���۷�Ʊ�����㵥��ʵ��
  left join org_orgs costorg on so_squareinv_b.ccostorgid = costorg.pk_org --�ɱ���
  left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --���۷�Ʊ�ӱ�
  left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --���۳��ⵥ�ӱ�
  left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --���۳��ⵥ��ͷ
  left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --�Ƿ���Ͱ�Զ�����
  --left join so_delivery_b so_delivery_b on saleout_b.csourcebillbid = so_delivery_b.cdeliverybid
  left join so_saleorder_b saleorder_b on saleout_b.csourcebillbid = saleorder_b.csaleorderbid --���۶����ӱ�
  where /*substr(t.busidate,1,10)>='' and substr(t.busidate,1,10)<='' and */t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
        and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--��Դ������ϵͳ
        and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
        and orgs.name = '���䱦����ɷ����޹�˾����'
        and saleorder_b.dr=0
        and substr(t.busidate, 1, 10) >= '2023-01-01' and substr(t.busidate, 1, 10) <= substr(to_char(sysdate,'yyyy-mm-dd'),1,10)
),
fr_zj as (
  select distinct ���ⵥ���� from fr_v_verifydetail_ys
),
fr_v_zjyf as (
  select t.zj ����, t.dbizdate ��������, sum(t.ftyfje) ֱ���˷�
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
                  when b.nnum < dm_b.nnum AND dm_b.nnum <> 0 then
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
            and b.cgeneralbid in (select ���ⵥ���� from fr_zj)
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
                  when b.nnum < dm_b.nnum AND dm_b.nnum <> 0 then
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
            and b.cgeneralbid in (select ���ⵥ���� from fr_zj)) t
    group by t.zj, t.dbizdate
 ),
t2 as (-- �����к����ͻ��Ļ�Ͱ�˷�
  SELECT distinct
    cust.code �ͻ�����, sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over(partition by cust.code)  �ͻ����ܻ�Ͱ�˷�,sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over() �ͻ���Ͱ�˷��ܶ�
    FROM dm_delivbill_b b
    left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
    LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
    left join bd_customer cust on b.casscustid=cust.pk_customer
    WHERE h.dr = 0  AND b.dr = 0  AND m.name = '����Ͱ'
        and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10)
),
t2_1 as (
  SELECT distinct  sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over() �޺����ͻ��Ļ�Ͱ�˷�
    FROM dm_delivbill_b b
    left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
    LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
    left join bd_customer cust on b.casscustid=cust.pk_customer
    WHERE h.dr = 0  AND b.dr = 0  AND m.name = '����Ͱ'
      and cust.code not in (select distinct cust.code �ͻ�����
    from arap_verifydetail t --������ϸ��
    left join org_orgs orgs on t.pk_org = orgs.pk_org --������֯
    left join ar_recbill h on t.pk_bill = h.pk_recbill --Ӧ�յ�����
    left join ar_recitem b on t.pk_item = b.pk_recitem --Ӧ�յ��ֱ�
    left join bd_material m on t.material= m.pk_material --����
    left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --���ϻ�������
    left join bd_customer cust on t.customer = cust.pk_customer --�ͻ�
    left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --�ͻ���������
    left join org_orgs so_org on b.so_org = so_org.pk_org --������֯
    left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --���۷�Ʊ��������ϸ
    left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --���۷�Ʊ�ӱ�
    left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --���۳��ⵥ�ӱ�
    left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --���۳��ⵥ��ͷ
    left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --�Ƿ���Ͱ�Զ�����

    where substr(t.busidate,1,10)>='2023-01-01' and substr(t.busidate,1,10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10) and t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
          and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--��Դ������ϵͳ
          and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
          and orgs.name = '���䱦����ɷ����޹�˾����'
          and b.dr=0)
      and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10)
),
t31 as (
  SELECT
    dept.name ���۲���,prod.prodname_y ��Ʒ����,prod.prodclass_y ��Ʒ���,m.code ���ϱ���,m.name ��������,m.materialspec ���,to_number(case when b.pk_org = '0001B3100000004AG5D0' then b.vbdef10 else b.vbdef18 end) �˷ѽ��
    FROM dm_delivbill h
    INNER JOIN dm_delivbill_b b    ON h.cdelivbill_hid = b.cdelivbill_hid
    LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
    LEFT JOIN bd_stordoc stordoc    ON b.creceivestoreid = stordoc.pk_stordoc
    left join bd_material m on b.cinventoryid=m.pk_material
    left join fr_product_details prod on m.code=prod.prodcode
    left join bd_customer cust on b.casscustid = cust.pk_customer
    left join org_dept dept on b.vbdef20 = dept.pk_dept
    WHERE h.dr = 0  AND b.dr = 0  AND meta.billtypename = '���������ⵥ'  AND (stordoc.name = '���ϰ��´��ֿ�' or stordoc.name = '�������´��ֿ�')
      and substr(h.dbilldate,1,10)>='2023-01-01' and substr(h.dbilldate,1,10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10)
),
t3 as (-- �����˷�
  select t31.���۲��� ���۲���,sum(t31.�˷ѽ��)  ���ŵ����˷� from t31 group by t31.���۲���
),
t4 as (-- ���ͻ����˻��˷�
  SELECT
  distinct cust.code �ͻ�����, sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over(partition by cust.code)  ���ͻ������˻��˷�,sum(to_number(case when b.pk_org = '0001B3100000004AG5D0'  and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over()  �ͻ��˻��˷��ܶ�
    FROM dm_delivbill_b b
    left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
    LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
    left join bd_customer cust on b.casscustid=cust.pk_customer
    LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
    WHERE h.dr = 0  AND b.dr = 0 AND meta.billtypename IS NULL  AND m.name <> '����Ͱ'
        and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10)
),
t4_1 as (
  SELECT distinct  dept.name ����, sum(to_number(case when b.pk_org = '0001B3100000004AG5D0' and b.vbdef10 <> '~' then b.vbdef10 else b.vbdef18 end)) over(partition by dept.name)  ���Ż����˻��˷�
                FROM dm_delivbill_b b
                left JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
                LEFT JOIN bd_material m     ON b.cinventoryvid = m.pk_material
                left join bd_customer cust on b.casscustid=cust.pk_customer
                left join bd_custclass custclass on cust.pk_custclass = custclass.pk_custclass
                LEFT JOIN bd_billtype meta    ON b.vsrctype = meta.pk_billtypeid
                left join org_dept dept on b.vbdef20 = dept.pk_dept
                WHERE h.dr = 0  AND b.dr = 0 AND meta.billtypename IS NULL  AND m.name <> '����Ͱ'
                  and cust.code not in (select distinct cust.code �ͻ�����
                from arap_verifydetail t --������ϸ��
                left join org_dept dept on t.pk_deptid = dept.pk_dept--���۲���
                left join org_orgs orgs on t.pk_org = orgs.pk_org --������֯
                left join ar_recbill h on t.pk_bill = h.pk_recbill --Ӧ�յ�����
                left join ar_recitem b on t.pk_item = b.pk_recitem --Ӧ�յ��ֱ�
                left join bd_material m on t.material= m.pk_material --����
                left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass --���ϻ�������
                left join bd_customer cust on t.customer = cust.pk_customer --�ͻ�
                left join bd_custclass cust_class on cust.pk_custclass = cust_class.pk_custclass --�ͻ���������
                left join org_orgs so_org on b.so_org = so_org.pk_org --������֯
                left join so_squareinv_d djs on b.top_itemid = djs.csalesquaredid --���۷�Ʊ��������ϸ
                left join so_saleinvoice_b invoice_b on djs.csquarebillbid = invoice_b.csaleinvoicebid --���۷�Ʊ�ӱ�
                left join ic_saleout_b saleout_b on invoice_b.csrcbid = saleout_b.cgeneralbid --���۳��ⵥ�ӱ�
                left join ic_saleout_h saleout_h on saleout_b.cgeneralhid = saleout_h.cgeneralhid --���۳��ⵥ��ͷ
                left join bd_defdoc sfst on saleout_h.vdef1 = sfst.pk_defdoc --�Ƿ���Ͱ�Զ�����

                where substr(t.busidate,1,10)>='2023-01-01' and substr(t.busidate,1,10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10) and t.billclass = 'ys' and t.dr = 0 and t.busiflag <> 2 and h.src_syscode <> 0
                      and substr(clazz.code,1,2)<>'12' and h.src_syscode = '3'--��Դ������ϵͳ
                      and substr(saleout_b.dbizdate,1,10) >= '2017-06-01'
                      and orgs.name = '���䱦����ɷ����޹�˾����'
                      and b.dr=0)
                 and substr(h.dbilldate, 1, 10)>='2023-01-01' and substr(h.dbilldate, 1, 10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10)
),
t5 as (
  select distinct cust.code �ͻ�����, cust.name �ͻ�����,m.code ���ϱ���, m.name ��������, sum(t.local_money_de) over(partition by cust.code,m.code ) ���ͻ����ϻ��ܴ�����
             from arap_verifydetail t
                left join ar_recitem recitem on t.pk_item = recitem.pk_recitem
                left join ar_recbill recbill on recitem.pk_recbill = recbill.pk_recbill
                left join bd_inoutbusiclass szxm on recitem.pk_subjcode = szxm.pk_inoutbusiclass
                left join bd_material m on recitem.material = m.pk_material
                left join bd_customer cust on recitem.ordercubasdoc = cust.pk_customer
                left join org_dept dept on recitem.pk_deptid = dept.pk_dept

                where substr(t.busidate,1,10)>='2023-01-01' and substr(t.busidate,1,10)<=substr(to_char(sysdate,'yyyy-mm-dd'),1,10) and szxm.name ='�˷ѣ���Ʒ����Ͱ�����ڣ�'
                      and recitem.pk_org = '0001B3100000000028GW'
),
t_st as (
  select distinct b.cgeneralbid ���ⵥ����,s.name orgname,st.name storename
    from ic_saleout_b b
    left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid
    left join org_orgs s on h.pk_org = s.pk_org
    left join bd_stordoc st on h.cwarehouseid = st.pk_stordoc
    where b.dr = 0 and h.dr = 0 and s.dr = 0 and st.dr = 0 and b.cgeneralbid in (select ���ⵥ���� from fr_zj )
),
fr_details as (
  select t.������ϸ������,
       t.Ӧ�յ���������,
       t.���ⵥ����,
       t.���۳��ⵥ��,
       t.��������,
       t.�տ�����,
       t.��˾,
       t.���۲���,
       t.ҵ��Ա,
       t.��������,
       t.Ӧ�յ���,
       t.�տ��,
       t.���㷽ʽ,
       t.ժҪ,
       t.�����־,
       t.����־,
       t.�Ƿ���Ͱ,
       t.�ɱ���,
       t.�Ƿ�OEM,
       t.������֯,
       t.�ͻ���������,
       t.�ͻ�����,
       t.�ͻ�����,
       t.���ϱ���,
       t.��������,
       t.����ͺ�,
       t.��Ʒ����,
       t.��Ʒ����,
       t.��������˰��,
       t.��װ�ɱ�,
       t.���̳ɱ�,
       t.�跽���ҽ��,
       t.�跽����,
       t.�跽�����ҽ��,
       t.�跽��������,
       t.�����Һ�˰�ɹ�����,
       t.����,
       t.������Դϵͳ,
       t1.����,
       t1.ֱ���˷�,t_st.orgname  �����֯����,t_st.storename  �ֿ�����,
       CASE WHEN t.�跽���� <> 0 THEN round(t1.ֱ���˷� * t.�跽�������� / t.�跽����, 6) ELSE 0 end ֱ���˷ѷ�̯���,
       t2.�ͻ����ܻ�Ͱ�˷�,
       case  when t.�Ƿ���Ͱ = '��תͰ' then  t.�跽��������  else 0 end ��תҵ��������,
       sum(case when t.�Ƿ���Ͱ = '��תͰ' then  t.�跽�������� else 0 end) over(partition by t.�ͻ�����) ���ͻ�������תҵ��������,
       sum(case when t.�Ƿ���Ͱ = '��תͰ' then  t.�跽�������� else 0 end) over() ������תҵ��������,
       case when sum(case when t.�Ƿ���Ͱ = '��תͰ' then t.�跽�������� else 0 end) over(partition by t.�ͻ�����) = 0 then 0 else round(t.�跽�������� * t2.�ͻ����ܻ�Ͱ�˷� / sum(case when t.�Ƿ���Ͱ = '��תͰ' then t.�跽�������� else 0 end) over(partition by t.�ͻ�����), 6) end �ͻ���̯��Ͱ�˷�,
       t2.�ͻ���Ͱ�˷��ܶ�,
       t2_1.�޺����ͻ��Ļ�Ͱ�˷�,
       CASE WHEN (sum(case when t.�Ƿ���Ͱ = '��תͰ' then t.�跽�������� else 0 end) over()) = 0 THEN 0 ELSE  round(t2_1.�޺����ͻ��Ļ�Ͱ�˷� * (case when t.�Ƿ���Ͱ = '��תͰ' then t.�跽�������� else 0 end) / (sum(case when t.�Ƿ���Ͱ = '��תͰ' then t.�跽�������� else 0 end) over()),6) END �޺����ͻ���̯��Ͱ�˷�,
       sum(t.�跽��������) over(partition by t.���۲���) �����Ż��ܴ�������,
       t3.���ŵ����˷�,CASE WHEN (sum(t.�跽��������) over(partition by t.���۲���)) = 0 THEN 0 ELSE round(t3.���ŵ����˷�*t.�跽��������/(sum(t.�跽��������) over(partition by t.���۲���)) ,6) END ��̯�����˷�,
       t4.���ͻ������˻��˷�,
       sum(t.�跽��������) over(partition by t.�ͻ�����) ���ͻ����ܴ�������,
       CASE WHEN sum(t.�跽��������)over(partition by t.�ͻ�����) = 0 THEN 0 ELSE round(t4.���ͻ������˻��˷� * t.�跽�������� / sum(t.�跽��������)over(partition by t.�ͻ�����),6) END �ͻ���̯�˻��˷�,
       t4_1.���Ż����˻��˷�,
       CASE WHEN (sum(t.�跽��������) over(partition by t.���۲���)) = 0 THEN 0 ELSE round(t4_1.���Ż����˻��˷� * t.�跽�������� /(sum(t.�跽��������) over(partition by t.���۲���)),6) END �����ŷ�̯�˻��˷�,
       t5.���ͻ����ϻ��ܴ����� ���溣�˷Ѵ�����,
       sum(t.�跽�����ҽ��)over(partition by t.�ͻ�����,t.���ϱ���) ������ͻ����ϻ���
  from fr_v_verifydetail_ys t
  left join fr_v_zjyf t1 on t.���ⵥ���� = t1.����
  left join t2 on t.�ͻ����� = t2.�ͻ�����
  left join t2_1 on 1=1
  left join t3 on t.���۲��� = t3.���۲���
  left join t4 on t.�ͻ����� = t4.�ͻ�����
  left join t4_1 on t.���۲��� = t4_1.����
  left join t5 on t.�ͻ����� = t5.�ͻ����� and t.���ϱ��� = t5.���ϱ���
  left join t_st on t.���ⵥ���� = t_st.���ⵥ����
)
select t.������ϸ������,
       t.Ӧ�յ���������,
       t.���ⵥ����,
       t.���۳��ⵥ��,
       t.��������,
       t.�տ�����,
       t.��˾,
       t.���۲���,
       t.ҵ��Ա,
       t.��������,
       t.Ӧ�յ���,
       t.�տ��,
       t.���㷽ʽ,
       t.ժҪ,
       t.�����־,
       t.����־,
       t.�Ƿ���Ͱ,
       t.�ɱ���,
       t.�Ƿ�OEM,
       t.������֯,
       t.�ͻ���������,
       t.�ͻ�����,
       t.�ͻ�����,
       t.���ϱ���,
       t.��������,
       t.����ͺ�,
       t.��Ʒ����,
       t.��Ʒ����,
       t.��������˰��,
       t.��װ�ɱ�,
       t.���̳ɱ�,
       t.�跽���ҽ��,
       t.�跽����,
       t.�跽�����ҽ��,
       t.�跽��������,
       t.�����Һ�˰�ɹ�����,
       t.����,
       t.������Դϵͳ,t.ֱ���˷�,t.�����֯����,t.�ֿ�����,
       t.ֱ���˷ѷ�̯���,
       t.�ͻ����ܻ�Ͱ�˷�,
       t.��תҵ��������,
       t.���ͻ�������תҵ��������,
       t.������תҵ��������,
       t.�ͻ���̯��Ͱ�˷�,
       t.�ͻ���Ͱ�˷��ܶ�,
       t.�޺����ͻ��Ļ�Ͱ�˷�,
       t.�޺����ͻ���̯��Ͱ�˷�,
       t.�����Ż��ܴ�������,
       t.���ŵ����˷�,t.��̯�����˷�,
       t.���ͻ������˻��˷�,
       t.���ͻ����ܴ�������,
       t.�ͻ���̯�˻��˷�,
       t.���Ż����˻��˷�,
       t.�����ŷ�̯�˻��˷�,
       t.���溣�˷Ѵ�����,
       t.������ͻ����ϻ���,
       round(t.ֱ���˷ѷ�̯���+t.�ͻ���̯��Ͱ�˷�+t.�޺����ͻ���̯��Ͱ�˷�+t.��̯�����˷�+t.�ͻ���̯�˻��˷�+t.�����ŷ�̯�˻��˷�,2) �˷ѻ���,
       round(t.�跽��������*t.�����Һ�˰�ɹ�����*0.8547,2) �ɹ����,
       CASE WHEN t.������ͻ����ϻ��� = 0 THEN 0 ELSE round(t.�跽�����ҽ��* t.���溣�˷Ѵ�����/t.������ͻ����ϻ���,2) END ��̯��Ĵ����˷�
from fr_details t
