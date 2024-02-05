WITH BASE AS
(SELECT T.DDATE IDATE, 
        t.banzu 班组,
        T.VAL VAL
FROM T --检测记录值
WHERE SUBSTR(T.DDATE,1,10) >= '${开始日期}' AND SUBSTR(T.DDATE,1,10) <= '${结束日期}'  AND T.KCP = '${关键控制点}' and T.GX = '${工序}'
ORDER BY T.DDATE),
/*标准差（两种算法）、均值、最大值、最小值*/
VAR_STDDEV_ALL AS
           (SELECT  STDDEV(BASE.VAL) STDDEV_A,STDDEV_SAMP(BASE.VAL) SAMP_A,AVG(BASE.VAL) AVG_A,MAX(BASE.VAL) MAX_A,MIN(BASE.VAL) MIN_A
           FROM BASE ),
/*上下限及中值*/
VAR_STD AS
        (SELECT T.GX,T.KCP,
               T.PRODUCT,
               T.SPEC,
               T.UPLEV,
               T.LOWLEV,
               T.MIDLEV
        FROM FR_QC_STD T
        WHERE T.KCP = '${关键控制点}' AND T.GX = '${工序}'
        )

SELECT Y.GX,Y.KCP,Y.UPLEV,Y.LOWLEV,X.STDDEV_A,X.SAMP_A,X.AVG_A,X.MAX_A,X.MIN_A,
       CASE   WHEN Y.UPLEV+Y.LOWLEV -2*X.AVG_A >= 0 THEN (Y.UPLEV - X.AVG_A)/(3*X.STDDEV_A)
              ELSE (X.AVG_A - Y.LOWLEV)/(3*X.STDDEV_A) END CPK,
       CASE   WHEN Y.UPLEV+Y.LOWLEV -2*X.AVG_A >= 0 THEN (Y.UPLEV - X.AVG_A)/(3*X.SAMP_A)
              ELSE (X.AVG_A - Y.LOWLEV)/(3*X.SAMP_A) END CPK_SAMP,BASE.VAL
FROM VAR_STDDEV_ALL X,VAR_STD Y,BASE