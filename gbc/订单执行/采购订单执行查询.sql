select t.POID 采购订单主表标识,t.ID 采购订单子表标识,h.cPOID as 订单编号,T.CDEFINE28 生产计划号,h.dPODate as 订单日期,t.dArriveDate as 计划到货日期,LEFT(CONVERT(VARCHAR, h.cAuditTime, 120),13) 订单审核时间,m.cinvcode as 存货编码,m.cinvname as 存货名称,m.cInvStd as 规格型号,d.cDepName as 采购部门,p.cPersonName as 采购业务员,h.cVenCode 供应商编码,sp.cvenname as 供应商名称,u.ccomunitname as 计量单位,t.iQuantity as 采购数量,t.iTaxPrice as 含税单价,t.iSum as 含税金额,t.iUnitPrice as 无税单价,t.iMoney as 无税金额,h.cmaker as 制单人,
pab.Autoid 到货单子表主键,pab.ID 到货单主表主键,pah.cCode 到货单号,LEFT(CONVERT(VARCHAR, pah.caudittime, 120),13) 到货审核时间,pab.iQuantity 到货数量,pah.cMaker 到货录入人,
 qmb.SOURCEAUTOID ,qmh.CINSPECTCODE AS 报检单号,LEFT(CONVERT(VARCHAR, qmh.DVERIFYTIME, 120),13) 报检审核时间,qmh.cMaker 报检人,
 qch.INSPECTAUTOID 报检单子表ID,qch.ID ,qch.CCHECKCODE  检验单号,LEFT(CONVERT(VARCHAR, qrh.DVERIFYTIME, 120),13)   检验审核时间,qch.CDEFINE13  检验结论,qch.FREGQUANTITY  合格数量,qch.FDISQUANTITY  不合格数量,qcp.cPsn_Name  检验人
 ,qrh.CDEFINE13 不良品处理方式,rh.cCode 入库单号,LEFT(CONVERT(VARCHAR, rh.dnverifytime , 120),13)  入库审核时间,rb.iQuantity 入库数量,rh.cMaker 入库录入人
from PO_Podetails as t
left join PO_Pomain as h on t.POID = h.POID
left join Inventory as m on t.cInvCode = m.cInvCode
left join Department as d on h.cDepCode = d.cDepCode
left join Person as p on h.cPersonCode = p.cPersonCode
left join Vendor as sp on h.cVenCode = sp.cVenCode
left join ComputationUnit as u on m.cComUnitCode = u.cComUnitCode
LEFT JOIN PU_ArrivalVouchs pab ON t.ID = pab.iPOsID
LEFT JOIN PU_ArrivalVouch pah ON pab.ID = pah.ID 
LEFT JOIN QMINSPECTVOUCHERS qmb ON pab.Autoid = qmb.SOURCEAUTOID
LEFT JOIN QMINSPECTVOUCHER qmh ON qmb.ID = qmh.ID 
LEFT JOIN QMCHECKVOUCHER qch ON qmb.AUTOID = qch.INSPECTAUTOID
LEFT JOIN hr_hi_person qcp ON  qch.CCHECKPERSONCODE = qcp.cPsn_Num 
LEFT JOIN QMREJECTVOUCHER qrh ON pab.Autoid = qrh.SOURCEAUTOID AND pah.ID = qrh.SOURCEID AND qch.ID = qrh.CHECKID
LEFT JOIN rdrecords01 rb ON  pab.Autoid = rb.iArrsId 
LEFT JOIN RdRecord01 rh ON rb.ID = rh.ID 
where 1 = 1 
--and h.dPODate >= '${开始日期}' and h.dPODate <= '${结束日期}' ${if(len(存货名称) == 0,"","and t.存货名称 in ('" + 存货名称 + "')")} ${if(len(供应商名称) == 0,""," and t.供应商名称 in ('" + 供应商名称 + "')")}  ${if(len(订单编号) == 0,""," and t.订单编号 = '" + 订单编号 + "'")} ${if(len(生产计划号)==0,""," and T.CDEFINE28 ='"+生产计划号+"'")} 
AND t.ID = 1000024264 
order by h.dPODate
;
select b.Autoid 到货单子表主键,b.ID 到货单主表主键,iorderid 订单ID ,iPOsID  采购订单子表标识  ,h.cCode 到货单号,CONVERT(VARCHAR, h.caudittime, 120) 到货审核时间,b.iQuantity 到货数量,h.cMaker 到货录入人
				from PU_ArrivalVouchs as b
				INNER JOIN PU_ArrivalVouch h ON b.ID = h.ID 
				where 1=1 --b.iposid in (select * from pk_podetails)
					AND b.Autoid = 1000098713
;

SELECT qmb.SOURCEAUTOID ,qmh.CINSPECTCODE AS 报检单号,qmh.DVERIFYTIME 报检审核时间,qmh.cMaker 报检人,qmb.SOURCEAUTOID ,qmb.*
FROM QMINSPECTVOUCHER qmh
INNER JOIN QMINSPECTVOUCHERS qmb ON qmh.ID = qmb.ID 
WHERE 1 = 1
	AND qmh.CINSPECTCODE = '0000030859' 

;

SELECT qch.INSPECTAUTOID 报检单子表ID,qch.ID ,qch.CCHECKCODE  检验单号,qch.DVERIFYDATE  检验审核时间,qch.CCHKCONCLUSION  检验结论,qch.FREGQUANTITY  合格数量,qch.FDISQUANTITY  不合格数量,qcp.cPsn_Name  检验人
FROM QMCHECKVOUCHER qch
LEFT JOIN hr_hi_person qcp ON  qch.CCHECKPERSONCODE = qcp.cPsn_Num 
WHERE qch.CCHECKCODE = 58074
--qch.INSPECTAUTOID = 49383
;

SELECT qrh.CDEFINE13 不良品处理方式,qrh.SOURCEAUTOID ,qrh.SOURCEID ,qrh.SOURCECODE ,qrh.CSOURCE ,qrh.CHECKID ,qrh.CCHECKCODE ,CONVERT(VARCHAR, qrh.DVERIFYTIME, 120)  ,qrh.*
FROM QMREJECTVOUCHER qrh
INNER JOIN QMREJECTVOUCHERS qrb ON qrh.ID = qrb.ID 
WHERE qrh.CREJECTCODE = '0000014971'