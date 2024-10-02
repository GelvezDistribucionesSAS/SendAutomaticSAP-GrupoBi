-- SELECT * FROM(
-- SELECT
-- 	(CASE 
--               WHEN T3."U_U_CheckBit" = 'Y' THEN T3."U_U_Acronimo"
--               ELSE T3."ItemCode" 
--               END || '#' ||
-- 	TO_VARCHAR(T1."TaxDate",'DDMMYYYY') || '#' ||
-- 	CONCAT(T4."SeriesName",T1."DocNum") || '#' ||
-- 	CASE 
-- 		WHEN T1."CANCELED" = 'Y' THEN CAST(-(T2."Quantity") AS INT)
-- 		ELSE CAST(T2."Quantity" AS INT)
-- 	END || '#' ||
-- 	CASE
-- 		WHEN T1."CANCELED" = 'Y' THEN CAST(-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 		WHEN T2."TaxOnly" = 'Y' THEN '0'
-- 		ELSE CAST((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 	END || '#' ||
-- 	IFNULL(IFNULL(T3."InvntryUom",T3."SalUnitMsr"),' ') || '#' ||
--     T2."WhsCode" || '#' ||
-- 	CASE T2."WhsCode"
-- 		WHEN '006' THEN 'PRINCIPAL CUCUTA'
-- 		WHEN '011' THEN 'PRINCIPAL OCAÑA'
-- 		WHEN '008' THEN 'AVERIAS CUCUTA'
-- 		WHEN '012' THEN 'AVERIAS OCAÑA'
-- 		WHEN '013' THEN 'PRINCIPAL ARAUCA'
-- 		WHEN '030' THEN 'CUCUTA MNM-TAT'
-- 		ELSE '0'
-- 	END
-- ) AS "SellIn"
-- FROM
-- 	"HBTGELVEZ_CUCUTA"."OPCH" T1
-- INNER JOIN
-- 	"HBTGELVEZ_CUCUTA"."PCH1" T2
-- 		ON T1."DocEntry" = T2."DocEntry"
-- INNER JOIN
-- 	"HBTGELVEZ_CUCUTA"."OITM" T3
-- 		ON T2."ItemCode" = T3."ItemCode"
-- INNER JOIN
-- 	"HBTGELVEZ_CUCUTA"."NNM1" T4
-- 		ON T1."Series" = T4."Series"
-- WHERE
-- 	T1."TaxDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
--               AND T2."WhsCode" IN ('006','030')

-- UNION ALL

-- SELECT
-- 	(CASE 
--               WHEN T3."U_U_CheckBit" = 'Y' THEN T3."U_U_Acronimo"
--               ELSE T3."ItemCode" 
--               END || '#' ||

-- 	TO_VARCHAR(T1."TaxDate", 'DDMMYYYY') ||'#' ||
-- 	CONCAT(T4."SeriesName",T1."DocNum") || '#' ||
-- 	 CASE
-- 		WHEN T1."JrnlMemo" LIKE '%Abono de compras%' THEN CAST(T2."Quantity" AS INT)
-- 		ELSE CAST(-(T2."Quantity") AS INT)
-- 	END || '#' ||
-- 	CASE
-- 		WHEN T1."JrnlMemo" LIKE '%Abono de compras%' THEN CAST((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 		ELSE CAST(-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 	END || '#' ||
-- 	IFNULL(IFNULL(T3."InvntryUom",T3."SalUnitMsr"),' ') || '#' ||
-- 	T2."WhsCode" || '#' ||
-- 	CASE T2."WhsCode"
-- 		WHEN '006' THEN 'PRINCIPAL CUCUTA'
-- 		WHEN '011' THEN 'PRINCIPAL OCAÑA'
-- 		WHEN '008' THEN 'AVERIAS CUCUTA'
-- 		WHEN '012' THEN 'AVERIAS OCAÑA'
-- 		WHEN '013' THEN 'PRINCIPAL ARAUCA'
-- 		WHEN '030' THEN 'CUCUTA MNM-TAT'
-- 		ELSE '0'
-- 	END
-- 	) AS "SellIn"
-- FROM
-- 	"HBTGELVEZ_CUCUTA"."ORPC" T1
-- INNER JOIN
-- 	"HBTGELVEZ_CUCUTA"."RPC1" T2
-- 		ON T1."DocEntry" = T2."DocEntry"
-- INNER JOIN
-- 	"HBTGELVEZ_CUCUTA"."OITM" T3
-- 		ON T2."ItemCode" = T3."ItemCode"
-- INNER JOIN
-- 	"HBTGELVEZ_CUCUTA"."NNM1" T4
-- 		ON T1."Series" = T4."Series"
-- WHERE
-- 	T1."TaxDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
--               AND T2."WhsCode" IN ('006','030')) AS "TA"
              

-- --UNION DE LA BASE DE CUCUTA CON LA DE GRAN DISTRIBUIDOR. 
-- UNION ALL

-- SELECT * FROM(
-- SELECT
-- 	(CASE 
--               WHEN T3."U_U_CheckBit" = 'Y' THEN T3."U_U_Acronimo"
--               ELSE T3."ItemCode" 
--               END || '#' ||
-- 	TO_VARCHAR(T1."TaxDate",'DDMMYYYY') || '#' ||
-- 	CONCAT(T4."SeriesName",T1."DocNum") || '#' ||
-- 	CASE 
-- 		WHEN T1."CANCELED" = 'Y' THEN CAST(-(T2."Quantity") AS INT)
-- 		ELSE CAST(T2."Quantity" AS INT)
-- 	END || '#' ||
-- 	CASE
-- 		WHEN T1."CANCELED" = 'Y' THEN CAST(-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 		WHEN T2."TaxOnly" = 'Y' THEN '0'
-- 		ELSE CAST((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 	END || '#' ||
-- 	IFNULL(IFNULL(T3."InvntryUom",T3."SalUnitMsr"),' ') || '#' ||
--     T2."WhsCode" || '#' ||
-- 	CASE T2."WhsCode"
-- 		WHEN '010' THEN 'PRINCIPAL CALI'
-- WHEN '014' THEN 'PRINCIPAL GIRON'
-- WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
-- ELSE '0'

-- 	END
-- ) AS "SellIn"
-- FROM
-- 	"HBTGRANDISTRIBUIDOR"."OPCH" T1
-- INNER JOIN
-- 	"HBTGRANDISTRIBUIDOR"."PCH1" T2
-- 		ON T1."DocEntry" = T2."DocEntry"
-- INNER JOIN
-- 	"HBTGRANDISTRIBUIDOR"."OITM" T3
-- 		ON T2."ItemCode" = T3."ItemCode"
-- INNER JOIN
-- 	"HBTGRANDISTRIBUIDOR"."NNM1" T4
-- 		ON T1."Series" = T4."Series"
-- WHERE
-- 	T1."TaxDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )

-- UNION ALL

-- SELECT
-- 	(CASE 
--               WHEN T3."U_U_CheckBit" = 'Y' THEN T3."U_U_Acronimo"
--               ELSE T3."ItemCode" 
--               END || '#' ||
-- 	TO_VARCHAR(T1."TaxDate", 'DDMMYYYY') ||'#' ||
-- 	CONCAT(T4."SeriesName",T1."DocNum") || '#' ||
-- 	 CASE
-- 		WHEN T1."JrnlMemo" LIKE '%Abono de compras%' THEN CAST(T2."Quantity" AS INT)
-- 		ELSE CAST(-(T2."Quantity") AS INT)
-- 	END || '#' ||
-- 	CASE
-- 		WHEN T1."JrnlMemo" LIKE '%Abono de compras%' THEN CAST((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 		ELSE CAST(-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS INT)
-- 	END || '#' ||
-- 	IFNULL(IFNULL(T3."InvntryUom",T3."SalUnitMsr"),' ') || '#' ||
-- 	T2."WhsCode" || '#' ||
-- 	CASE T2."WhsCode"
-- 		WHEN '010' THEN 'PRINCIPAL CALI'
-- WHEN '014' THEN 'PRINCIPAL GIRON'
-- WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
-- ELSE '0'

-- 	END
-- 	) AS "SellIn"
-- FROM
-- 	"HBTGRANDISTRIBUIDOR"."ORPC" T1
-- INNER JOIN
-- 	"HBTGRANDISTRIBUIDOR"."RPC1" T2
-- 		ON T1."DocEntry" = T2."DocEntry"
-- INNER JOIN
-- 	"HBTGRANDISTRIBUIDOR"."OITM" T3
-- 		ON T2."ItemCode" = T3."ItemCode"
-- INNER JOIN
-- 	"HBTGRANDISTRIBUIDOR"."NNM1" T4
-- 		ON T1."Series" = T4."Series"
-- WHERE
-- 	T1."TaxDate" BETWEEN {0}) AS "TA"--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )) AS "TA"
