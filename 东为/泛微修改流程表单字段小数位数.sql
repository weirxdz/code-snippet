--《工作流单据信息表》 查 对应流程表单 ID
SELECT ID FROM workflow_bill WHERE TABLENAME='formtable_main_84'; --查询流程表单 ID

--《工作流单据字段表》 WHERE billid(单据ID) AND FIELDNAME(字段名) AND DETAILTABLE(明细表)
SELECT * FROM workflow_billfield WHERE billid=-84 AND FIELDNAME='sl'
SELECT * FROM workflow_billfield WHERE billid=-84  AND DETAILTABLE='formtable_main_84_dt1' 
;
--备份《工作流单据字段表》，保险起见可以备份下表
select * into workflow_billfield_bak20230726 from workflow_billfield
;
--更新 《工作流单据字段表》 fielddbtype(单据字段数据库类型) fielddbtype decimal(38,2) 改为 decimal(38,4) ,修改后重启服务。
--UPDATE workflow_billfield SET fielddbtype = 'decimal(38,4)' WHERE fielddbtype='decimal(38,2)' AND billid=-303 AND FIELDNAME='sl' AND DETAILTABLE='formtable_main_303_dt1'
;
SELECT * FROM  workflow_billfield WHERE  billid=-303 
;
SELECT * FROM  workflow_billfield WHERE fielddbtype='decimal(38,2)' AND billid=-303 AND FIELDNAME='sl' AND DETAILTABLE='formtable_main_303_dt1'
;
select * FROM  workflow_billfield_bak20230726 ;

SELECT ID FROM workflow_bill WHERE TABLENAME='formtable_main_83'; --查询流程表单 ID
SELECT * FROM workflow_billfield WHERE billid=-83  AND DETAILTABLE='formtable_main_83_dt6' ;
SELECT * FROM workflow_billfield WHERE fielddbtype='int' AND billid=-83 AND FIELDNAME='hsdj' AND DETAILTABLE='formtable_main_83_dt6';
-- UPDATE workflow_billfield SET fielddbtype = 'decimal(38,4)' WHERE fielddbtype='int' AND billid=-83 AND FIELDNAME='hsdj' AND DETAILTABLE='formtable_main_83_dt6'

;
SELECT * FROM workflow_billfield WHERE id = 7732;
-- 修改表单字段类型
ALTER TABLE ecology.dbo.formtable_main_83_dt6 ALTER COLUMN hsdj decimal(38,4) NULL;



--UPDATE workflow_billfield SET [type] = 3 WHERE id = 7732;