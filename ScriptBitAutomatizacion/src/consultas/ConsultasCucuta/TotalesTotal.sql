SELECT 
	('TotalValorVenta' || '#' ||
cast(SUM(TC."Total")as bigint )) AS "Tot"
FROM (
SELECT 

        SUM(D1."Valor") AS "Total"
FROM(SELECT
		T1."CardCode" AS "CodigoCliente",
		T1."SlpCode" AS "CodigoVendedor",
		T2."ItemCode" AS "CodigoProducto",
		TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "Fecha",
		T1."DocNum" AS "NumeroDocumento",
		T2."Quantity" AS "Cantidad",
		(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "Valor",
		0 AS "Tipo",
		(T2."StockValue") AS "Costo"
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
T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN ('006','030')	--	bodega
	
	UNION ALL
	
	SELECT
		T1."CardCode" AS "CodigoCliente",
		T1."SlpCode" AS "CodigoVendedor",
		T2."ItemCode" AS "CodigoProducto",
		TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "Fecha",
		T1."DocNum" AS "NumeroDocumento",
		-T2."Quantity" AS "Cantidad",
		-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "Valor",
		1 AS "Tipo",
		-(T2."StockValue") AS "Costo"
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
T1."DocDate"  BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN ('006','030') --	Bodega
) AS D1

--UNION DE LA BASE DE CUCUTA CON  LA DE GRAN DISTRIBUIDOR.

UNION ALL

SELECT 
        SUM(D1."Valor") AS "Total"
FROM(SELECT
		T1."CardCode" AS "CodigoCliente",
		T1."SlpCode" AS "CodigoVendedor",
		T2."ItemCode" AS "CodigoProducto",
		TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "Fecha",
		T1."DocNum" AS "NumeroDocumento",
		T2."Quantity" AS "Cantidad",
		(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "Valor",
		0 AS "Tipo",
		(T2."StockValue") AS "Costo"
--	DOCUMENTO
	FROM
		"HBTGRANDISTRIBUIDOR"."OINV" T1
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."INV1" T2
			ON T1."DocEntry" = T2."DocEntry"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."INV12" T3
			ON T1."DocEntry" = T3."DocEntry"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."NNM1" T4
			ON T1."Series" = T4."Series"
--	CLIENTE
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OCRD" T5
			ON T1."CardCode" = T5."CardCode"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OCRG" T6
			ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OITM" T7
			ON T2."ItemCode" = T7."ItemCode"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OITB" T8
			ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
	LEFT JOIN
		"HBTGRANDISTRIBUIDOR"."@GD_SUBGRUPO" T9
			ON T7."U_GD_SubGrupo" = T9."Code"
	LEFT JOIN
		"HBTGRANDISTRIBUIDOR"."@GD_FAMPRODUCTOS" T10
			ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OSLP" T11
			ON T1."SlpCode" = T11."SlpCode"
	WHERE
T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND (T2."WhsCode" = '010' OR T2."WhsCode" = '014' OR T2."WhsCode" = '019')
	
	UNION ALL
	
	SELECT
		T1."CardCode" AS "CodigoCliente",
		T1."SlpCode" AS "CodigoVendedor",
		T2."ItemCode" AS "CodigoProducto",
		TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "Fecha",
		T1."DocNum" AS "NumeroDocumento",
		-T2."Quantity" AS "Cantidad",
		-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "Valor",
		1 AS "Tipo",
		-(T2."StockValue") AS "Costo"
--	DOCUMENTO
	FROM
		"HBTGRANDISTRIBUIDOR"."ORIN" T1
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."RIN1" T2
			ON T1."DocEntry" = T2."DocEntry"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."RIN12" T3
			ON T1."DocEntry" = T3."DocEntry"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."NNM1" T4
			ON T1."Series" = T4."Series"
--	CLIENTE
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OCRD" T5
			ON T1."CardCode" = T5."CardCode"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OCRG" T6
			ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OITM" T7
			ON T2."ItemCode" = T7."ItemCode"
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OITB" T8
			ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
	LEFT JOIN
		"HBTGRANDISTRIBUIDOR"."@GD_SUBGRUPO" T9
			ON T7."U_GD_SubGrupo" = T9."Code"
	LEFT JOIN
		"HBTGRANDISTRIBUIDOR"."@GD_FAMPRODUCTOS" T10
			ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
	INNER JOIN
		"HBTGRANDISTRIBUIDOR"."OSLP" T11
			ON T1."SlpCode" = T11."SlpCode"
	WHERE
T1."DocDate"  BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND (T2."WhsCode" = '010' OR T2."WhsCode" = '014' OR T2."WhsCode" = '019')
) AS D1 ) AS TC 