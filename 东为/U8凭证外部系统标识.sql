-- 凭证外部系统标识
select  g.ino_id ,g.coutsysname,g.iflagbank,g.iflagperson  ,g.* 
from gl_accvouch g 
WHERE g.iyear = 2024 AND g.iperiod = 3 AND g.ino_id = 324
;
update gl_accvouch set coutsysname=null where iyear = 2024 AND iperiod = 3 AND ino_id = 324