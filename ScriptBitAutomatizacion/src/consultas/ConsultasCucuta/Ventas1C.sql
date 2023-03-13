SELECT
	(T1."CardCode" || '#' ||
	T1."SlpCode" || '#' ||
    T7."SuppCatNum" || '#' || --Colgate
	--T2."ItemCode" || '#' ||
	TO_VARCHAR(T1."DocDate", 'DDMMYYYY')|| '#' ||
	T1."DocNum" || '#' ||
	cast(T2."Quantity" as int) || '#' ||
	round((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)),0)|| '#' ||
	0 || '#' ||
	cast(T2."StockValue" as int)) AS "Ventas"
--	DOCUMENTO
FROM
	"HBTGELVEZ_CUCUTA"."OINV" T1
INNER JOIN
	"HBTGELVEZ_CUCUTA"."INV1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."INV12" T3
		ON T1."DocEntry" = T3."DocEntry"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."NNM1" T4
		ON T1."Series" = T4."Series"
--	CLIENTE
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OCRD" T5
		ON T1."CardCode" = T5."CardCode"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OCRG" T6
		ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OITM" T7
		ON T2."ItemCode" = T7."ItemCode"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OITB" T8
		ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
LEFT JOIN
	"HBTGELVEZ_CUCUTA"."@GD_SUBGRUPO" T9
		ON T7."U_GD_SubGrupo" = T9."Code"
LEFT JOIN
	"HBTGELVEZ_CUCUTA"."@GD_FAMPRODUCTOS" T10
		ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OSLP" T11
		ON T1."SlpCode" = T11."SlpCode"
WHERE
    --T1."DocDate" BETWEEN '[%1]' AND '[%2]'
    --T1."DocDate" BETWEEN '20221101' AND '20221130'
	T1."DocDate" BETWEEN {1}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{1})),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	AND T8."ItmsGrpCod" = {0}	--	Buscar por códigos
	AND T2."WhsCode" = '006'

UNION ALL

SELECT
	(T1."CardCode" || '#' ||
	T1."SlpCode" || '#' ||
    T7."SuppCatNum" || '#' ||   -- Colgate
	--T2."ItemCode" || '#' ||
	TO_VARCHAR(T1."DocDate", 'DDMMYYYY')|| '#' ||
	T1."DocNum" || '#' ||
	cast(-T2."Quantity" as int) || '#' ||
	round(-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)),0)|| '#' ||
	1 || '#' ||
	cast(-(T2."StockValue")as int)) AS "Ventas"
--	DOCUMENTO
FROM
	"HBTGELVEZ_CUCUTA"."ORIN" T1
INNER JOIN
	"HBTGELVEZ_CUCUTA"."RIN1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."RIN12" T3
		ON T1."DocEntry" = T3."DocEntry"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."NNM1" T4
		ON T1."Series" = T4."Series"
--	CLIENTE
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OCRD" T5
		ON T1."CardCode" = T5."CardCode"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OCRG" T6
		ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OITM" T7
		ON T2."ItemCode" = T7."ItemCode"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OITB" T8
		ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
LEFT JOIN
	"HBTGELVEZ_CUCUTA"."@GD_SUBGRUPO" T9
		ON T7."U_GD_SubGrupo" = T9."Code"
LEFT JOIN
	"HBTGELVEZ_CUCUTA"."@GD_FAMPRODUCTOS" T10
		ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OSLP" T11
		ON T1."SlpCode" = T11."SlpCode"
WHERE
    --T1."DocDate" BETWEEN '[%1]' AND '[%2]'
    --T1."DocDate" BETWEEN '20221101' AND '20221130'
	T1."DocDate" BETWEEN {1}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{1})),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	AND T8."ItmsGrpCod" = {0}	--	Buscar por códigos
	AND T2."WhsCode" = '006'