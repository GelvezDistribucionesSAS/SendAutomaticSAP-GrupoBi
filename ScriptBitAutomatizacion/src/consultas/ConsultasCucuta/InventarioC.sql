SELECT 

max(ta."Fecha")||'#' ||ta."Item"||'#' || sum(ta."Stock")||'#' || ta."TipoStok"||'#C'
FROM 

(SELECT
TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD') AS "Fecha" ,
 IFNULL(T1."SuppCatNum",T0."ItemCode") AS "Item",
 --IFNULL(T0."ItemCode",'') AS "Item" ,
	 IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+ IFNULL((SELECT
	 SUM(TA."InQty") - SUM(TA."OutQty") 
				FROM {2}.OINM TA 
				WHERE (TA."CreateDate" <=LAST_DAY(ADD_MONTHS('20220101',-1))) 
				AND TA."ItemCode" = T0."ItemCode" 
				AND (TA."Warehouse" IN ({1})) ),0) AS INT),'0') AS "Stock",
	 IFNULL(T1."InvntryUom",'') AS "TipoStok" 
FROM {2}.OINM T0 
INNER JOIN {2}.OITM T1 ON T1."ItemCode" = T0."ItemCode" 
INNER JOIN {2}.OITB T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod" 
WHERE ( T0."CreateDate" BETWEEN '20220101' AND '{3}' ) 
AND T2."ItmsGrpCod" = {0}
AND (T0."Warehouse" IN ({1})) 
GROUP BY T1."SuppCatNum",TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD'),T1."InvntryUom" ,T0."ItemCode" 
ORDER BY T0."ItemCode") AS ta

GROUP BY ta."Item", ta."TipoStok"