-- ��ѯϵͳ���е�directory
SELECT *
FROM DBA_DIRECTORIES
;
grant read,write on directory NCBAK to blbzs ;
-- ����
expdp blbzs@nc  parallel=8  directory=NCBAK dumpfile=exp230531_%U.dmp schemas=blbzs logfile=exp230531.log

-- �����û�

create user blb230531 identified by ***** default tablespace NNC_DATA01 temporary tablespace temp; 

-- �û���Ȩ
grant connect,dba to blb230531;  -- cmsϵͳ����Ҫ����grant create view to bp_oracle��ͼȨ��

-- �û����� ����dump_dir ������е���͵�������
grant read,write on directory NCBAK to blb230531;  -- ���û��dump_dir���Խ���

impdp blb230531/blb230531@nc parallel=8  directory=NCBAK dumpfile=exp230531_%U.dmp  logfile=imp230531.log schemas=blbzs remap_schema=blbzs:blb230531


expdp blbzs@nc  parallel=8  directory=NCBAK dumpfile=exp230627_%U.dmp schemas=blbzs logfile=exp230627.log FILESIZE=12G
-- �����û�

create user blb230627 identified by *** default tablespace NNC_DATA01 temporary tablespace temp; 

-- �û���Ȩ
grant connect,dba to blb230627;  -- cmsϵͳ����Ҫ����grant create view to bp_oracle��ͼȨ��

-- �û����� ����dump_dir ������е���͵�������
grant read,write on directory NCBAK to blb230627; 

impdp blb230627/****@nc parallel=8  directory=NCBAK dumpfile=exp230627_%U.dmp  logfile=imp230627.log schemas=blbzs remap_schema=blbzs:blb230627
-- ���쳣�ı���ͼ���洢����
SELECT *
FROM user_objects
WHERE object_type = 'PROCEDURE';

