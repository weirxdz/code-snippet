CREATE TABLE sys_config (
	config_id int IDENTITY(1,1) NOT NULL,
	config_name nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	config_key nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	config_value nvarchar(256) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	config_type nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'N' NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL,
	remark nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
);
SET IDENTITY_INSERT sys_config ON;
INSERT INTO sys_config
(config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark)
SELECT config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark FROM UFDATA_100_2024.dbo.sys_config ;
SET IDENTITY_INSERT sys_config OFF ;
SELECT * FROM sys_config sc 
;
CREATE TABLE sys_dept (
	dept_id int IDENTITY(212,1) NOT NULL,
	parent_id int DEFAULT 0 NULL,
	ancestors nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	dept_name nvarchar(30) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	order_num int DEFAULT 0 NULL,
	leader nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	phone nvarchar(11) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	email nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	del_flag nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL
);
SET IDENTITY_INSERT sys_dept ON;
INSERT INTO sys_dept
(dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time)
SELECT dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time
FROM UFDATA_100_2024.dbo.sys_dept WHERE 1 = 1 ;
SET IDENTITY_INSERT sys_dept OFF ;

CREATE TABLE sys_dict_type (
	dict_id int IDENTITY(102,1) NOT NULL,
	dict_name nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	dict_type nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL,
	remark nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
);

SET IDENTITY_INSERT sys_dict_type ON;
INSERT INTO sys_dict_type
(dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark)
SELECT dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark FROM UFDATA_100_2024.dbo.sys_dict_type ;
SET IDENTITY_INSERT sys_dict_type OFF ;


CREATE TABLE sys_dict_data (
	dict_code int IDENTITY(108,1) NOT NULL,
	dict_sort int DEFAULT 0 NULL,
	dict_label nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	dict_value nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	dict_type nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	css_class nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	list_class nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	is_default nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'N' NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL,
	remark nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
);
SET IDENTITY_INSERT sys_dict_data ON;
INSERT INTO sys_dict_data
(dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
SELECT dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark 
FROM UFDATA_100_2024.dbo.sys_dict_data ;
SET IDENTITY_INSERT sys_dict_data OFF ;

;
CREATE TABLE sys_job (
	job_id int IDENTITY(3,1) NOT NULL,
	job_name nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NOT NULL,
	job_group nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NOT NULL,
	invoke_target nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NOT NULL,
	cron_expression nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	misfire_policy nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT N'3' NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL,
	remark nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	concurrent nchar(1) COLLATE Chinese_PRC_CI_AS NULL
);
SET IDENTITY_INSERT sys_job ON;
INSERT INTO sys_job
(job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, status, create_by, create_time, update_by, update_time, remark, concurrent)
SELECT job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, status, create_by, create_time, update_by, update_time, remark, concurrent
FROM UFDATA_600_2024.dbo.sys_job ;
SET IDENTITY_INSERT sys_job OFF ;
--SELECT * FROM sys_job;
--UPDATE sys_job SET status = 1 ;

CREATE TABLE sys_job_log (
	job_log_id int IDENTITY(1,1) NOT NULL,
	job_name nvarchar(64) COLLATE Chinese_PRC_CI_AS NOT NULL,
	job_group nvarchar(64) COLLATE Chinese_PRC_CI_AS NOT NULL,
	invoke_target nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NOT NULL,
	job_message nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	exception_info nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL
);
SET IDENTITY_INSERT sys_job_log ON;
INSERT INTO sys_job_log
(job_log_id, job_name, job_group, invoke_target, job_message, status, exception_info, create_time)
SELECT job_log_id, job_name, job_group, invoke_target, job_message, status, exception_info, create_time
FROM UFDATA_600_2024.dbo.sys_job_log WHERE 1 =2 ;
SET IDENTITY_INSERT sys_job_log OFF ;
SELECT * FROM sys_job_log;



CREATE TABLE sys_logininfor (
	info_id int IDENTITY(203,1) NOT NULL,
	login_name nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	ipaddr nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	login_location nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	browser nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	os nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	msg nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	login_time datetime2 DEFAULT NULL NULL
);
SET IDENTITY_INSERT sys_logininfor ON;
INSERT INTO sys_logininfor
(info_id, login_name, ipaddr, login_location, browser, os, status, msg, login_time)
SELECT info_id, login_name, ipaddr, login_location, browser, os, status, msg, login_time
FROM UFDATA_100_2024.dbo.sys_logininfor WHERE 1 = 2 ;
SET IDENTITY_INSERT sys_logininfor OFF ;
;

CREATE TABLE sys_menu (
	menu_id int IDENTITY(2038,1) NOT NULL,
	menu_name nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	parent_id int DEFAULT 0 NULL,
	order_num int DEFAULT 0 NULL,
	url nvarchar(200) COLLATE Chinese_PRC_CI_AS DEFAULT N'#' NULL,
	menu_type nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	visible nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	perms nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL,
	icon nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'#' NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL,
	remark nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	target nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL
);
SET IDENTITY_INSERT sys_menu ON;
INSERT INTO sys_menu
(menu_id, menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark, target)
SELECT menu_id, menu_name, parent_id, order_num, url, menu_type, visible, perms, icon, create_by, create_time, update_by, update_time, remark, target
FROM UFDATA_100_2024.dbo.sys_menu WHERE 1 = 1 ;
SET IDENTITY_INSERT sys_menu OFF ;
;
CREATE TABLE sys_oper_log (
	oper_id int IDENTITY(243,1) NOT NULL,
	title nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	business_type int DEFAULT 0 NULL,
	[method] nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	operator_type int DEFAULT 0 NULL,
	oper_name nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	dept_name nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	oper_url nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	oper_ip nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	oper_location nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	oper_param nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	status int DEFAULT 0 NULL,
	error_msg nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	oper_time datetime2 DEFAULT '' NULL,
	request_method nvarchar(10) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL,
	json_result nvarchar(2000) COLLATE Chinese_PRC_CI_AS DEFAULT '' NULL
);
SELECT * FROM sys_oper_log;

CREATE TABLE sys_role (
	role_id int IDENTITY(101,1) NOT NULL,
	role_name nvarchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	role_key nvarchar(100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	role_sort int NOT NULL,
	data_scope nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'1' NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS NOT NULL,
	del_flag nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL,
	remark nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT NULL NULL
);
SET IDENTITY_INSERT sys_role ON;
INSERT INTO sys_role
(role_id, role_name, role_key, role_sort, data_scope, status, del_flag, create_by, create_time, update_by, update_time, remark)
SELECT role_id, role_name, role_key, role_sort, data_scope, status, del_flag, create_by, create_time, update_by, update_time, remark
FROM UFDATA_100_2024.dbo.sys_role WHERE 1 = 1 ;
SET IDENTITY_INSERT sys_role OFF ;
;

CREATE TABLE sys_user (
	user_id int IDENTITY(101,1) NOT NULL,
	dept_id int DEFAULT NULL NULL,
	login_name nvarchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	user_name nvarchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	user_type nvarchar(2) COLLATE Chinese_PRC_CI_AS DEFAULT N'00' NULL,
	email nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	phonenumber nvarchar(11) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	sex nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	avatar nvarchar(100) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	password nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	salt nvarchar(20) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	status nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	del_flag nchar(1) COLLATE Chinese_PRC_CI_AS DEFAULT N'0' NULL,
	login_ip nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	login_date datetime2 DEFAULT NULL NULL,
	create_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	create_time datetime2 DEFAULT NULL NULL,
	update_by nvarchar(64) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	update_time datetime2 DEFAULT NULL NULL,
	remark nvarchar(500) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL
);
SET IDENTITY_INSERT sys_user ON;
INSERT INTO sys_user
(user_id, dept_id, login_name, user_name, user_type, email, phonenumber, sex, avatar, password, salt, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark)
SELECT user_id, dept_id, login_name, user_name, user_type, email, phonenumber, sex, avatar, password, salt, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark
FROM UFDATA_100_2024.dbo.sys_user WHERE 1 = 1 ;
SET IDENTITY_INSERT sys_user OFF ;
;


CREATE TABLE sys_user_online (
	sessionId nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NOT NULL,
	login_name nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	dept_name nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	ipaddr nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	login_location nvarchar(255) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	browser nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	os nvarchar(50) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	status nvarchar(10) COLLATE Chinese_PRC_CI_AS DEFAULT N'' NULL,
	start_timestamp datetime2 DEFAULT NULL NULL,
	last_access_time datetime2 DEFAULT NULL NULL,
	expire_time int DEFAULT 0 NULL
);
-- SET IDENTITY_INSERT sys_user_online ON;
INSERT INTO sys_user_online
(sessionId, login_name, dept_name, ipaddr, login_location, browser, os, status, start_timestamp, last_access_time, expire_time)
SELECT sessionId, login_name, dept_name, ipaddr, login_location, browser, os, status, start_timestamp, last_access_time, expire_time
FROM UFDATA_100_2024.dbo.sys_user_online WHERE 1 = 2 ;
-- SET IDENTITY_INSERT sys_user_online OFF ;
;
CREATE TABLE sys_user_role (
	user_id int NOT NULL,
	role_id int NOT NULL
);
-- SET IDENTITY_INSERT sys_user_role ON;
INSERT INTO sys_user_role
(user_id, role_id)
SELECT user_id, role_id
FROM UFDATA_100_2024.dbo.sys_user_role WHERE 1 = 1 ;
-- SET IDENTITY_INSERT sys_user_role OFF ;



;
