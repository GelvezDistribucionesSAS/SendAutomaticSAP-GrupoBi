SELECT
    (
        T1."ItemCode" || '#' ||
--T1."SuppCatNum" || '#' || --Colgate
T1."ItemName" || '#' || 
CASE T1."SalUnitMsr" 
WHEN 'CBO' THEN 'OF' 
ELSE 'RG'
 END || '#' ||
    T1."SalUnitMsr" || '#' || 
T1."CodeBars" || '#' || 
--T1."ItemCode" || '#' || --Colgate
T1."ItmsGrpCod"
    ) AS "Sku"
FROM
    {2}.OINM T0
    INNER JOIN {2}.OITM T1 ON T0."ItemCode" = T1."ItemCode"
    INNER JOIN {2}.OITB T2 ON T1."ItmsGrpCod" = T2."ItmsGrpCod"
WHERE
    (
        T0."CreateDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{3})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
    )
    AND T2."ItmsGrpCod" = {0}
    AND T0."Warehouse" IN ({1})
    GROUP BY T1."ItemCode", T1."ItemName" ,T1."SalUnitMsr",T1."CodeBars", T1."ItmsGrpCod" --,T1."SuppCatNum"
    ORDER BY T1."ItemCode"