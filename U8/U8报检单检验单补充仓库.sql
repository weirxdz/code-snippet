select t.cWhCode,t.cInvCode,t.fAvaNum,t.fAvaQuantity,t.fDisableNum,t.fDisableQuantity,t.fInNum,t.fInQuantity,t.fOutNum,t.fOutQuantity,t.iNum,t.iQuantity,t.* 
from CurrentStock t
where t.cInvCode = '41110002'
;
select h.CINSPECTCODE,b.AUTOID,b.CWHCODE
from QMINSPECTVOUCHER h
inner join QMINSPECTVOUCHERS b on h.ID = b.ID 
where h.CINSPECTCODE = '202309070002';
-- update QMINSPECTVOUCHERS set CWHCODE = '01' where AUTOID = '1000000002'
;
select t.ID, t.CWHCODE,t.CCHECKCODE,t.CCHECKTYPECODE 
from QMCHECKVOUCHER t
where t.CCHECKCODE = '0000020397' and t.CCHECKTYPECODE = 'PER';
-- update QMCHECKVOUCHER set CWHCODE = '01' where ID = 89124

--update QMINSPECTVOUCHERS 
--set CWHCODE = '01' 
--where AUTOID in(select b.AUTOID
--					from QMINSPECTVOUCHER h
--					inner join QMINSPECTVOUCHERS b on h.ID = b.ID 
--					where h.CINSPECTCODE in( '202309070001','202309070003','202309070004','202309070005','202309070006','202309070009','202309070008'));

--update QMCHECKVOUCHER 
--set CWHCODE = '01' 
--where ID in (
--	select t.ID
--	from QMCHECKVOUCHER t
--	where t.CINSPECTCODE in( '202309070001','202309070003','202309070004','202309070005','202309070006','202309070009','202309070008') and t.CCHECKTYPECODE = 'PER');
