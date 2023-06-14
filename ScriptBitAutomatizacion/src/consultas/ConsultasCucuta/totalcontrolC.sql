SELECT
	(cast((SUM(D1."Valor")) as int)) AS "Totales_control"
FROM (
	SELECT
		T1."CardCode" AS "CodigoCliente",
		T1."SlpCode" AS "CodigoVendedor",
		T2."ItemCode" AS "CodigoProducto",
		TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "Fecha",
		T1."DocNum" AS "NumeroDocumento",
		T2."Quantity" AS "Cantidad",
		(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "Valor",
		0 AS "Tipo"
--	DOCUMENTO
	FROM
		{2}."OINV" T1
	INNER JOIN
		{2}."INV1" T2
			ON T1."DocEntry" = T2."DocEntry"
	INNER JOIN
		{2}."INV12" T3
			ON T1."DocEntry" = T3."DocEntry"
	INNER JOIN
		{2}."NNM1" T4
			ON T1."Series" = T4."Series"
--	CLIENTE
	INNER JOIN
		{2}."OCRD" T5
			ON T1."CardCode" = T5."CardCode"
	INNER JOIN
		{2}."OCRG" T6
			ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
	INNER JOIN
		{2}."OITM" T7
			ON T2."ItemCode" = T7."ItemCode"
	INNER JOIN
		{2}."OITB" T8
			ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
	LEFT JOIN
		{2}."@GD_SUBGRUPO" T9
			ON T7."U_GD_SubGrupo" = T9."Code"
	LEFT JOIN
		{2}."@GD_FAMPRODUCTOS" T10
			ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
	INNER JOIN
		{2}."OSLP" T11
			ON T1."SlpCode" = T11."SlpCode"
	WHERE
        --T1."DocDate" BETWEEN '[%1]' AND '[%2]'
		T1."DocDate" BETWEEN {3}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{3})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		--AND T8."ItmsGrpCod" IN ()	--	Buscar por códigos
		AND T8."ItmsGrpCod" = {0}
AND T2."WhsCode" IN ({1})	--	bodega
	
	UNION ALL
	
	SELECT
		T1."CardCode" AS "CodigoCliente",
		T1."SlpCode" AS "CodigoVendedor",
		T2."ItemCode" AS "CodigoProducto",
		TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "Fecha",
		T1."DocNum" AS "NumeroDocumento",
		-T2."Quantity" AS "Cantidad",
		-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "Valor",
		1 AS "Tipo"
		
--	DOCUMENTO
	FROM
		{2}."ORIN" T1
	INNER JOIN
		{2}."RIN1" T2
			ON T1."DocEntry" = T2."DocEntry"
	INNER JOIN
		{2}."RIN12" T3
			ON T1."DocEntry" = T3."DocEntry"
	INNER JOIN
		{2}."NNM1" T4
			ON T1."Series" = T4."Series"
--	CLIENTE
	INNER JOIN
		{2}."OCRD" T5
			ON T1."CardCode" = T5."CardCode"
	INNER JOIN
		{2}."OCRG" T6
			ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
	INNER JOIN
		{2}."OITM" T7
			ON T2."ItemCode" = T7."ItemCode"
	INNER JOIN
		{2}."OITB" T8
			ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
	LEFT JOIN
		{2}."@GD_SUBGRUPO" T9
			ON T7."U_GD_SubGrupo" = T9."Code"
	LEFT JOIN
		{2}."@GD_FAMPRODUCTOS" T10
			ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
	INNER JOIN
		{2}."OSLP" T11
			ON T1."SlpCode" = T11."SlpCode"
	WHERE
        --T1."DocDate" BETWEEN '[%1]' AND '[%2]'
		T1."DocDate" BETWEEN {3}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{3})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		--AND T8."ItmsGrpCod" IN ()	--	Buscar por códigos
		AND T8."ItmsGrpCod" = {0} 
AND T2."WhsCode" IN ({1}) --	Bodega
) AS D1