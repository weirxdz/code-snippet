SELECT h.cCode ,b.cInvCode,b.cBatch ,B.iQuantity  ,b.iMPoIds 
FROM rdrecords10 b
INNER JOIN rdrecord10 h ON b.ID = h.ID 
WHERE H.cCode = '0000000001'

;
SELECT h.cCode ,b.cInvCode,b.cBatch ,B.iQuantity  ,b.iMPoIds 
FROM rdrecords11 b
INNER JOIN rdrecord11 h ON b.ID = h.ID 
WHERE H.cCode = '202312080006'

;
SELECT * FROM v_mom_moallocate_rpt
;
SELECT * FROM rdrecord10