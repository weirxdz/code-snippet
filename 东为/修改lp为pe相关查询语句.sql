SELECT *
FROM   mom_orderdetail B 
INNER JOIN mom_order h ON B.MoId = H.MoId 
WHERE H.MoCode = '202312130039'

;

SELECT MC.*
FROM   mom_moallocate MC 
INNER JOIN mom_orderdetail B ON MC.MoDId = B.MoDId 
INNER JOIN mom_order h ON B.MoId = H.MoId 
WHERE H.MoCode = '202312130039' AND MC.WhCode = '21' AND MC.InvCode  = '0101110013'

;
SELECT T.AllocateId ,T.SoType ,T.SoCode ,T.SoSeq,T.SoDId  FROM mom_moallocate t 
-- UPDATE mom_moallocate SET SoType = 0,SoCode = null,SoSeq = null,SoDId = null
;
SELECT T.AllocateId ,T.SoType ,T.SoCode ,T.SoSeq,T.SoDId  FROM mom_moallocate T WHERE T.SoType  <> 0;

--关于供需政策LP能否改PE问题,只能回答不建议修改,因为一旦使用生成计划并下达计划后生成的供应单据此时写入销售定单＋行号信息；再修改为PE后这样生成的有很多单据带有销售定单信息；如果这些供应单据没有入库会参与mrp计算和修改为PE之后生成的计划混在一起,造成计划中PE政策存货有的带有销售定单＋行号信息,有的供应单据没有销售定单＋行号 ；从而混乱不宜查看,给计划分析造成困难；
--
--   如果排除以上问题,需要:
--
--1.删除所有根据计划下达的供应单据(生产,采购,委外等)或全部抹掉订单＋行信息,否则,计划不准确甚至混乱,改为PE后,即使从后台数据也无法完全修复处理,以为无法处理期间合并；这也是开发强调的问题；
--
--2. 删除所有计划,重算
--
--3. 现有LP件订单库存全部改为自由库存(currentstock.iSoType,currentstockiSodid),抹掉供应单据订单＋行信息
--
--4.批改LP为PE,需要同时批改"销售跟单"
--
--5.pe/lp混合使用,bom建立注意不能pe母件下挂lp子件,特别是PE＋销售跟单情况下；
--
--6.严格测试后使用


--如题。我的操作是
--truncate table  CurrentStock
--
--Update   Inventory  SET cSRPolicy = 'PE'  WHERE cSRPolicy = 'LP'
--
--
--update inventory_sub  set iRequireTrackStyle=0
--exec SP_ClearCurrentStock_ST
--
--where条件到时候详细加，各位大大看看，还有哪里要注意的！

--供需政策应该在实施阶段方案确定,不应经常来回修改；否则,可能会存在问题；
--
--注意事项:1.升级871删除所有已存在的MPS/MRP计划,释放所有LP件订单库存并确认表CurrentStock.iSodid和iSoType值为null
--
--         2.871后修改存货档案时注意"销售跟单"选项应先同步修改
--
--         3.确认所有存货BOM,不能存在PE供需政策的母件bom子件为LP件情况,否则,计划有误；
--
--        4.和客户说明,如果使用PE＋销售跟单属性时不能处理销售订单插单的情况(02单的预计完工日在01单之前),否则,跟单信息无用且会误导客户
--
--         5.因为设计上供需政策不应相互修改,所以该方案未经测试,请修改后详细测试使用

--	你好!
--
--  首先确认,金盘安装的872,升级后原PE跟单存货自动修改为PE件,如果要修改为LP可根据实施工具中"pe转LP"修改；过程复杂；
--
--  其次确认,你对该客户数据升级872时不是使用的金盘,所以没有自动修改为PE；而产品设计上不支持"LP转PE",如果强行修改可能涉及到很多未经测试的不明问题；
--
--  已经提交开发给出意见:
--
--1.南京开发意见:"修改所有存货为pe不可部分修改,语句:update inventory set bspecialorder = 0,btracksalebill = 0,csrpolicy = ＇PE＇。修改后需要整理现存量，重展MPS/MRP计划，说明:在一些查询界面，如供需资料查询，因为对于已生成的生产订单或采购订单等供应单据已经有销售订单信息，其"需求跟踪方式仍显示原来的跟踪方式"即lp的销售订单和行，但以修改后PE件原理进行计划,所以无法根据销售订单等跟踪方式分析计划,这种情况可视为销售订单信息不存在或隐藏显示。请支持人员再咨询供应链，财务等，修改跟踪方式对供应链单据，成本是否可行？"
--
--2.供应链开发意见:"整理存量后，对供应链单据没有影响"
--
--  再次声明,设计上不支持的修改,未经任何测试,请详细测试

--1、
----update inventory_sub  set iRequireTrackStyle=0  where cinvsubcode in (select cInvCode  from CurrentStock where iSoType <>0) --需求跟踪方式为0
--2、
----update inventory set csrpolicy='PE'  where cinvcode in (select cInvCode  from CurrentStock where iSoType <>0)  --LP改PE
--3、
----delete from currentstock  --删除现存量后，再重新整理现存量。

SELECT * FROM inventory I WHERE I.csrpolicy='LP'

