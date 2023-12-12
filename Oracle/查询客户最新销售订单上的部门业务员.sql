SELECT * 
FROM (
  SELECT s.vbillcode,s.CCUSTOMERID,c.code custcode,c.name custname,s.CDEPTID,d.code depcode,d.name depname,s.CEMPLOYEEID ,p.code psncode,p.name psnname,ROW_NUMBER() over(PARTITION BY s.CCUSTOMERID ORDER BY s.DBILLDATE DESC)   rn
  FROM SO_SALEORDER s
  LEFT JOIN BD_CUSTOMER c ON s.CCUSTOMERID = c.pk_customer
  LEFT JOIN ORG_DEPT d ON s.CDEPTID = d.pk_dept
  LEFT JOIN BD_PSNDOC p ON s.CEMPLOYEEID = p.pk_psndoc 
  WHERE s.dr = 0
)
WHERE rn = 1
;


select distinct
       t.def12,
       t.def13,
       t.def14,
       t.def15,
       t.def16,
       t.def17,
       t.def18,
       t.def19,
       
       t.def20,
       t.def21,
       t.def22,
       t.def23,
       t.def24,
       t.def25,
       t.def26,
       t.def27,
       t.def28,
       t.def29,
       
       t.def30,
      
       t.deletestate,
       t.delperson,
       t.deltime from bd_customer t
