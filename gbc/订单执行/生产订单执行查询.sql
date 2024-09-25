select h.RelsVTid,h.VTid,h.MoId AS 订单主键,b.MoDId as 订单子表主键,h.MoCode AS 生产订单编号,b.Define28 生产计划号,LEFT(CONVERT(VARCHAR, h.CreateDate, 120),13) AS 创建日期,CONVERT(VARCHAR, h.CreateDate, 120) AS 订单日期,CONVERT(VARCHAR,b1.StartDate, 120) as 开工日期,CONVERT(VARCHAR,b1.DueDate, 120) as 完工日期,LEFT(CONVERT(VARCHAR, b.RelsTime, 120),13) 订单审核时间,uu.cUser_Name 订单录入人,b.InvCode as 存货编码,m.cInvName as 存货名称,m.cInvStd as 规格型号,d.cDepName as 生产部门,u.cComUnitName as 计量单位,b.Qty as 计划生产数量,bjh.CINSPECTCODE 报检单号,CONVERT(VARCHAR,bjh.DDATE, 120) as 报检日期,LEFT(CONVERT(VARCHAR,bjh.DVERIFYTIME, 120),13) as 报检审核日期,bjh.CMAKER  报检人,bjb.FQUANTITY as 报检数量,jyh.CCHECKCODE 检验单号,CONVERT(VARCHAR,jyh.DDATE, 120)  as 检验单日期,LEFT(CONVERT(VARCHAR,jyh.DVERIFYtime, 120),13)  as 检验单审核时间,jyh.CDEFINE13 检验结论,jyh.FREGQUANTITY as 合格接收数量,jyh.FDISQUANTITY 不合格接收数量,'' 不合格品处理方式,qcp.cPsn_Name 检验人,jyh.cdefine10 as 灌装产线,rkh.cCode 入库单号,LEFT(CONVERT(VARCHAR,rkh.dnverifytime , 120),13) as  入库审核日期,CONVERT(VARCHAR,rkh.dDate, 120) as 入库日期,rkb.iQuantity  as 入库数量,bjh.CVOUCHTYPE,rkh.cMaker 入库录入人,jyh.*
from mom_order AS h 
left join mom_orderdetail AS b on b.moid = h.moid
left join mom_morder as b1 on b.MoDId = b1.MoDId
left join Inventory as m on b.InvCode = m.cInvCode
left join ComputationUnit as u on m.cComUnitCode = u.cComunitCode
left join QMINSPECTVOUCHERS as bjb on b.MoDId = bjb.SOURCEAUTOID
left join QMINSPECTVOUCHER as bjh on bjb.id = bjh.id
left join QMCHECKVOUCHER as jyh on bjb.AUTOID = jyh.INSPECTAUTOID
LEFT JOIN hr_hi_person qcp ON  jyh.CCHECKPERSONCODE = qcp.cPsn_Num 
--LEFT JOIN QMREJECTVOUCHER qrh ON pab.Autoid = qrh.SOURCEAUTOID AND pah.ID = qrh.SOURCEID AND qch.ID = qrh.CHECKID -- 暂时没有产品的不合格处理单
left join rdrecords10 as rkb on b.MoDId = rkb.iMPoIds and jyh.ID = isnull(rkb.iCheckIdBaks,'')
left join rdrecord10 as rkh on rkb.id = rkh.id
left join Department as d on rkh.cDepCode = d.cDepCode
LEFT JOIN UA_User uu ON h.CreateUser = uu.cUser_Id 
WHERE b.InvCode like '5%' and h.VTid = '30413' and isnull(bjh.CVOUCHTYPE,'QM02') = 'QM02' 
--and h.CreateDate >= '${开始日期}' and h.CreateDate <= '${结束日期}'  ${if(len(订单编号)==0,""," and h.MoCode ='"+订单编号+"'")} ${if(len(生产计划号)==0,""," and b.Define28 ='"+生产计划号+"'")} 
AND H.MoCode = '20190908001'
order by h.CreateDate DESC



;
SELECT * FROM QMREJECTVOUCHER t WHERE t.CCHECKTYPECODE  = 'PRO'