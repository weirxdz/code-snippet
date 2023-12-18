-- 成本对象
SELECT b.iMPoIds ,b.cInvCode,b.cBatch ,B.iQuantity  ,ob.BomId ,CAST(bb.Define1 AS decimal(12,6)) ,CAST(bb.Define2 AS decimal(12,6)) ,CAST(bb.Define3 AS decimal(12,6)) 
FROM rdrecords10 b
INNER JOIN rdrecord10 h ON b.ID = h.ID 
INNER JOIN mom_orderdetail ob ON b.iMPoIds = ob.MoDId 
LEFT JOIN bom_bom bb ON ob.BomId = bb.BomId 
WHERE H.cCode = '0000000001'

;
SELECT h.cCode ,b.cInvCode,b.cBatch ,B.iQuantity  ,b.iMPoIds 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
WHERE H.cCode in( '202312080006','202312080007','202312080008')

;
SELECT * FROM v_mom_moallocate_rpt
;
SELECT * FROM rdrecord10
;

-- 直接材料
SELECT b.MoDId ,b.MoId ,b.PartId ,b.InvCode ,c.InvCode AS materialcode,c.Qty ,c.IssQty ,b.BomId 
FROM mom_orderdetail b
INNER JOIN mom_order h ON b.MoId = h.MoId 
INNER JOIN mom_moallocate c ON b.MoDId = c.MoDId 
LEFT JOIN rdrecords10 AS rkb ON b.MoDId = rkb.iMPoIds 
INNER JOIN rdrecord10 AS rkh ON rkb.ID = rkh.ID 
WHERE 1=1 
	AND h.MoCode = '202312070021'
	-- AND rkh.cCode = ''
;
-- 分摊材料
-- 需要区分焊接材料210101\210102、商砼材料0201\0202\0203\0204、其他材料
-- 材料出库单上需要填写领料部门
SELECT h.cCode ,b.cInvCode,b.cBatch ,B.iQuantity  ,b.iMPoIds ,h.cSource ,h.cDepCode 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
INNER JOIN Inventory i ON b.cInvCode = i.cInvCode 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
WHERE 1=1 
	--AND H.cCode in( '202312080006','202312080007','202312080008')
	AND h.cSource = '库存'
	
-- 存货单价
SELECT *
FROM RdRecord01 h
INNER JOIN rdrecords01 b ON h.ID = b.ID 
WHERE h.cCode = '202312060050'

-- 制费从凭证取数；其中有一些其他的材料出库单，做凭证到制造费用，
-- 费用凭证的发生数仅能录入借方，负数可以录入借方红字
-- 两天做完

-- 销售（有虚拟库，得会库存的操作）、采购、物控+仓库、财务
-- 财务带供应链的4个账套；
-- 委外单独培训
-- 销货单、进货单去掉了，业务部门做发票、财务审核
-- 防火、耐火、华筑，迈凯诺的销售出库单倒过来做采购订单、销售出库
--两个供应链 启源（）、捷顺，

-- 四五六培训
