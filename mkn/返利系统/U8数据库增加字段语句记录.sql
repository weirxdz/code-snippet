-- 对U8系统中的项目档案增加是否返利的标识字段 Rebate_flage
ALTER TABLE UFDATA_400_2024.dbo.fitemss01 ADD Rebate_flage char(1) DEFAULT 'Y' NULL;
EXEC UFDATA_400_2024.sys.sp_addextendedproperty 'MS_Description', N'标识项目是否参与返利；默认为Y，参与返利；如有不参与的项目，改为N', 'schema', N'dbo', 'table', N'fitemss01', 'column', N'Rebate_flage';

ALTER TABLE UFDATA_500_2024.dbo.fitemss01 ADD Rebate_flage char(1) DEFAULT 'Y' NULL;
EXEC UFDATA_500_2024.sys.sp_addextendedproperty 'MS_Description', N'标识项目是否参与返利；默认为Y，参与返利；如有不参与的项目，改为N', 'schema', N'dbo', 'table', N'fitemss01', 'column', N'Rebate_flage';

ALTER TABLE UFDATA_600_2024.dbo.fitemss01 ADD Rebate_flage char(1) DEFAULT 'Y' NULL;
EXEC UFDATA_600_2024.sys.sp_addextendedproperty 'MS_Description', N'标识项目是否参与返利；默认为Y，参与返利；如有不参与的项目，改为N', 'schema', N'dbo', 'table', N'fitemss01', 'column', N'Rebate_flage';

ALTER TABLE UFDATA_610_2024.dbo.fitemss01 ADD Rebate_flage char(1) DEFAULT 'Y' NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'标识项目是否参与返利；默认为Y，参与返利；如有不参与的项目，改为N', 'schema', N'dbo', 'table', N'fitemss01', 'column', N'Rebate_flage';

ALTER TABLE UFDATA_700_2024.dbo.fitemss01 ADD Rebate_flage char(1) DEFAULT 'Y' NULL;
EXEC UFDATA_700_2024.sys.sp_addextendedproperty 'MS_Description', N'标识项目是否参与返利；默认为Y，参与返利；如有不参与的项目，改为N', 'schema', N'dbo', 'table', N'fitemss01', 'column', N'Rebate_flage';

ALTER TABLE UFDATA_800_2024.dbo.fitemss00 ADD Rebate_flage char(1) DEFAULT 'Y' NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'标识项目是否参与返利；默认为Y，参与返利；如有不参与的项目，改为N', 'schema', N'dbo', 'table', N'fitemss00', 'column', N'Rebate_flage';

ALTER TABLE UFDATA_900_2024.dbo.fitemss01 ADD Rebate_flage char(1) DEFAULT 'Y' NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'标识项目是否参与返利；默认为Y，参与返利；如有不参与的项目，改为N', 'schema', N'dbo', 'table', N'fitemss01', 'column', N'Rebate_flage';

-- 对存货档案表增加返利产品系列字段
ALTER TABLE UFDATA_100_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_100_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_400_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_400_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_500_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_500_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_600_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_600_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_610_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_610_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_700_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_700_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_800_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_800_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_900_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_900_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';

ALTER TABLE UFDATA_999_2024.dbo.Inventory ADD RebateProductSeries nvarchar(20) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'返利产品系列', 'schema', N'dbo', 'table', N'Inventory', 'column', N'RebateProductSeries';


-- 销售发票增加字段，记录修改前的含税单价；不用这个字段了
ALTER TABLE UFDATA_999_2024.dbo.SaleBillVouchs ADD originalTaxPrice decimal(38,6) NULL;
EXEC UFDATA_999_2024.sys.sp_addextendedproperty 'MS_Description', N'返利按钮修改前原始含税单价', 'schema', N'dbo', 'table', N'SaleBillVouchs', 'column', N'originalTaxPrice';
