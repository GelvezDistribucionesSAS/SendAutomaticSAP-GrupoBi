SELECT 

max(ta."Fecha")||'#' ||ta."Item"||'#' || sum(ta."Stock")||'#' || ta."TipoStok"
FROM 

(SELECT
20230201 AS "Fecha" ,
 --IFNULL(T1."SuppCatNum",T0."ItemCode") AS "Item",
 IFNULL(T0."ItemCode",'') AS "Item" ,
	 IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty")+ IFNULL((SELECT
	 SUM(TA."InQty") - SUM(TA."OutQty") 
				FROM OINM TA 
				WHERE (TA."CreateDate" <=LAST_DAY(ADD_MONTHS('20220101',-1))) 
				AND TA."ItemCode" = T0."ItemCode" 
				AND (TA."Warehouse" IN (006)) ),0) AS INT),'0') AS "Stock",
	 IFNULL(T1."InvntryUom",'') AS "TipoStok" 
FROM OINM T0 
INNER JOIN OITM T1 ON T1."ItemCode" = T0."ItemCode" 
INNER JOIN OITB T2 ON T2."ItmsGrpCod" = T1."ItmsGrpCod" 
WHERE ( T0."CreateDate" BETWEEN '20220101' AND '20240301' ) 
AND T2."ItmsGrpCod" IN ('149', '152')
AND (T0."Warehouse" IN (006)) 
GROUP BY T0."ItemCode",TO_VARCHAR(LAST_DAY(T0."CreateDate"),'YYYYMMDD'),T1."InvntryUom" 
ORDER BY T0."ItemCode") AS ta

GROUP BY ta."Item", ta."TipoStok"
