-- 需要建立一个物料档案对照表，源数据是U8中的存货档案，对照列需要维护
-- 字段包括 存货编码、存货名称、规格型号、存货分类、存货大类、对照分类、对照规格、备注
SELECT i.cInvCode 存货编码,i.cInvName 存货名称,i.cInvStd 规格型号,c.cInvCCode 存货分类编码,c.cInvCName 存货分类,c1.cInvCCode 存货大类编码,c1.cInvCName 存货大类,CONCAT(i.cInvName, COALESCE(i.cInvStd, '')) AS 对照规格
FROM Inventory i 
INNER JOIN InventoryClass c ON i.cInvCCode = c.cInvCCode 
INNER JOIN InventoryClass c1 ON LEFT(c.cInvCCode,2) = c1.cInvCCode 