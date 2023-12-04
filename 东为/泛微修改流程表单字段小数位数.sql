--《工作流单据信息表》 查 对应流程表单 ID
SELECT ID FROM workflow_bill WHERE TABLENAME='formtable_main_84'; --查询流程表单 ID

--《工作流单据字段表》 WHERE billid(单据ID) AND FIELDNAME(字段名) AND DETAILTABLE(明细表)
SELECT * FROM workflow_billfield WHERE billid=-84 AND FIELDNAME='sl'
SELECT * FROM workflow_billfield WHERE billid=-84  AND DETAILTABLE='formtable_main_84_dt1' 

--备份《工作流单据字段表》，保险起见可以备份下表
select * into workflow_billfield_bak20230726 from workflow_billfield

--更新 《工作流单据字段表》 fielddbtype(单据字段数据库类型) fielddbtype decimal(38,2) 改为 decimal(38,4) ,修改后重启服务。
UPDATE workflow_billfield SET fielddbtype = 'decimal(38,4)' WHERE fielddbtype='decimal(38,2)' AND billid=-303 AND FIELDNAME='sl' AND DETAILTABLE='formtable_main_303_dt1'