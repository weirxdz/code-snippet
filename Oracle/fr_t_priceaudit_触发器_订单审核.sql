CREATE OR REPLACE TRIGGER fr_t_priceaudit
  before insert or update  on so_saleorder_b
  for each row

declare
  t_isaudit          varchar2(2);
  t_code             varchar2(20);
  t_prod_cost        number(12, 4);--一般裸品价格
  t_prod_cost_quarter  number(12, 4);--季度裸品价格
  t_packing_cost     number(12, 2);
  t_exp_packing_cost number(12, 2);
  t_turnover_cost    number(12, 2);
  t_tonbox_rental    number(12, 2);--吨箱租金，按个，需要转换到每吨
  t_exp_tax          number(6, 2);
  t_profit_t         number(9, 2);
  t_export_profit_t  number(9, 2);
  t_ex_factory_price number(9, 2);
  t_burden           number(9, 2);--制造费用
  t_deprecost        number(9, 2);--折旧费用
  t_labour_cost      number(9,2);--人工费用
  t_burden_a         number(9,2);--辅助部门制费
  c_packing_cost     number(9,2);
  c_pallet_cost      number(9,2);
  t_sfst             varchar2(20);
  t_sftp             varchar2(20);
  t_isQuarter             varchar2(20);
  t_diff             number(9,2);
  t_gross_profit            number(9,2);-- 吨毛利
  t_gross_profit_rate            number(9,2);-- 毛利率
  t_tax_factor            number(10,9);-- 税率系数
  t_unitflag         number(6,2);
  t_fbuysellflag     number(6,2);
begin
  if (:new.pk_org = '0001B3100000000028HE' -- 淀粉糖事业部
    or :new.pk_org = '0001B31000000001VU4Q'-- 国际业务部
    or :new.pk_org = '0001B3100000000028GZ'-- 国内业务部
    or :new.pk_org = '0001B3100000000028GW'-- 保龄宝本部
    or :new.pk_org = '0001B31000000048Q71R'-- 保龄宝国际
    or :new.pk_org = '0001B31000000039DYB9'-- 保龄宝青岛，20231218添加
    ) and :new.blargessflag = 'N' -- 仅对非赠品行进行处理，赠品行不处理
    then --筛选销售组织
    t_tax_factor := 0.884955752;
    select nvl(bd_material.code,'')                  into t_code             from bd_material       where bd_material.pk_material = :new.cmaterialid ;
    select nvl((select fr_v_priceaudit.isprice_audit             from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),'Y') into t_isaudit          from dual;
    select nvl((select nvl(fr_v_priceaudit.prod_cost,0)          from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_prod_cost        from dual;
    select nvl((select nvl(fr_v_priceaudit.prod_cost_quarter,0)  from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_prod_cost_quarter        from dual;
    select nvl((select nvl(fr_v_priceaudit.packing_cost,0)       from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_packing_cost     from dual;
    select nvl((select nvl(fr_v_priceaudit.exp_packing_cost,0)   from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_exp_packing_cost from dual;
    select nvl((select nvl(fr_v_priceaudit.turnover_cost,0)      from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_turnover_cost    from dual;
    select nvl(bd_address.postcode,120)                  into t_tonbox_rental             from bd_address       where :new.creceiveaddrid =  bd_address.pk_address;--取得每个吨箱的租金价格
    select nvl((select nvl(fr_v_priceaudit.exp_tax,0)            from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_exp_tax          from dual;
    select nvl((select nvl(fr_v_priceaudit.profit_t,0)           from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_profit_t         from dual;
    select nvl((select nvl(fr_v_priceaudit.export_profit_t,0)    from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_export_profit_t  from dual;
    select nvl((select nvl(fr_v_priceaudit.ex_factory_price,0)   from fr_v_priceaudit   where fr_v_priceaudit.prodcode = t_code),0)   into t_ex_factory_price from dual;
    select so_saleorder.vdef1                        into t_sfst from so_saleorder      where so_saleorder.csaleorderid = :new.csaleorderid;
    select so_saleorder.vdef6                        into t_sftp from so_saleorder      where so_saleorder.csaleorderid = :new.csaleorderid;
    select so_saleorder.vdef16                       into t_isQuarter from so_saleorder      where so_saleorder.csaleorderid = :new.csaleorderid;
      -- 如果vbdef17 处填写的值为 0 ，重置为 '~'
      if :NEW.vbdef17 <>'~' and to_number(nvl(:NEW.vbdef17,0)) = 0 then :new.vbdef17 := '~'; end if;
      if :new.vbdef18 = '~' then :new.vbdef18 := 0; end if;
      if :new.vbdef19 = '~' then :new.vbdef19 := 0; end if;
      if :NEW.cunitid = '0001Z0100000000000XK'  then-- 主单位为吨
            t_unitflag := 1;
      elsif :NEW.cunitid = '0001Z0100000000000XI' or  :NEW.cunitid = '1001B3100000000D26QT'  then-- 主单位为千克
            t_unitflag := 1000;
      else  t_unitflag := 1;
      end if;
      if  :NEW.ntaxprice <> :new.nprice then -- 国内销售
        t_fbuysellflag := 0;
      elsif :NEW.ntaxprice = :new.nprice then -- 出口销售
        t_fbuysellflag := nvl(t_exp_tax,0.00);
        t_profit_t     := to_number(nvl(t_export_profit_t,0));
      end if;
      if t_isaudit = 'N' AND :NEW.vbdef17 = '~'  THEN-- 采购价处有值即判定为OEM;只有采购价没有填写的不审核的物料（包括不审核的非OEM物料）才直接置vbdef16 为N
      :NEW.vbdef16 := 'N';
      :NEW.vbdef11 :=0;
      end if;
      if :NEW.vbdef17 <>'~'  then-- 采购单价处填写的有值，包括OEM业务和直运业务，此处不管物料是否控制销售价格，都进行判断
        if :new.vbdef6 = '~' then :new.vbdef6 := 0; end if;
        if :NEW.ntaxprice <> :new.nprice then -- 国内销售
          -- 吨价差 = 售价-预估吨运费-海运费-港杂空运-采购价
          t_diff :=  :NEW.nprice * t_unitflag - :new.vbdef6 - round(t_unitflag * :new.vbdef18 * :new.nexchangerate / :new.nnum,4) - :new.vbdef19 - :NEW.vbdef17 * t_unitflag * t_tax_factor;
          t_gross_profit_rate := round( t_diff / (:NEW.nprice * t_unitflag),3);
        elsif :NEW.ntaxprice = :new.nprice then-- 出口
          -- 吨价差 = 售价-预估吨运费-海运费-港杂空运-采购价
          t_diff := :NEW.nprice * t_unitflag * (1 - t_exp_tax) - :new.vbdef6 - round(t_unitflag * :new.vbdef18 * :new.nexchangerate / :new.nnum,4) - :new.vbdef19 - :NEW.vbdef17 * t_unitflag * t_tax_factor ;
          t_gross_profit_rate := round( t_diff / (:NEW.nprice * t_unitflag* (1 - t_exp_tax)),3);-- 毛利率
        end if;
        :NEW.vdef22 := t_gross_profit_rate; -- 毛利率
        :NEW.vbdef11 := t_diff ;
        :NEW.vdef21 := ROUND(t_diff * :NEW.NNUM / t_unitflag,2) ;-- 毛利
        
        if t_gross_profit_rate < 0 then -- 毛利率小于零
          :NEW.vbdef16 := 'AA';  
        elsif t_gross_profit_rate >= 0 and t_gross_profit_rate <= 0.06 then
          :NEW.vbdef16 := 'A';          
        elsif t_gross_profit_rate > 0.06 then 
              :NEW.vbdef16 := 'N';
        end if;
        :new.prodcost  := :NEW.vbdef17 * t_unitflag * t_tax_factor;
      end if;
      if t_isaudit <> 'N' and :NEW.vbdef17 = '~' then -- 采购单价处未填写值，认为是一般销售业务
        if t_ex_factory_price > 0 then-- 出厂指导价大于零，则跟出厂指导价比较
          if :new.vbdef6 = '~' then :new.vbdef6 := 0; end if;
          if :new.vbdef7 = '~' then :new.vbdef7 := 0; end if;
          :new.ex_factory_price := t_ex_factory_price;
          -- 吨价差 = 售价-出厂价-预估吨运费-预估回桶吨运费-海运费-港杂空运
          t_diff := :new.nprice * t_unitflag * (1 - t_fbuysellflag) -  t_ex_factory_price * t_tax_factor - :new.vbdef6 - :new.vbdef7 - round(t_unitflag * :new.vbdef18 * :new.nexchangerate / :new.nnum,4)  - :new.vbdef19 ;
          t_gross_profit_rate := round( t_diff / (:new.nprice * t_unitflag * (1 - t_fbuysellflag)),3);
          :NEW.vdef22 := t_gross_profit_rate; -- 毛利率
          :NEW.vbdef11 := t_diff ;
          :NEW.vdef21 := ROUND(t_diff * :NEW.NNUM / t_unitflag,2);-- 毛利
          if t_gross_profit_rate < 0 then
            :NEW.vbdef16 := 'AA';
          elsif t_gross_profit_rate >= 0 and t_gross_profit_rate <= 0.06 then
            :NEW.vbdef16 := 'A';
          elsif t_gross_profit_rate > 0.06 then 
            :NEW.vbdef16 := 'N';
          end if;
          :new.prodcost  := t_ex_factory_price * t_tax_factor;
        end if;-- 出厂指导价大于零，则跟出厂指导价比较结束
        if t_ex_factory_price <= 0 then -- 出厂指导价不大于0，则跟目标利润比较
          if :new.vbdef6 = '~' then :new.vbdef6 := 0; end if;
          if :new.vbdef7 = '~' then :new.vbdef7 := 0; end if;
          --把地址簿上的邮政编码处填写上吨箱的租赁价格后，取消掉下面这句的注释，稍加改动即可
          select case when t_sfst = '1001B3100000000573ZA'--售桶
                            or t_sfst = '1001B31000000005A084'-- 其它
                        then t_packing_cost
                      when t_sfst = '1001B3100000000573ZD' -- 周转桶
                        then t_turnover_cost
                      when t_sfst = '1001B3100000000KXJLJ' -- 吨箱
                        then round(t_tonbox_rental/1.06*:new.nastnum*t_unitflag/:new.nnum,4)
                      else 0 end into c_packing_cost from dual;
          select case  when t_sftp = '1001B3100000000GXK98' or t_sftp = '1001B3100000000HJC28' then 185.3 when t_sftp = '1001B3100000000GXK99' or t_sftp = '1001B3100000000HJC2A' then 37.06 when t_sftp = '1001B3100000000HJC26' then 66.77 when t_sftp = '1001B3100000000HJC29' then 13.9 else 0 end into c_pallet_cost from dual;
          select nvl((select fpb.burden_all  from fr_prodclass_burden_list fpb where fpb.producing_dept = (select orgs.name from org_orgs orgs where orgs.pk_org = :new.csendstockorgid) and fpb.product = (select pd.prodname_y from fr_product_details pd where pd.prodcode = t_code)),0) into t_burden from dual;
          select nvl((select fpb.depre_cost from fr_prodclass_burden_list fpb where fpb.producing_dept = (select orgs.name from org_orgs orgs where orgs.pk_org = :new.csendstockorgid) and fpb.product = (select pd.prodname_y from fr_product_details pd where pd.prodcode = t_code)),0) into t_deprecost from dual;
          select nvl((select fpb.labour_cost from fr_prodclass_burden_list fpb where fpb.producing_dept = (select orgs.name from org_orgs orgs where orgs.pk_org = :new.csendstockorgid) and fpb.product = (select pd.prodname_y from fr_product_details pd where pd.prodcode = t_code)),0) into t_labour_cost from dual;
          select nvl((select fpb.burden_a from fr_prodclass_burden_list fpb where fpb.producing_dept = (select orgs.name from org_orgs orgs where orgs.pk_org = :new.csendstockorgid) and fpb.product = (select pd.prodname_y from fr_product_details pd where pd.prodcode = t_code)),0) into t_burden_a from dual;
          if  t_isQuarter = '1001B310000000026FZB'        then /*季度合同的订单*/
            -- 吨价差 = 售价 - 裸品成本 - 包装成本 - 托盘成本 - 预估吨运费 - 预估回桶吨运费 - 制造费用 - 海运费 - 港杂空运费 - 目标利润
            t_diff         := :new.nprice * t_unitflag * (1 - t_fbuysellflag)- t_prod_cost_quarter -  c_packing_cost - c_pallet_cost - :new.vbdef6 - :new.vbdef7 - t_burden - round(t_unitflag * :new.vbdef18 * :new.nexchangerate / :new.nnum,4) - :new.vbdef19 - t_profit_t * t_tax_factor ;
            t_gross_profit := :new.nprice * t_unitflag * (1 - t_fbuysellflag)- t_prod_cost_quarter -  c_packing_cost - c_pallet_cost - :new.vbdef6 - :new.vbdef7 - t_burden - round(t_unitflag * :new.vbdef18 * :new.nexchangerate / :new.nnum,4) - :new.vbdef19 ;
            t_gross_profit_rate := round( t_gross_profit / (:new.nprice * t_unitflag * (1 - t_fbuysellflag)),3);
            :new.prodcost  := t_prod_cost_quarter;
          elsif t_isQuarter <> '1001B310000000026FZB'   then /*不是季度合同的订单*/
            -- 吨价差 = 售价 - 裸品成本 - 包装成本 - 托盘成本 - 预估吨运费 - 预估回桶吨运费 - 制造费用 - 海运费 - 港杂空运费 - 目标利润
            t_diff := :new.nprice * t_unitflag * (1 - t_fbuysellflag)- t_prod_cost -  c_packing_cost - c_pallet_cost - :new.vbdef6 - :new.vbdef7 - t_burden - round(t_unitflag * :new.vbdef18 * :new.nexchangerate / :new.nnum,4) - :new.vbdef19 - t_profit_t * t_tax_factor ;
            t_gross_profit := :new.nprice * t_unitflag * (1 - t_fbuysellflag)- t_prod_cost -  c_packing_cost - c_pallet_cost - :new.vbdef6 - :new.vbdef7 - t_burden - round(t_unitflag * :new.vbdef18 * :new.nexchangerate / :new.nnum,4) - :new.vbdef19 ;
            t_gross_profit_rate := round( t_gross_profit / (:new.nprice * t_unitflag * (1 - t_fbuysellflag)),3);
            :new.prodcost  := t_prod_cost;
          end if;
          :new.packing_cost := c_packing_cost; :new.pallet_cost := c_pallet_cost; :new.burden_cost := t_burden; :new.labour_cost := t_labour_cost; :new.deprecost := t_deprecost; :new.burden_a := t_burden_a; :new.profit_t := t_profit_t;
          :NEW.vbdef11 := t_diff ;
          :NEW.vdef21 := ROUND(t_gross_profit * :NEW.NNUM / t_unitflag,2);
          :NEW.vdef22 := t_gross_profit_rate ;
          if t_gross_profit_rate < 0 then 
            :NEW.vbdef16 := 'AA';
          elsif t_gross_profit_rate >= 0 and t_gross_profit_rate <= 0.06 then
            :NEW.vbdef16 := 'A';
          elsif t_gross_profit_rate > 0.06 then -- 毛利率高于0.06
            if  t_diff >0 then -- 不审核
                :NEW.vbdef16 := 'N';
            elsif t_diff <= 0 and t_diff + 0.5 * t_profit_t*t_tax_factor > 0 then  -- 总监审核
                :NEW.vbdef16 := 'C';
            elsif t_diff + 0.5 * t_profit_t*t_tax_factor <= 0 and t_diff + t_tax_factor * t_profit_t + t_deprecost + 0.5*t_labour_cost + 0.5*t_burden_a > 0 then -- 副总审核
                :NEW.vbdef16 := 'B';
            elsif t_diff + t_tax_factor * t_profit_t + t_deprecost + 0.5*t_labour_cost + 0.5*t_burden_a <= 0 then -- 执行总裁审核
                :NEW.vbdef16 := 'A';
            end if;
          end if;
        end if;
      end if;
  end if;
end;
