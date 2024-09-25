-- FR_RS.dbo.RS_OrgList definition

-- 返利系统销售组织对照表 

-- DROP TABLE FR_RS.dbo.RS_OrgList;

CREATE TABLE FR_RS.dbo.RS_OrgList (
	CCODE varchar(4) COLLATE Chinese_PRC_CI_AS NOT NULL,
	CNAME nvarchar(100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	RFLAG int DEFAULT 0 NULL,
	RS_ORGCODE nvarchar(4) COLLATE Chinese_PRC_CI_AS NULL,
	RS_ORGNAME nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
	Sales_Stat_StartDate varchar(10) COLLATE Chinese_PRC_CI_AS NULL,
	Sales_Stat_EndDate varchar(10) COLLATE Chinese_PRC_CI_AS NULL,
	Rebate_Exec_StartDate varchar(10) COLLATE Chinese_PRC_CI_AS NULL,
	Rebate_Exec_EndDate varchar(10) COLLATE Chinese_PRC_CI_AS NULL,
	dr int NULL,
	CONSTRAINT PK_RS_OrgList PRIMARY KEY (CCODE)
);

-- Extended properties

EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码，U8系统中自定义项档案的代码', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'CCODE';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称，U8系统中自定义项档案的名称，按公司名称列示', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'CNAME';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否执行返利计算，0，执行，1，不执行', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'RFLAG';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返利系统组织编码，会存在多个公司对应一个编码的情况，如耐火和四川耐火都对应为耐火', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'RS_ORGCODE';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返利系统组织名称', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'RS_ORGNAME';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销量统计起始日期', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'Sales_Stat_StartDate';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销量统计截至日期', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'Sales_Stat_EndDate';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返利执行起始日期', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'Rebate_Exec_StartDate';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返利执行截至日期', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'Rebate_Exec_EndDate';
EXEC FR_RS.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效性标识，0为有效记录，1为无效记录', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'RS_OrgList', @level2type=N'Column', @level2name=N'dr';