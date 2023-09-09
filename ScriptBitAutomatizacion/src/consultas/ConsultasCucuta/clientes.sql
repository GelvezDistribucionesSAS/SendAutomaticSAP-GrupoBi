SELECT
	DISTINCT * FROM (
SELECT
	--	CLIENTE
	(T1."CardCode" || '#' ||
	IFNULL(REPLACE(REPLACE(T5."CardName", '\n', ' '), '\r', ' '),'NN') || '#' ||
	TO_VARCHAR(IFNULL(T5."U_FECHA_CLIENTE",T5."CreateDate"), 'YYYYMMDD') || '#' ||
	T5."LicTradNum" || '#' ||
	CONCAT(IFNULL(T3."StreetS",' '),CONCAT(' ',IFNULL(T3."BlockS",'Principal Gelvez')))|| '#' ||
	--(SELECT CONCAT(TA."Street",CONCAT(' ',TA."Block")) FROM "CRD1" TA WHERE TA."CardCode" = T1."CardCode" AND TA."LineNum" = 0) AS "Direccion",
	IFNULL(T5."Phone1",IFNULL(T5."Phone2",IFNULL(T5."Cellular",'0'))) || '#' ||
	'SIN REPRESENTANTE' || '#' ||
	IFNULL(T3."U_HBT_MunMedS",'54001') || '#' ||
	T6."GroupCode" ) AS "Clientes"
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

	T1."DocDate" BETWEEN {3}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{3})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )

	AND T8."ItmsGrpCod" = {0}
AND T2."WhsCode" IN ({1})

UNION ALL

SELECT
	--	CLIENTE
	(T1."CardCode" || '#' ||
	IFNULL(REPLACE(REPLACE(T5."CardName", '\n', ' '), '\r', ' '),'NN') || '#' ||
	TO_VARCHAR(IFNULL(T5."U_FECHA_CLIENTE",T5."CreateDate"), 'YYYYMMDD') || '#' ||
	T5."LicTradNum" || '#' ||
	CONCAT(IFNULL(T3."StreetS",' '),CONCAT(' ',IFNULL(T3."BlockS",'Principal Gelvez')))|| '#' ||
	--(SELECT CONCAT(TA."Street",CONCAT(' ',TA."Block")) FROM "CRD1" TA WHERE TA."CardCode" = T1."CardCode" AND TA."LineNum" = 0) AS "Direccion",
	IFNULL(T5."Phone1",IFNULL(T5."Phone2",IFNULL(T5."Cellular",'0'))) || '#' ||
	'SIN REPRESENTANTE' || '#' ||
	IFNULL(T3."U_HBT_MunMedS",'54001') || '#' ||
	T6."GroupCode" ) AS "Clientes"
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

	T1."DocDate" BETWEEN {3}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{3})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )

	AND T8."ItmsGrpCod" = {0}
AND T2."WhsCode" IN ({1})) AS "TA"