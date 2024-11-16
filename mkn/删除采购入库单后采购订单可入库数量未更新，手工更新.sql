-- 删除采购入库单后采购订单可入库数量未更新，手工更新
SELECT b.id ,b.POID ,b.iQuantity ,b.freceivedqty ,b.freceivednum ,b.fPoArrQuantity ,b.fPoArrNum ,b.iReceivedQTY ,b.iReceivedNum ,b.iReceivedMoney ,b.*
FROM po_pomain h
INNER JOIN PO_Podetails b ON h.POID = b.POID 
WHERE h.cPOID = 'CGDD202409070043'
;

UPDATE PO_Podetails SET iReceivedQTY = 0 WHERE id = 1000003486 AND poid = 1000001570 AND iReceivedQTY = 1