-- 存货返利系列视图
CREATE VIEW v_RS_ProductLine AS 
SELECT i.cInvCode cinvcode,i.cInvName cinvname,i.cInvStd cinvstd,p.name AS plname
FROM Inventory i 
INNER JOIN InventoryClass ic ON i.cInvCCode = ic.cInvCCode 
LEFT JOIN FR_RS.dbo.RS_RebateProductLine p ON i.RebateProductSeries = p.code AND p.dr = 0 
WHERE (ic.cInvCName LIKE '%超轻%' OR ic.cInvCName LIKE '%一体%' )
;

-- 返利组织及起始日期视图
CREATE VIEW dbo.v_rs_org AS
SELECT r.CCODE AS orgcode,r.CNAME AS orgname,r.RFLAG AS rflag,r.Rebate_Exec_StartDate ,r.Rebate_Exec_EndDate 
FROM FR_RS.dbo.RS_OrgList r
WHERE r.dr = 0
;

-- 出库统计数据



-- 发票执行数据


-- 余额表数据


基础档案这周维护完
  销售订单表头
  
  
  
  
  接口调一下
  
  
  基础档案：
      存货，两类下的存货档案要财务处理，
      触发数量，触发后的返利比例表
      起止日期
      客户档案标识
      
   周末先用冯录的数据测试下
   
   1、10万、21万
   2、手填记录，帆软填报表，操控余额；红字单据，如果有大额的再反馈
   3、
   
  后边的
  古贝春，
  
  迈凯诺，返利、项目利润
  
  
  东为
  项目利润调整；
  
绿健
  
  
  
  
  
