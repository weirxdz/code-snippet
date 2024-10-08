-- 原酒盘点表语句
-- 存在一个容器有两个产品的结存的情况，应该是有数据错误，找出来看一下，把错误的出入库单据处理一下


with details AS (
  -- 查询截至日期之前的期初数据
 select distinct b.ID ,b.BILLCODE ,b.DDATE AS DDATE,b.JARSCODE , h.WINECODE ,
 COALESCE(b.QUANTITY_IN,0) QUANTITY_IN,COALESCE(b.AQUANTITY_IN,0) AQUANTITY_IN,COALESCE(b.QUANTITY_OUT,0) QUANTITY_OUT,COALESCE(b.AQUANTITY_OUT,0) AQUANTITY_OUT
  from fr_rw_jars_balance_b b 
  left join fr_rw_jars_balance_h h on b.ID = h.ID and  h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where b.BILLCODE = 'QC' and B.DR = 0 
   and jar.cwhcode<>'8888'
   
    AND b.DDATE <=  '${v_end_date}' 

  UNION ALL
  -- 查询截至日期之前的到货单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,
  b.PRODUCTCODE WINECODE,
  COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_IN,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_IN,0 QUANTITY_OUT,0 AQUANTITY_OUT
  from fr_rw_rds_arrivalvouch_b b
  left join fr_rw_rds_arrivalvouch_h h on b.ID = h.ID  and  h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where B.DR = 0 
    AND b.DDATE <=  '${v_end_date}' 
   and jar.cwhcode<>'8888'

  UNION ALL
  -- 查询截至日期之前的产成品入库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,
  b.PRODUCTCODE WINECODE,
  COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_IN,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_IN,0 QUANTITY_OUT,0 AQUANTITY_OUT
  from fr_rw_rds_productin_b  b
  left join fr_rw_rds_productin_h h on b.ID = h.ID  and h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where B.DR = 0 
    AND b.DDATE <=  '${v_end_date}' 
   and jar.cwhcode<>'8888'

  UNION ALL
  -- 查询截至日期之前的其他入库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,
  b.PRODUCTCODE WINECODE,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_IN,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_IN,0 QUANTITY_OUT,0 AQUANTITY_OUT
  from fr_rw_rds_othersin_b  b
  left join fr_rw_rds_othersin_h h on b.ID = h.ID  and h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where B.DR = 0 
    AND b.DDATE <=  '${v_end_date}' 
   and jar.cwhcode<>'8888'

    UNION ALL
  -- 查询截至日期之前的内部其他入库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_IN,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_IN,0 QUANTITY_OUT,0 AQUANTITY_OUT
  from fr_rw_rds_frin_b  b
  left join fr_rw_rds_frin_h h on b.ID = h.ID  and h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where B.DR = 0 
    AND b.DDATE <=  '${v_end_date}' 
   and jar.cwhcode<>'8888'

  UNION ALL
  -- 查询截至日期之前的材料出库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,0 QUANTITY_IN,0 AQUANTITY_IN,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_OUT,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_OUT
  from fr_rw_rds_materialout_b  b
  left join fr_rw_rds_materialout_h h on b.ID = h.ID  and h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where B.DR = 0 
    AND b.DDATE <=  '${v_end_date}' 
   and jar.cwhcode<>'8888'

  UNION ALL
  
  -- 查询截至日期之前的其他出库单
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,0 QUANTITY_IN,0 AQUANTITY_IN,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_OUT,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_OUT
  from fr_rw_rds_othersout_b  b
  left join fr_rw_rds_othersout_h h on b.ID = h.ID  and h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where B.DR = 0 
    AND b.DDATE <=  '${v_end_date}' 
   and jar.cwhcode<>'8888'
-- 
   UNION ALL
   
  select b.AUTOID ID ,b.ID billcode,b.DDATE  AS DDATE,b.JARSCODE ,b.PRODUCTCODE WINECODE,0 QUANTITY_IN,0 AQUANTITY_IN,COALESCE(b.CONVERT_65_WEIGHT ,0) QUANTITY_OUT,COALESCE(b.ACTUAL_WEIGHT ,0) AQUANTITY_OUT
  from fr_rw_rds_frout_b  b
  left join fr_rw_rds_frout_h h on b.ID = h.ID  and h.dr = 0
left join fr_rw_wine_jars jar on b.jarscode = jar.ccode
  where B.DR = 0 
    AND b.DDATE <=  '${v_end_date}' 
   and jar.cwhcode<>'8888'
),
   mlist AS (
   SELECT DISTINCT  t.jarscode ,winecode FROM details t
   ),
   qc AS (
   SELECT t.jarscode,t.WINECODE,SUM(QUANTITY_IN)-SUM(QUANTITY_OUT) AS qc_QUANTITY,SUM(AQUANTITY_IN)-SUM(AQUANTITY_OUT) AS qc_AQUANTITY -- , t.WINECODE
   FROM details t 
   WHERE t.ddate <= '${v_end_date}' -- and t.billcode='QC' 
   GROUP BY t.jarscode,t.WINECODE
   ),
   income AS (
   SELECT t.jarscode,t.WINECODE,SUM(QUANTITY_IN) AS in_QUANTITY,SUM(AQUANTITY_IN)AS in_AQUANTITY
   FROM details t 
   WHERE  t.ddate <= '${v_end_date}' 
   GROUP BY t.jarscode,t.WINECODE   
   ),
   outgo AS (
   SELECT t.jarscode,t.WINECODE,SUM(QUANTITY_OUT) AS out_QUANTITY,SUM(AQUANTITY_OUT)AS out_AQUANTITY 
   FROM details t 
   WHERE t.ddate <= '${v_end_date}' 
   GROUP BY t.jarscode,t.WINECODE   
   ),
	z as (
	select z1.jarscode ,z1.WINECODE,z1.cname ,z1.Inventory_category,z1.Receiving,z1.dispatch,z1.Stock,z1.jc_quantity,z1.jc_AQUANTITY
	from ( select m.jarscode ,m.WINECODE,p.cname ,p.Inventory_category,
	   COALESCE(qc.qc_QUANTITY ,0) AS qc_QUANTITY,COALESCE(qc.qc_AQUANTITY ,0) AS qc_AQUANTITY,
	   COALESCE(income.in_QUANTITY ,0) AS in_QUANTITY,COALESCE(income.in_AQUANTITY ,0) AS in_AQUANTITY,
	   COALESCE(outgo.out_QUANTITY ,0) AS out_QUANTITY,COALESCE(outgo.out_AQUANTITY ,0) AS out_AQUANTITY,
	  /* COALESCE(qc.qc_QUANTITY ,0) +*/ COALESCE(income.in_QUANTITY ,0) - COALESCE(outgo.out_QUANTITY ,0) AS jc_QUANTITY,
	  /* COALESCE(qc.qc_AQUANTITY ,0) +*/ COALESCE(income.in_AQUANTITY ,0) - COALESCE(outgo.out_AQUANTITY ,0) AS jc_AQUANTITY,
	   CASE WHEN p.Inventory_category = '半成品酒'  THEN COALESCE(income.in_AQUANTITY ,0) ELSE COALESCE(income.in_QUANTITY ,0) END AS Receiving,
	   CASE WHEN p.Inventory_category = '半成品酒'  THEN COALESCE(outgo.out_AQUANTITY ,0) ELSE COALESCE(outgo.out_QUANTITY ,0) END AS Dispatch,
	   CASE WHEN p.Inventory_category = '半成品酒'  THEN /*COALESCE(qc.qc_AQUANTITY ,0) +*/ COALESCE(income.in_AQUANTITY ,0) - COALESCE(outgo.out_AQUANTITY ,0) ELSE /* COALESCE(qc.qc_QUANTITY ,0) +*/ COALESCE(income.in_QUANTITY ,0) - COALESCE(outgo.out_QUANTITY ,0) END AS Stock
	   from mlist m
	   LEFT JOIN fr_rw_rds_product p on m.winecode=p.ccode 
	   LEFT JOIN qc ON m.JARSCODE = qc.JARSCODE and m.WINECODE = qc.WINECODE
	   LEFT JOIN income ON m.JARSCODE = income.JARSCODE and m.WINECODE = income.WINECODE
	   LEFT JOIN outgo ON m.JARSCODE = outgo.JARSCODE and m.WINECODE = outgo.WINECODE
	   )z1 
	   where  -- (z1.Receiving <> 0 and z1.Stock <> 0 or z1.dispatch <> 0 and z1.Stock <> 0 or z1.Receiving = 0 and z1.dispatch = 0 and z1.Stock = 0 ) and
	    z1.jarscode <> '0'
	)
select  j.cwhcode,j.ccode ,z.WINECODE,z.cname ,z.Inventory_category,z.Receiving,z.dispatch,z.Stock,z.jc_quantity,z.jc_AQUANTITY
from fr_rw_wine_jars j -- 用酒坛酒罐档案表关联，能够把没有酒的空坛空罐显示出来
left join z on j.ccode = z.jarscode and z.Stock <> 0
where j.cwhcode <> '8888'
order by  j.ccode ,z.WINECODE,z.Stock 