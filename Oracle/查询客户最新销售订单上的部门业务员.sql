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
