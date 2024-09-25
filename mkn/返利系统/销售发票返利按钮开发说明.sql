-- 开发程序，当《销售发票》符合“返利范围”的“组织范围”的子公司“返利金额余额”大于1（不是大于0，主要是考虑四舍五入导致的尾差问题）并且行记录产品档案符“返利范围”的“产品范围”时，计算返利后的含税单价。按照符合范围要求所有行记录的“返利单价”*销售数量*30%之和计算返利金额，如果返利金额小于等于该子公司的“返利金额余额”，那么行记录中“调整单价”（自定义字段）按照“含税单价”*70%计算并填写（不符合返利范围的行记录“返利单价”为空值）；如果返利金额小于等于该子公司的“返利金额余额”，那么按照“返利金额余额”/本单计算的返利金额计算返利折扣，行记录中“调整单价”（自定义字段）按照“含税单价”*返利折扣计算并填写。财务部确认各行记录“调整单价”计算的正确性，确认后按照“调整单价”更改“含税单价”。

-- 销售发票上增加一个按钮，"返利计算"
-- 发票保存后点击这个按钮，执行以下运算

-- 查询销售组织是否执行返利
SELECT rflag FROM v_rs_org WHERE v_rs_org.orgname = cdefine14
--      N，退出
--      Y，继续
-- 查询销售组织的返利期间
SELECT Rebate_Exec_StartDate,Rebate_Exec_EndDate FROM v_rs_org WHERE v_rs_org.orgname = cdefine14
-- 如果销售发票的单据日期不在 Rebate_Exec_StartDate,Rebate_Exec_EndDate 之间，直接退出
-- 销售发票的日期字段：SaleBillVouch.dDate 
-- 查询销售项目是否执行返利
SELECT Rebate_flage FROM v_rs_fitemss_xs WHERE v_rs_fitemss_xs.citemcode = cdefine11
--      N，退出
--      Y，继续

--    查询表体存货所属产品系列, plname 的值可能为空，或者是 超轻板、一体板 中的一种或两种都有
SELECT distinct plname FROM v_RS_ProductLine WHERE v_RS_ProductLine.cinvcode IN (SELECT DISTINCT cinvcode FROM SaleBillVouchs b where b.SBVID = '$当前发票主键')
--    既不存在超轻板也不存在一体板，退出
--    存在
--      查询返利余额，如果 plname 只返回一条记录，则只查询这个系列的即可，如果 plname 返回多条记录，需要循环处理每个产品系列
SELECT t.RebatesBalance FROM v_RS_RebateBalances t WHERE t.orgname = cdefine14 AND productlinename = '$查询结果中的一个'
--        返利余额 <= 1 退出
--        返利余额 > 1 
--          计算返利金额，发票表体所有属于当前处理的系列的存货行，以 发票数量*返利单价*返利计算比例 计算返利金额
--            发票数量 iQuantity ，返利单价 存货自定义项14 cInvDefine14 ，
--            返利计算比例
SELECT ipercentage FROM v_rs_Rebate_percentage WHERE orgname = cdefine14 AND productlinename = '$查询结果中的一个'
--            当前系列的返利金额，sum(iQuantity * cInvDefine14 * ipercentage)
--            返利余额 >= 返利金额
--              直接计算调整单价即可，cDefine24 记录调整单价 ，cDefine23 记录原含税单价 iTaxUnitPrice 
--              cDefine23 = iTaxUnitPrice ，cDefine24 = iTaxUnitPrice - cInvDefine14 * ipercentage
--            返利余额 < 返利金额 
--              需要先计算返利计算系数，然后再计算调整单价；
--                返利计算系数为 返利余额 / 返利金额
--                cDefine23 = iTaxUnitPrice ，cDefine24 = iTaxUnitPrice - cInvDefine14 * ipercentage * 返利计算系数

--   计算一个产品系列后，再计算下一个产品系列，直至计算玩所有产品系列           


1、SELECT rflag FROM v_rs_org WHERE v_rs_org.orgname = cdefine14 的返回值为 'N' 的时候，返回信息为 '销售公司不在执行返利的组织范围，请检查！'
2、SELECT Rebate_Exec_StartDate,Rebate_Exec_EndDate FROM v_rs_org WHERE v_rs_org.orgname = cdefine14 返回的时间为空的时候，返回信息为 '销售公司返利执行期间维护有误，请检查！'
3、销售发票的日期不在 SELECT Rebate_Exec_StartDate,Rebate_Exec_EndDate FROM v_rs_org WHERE v_rs_org.orgname = cdefine14 返回的日期之间的时候，返回信息为 '单据日期不在返利执行期间，请检查！'
4、增加一步检查，有产品系列的存货，如果存货自定义项14 没有维护，报错，'存货的返利单价没有维护，请检查!'
5、已经计算过的发票，再次计算的时候不能执行，可以是 发票表体自定义项 cDefine23 和 cDefine24 同时非空时，点击按钮 ，不执行计算，直接报错 '此发票已经执行过返利计算，请检查！'；
如果 发票表体自定义项 cDefine23 非空，cDefine24 为空时，如果 含税单价等于 cDefine23 可以执行计算，如果 含税单价不等于 cDefine23，不执行计算，直接报错 '此发票已经执行过返利计算，请检查！'；
6、计算逻辑修改一下。查询出单据某一产品系列返利金额和当前返利余额后，逐行计算
返利金额 = sum(iQuantity * cInvDefine14 * ipercentage)
while(返利金额 > 0 AND 返利余额 > 1){ 
  行返利金额 = 行发票数量 * 行发票含税单价 * 0.3 
  行返利金额 = MIN(返利金额,返利余额,行返利金额)
  返利金额 = 返利金额 - 行返利金额
  返利余额 = 返利余额 - 行返利金额
  调整单价 = 含税金额 - 行返利金额 / 行发票数量
}

