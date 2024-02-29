-- 查询销售订单表头项目与表体项目不一致的记录
SELECT DISTINCT  h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SO_SODetails b
INNER JOIN SO_SOMain h ON b.ID = h.ID 
WHERE h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;

-- 查询销售订单表头项目与表体项目不一致的记录
SELECT b.AutoID ,h.cSOCode ,h.cDefine11 ,h.cDefine12 ,b.cItemCode ,b.cItemName ,b.cItem_class ,b.cItem_CName 
FROM SaleBillVouchs b
INNER JOIN SaleBillVouch h ON b.SBVID = h.SBVID  
WHERE h.cDefine11 <> b.cItemCode OR b.cItemCode IS NULL 
;

EXEC UpdateSoDetailsItemCode;
EXEC UpdateSaleBillVouchsItemCode;