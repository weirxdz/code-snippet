-- 原酒收发存查询语句
-- 存在同一个容器有两种产品结存的情况，应该是单据有错误，需要进一步分析
WITH details AS (
  -- 查询截至日期之前的期初数据
  select distinct b.ID ,b.BILLCODE ,b.DDATE AS DDATE,b.JARSCODE ,h.WINECODE ,COALESCE(b.QUANTITY_IN,0) QUANTITY_IN,COALESCE(b.AQUANTITY_IN,0) AQUANTITY_IN,COALESCE(b.QUANTITY_OUT,0) QUANTITY_OUT,COALESCE(b.AQUANTITY_OUT,0) AQUANTITY_OUT
  from fr_rw_jars_balance_b b 
  left join fr_rw_jars_balance_h h on b.ID = h.ID and  h.dr = 0
  where b.BILLCODE = 'QC' and B.DR = 0 
    -- AND b.DDATE < '${v_start_date}' 
    AND b.DDATE <=  '${v_end_date}' 
     ${if(len(v_inventory_list)==0,"", " AND h.WINECODE IN ('" + v_inventory_list + "')")}
  UNION ALL
  -- 查询截至日期之前的到货单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_IN,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_IN,0 QUANTITY_OUT,0 AQUANTITY_OUT
  from fr_rw_rds_arrivalvouch_b b
  left join fr_rw_rds_arrivalvouch_h h on b.ID = h.ID  and  h.dr = 0
  where B.DR = 0 
    -- AND b.DDATE < '${v_start_date}' 
    AND b.DDATE <=  '${v_end_date}' 
    ${if(len(v_inventory_list)==0,"", " AND b.PRODUCTCODE IN ('" + v_inventory_list + "')")}
  UNION ALL
  -- 查询截至日期之前的产成品入库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_IN,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_IN,0 QUANTITY_OUT,0 AQUANTITY_OUT
  from fr_rw_rds_productin_b  b
  left join fr_rw_rds_productin_h h on b.ID = h.ID  and h.dr = 0
  where B.DR = 0 
    -- AND b.DDATE < '${v_start_date}' 
    AND b.DDATE <=  '${v_end_date}' 
--    ${if(len(v_inventory_list)==0,"", " AND b.PRODUCTCODE IN ('" + v_inventory_list + "')")}
  UNION ALL
  -- 查询截至日期之前的其他入库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_IN,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_IN,0 QUANTITY_OUT,0 AQUANTITY_OUT
  from fr_rw_rds_othersin_b  b
  left join fr_rw_rds_othersin_h h on b.ID = h.ID  and h.dr = 0
  where B.DR = 0 
    -- AND b.DDATE < '${v_start_date}' 
    AND b.DDATE <=  '${v_end_date}' 
    ${if(len(v_inventory_list)==0,"", " AND b.PRODUCTCODE IN ('" + v_inventory_list + "')")}
  UNION ALL
  -- 查询截至日期之前的材料出库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,0 QUANTITY_IN,0 AQUANTITY_IN,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_OUT,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_OUT
  from fr_rw_rds_materialout_b  b
  left join fr_rw_rds_materialout_h h on b.ID = h.ID  and h.dr = 0
  where B.DR = 0 
    -- AND b.DDATE < '${v_start_date}' 
    AND b.DDATE <=  '${v_end_date}' 
    ${if(len(v_inventory_list)==0,"", " AND b.PRODUCTCODE IN ('" + v_inventory_list + "')")}
  UNION ALL
  -- 查询截至日期之前的其他出库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,0 QUANTITY_IN,0 AQUANTITY_IN,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_OUT,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_OUT
  from fr_rw_rds_othersout_b  b
  left join fr_rw_rds_othersout_h h on b.ID = h.ID  and h.dr = 0
  where B.DR = 0 
    -- AND b.DDATE < '${v_start_date}' 
    AND b.DDATE <=  '${v_end_date}' 
    ${if(len(v_inventory_list)==0,"", " AND b.PRODUCTCODE IN ('" + v_inventory_list + "')")}
   ),
   mlist AS (
   SELECT DISTINCT  t.JARSCODE ,t.WINECODE FROM details t
   ),
   qc AS (
   SELECT t.JARSCODE ,t.WINECODE,SUM(QUANTITY_IN)-SUM(QUANTITY_OUT) AS qc_QUANTITY,SUM(AQUANTITY_IN)-SUM(AQUANTITY_OUT) AS qc_AQUANTITY 
   FROM details t 
   WHERE t.ddate < '${v_start_date}' 
   GROUP BY t.JARSCODE ,t.WINECODE
   ),
   income AS (
   SELECT t.JARSCODE ,t.WINECODE,SUM(QUANTITY_IN) AS in_QUANTITY,SUM(AQUANTITY_IN)AS in_AQUANTITY 
   FROM details t 
   WHERE t.ddate >= '${v_start_date}' AND  t.ddate <= '${v_end_date}' 
   GROUP BY t.JARSCODE ,t.WINECODE   
   ),
   outgo AS (
   SELECT t.JARSCODE ,t.WINECODE,SUM(QUANTITY_OUT) AS out_QUANTITY,SUM(AQUANTITY_OUT)AS out_AQUANTITY 
   FROM details t 
   WHERE t.ddate >= '${v_start_date}' AND  t.ddate <= '${v_end_date}' 
   GROUP BY t.JARSCODE ,t.WINECODE   
   ),
   rz AS (
   select m.JARSCODE,m.WINECODE,p.cname ,p.Inventory_category,COALESCE(qc.qc_QUANTITY ,0) AS qc_QUANTITY,COALESCE(qc.qc_AQUANTITY ,0) AS qc_AQUANTITY,
   COALESCE(income.in_QUANTITY ,0) AS in_QUANTITY,COALESCE(income.in_AQUANTITY ,0) AS in_AQUANTITY,
   COALESCE(outgo.out_QUANTITY ,0) AS out_QUANTITY,COALESCE(outgo.out_AQUANTITY ,0) AS out_AQUANTITY,
   COALESCE(qc.qc_QUANTITY ,0) + COALESCE(income.in_QUANTITY ,0) - COALESCE(outgo.out_QUANTITY ,0) AS jc_QUANTITY,
   COALESCE(qc.qc_AQUANTITY ,0) + COALESCE(income.in_AQUANTITY ,0) - COALESCE(outgo.out_AQUANTITY ,0) AS jc_AQUANTITY,
   CASE WHEN p.Inventory_category = '半成品酒' THEN COALESCE(income.in_AQUANTITY ,0) ELSE COALESCE(income.in_QUANTITY ,0) END AS Receiving,
   CASE WHEN p.Inventory_category = '半成品酒' THEN COALESCE(outgo.out_AQUANTITY ,0) ELSE COALESCE(outgo.out_QUANTITY ,0) END AS Dispatch,
   CASE WHEN p.Inventory_category = '半成品酒' THEN COALESCE(qc.qc_AQUANTITY ,0) + COALESCE(income.in_AQUANTITY ,0) - COALESCE(outgo.out_AQUANTITY ,0) ELSE COALESCE(qc.qc_QUANTITY ,0) + COALESCE(income.in_QUANTITY ,0) - COALESCE(outgo.out_QUANTITY ,0) END AS Stock
   from mlist m
   LEFT JOIN fr_rw_rds_product p ON m.WINECODE = p.ccode
   LEFT JOIN qc ON m.WINECODE = qc.WINECODE AND m.jarscode = qc.jarscode
   LEFT JOIN income ON m.WINECODE = income.WINECODE AND m.jarscode = income.jarscode
   LEFT JOIN outgo ON m.WINECODE = outgo.WINECODE AND m.jarscode = outgo.jarscode
   )
   select jar.ccode ,rz.WINECODE,rz.cname ,rz.Inventory_category,rz.Receiving,rz.dispatch,rz.Stock,rz.*
	  from fr_rw_wine_jars jar  
	  left join rz  on jar.ccode = rz.jarscode and rz.Stock <> 0
    where -- (rz.Receiving <> 0 and rz.Stock <> 0 or rz.dispatch <> 0 and rz.Stock <> 0 or rz.Receiving = 0 and rz.dispatch = 0 and rz.Stock = 0) AND 
     rz.jarscode  <> '0'
--     	and  rz.jarscode = '10070002'    
    	and  jar.cwhcode<>'8888'
