-- 取样单单据产品编码错误修正
-- 20010174
SELECT x.* FROM fr_dw_rds.fr_rw_rds_othersout_b x
WHERE JARSCODE = '20010174'  -- and id = 'QYCK20230927001'
;
SELECT x.* FROM fr_dw_rds.fr_rw_jars_balance_b x
WHERE jarscode ='20010174'-- and BILLCODE = 'QYCK20230605001'
;

select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010174' and t.PRODUCTCODE <> h.WINECODE 
;
-- 20010178
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010178' and t.PRODUCTCODE <> h.WINECODE 
;
-- 20010180
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010180' and t.PRODUCTCODE <> h.WINECODE 
;
-- 20010196
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010196' and t.PRODUCTCODE <> h.WINECODE 
;
-- 20010287
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010287' and t.PRODUCTCODE <> h.WINECODE 
;
-- 20010293
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010293' and t.PRODUCTCODE <> h.WINECODE 
;
-- 20010294
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010294' and t.PRODUCTCODE <> h.WINECODE 
;
-- 20010295
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010295' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 882 and PRODUCTCODE = '41110001'
;
-- 20010298
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010298' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 4028 and PRODUCTCODE = '41110001'
;
-- 20010299
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010299' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 1260 and PRODUCTCODE = '41110001'
;
-- 20010300
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010300' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 4104 and PRODUCTCODE = '41110001'
;
-- 20010302
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010302' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 1411 and PRODUCTCODE = '41110001'
;
-- 20010412
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010412' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 4258 and PRODUCTCODE = '41110001'
;
-- 20010440
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010440' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 557 and PRODUCTCODE = '41110001'
;
-- 20010551
select t.AUTOID ,t.ID ,t.DDATE ,t.JARSCODE ,t.PRODUCTCODE ,t.PRODUCTNAME ,t.CONVERT_65_WEIGHT ,b.ID ,h.WINECODE 
from fr_rw_rds_othersout_b t
left join fr_rw_jars_balance_b b on t.ID = b.BILLCODE and t.JARSCODE = b.JARSCODE 
left join fr_rw_jars_balance_h h on b.id = h.ID 
where t.JARSCODE = '20010551' and t.PRODUCTCODE <> h.WINECODE 
;
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110002',PRODUCTNAME = '五粮二级' where AUTOID = 482 and PRODUCTCODE = '41110001'
-- update fr_rw_rds_othersout_b set PRODUCTCODE = '41110001',PRODUCTNAME = '五粮一级' where AUTOID = 902 and PRODUCTCODE = '41110002'
;

