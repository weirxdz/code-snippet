-- 查询系统现有的directory
SELECT *
FROM DBA_DIRECTORIES
;
grant read,write on directory NCBAK to blbzs ;
-- 导出
expdp blbzs@nc  parallel=8  directory=NCBAK dumpfile=exp230531_%U.dmp schemas=blbzs logfile=exp230531.log

-- 创建用户

create user blb230531 identified by ***** default tablespace NNC_DATA01 temporary tablespace temp; 

-- 用户授权
grant connect,dba to blb230531;  -- cms系统中需要增加grant create view to bp_oracle视图权限

-- 用户可以 访问dump_dir 方便进行导入和导出操作
grant read,write on directory NCBAK to blb230531;  -- 如果没有dump_dir可以建立

impdp blb230531/blb230531@nc parallel=8  directory=NCBAK dumpfile=exp230531_%U.dmp  logfile=imp230531.log schemas=blbzs remap_schema=blbzs:blb230531


expdp blbzs@nc  parallel=8  directory=NCBAK dumpfile=exp230627_%U.dmp schemas=blbzs logfile=exp230627.log FILESIZE=12G
-- 创建用户

create user blb230627 identified by *** default tablespace NNC_DATA01 temporary tablespace temp; 

-- 用户授权
grant connect,dba to blb230627;  -- cms系统中需要增加grant create view to bp_oracle视图权限

-- 用户可以 访问dump_dir 方便进行导入和导出操作
grant read,write on directory NCBAK to blb230627; 

impdp blb230627/****@nc parallel=8  directory=NCBAK dumpfile=exp230627_%U.dmp  logfile=imp230627.log schemas=blbzs remap_schema=blbzs:blb230627
-- 有异常的表、视图、存储过程
SELECT *
FROM user_objects
WHERE object_type = 'PROCEDURE';

