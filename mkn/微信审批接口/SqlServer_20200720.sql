/*
 Navicat Premium Data Transfer

 Date: 20/07/2020 17:16:19
*/


-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_table]') AND type IN ('U'))
	DROP TABLE [dbo].[gen_table]
GO

CREATE TABLE [dbo].[gen_table] (
  [table_id] bigint  IDENTITY(1,1) NOT NULL,
  [table_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [table_comment] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [class_name] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [tpl_category] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT ('crud') NULL,
  [package_name] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [module_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [business_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [function_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [function_author] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [options] nvarchar(1000) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [sub_table_name] varchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [sub_table_fk_name] varchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [gen_type] char(1) COLLATE Chinese_PRC_CI_AS DEFAULT ('0') NULL,
  [gen_path] varchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT ('/') NULL
)
GO

ALTER TABLE [dbo].[gen_table] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'编号',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'table_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表名称',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'table_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表描述',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'table_comment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实体类名称',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'class_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'使用的模板（crud单表操作 tree树表操作）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'tpl_category'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成包路径',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'package_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成模块名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'module_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成业务名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'business_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成功能名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'function_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成功能作者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'function_author'
GO

EXEC sp_addextendedproperty
'MS_Description', N'其它生成选项',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'options'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'关联子表的表名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'sub_table_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'子表关联的外键名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'sub_table_fk_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成代码方式（0zip压缩包 1自定义路径）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'gen_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成路径（不填默认项目路径）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'gen_path'
GO

EXEC sp_addextendedproperty
'MS_Description', N'代码生成业务表',
'SCHEMA', N'dbo',
'TABLE', N'gen_table'
GO

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_table_column]') AND type IN ('U'))
	DROP TABLE [dbo].[gen_table_column]
GO

CREATE TABLE [dbo].[gen_table_column] (
  [column_id] bigint  IDENTITY(1,1) NOT NULL,
  [table_id] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [column_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [column_comment] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [column_type] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [java_type] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [java_field] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_pk] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_increment] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_required] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_insert] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_edit] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_list] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_query] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [query_type] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT ('EQ') NULL,
  [html_type] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [dict_type] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [sort] int DEFAULT NULL NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[gen_table_column] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'编号',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'归属表编号',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'table_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'列名称',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'列描述',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_comment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'列类型',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'JAVA类型',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'java_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'JAVA字段名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'java_field'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否主键（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_pk'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否自增（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_increment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否必填（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_required'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否为插入字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_insert'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否编辑字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_edit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否列表字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_list'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否查询字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_query'
GO

EXEC sp_addextendedproperty
'MS_Description', N'查询方式（等于、不等于、大于、小于、范围）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'query_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'html_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'代码生成业务表字段',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column'
GO

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_blob_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_blob_triggers]
GO

CREATE TABLE [dbo].[qrtz_blob_triggers] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [blob_data] varbinary(max)  NULL
)
GO

ALTER TABLE [dbo].[qrtz_blob_triggers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_calendars]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_calendars]
GO

CREATE TABLE [dbo].[qrtz_calendars] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [calendar_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [calendar] varbinary(max)  NOT NULL
)
GO

ALTER TABLE [dbo].[qrtz_calendars] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_cron_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_cron_triggers]
GO

CREATE TABLE [dbo].[qrtz_cron_triggers] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [cron_expression] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [time_zone_id] nvarchar(80) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[qrtz_cron_triggers] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_fired_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_fired_triggers]
GO

CREATE TABLE [dbo].[qrtz_fired_triggers] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [entry_id] nvarchar(95) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [instance_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [fired_time] bigint  NOT NULL,
  [sched_time] bigint  NOT NULL,
  [priority] int  NOT NULL,
  [state] nvarchar(16) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [job_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [job_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_nonconcurrent] nvarchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [requests_recovery] nvarchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[qrtz_fired_triggers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_job_details]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_job_details]
GO

CREATE TABLE [dbo].[qrtz_job_details] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [job_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [job_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [description] nvarchar(250) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [job_class_name] nvarchar(250) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [is_durable] nvarchar(1) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [is_nonconcurrent] nvarchar(1) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [is_update_data] nvarchar(1) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [requests_recovery] nvarchar(1) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [job_data] varbinary(max)  NULL
)
GO

ALTER TABLE [dbo].[qrtz_job_details] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_locks]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_locks]
GO

CREATE TABLE [dbo].[qrtz_locks] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [lock_name] nvarchar(40) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[qrtz_locks] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_paused_trigger_grps]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_paused_trigger_grps]
GO

CREATE TABLE [dbo].[qrtz_paused_trigger_grps] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[qrtz_paused_trigger_grps] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_scheduler_state]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_scheduler_state]
GO

CREATE TABLE [dbo].[qrtz_scheduler_state] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [instance_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [last_checkin_time] bigint  NOT NULL,
  [checkin_interval] bigint  NOT NULL
)
GO

ALTER TABLE [dbo].[qrtz_scheduler_state] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_simple_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_simple_triggers]
GO

CREATE TABLE [dbo].[qrtz_simple_triggers] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [repeat_count] bigint  NOT NULL,
  [repeat_interval] bigint  NOT NULL,
  [times_triggered] bigint  NOT NULL
)
GO

ALTER TABLE [dbo].[qrtz_simple_triggers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_simprop_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_simprop_triggers]
GO

CREATE TABLE [dbo].[qrtz_simprop_triggers] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [str_prop_1] nvarchar(512) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [str_prop_2] nvarchar(512) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [str_prop_3] nvarchar(512) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [int_prop_1] int DEFAULT NULL NULL,
  [int_prop_2] int DEFAULT NULL NULL,
  [long_prop_1] bigint DEFAULT NULL NULL,
  [long_prop_2] bigint DEFAULT NULL NULL,
  [dec_prop_1] decimal(13,4) DEFAULT NULL NULL,
  [dec_prop_2] decimal(13,4) DEFAULT NULL NULL,
  [bool_prop_1] nvarchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [bool_prop_2] nvarchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[qrtz_simprop_triggers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_triggers]
GO

CREATE TABLE [dbo].[qrtz_triggers] (
  [sched_name] nvarchar(120) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [job_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [job_group] nvarchar(200) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [description] nvarchar(250) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [next_fire_time] bigint DEFAULT NULL NULL,
  [prev_fire_time] bigint DEFAULT NULL NULL,
  [priority] int DEFAULT NULL NULL,
  [trigger_state] nvarchar(16) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [trigger_type] nvarchar(8) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [start_time] bigint  NOT NULL,
  [end_time] bigint DEFAULT NULL NULL,
  [calendar_name] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [misfire_instr] smallint DEFAULT NULL NULL,
  [job_data] varbinary(max)  NULL
)
GO

ALTER TABLE [dbo].[qrtz_triggers] SET (LOCK_ESCALATION = TABLE)
GO

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_config]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_config]
GO

CREATE TABLE [dbo].[sys_config] (
  [config_id] int  IDENTITY(3,1) NOT NULL,
  [config_name] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [config_key] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [config_value] nvarchar(256) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [config_type] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'N') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_config] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数主键',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数键名',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数键值',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统内置（Y是 N否）',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数配置表',
'SCHEMA', N'dbo',
'TABLE', N'sys_config'
GO


-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[sys_config] ON
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (1, N'主框架页-默认皮肤样式名称', N'sys.index.skinName', N'skin-blue', N'Y', N'admin', '2018-03-16 11:33:00.0000000', N'admin', '2018-03-16 11:33:00.0000000', N'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (2, N'用户管理-账号初始密码', N'sys.user.initPassword', N'123456', N'Y', N'admin', '2018-03-16 11:33:00.0000000', N'admin', '2018-03-16 11:33:00.0000000', N'初始化密码 123456');
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (3, N'主框架页-侧边栏主题', N'sys.index.sideTheme', N'theme-dark', N'Y', N'admin', '2018-03-16 11:33:00.0000000', N'admin', '2019-08-05 16:27:09.0500000', N'深色主题theme-dark，浅色主题theme-light， 深蓝主题theme-blue');
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (10, N'SuMainTemplateId', N'SuMainTemplateId', N'C4Woq1LJ9uxyUsSLxbvriZc4wVcfDKZqKwHT7bnuk', N'Y', N'admin', '2023-12-27 15:38:13.5833333', N'', NULL, NULL);
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (11, N'PuAppVouchMainTemplateId', N'PuAppVouchMainTemplateId', N'C4Woq1LJZLpCf6GNxzdbXXZYH3sv63JmetvzJoX71', N'Y', N'admin', '2023-12-27 15:58:49.5433333', N'', NULL, NULL);
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (12, N'DispatchListTemplateId', N'DispatchListTemplateId', N'3WLtqwT8EutyT8JRc6nMk5hPcsT83ESq3YNcwLEK', N'Y', N'admin', '2023-12-27 16:21:49.0500000', N'', NULL, NULL);
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (13, N'ApplyPayVouchTemplateId', N'ApplyPayVouchTemplateId', N'C4Woq1aV21162M6sdwHN2zi4MjFmi1dU8VFE2voN5', N'Y', N'admin', '2023-12-29 17:07:45.5266667', N'', NULL, NULL);
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (9, N'access_token', N'access_token', N'dY5QHZ0QukNUefD7EswmYG8ULkhfoWeWKTmvFLeJDdmyilFv_uA1GBl7wV_qGpVxxRHq1w9aXqQ0MAUw2Tvc5gfMEUC1gj7HqOfOxQxQqi1dH43wnt5pq2bT3KJjDObetFvYyfj2REEFoar9pNP8UmKpzt3h4Oh3487hG4G3ZUq1BeDKPxw2Jb5XDsokqjy2rNV2P8jW3RX6hzWHPipFOQ', N'N', N'', '2023-12-26 17:20:37.9500000', N'', '2023-12-30 11:16:59.8100000', NULL);
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (4, N'corpsecret', N'corpsecret', N'tIwGhHGMlANqZ9Wlil3fTCHdaRc57wBkzHtd6B2TwZo', N'Y', N'admin', '2023-12-25 17:21:28.9800000', N'', NULL, NULL);
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (5, N'corpid', N'corpid', N'ww8847d5201a1d9d13', N'Y', N'admin', '2023-12-25 17:21:52.7633333', N'', NULL, NULL);
GO
INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (8, N'采购订单', N'PuMainTemplateId', N'C4WopsawemZH52j4qHjDXQfc5NR3XAk5ZdiXv8WpK', N'Y', N'admin', '2023-12-25 17:55:50.9866667', N'', NULL, NULL);
GO

SET IDENTITY_INSERT [dbo].[sys_config] OFF
GO

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_dept]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_dept]
GO

CREATE TABLE [dbo].[sys_dept] (
  [dept_id] int  IDENTITY(212,1) NOT NULL,
  [parent_id] int DEFAULT ((0)) NULL,
  [ancestors] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [dept_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [order_num] int DEFAULT ((0)) NULL,
  [leader] nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [phone] nvarchar(11) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [email] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [del_flag] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_dept] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门id',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父部门id',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'祖级列表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'ancestors'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'dept_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'order_num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'负责人',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'leader'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系电话',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'phone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'邮箱',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept'
GO

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_dict_data]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_dict_data]
GO

CREATE TABLE [dbo].[sys_dict_data] (
  [dict_code] int  IDENTITY(108,1) NOT NULL,
  [dict_sort] int DEFAULT ((0)) NULL,
  [dict_label] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [dict_value] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [dict_type] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [css_class] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [list_class] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [is_default] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'N') NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_dict_data] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典编码',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典排序',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典标签',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_label'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典键值',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'样式属性（其他样式扩展）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'css_class'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表格回显样式',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'list_class'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否默认（Y是 N否）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'is_default'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典数据表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data'
GO


-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[sys_dict_data] ON
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'1', N'男', N'0', N'sys_user_sex', N'', N'', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'性别男')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'2', N'2', N'女', N'1', N'sys_user_sex', N'', N'', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'性别女')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'3', N'3', N'未知', N'2', N'sys_user_sex', N'', N'', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'性别未知')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'4', N'1', N'显示', N'0', N'sys_show_hide', N'', N'primary', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'显示菜单')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'5', N'2', N'隐藏', N'1', N'sys_show_hide', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'隐藏菜单')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'6', N'1', N'正常', N'0', N'sys_normal_disable', N'', N'primary', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'正常状态')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'7', N'2', N'停用', N'1', N'sys_normal_disable', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'停用状态')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'8', N'1', N'正常', N'0', N'sys_job_status', N'', N'primary', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'正常状态')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'9', N'2', N'暂停', N'1', N'sys_job_status', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'停用状态')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'10', N'1', N'默认', N'DEFAULT', N'sys_job_group', N'', N'', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'默认分组')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'11', N'2', N'系统', N'SYSTEM', N'sys_job_group', N'', N'', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'系统分组')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'12', N'1', N'是', N'Y', N'sys_yes_no', N'', N'primary', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'系统默认是')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'13', N'2', N'否', N'N', N'sys_yes_no', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'系统默认否')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'14', N'1', N'通知', N'1', N'sys_notice_type', N'', N'warning', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'通知')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'15', N'2', N'公告', N'2', N'sys_notice_type', N'', N'success', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'公告')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'16', N'1', N'正常', N'0', N'sys_notice_status', N'', N'primary', N'Y', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'正常状态')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'17', N'2', N'关闭', N'1', N'sys_notice_status', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'关闭状态')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'18', N'1', N'新增', N'1', N'sys_oper_type', N'', N'info', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'admin', N'2019-08-07 17:22:17.0800000', N'新增操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'19', N'2', N'修改', N'2', N'sys_oper_type', N'', N'info', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'修改操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'20', N'3', N'删除', N'3', N'sys_oper_type', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'删除操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'21', N'4', N'授权', N'4', N'sys_oper_type', N'', N'primary', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'授权操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'22', N'5', N'导出', N'5', N'sys_oper_type', N'', N'warning', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'导出操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'23', N'6', N'导入', N'6', N'sys_oper_type', N'', N'warning', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'导入操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'24', N'7', N'强退', N'7', N'sys_oper_type', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'强退操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'25', N'8', N'生成代码', N'8', N'sys_oper_type', N'', N'warning', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'生成操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'26', N'9', N'清空数据', N'9', N'sys_oper_type', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'清空操作')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'108', N'1', N'成功', N'0', N'sys_common_status', N'', N'primary', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'正常状态')
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'109', N'2', N'失败', N'1', N'sys_common_status', N'', N'danger', N'N', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'停用状态')
GO

SET IDENTITY_INSERT [dbo].[sys_dict_data] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_dict_type]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_dict_type]
GO

CREATE TABLE [dbo].[sys_dict_type] (
  [dict_id] int  IDENTITY(102,1) NOT NULL,
  [dict_name] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [dict_type] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_dict_type] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典主键',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'dict_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'dict_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type'
GO


-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[sys_dict_type] ON
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'用户性别', N'sys_user_sex', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'admin', N'2019-08-07 17:19:25.5200000', N'用户性别列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'2', N'菜单状态', N'sys_show_hide', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'菜单状态列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'3', N'系统开关', N'sys_normal_disable', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'系统开关列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'4', N'任务状态', N'sys_job_status', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'任务状态列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'5', N'任务分组', N'sys_job_group', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'admin', N'2019-08-05 16:25:11.6230000', N'任务分组列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'6', N'系统是否', N'sys_yes_no', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'系统是否列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'7', N'通知类型', N'sys_notice_type', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'通知类型列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'8', N'通知状态', N'sys_notice_status', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'通知状态列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'9', N'操作类型', N'sys_oper_type', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'操作类型列表')
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'103', N'系统状态', N'sys_common_status', N'0', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'登录状态列表')
GO

SET IDENTITY_INSERT [dbo].[sys_dict_type] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_job]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_job]
GO

CREATE TABLE [dbo].[sys_job] (
  [job_id] int  IDENTITY(3,1) NOT NULL,
  [job_name] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NOT NULL,
  [job_group] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NOT NULL,
  [invoke_target] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NOT NULL,
  [cron_expression] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [misfire_policy] nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT (N'3') NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [concurrent] nchar(1) COLLATE Chinese_PRC_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[sys_job] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'job_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务组名',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调用目标字符串',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'invoke_target'
GO

EXEC sp_addextendedproperty
'MS_Description', N'cron执行表达式',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'cron_expression'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'misfire_policy'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1暂停）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否并发执行（0允许 1禁止）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'concurrent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定时任务调度表',
'SCHEMA', N'dbo',
'TABLE', N'sys_job'
GO


-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[sys_job] ON
GO

INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (3, N'定时获取token', N'DEFAULT', N'tokenTask.getAccessToken()', N'0 0 0,2,4,6,8,10,12,14,16,18,20,22 * * ?', N'1', N'1', N'admin', '2023-12-25 17:23:52.0966667', N'', NULL, N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (4, N'采购订单', N'DEFAULT', N'poMainTask.sendWork()', N'0 0/10 * * * ?', N'1', N'1', N'admin', '2023-12-25 19:55:18.5033333', N'admin', '2023-12-30 11:56:32.2933333', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (5, N'销售订单', N'DEFAULT', N'soMainTask.sendWork()', N'0 0/10 * * * ?', N'1', N'1', N'admin', '2023-12-27 15:47:25.9100000', N'admin', '2023-12-30 11:56:23.7066667', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (6, N'请购单', N'DEFAULT', N'puAppVouchTask.sendWork()', N'0 0/10 * * * ?', N'1', N'1', N'admin', '2023-12-27 16:15:07.7966667', N'admin', '2023-12-30 11:56:15.0200000', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (7, N'发货单', N'DEFAULT', N'dispatchListTask.sendWork()', N'0 0/10 * * * ?', N'1', N'1', N'admin', '2023-12-27 16:37:16.5766667', N'admin', '2023-12-30 11:56:06.6500000', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (8, N'采购订单审核状态查询', N'DEFAULT', N'WeiXinResultTask.getPoMain()', N'0 3/10 * * * ?', N'1', N'1', N'admin', '2023-12-27 17:21:37.8833333', N'admin', '2023-12-30 11:57:51.0833333', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (9, N'销售订单审核状态查询', N'DEFAULT', N'WeiXinResultTask.getSoMain()', N'0 3/10 * * * ?', N'1', N'1', N'admin', '2023-12-28 11:07:13.5933333', N'admin', '2023-12-30 11:57:41.0666667', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (10, N'发货单审核状态查询', N'DEFAULT', N'WeiXinResultTask.getDispatchListMain()', N'0 3/10 * * * ?', N'1', N'1', N'admin', '2023-12-28 11:08:03.1166667', N'admin', '2023-12-30 11:57:32.8633333', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (11, N'请购单审核状态查询', N'DEFAULT', N'WeiXinResultTask.getPuAppVouchMain()', N'0 3/10 * * * ?', N'1', N'1', N'admin', '2023-12-28 11:08:53.8100000', N'admin', '2023-12-30 11:57:24.1733333', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (12, N'付款申请', N'DEFAULT', N'ApplyPayVouchTask.sendWork()', N'0 0/10 * * * ?', N'1', N'1', N'admin', '2023-12-29 17:08:26.9200000', N'admin', '2023-12-30 11:55:25.1700000', N'', N'1');
GO
INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [status], [create_by], [create_time], [update_by], [update_time], [remark], [concurrent]) VALUES (13, N'付款申请审核状态查询', N'DEFAULT', N'WeiXinResultTask.getApplyPayVouch()', N'0 3/10 * * * ?', N'1', N'1', N'admin', '2023-12-29 17:10:39.3000000', N'admin', '2023-12-30 11:57:14.3933333', N'', N'1');
GO

SET IDENTITY_INSERT [dbo].[sys_job] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_job_log]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_job_log]
GO

CREATE TABLE [dbo].[sys_job_log] (
  [job_log_id] int  IDENTITY(1,1) NOT NULL,
  [job_name] nvarchar(64) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [job_group] nvarchar(64) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [invoke_target] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NOT NULL,
  [job_message] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [exception_info] nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_job_log] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务日志ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_log_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务组名',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调用目标字符串',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'invoke_target'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日志信息',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_message'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行状态（0正常 1失败）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'异常信息',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'exception_info'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定时任务调度日志表',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log'
GO

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_logininfor]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_logininfor]
GO

CREATE TABLE [dbo].[sys_logininfor] (
  [info_id] int  IDENTITY(203,1) NOT NULL,
  [login_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [ipaddr] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [login_location] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [browser] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [os] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [msg] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [login_time] datetime2(7) DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_logininfor] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'访问ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'info_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录账号',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'login_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录IP地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'ipaddr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录地点',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'login_location'
GO

EXEC sp_addextendedproperty
'MS_Description', N'浏览器类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'browser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作系统',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'os'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录状态（0成功 1失败）',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'提示消息',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'msg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'访问时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'login_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统访问记录',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor'
GO


-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_menu]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_menu]
GO

CREATE TABLE [dbo].[sys_menu] (
  [menu_id] int  IDENTITY(2038,1) NOT NULL,
  [menu_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [parent_id] int DEFAULT ((0)) NULL,
  [order_num] int DEFAULT ((0)) NULL,
  [url] nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT (N'#') NULL,
  [menu_type] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [visible] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [perms] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [icon] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'#') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [target] nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL
)
GO

ALTER TABLE [dbo].[sys_menu] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'menu_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'menu_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父菜单ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'order_num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请求地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单类型（M目录 C菜单 F按钮）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'menu_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单状态（0显示 1隐藏）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'visible'
GO

EXEC sp_addextendedproperty
'MS_Description', N'权限标识',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'perms'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单图标',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'icon'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'打开方式（menuItem页签 menuBlank新窗口）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'target'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单权限表',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu'
GO


-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[sys_menu] ON
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1', N'系统管理', N'0', N'1', N'#', N'M', N'0', N'', N'fa fa-gear', N'admin', N'2018-03-16 11:33:00.0000000', N'admin', N'2019-06-10 11:46:29.5100000', N'系统管理目录', N'menuItem')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'2', N'系统监控', N'0', N'2', N'#', N'M', N'0', N'', N'fa fa-video-camera', N'admin', N'2018-03-16 11:33:00.0000000', N'admin', N'2019-11-26 17:29:32.7730000', N'系统监控目录', N'menuItem')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'3', N'系统工具', N'0', N'3', N'#', N'M', N'0', N'', N'fa fa-wrench', N'admin', N'2018-03-16 11:33:00.0000000', N'admin', N'2019-08-08 13:55:36.9170000', N'系统工具目录', N'menuItem')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'100', N'用户管理', N'1', N'1', N'/system/user', N'C', N'0', N'system:user:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'用户管理菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'101', N'角色管理', N'1', N'2', N'/system/role', N'C', N'0', N'system:role:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'角色管理菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'102', N'菜单管理', N'1', N'3', N'/system/menu', N'C', N'0', N'system:menu:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'菜单管理菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'103', N'部门管理', N'1', N'4', N'/system/dept', N'C', N'0', N'system:dept:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'部门管理菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'104', N'岗位管理', N'1', N'5', N'/system/post', N'C', N'0', N'system:post:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'岗位管理菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'105', N'字典管理', N'1', N'6', N'/system/dict', N'C', N'0', N'system:dict:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'字典管理菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'106', N'参数设置', N'1', N'7', N'/system/config', N'C', N'0', N'system:config:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'参数设置菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'107', N'通知公告', N'1', N'8', N'/system/notice', N'C', N'0', N'system:notice:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'通知公告菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'108', N'日志管理', N'1', N'9', N'#', N'M', N'0', N'', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'日志管理菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'109', N'在线用户', N'2', N'1', N'/monitor/online', N'C', N'0', N'monitor:online:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'在线用户菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'110', N'定时任务', N'2', N'2', N'/monitor/job', N'C', N'0', N'monitor:job:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'定时任务菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'111', N'数据监控', N'2', N'3', N'/monitor/data', N'C', N'0', N'monitor:data:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'数据监控菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'112', N'服务监控', N'2', N'3', N'/monitor/server', N'C', N'0', N'monitor:server:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'服务监控菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'113', N'表单构建', N'3', N'1', N'/tool/build', N'C', N'0', N'tool:build:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'表单构建菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'114', N'代码生成', N'3', N'2', N'/tool/gen', N'C', N'0', N'tool:gen:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'代码生成菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'115', N'系统接口', N'3', N'3', N'/tool/swagger', N'C', N'0', N'tool:swagger:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'系统接口菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'500', N'操作日志', N'108', N'1', N'/monitor/operlog', N'C', N'0', N'monitor:operlog:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'操作日志菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'501', N'登录日志', N'108', N'2', N'/monitor/logininfor', N'C', N'0', N'monitor:logininfor:view', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'登录日志菜单', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1000', N'用户查询', N'100', N'1', N'#', N'F', N'0', N'system:user:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1001', N'用户新增', N'100', N'2', N'#', N'F', N'0', N'system:user:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1002', N'用户修改', N'100', N'3', N'#', N'F', N'0', N'system:user:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1003', N'用户删除', N'100', N'4', N'#', N'F', N'0', N'system:user:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1004', N'用户导出', N'100', N'5', N'#', N'F', N'0', N'system:user:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1005', N'用户导入', N'100', N'6', N'#', N'F', N'0', N'system:user:import', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1006', N'重置密码', N'100', N'7', N'#', N'F', N'0', N'system:user:resetPwd', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1007', N'角色查询', N'101', N'1', N'#', N'F', N'0', N'system:role:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1008', N'角色新增', N'101', N'2', N'#', N'F', N'0', N'system:role:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1009', N'角色修改', N'101', N'3', N'#', N'F', N'0', N'system:role:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1010', N'角色删除', N'101', N'4', N'#', N'F', N'0', N'system:role:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1011', N'角色导出', N'101', N'5', N'#', N'F', N'0', N'system:role:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1012', N'菜单查询', N'102', N'1', N'#', N'F', N'0', N'system:menu:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1013', N'菜单新增', N'102', N'2', N'#', N'F', N'0', N'system:menu:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1014', N'菜单修改', N'102', N'3', N'#', N'F', N'0', N'system:menu:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1015', N'菜单删除', N'102', N'4', N'#', N'F', N'0', N'system:menu:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1016', N'部门查询', N'103', N'1', N'#', N'F', N'0', N'system:dept:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1017', N'部门新增', N'103', N'2', N'#', N'F', N'0', N'system:dept:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1018', N'部门修改', N'103', N'3', N'#', N'F', N'0', N'system:dept:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1019', N'部门删除', N'103', N'4', N'#', N'F', N'0', N'system:dept:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1020', N'岗位查询', N'104', N'1', N'#', N'F', N'0', N'system:post:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1021', N'岗位新增', N'104', N'2', N'#', N'F', N'0', N'system:post:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1022', N'岗位修改', N'104', N'3', N'#', N'F', N'0', N'system:post:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1023', N'岗位删除', N'104', N'4', N'#', N'F', N'0', N'system:post:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1024', N'岗位导出', N'104', N'5', N'#', N'F', N'0', N'system:post:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1025', N'字典查询', N'105', N'1', N'#', N'F', N'0', N'system:dict:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1026', N'字典新增', N'105', N'2', N'#', N'F', N'0', N'system:dict:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1027', N'字典修改', N'105', N'3', N'#', N'F', N'0', N'system:dict:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1028', N'字典删除', N'105', N'4', N'#', N'F', N'0', N'system:dict:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1029', N'字典导出', N'105', N'5', N'#', N'F', N'0', N'system:dict:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1030', N'参数查询', N'106', N'1', N'#', N'F', N'0', N'system:config:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1031', N'参数新增', N'106', N'2', N'#', N'F', N'0', N'system:config:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1032', N'参数修改', N'106', N'3', N'#', N'F', N'0', N'system:config:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1033', N'参数删除', N'106', N'4', N'#', N'F', N'0', N'system:config:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1034', N'参数导出', N'106', N'5', N'#', N'F', N'0', N'system:config:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1035', N'公告查询', N'107', N'1', N'#', N'F', N'0', N'system:notice:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1036', N'公告新增', N'107', N'2', N'#', N'F', N'0', N'system:notice:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1037', N'公告修改', N'107', N'3', N'#', N'F', N'0', N'system:notice:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1038', N'公告删除', N'107', N'4', N'#', N'F', N'0', N'system:notice:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1039', N'操作查询', N'500', N'1', N'#', N'F', N'0', N'monitor:operlog:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1040', N'操作删除', N'500', N'2', N'#', N'F', N'0', N'monitor:operlog:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1041', N'详细信息', N'500', N'3', N'#', N'F', N'0', N'monitor:operlog:detail', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1042', N'日志导出', N'500', N'4', N'#', N'F', N'0', N'monitor:operlog:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1043', N'登录查询', N'501', N'1', N'#', N'F', N'0', N'monitor:logininfor:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1044', N'登录删除', N'501', N'2', N'#', N'F', N'0', N'monitor:logininfor:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1045', N'日志导出', N'501', N'3', N'#', N'F', N'0', N'monitor:logininfor:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1046', N'在线查询', N'109', N'1', N'#', N'F', N'0', N'monitor:online:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1047', N'批量强退', N'109', N'2', N'#', N'F', N'0', N'monitor:online:batchForceLogout', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1048', N'单条强退', N'109', N'3', N'#', N'F', N'0', N'monitor:online:forceLogout', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1049', N'任务查询', N'110', N'1', N'#', N'F', N'0', N'monitor:job:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1050', N'任务新增', N'110', N'2', N'#', N'F', N'0', N'monitor:job:add', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1051', N'任务修改', N'110', N'3', N'#', N'F', N'0', N'monitor:job:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1052', N'任务删除', N'110', N'4', N'#', N'F', N'0', N'monitor:job:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1053', N'状态修改', N'110', N'5', N'#', N'F', N'0', N'monitor:job:changeStatus', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1054', N'任务详细', N'110', N'6', N'#', N'F', N'0', N'monitor:job:detail', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1055', N'任务导出', N'110', N'7', N'#', N'F', N'0', N'monitor:job:export', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1056', N'生成查询', N'114', N'1', N'#', N'F', N'0', N'tool:gen:list', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'1057', N'生成代码', N'114', N'2', N'#', N'F', N'0', N'tool:gen:edit', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'2042', N'生成删除', N'114', N'3', N'#', N'F', N'0', N'tool:gen:remove', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'2043', N'预览代码', N'114', N'4', N'#', N'F', N'0', N'tool:gen:preview', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [url], [menu_type], [visible], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark], [target]) VALUES (N'2044', N'生成代码', N'114', N'5', N'#', N'F', N'0', N'tool:gen:code', N'#', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2018-03-16 11:33:00.0000000', N'', N'')
GO

SET IDENTITY_INSERT [dbo].[sys_menu] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_notice]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_notice]
GO

CREATE TABLE [dbo].[sys_notice] (
  [notice_id] int  IDENTITY(3,1) NOT NULL,
  [notice_title] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [notice_type] nchar(1) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [notice_content] nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_notice] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告标题',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告类型（1通知 2公告）',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告内容',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告状态（0正常 1关闭）',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'通知公告表',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice'
GO

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_oper_log]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_oper_log]
GO

CREATE TABLE [dbo].[sys_oper_log] (
  [oper_id] int  IDENTITY(243,1) NOT NULL,
  [title] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [business_type] int DEFAULT ((0)) NULL,
  [method] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [operator_type] int DEFAULT ((0)) NULL,
  [oper_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [dept_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [oper_url] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [oper_ip] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [oper_location] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [oper_param] nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [status] int DEFAULT ((0)) NULL,
  [error_msg] nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [oper_time] datetime2(7) DEFAULT '' NULL,
  [request_method] nvarchar(10) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
  [json_result] nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL
)
GO

ALTER TABLE [dbo].[sys_oper_log] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'日志主键',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块标题',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'业务类型（0其它 1新增 2修改 3删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'business_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'方法名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'method'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作类别（0其它 1后台用户 2手机端用户）',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'operator_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人员',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'dept_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请求URL',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'主机地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作地点',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_location'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请求参数',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_param'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作状态（0正常 1异常）',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'错误消息',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'error_msg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请求方式',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
'MS_Description', N'返回参数',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'json_result'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作日志记录',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log'
GO

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_post]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_post]
GO

CREATE TABLE [dbo].[sys_post] (
  [post_id] int  IDENTITY(5,1) NOT NULL,
  [post_code] nvarchar(64) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [post_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [post_sort] int  NOT NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_post] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位编码',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位信息表',
'SCHEMA', N'dbo',
'TABLE', N'sys_post'
GO

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_role]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_role]
GO

CREATE TABLE [dbo].[sys_role] (
  [role_id] int  IDENTITY(101,1) NOT NULL,
  [role_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [role_key] nvarchar(100) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [role_sort] int  NOT NULL,
  [data_scope] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'1') NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [del_flag] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
)
GO

ALTER TABLE [dbo].[sys_role] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色权限字符串',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据范围（1：全部数据权限 2：自定数据权限）',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'data_scope'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色信息表',
'SCHEMA', N'dbo',
'TABLE', N'sys_role'
GO

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_role_dept]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_role_dept]
GO

CREATE TABLE [dbo].[sys_role_dept] (
  [role_id] int  NOT NULL,
  [dept_id] int  NOT NULL
)
GO

ALTER TABLE [dbo].[sys_role_dept] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_dept',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_dept',
'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色和部门关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_dept'
GO

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_role_menu]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_role_menu]
GO

CREATE TABLE [dbo].[sys_role_menu] (
  [role_id] int  NOT NULL,
  [menu_id] int  NOT NULL
)
GO

ALTER TABLE [dbo].[sys_role_menu] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_menu',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_menu',
'COLUMN', N'menu_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色和菜单关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_menu'
GO

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_user]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_user]
GO

CREATE TABLE [dbo].[sys_user] (
  [user_id] int  IDENTITY(101,1) NOT NULL,
  [dept_id] int DEFAULT NULL NULL,
  [login_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [user_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS  NOT NULL,
  [user_type] nvarchar(2) COLLATE Chinese_PRC_CI_AS DEFAULT (N'00') NULL,
  [email] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [phonenumber] nvarchar(11) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [sex] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [avatar] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [password] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [salt] nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [status] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [del_flag] nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT (N'0') NULL,
  [login_ip] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [login_date] datetime2(7) DEFAULT NULL NULL,
  [create_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [create_time] datetime2(7) DEFAULT NULL NULL,
  [update_by] nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [update_time] datetime2(7) DEFAULT NULL NULL,
  [remark] nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL
)
GO

ALTER TABLE [dbo].[sys_user] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录账号',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'login_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户类型（00系统用户）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户邮箱',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'手机号码',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'phonenumber'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户性别（0男 1女 2未知）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
'MS_Description', N'头像路径',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
'MS_Description', N'密码',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'盐加密',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'salt'
GO

EXEC sp_addextendedproperty
'MS_Description', N'帐号状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后登陆IP',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'login_ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后登陆时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'login_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户信息表',
'SCHEMA', N'dbo',
'TABLE', N'sys_user'
GO


-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[sys_user] ON
GO

INSERT INTO [dbo].[sys_user] ([user_id], [dept_id], [login_name], [user_name], [user_type], [email], [phonenumber], [sex], [avatar], [password], [salt], [status], [del_flag], [login_ip], [login_date], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'103', N'admin', N'管理', N'00', N'cat@163.com', N'15888888888', N'1', N'/profile/avatar/2020/05/06/eee5b449f0f07cfca0b86f13154838b3.png', N'29c67a30398638269fe600f73a054934', N'111111', N'0', N'0', N'127.0.0.1', N'2020-07-20 17:02:56.9700000', N'admin', N'2018-03-16 11:33:00.0000000', N'ry', N'2020-07-20 17:02:58.0200000', N'管理员')
GO

SET IDENTITY_INSERT [dbo].[sys_user] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_user_online]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_user_online]
GO

CREATE TABLE [dbo].[sys_user_online] (
  [sessionId] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NOT NULL,
  [login_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [dept_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [ipaddr] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [login_location] nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [browser] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [os] nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [status] nvarchar(10) COLLATE Chinese_PRC_CI_AS DEFAULT (N'') NULL,
  [start_timestamp] datetime2(7) DEFAULT NULL NULL,
  [last_access_time] datetime2(7) DEFAULT NULL NULL,
  [expire_time] int DEFAULT ((0)) NULL
)
GO

ALTER TABLE [dbo].[sys_user_online] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户会话id',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'sessionId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录账号',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'login_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'dept_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录IP地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'ipaddr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录地点',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'login_location'
GO

EXEC sp_addextendedproperty
'MS_Description', N'浏览器类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'browser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作系统',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'os'
GO

EXEC sp_addextendedproperty
'MS_Description', N'在线状态on_line在线off_line离线',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'session创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'start_timestamp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'session最后访问时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'last_access_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'超时时间，单位为分钟',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online',
'COLUMN', N'expire_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'在线用户记录',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_online'
GO

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_user_post]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_user_post]
GO

CREATE TABLE [dbo].[sys_user_post] (
  [user_id] int  NOT NULL,
  [post_id] int  NOT NULL
)
GO

ALTER TABLE [dbo].[sys_user_post] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_post',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_post',
'COLUMN', N'post_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户与岗位关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_post'
GO

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_user_role]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_user_role]
GO

CREATE TABLE [dbo].[sys_user_role] (
  [user_id] int  NOT NULL,
  [role_id] int  NOT NULL
)
GO

ALTER TABLE [dbo].[sys_user_role] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_role',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_role',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户和角色关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_role'
GO

-- ----------------------------
-- Auto increment value for gen_table
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[gen_table]', RESEED, 21)
GO


-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE [dbo].[gen_table] ADD CONSTRAINT [PK__gen_tabl__B21E8F245E8A0973] PRIMARY KEY CLUSTERED ([table_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for gen_table_column
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[gen_table_column]', RESEED, 157)
GO


-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE [dbo].[gen_table_column] ADD CONSTRAINT [PK__gen_tabl__E301851F625A9A57] PRIMARY KEY CLUSTERED ([column_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_blob_triggers] ADD CONSTRAINT [PK__qrtz_blo__009FEA1C7BC66EAC] PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_blob_triggers] ADD CONSTRAINT [QRTZ_BLOB_TRIGGERS$QRTZ_BLOB_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Primary Key structure for table qrtz_calendars
-- ----------------------------
ALTER TABLE [dbo].[qrtz_calendars] ADD CONSTRAINT [PK__qrtz_cal__E21C986900CE7591] PRIMARY KEY CLUSTERED ([sched_name], [calendar_name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_cron_triggers] ADD CONSTRAINT [PK__qrtz_cro__009FEA1C2AFD5BF1] PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_cron_triggers] ADD CONSTRAINT [QRTZ_CRON_TRIGGERS$QRTZ_CRON_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Primary Key structure for table qrtz_fired_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_fired_triggers] ADD CONSTRAINT [PK__qrtz_fir__5E6EA63BE5AA7241] PRIMARY KEY CLUSTERED ([sched_name], [entry_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table qrtz_job_details
-- ----------------------------
ALTER TABLE [dbo].[qrtz_job_details] ADD CONSTRAINT [PK__qrtz_job__1642BB8CBCC64BA6] PRIMARY KEY CLUSTERED ([sched_name], [job_name], [job_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table qrtz_locks
-- ----------------------------
ALTER TABLE [dbo].[qrtz_locks] ADD CONSTRAINT [PK__qrtz_loc__F1C0211F72D72392] PRIMARY KEY CLUSTERED ([sched_name], [lock_name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table qrtz_paused_trigger_grps
-- ----------------------------
ALTER TABLE [dbo].[qrtz_paused_trigger_grps] ADD CONSTRAINT [PK__qrtz_pau__3D845B2BE5DC7E64] PRIMARY KEY CLUSTERED ([sched_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table qrtz_scheduler_state
-- ----------------------------
ALTER TABLE [dbo].[qrtz_scheduler_state] ADD CONSTRAINT [PK__qrtz_sch__FDC0ABB1D8838663] PRIMARY KEY CLUSTERED ([sched_name], [instance_name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simple_triggers] ADD CONSTRAINT [PK__qrtz_sim__009FEA1C76C9C464] PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simple_triggers] ADD CONSTRAINT [QRTZ_SIMPLE_TRIGGERS$QRTZ_SIMPLE_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Primary Key structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simprop_triggers] ADD CONSTRAINT [PK__qrtz_sim__009FEA1C469BA59D] PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simprop_triggers] ADD CONSTRAINT [QRTZ_SIMPROP_TRIGGERS$QRTZ_SIMPROP_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Primary Key structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_triggers] ADD CONSTRAINT [PK_QRTZ_TRIGGERS_sched_name] PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_triggers] ADD CONSTRAINT [QRTZ_TRIGGERS$QRTZ_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [job_name], [job_group]) REFERENCES [dbo].[qrtz_job_details] ([sched_name], [job_name], [job_group]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Auto increment value for sys_config
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_config]', RESEED, 3)
GO


-- ----------------------------
-- Auto increment value for sys_dept
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_dept]', RESEED, 215)
GO


-- ----------------------------
-- Auto increment value for sys_dict_data
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_dict_data]', RESEED, 109)
GO


-- ----------------------------
-- Auto increment value for sys_dict_type
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_dict_type]', RESEED, 103)
GO


-- ----------------------------
-- Auto increment value for sys_job
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_job]', RESEED, 3)
GO


-- ----------------------------
-- Auto increment value for sys_job_log
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_job_log]', RESEED, 7)
GO


-- ----------------------------
-- Auto increment value for sys_logininfor
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_logininfor]', RESEED, 203)
GO


-- ----------------------------
-- Auto increment value for sys_menu
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_menu]', RESEED, 2044)
GO


-- ----------------------------
-- Auto increment value for sys_notice
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_notice]', RESEED, 3)
GO


-- ----------------------------
-- Auto increment value for sys_oper_log
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_oper_log]', RESEED, 249)
GO


-- ----------------------------
-- Auto increment value for sys_post
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_post]', RESEED, 5)
GO


-- ----------------------------
-- Auto increment value for sys_role
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_role]', RESEED, 106)
GO


-- ----------------------------
-- Auto increment value for sys_user
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[sys_user]', RESEED, 106)
GO

