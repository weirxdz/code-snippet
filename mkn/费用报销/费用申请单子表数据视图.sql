--100
USE ufdata_100_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--200
USE ufdata_200_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--300
USE ufdata_300_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--400
USE ufdata_400_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--500
USE ufdata_500_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--600
USE ufdata_600_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--610
USE ufdata_610_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--700
USE ufdata_700_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--800
USE ufdata_800_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss00 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;
--900
USE ufdata_900_2024;
CREATE VIEW v_NE_CostApply_sub AS 
SELECT
	b.ID, -- 费用申请单子表主键
	b.CostApplyID,-- 费用申请单主表主键
	ec.cExpCName ,--费用分类
	ei.cExpName  ,--费用项目
	b.ApplyMoney ,--申请金额
	b.used ,--行说明
	f.citemname ,--销售项目
	v.cVenName ,--供应商
	d.cDepName --费用承担部门
FROM
	NE_CostApply_Sub b
INNER JOIN  NE_CostApply h ON b.CostApplyID  = h.ID 
LEFT JOIN ExpenseItem ei ON b.CostItemID = ei.cExpCode 
LEFT JOIN ExpItemClass ec ON b.CostItemClassID = ec.cExpCCode 
LEFT JOIN fitemss01 f ON b.ItemID = f.citemcode 
LEFT JOIN Department d ON b.SpreadDeptID = d.cDepCode 
LEFT JOIN Vendor v ON b.VenCode = v.cVenCode 
WHERE h.VouchState < 4;