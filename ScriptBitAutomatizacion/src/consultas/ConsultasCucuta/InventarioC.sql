SELECT
    (TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD') || '#' ||
    IFNULL(T1."SuppCatNum",'') || '#' ||
    --IFNULL(T0."ItemCode",'')|| '#' ||
    IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+
    IFNULL((SELECT
    SUM(TA."InQty") - SUM(TA."OutQty") 
FROM
    {2}.OINM TA
WHERE
        (TA."CreateDate" <=LAST_DAY(ADD_MONTHS({4}))) AND TA."ItemCode" = T0."ItemCode" 
        AND (TA."Warehouse" IN ({1}))
    ),0) AS INT),'0') || '#' ||
IFNULL(T1."InvntryUom",'')|| '#C') AS "Inventario"
    FROM {2}.OINM T0
    INNER JOIN {2}.OITM T1 ON T1."ItemCode" = T0."ItemCode"
    INNER JOIN {2}.OITB T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod"
WHERE
    (
        T0."CreateDate" BETWEEN {3}
    ) AND T2."ItmsGrpCod" = {0}
    AND (T0."Warehouse" in ({1}))
    GROUP BY T0."ItemCode", 
    LAST_DAY(T0."CreateDate"), T1."InvntryUom",T1."SuppCatNum"
    ORDER BY T1."SuppCatNum"