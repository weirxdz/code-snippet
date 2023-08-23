IF(C23 = '酒坛', CONCATENATE(FORMAT(C18, "yyyyMMdd"), format(if(len(SQL("RDS", "select MAX(right(B.CBATCH,3)) from fr_rw_jars_balance_b B where B.CBATCH like  '" + format(C18, "yyyyMMdd") + "%'", 1, 1)) = 0, "001", SQL("RDS", "select MAX(right(B.CBATCH,3)) from fr_rw_jars_balance_b B where B.CBATCH like  '" + format(C18, "yyyyMMdd") + "%'", 1, 1) + 1), "000")), '')


CONCATENATE(FORMAT(C2, "YY"),"-Y-",C15, format(if(len(SQL("RDS", "select MAX(right(B.CBATCH,3)) from fr_rw_rds_sealedcbatch_h B where B.CBATCH like  '" + CONCATENATE(FORMAT(C2, "YY"),"-Y-",C15) + "%'", 1, 1)) = 0, "001", SQL("RDS", "select MAX(right(B.CBATCH,3)) from fr_rw_rds_sealedcbatch_h B where B.CBATCH like  '" + CONCATENATE(FORMAT(C2, "YY"),"-Y-",C15) + "%'", 1, 1) + 1), "000"))



sql("RDS", "select frrp.shortname  from fr_rw_rds_product frrp where frrp.CCODE = (SELECT distinct  t.winecode FROM fr_rw_jars_balance_h t where t.jarscode = '" + C10 + "' and t.iLatest = 1) ", 1, 1)