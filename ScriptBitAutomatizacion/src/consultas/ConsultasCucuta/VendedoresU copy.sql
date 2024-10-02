SELECT DISTINCT * FROM( 

SELECT
	(
	T1."SlpCode" || '#' ||
	T11."SlpName"  || '#' || ' '  || '#' ||
             IFNULL(T11."U_HBT_Cedula",'0')
	 ) AS "Vendedores"
--	DOCUMENTO
FROM
	"OINV" T1
INNER JOIN
	"INV1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"INV12" T3
		ON T1."DocEntry" = T3."DocEntry"
INNER JOIN
	"NNM1" T4
		ON T1."Series" = T4."Series"
--	CLIENTE
INNER JOIN
	"OCRD" T5
		ON T1."CardCode" = T5."CardCode"
INNER JOIN
	"OCRG" T6
		ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
INNER JOIN
	"OITM" T7
		ON T2."ItemCode" = T7."ItemCode"
INNER JOIN
	"OITB" T8
		ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
LEFT JOIN
	"@GD_SUBGRUPO" T9
		ON T7."U_GD_SubGrupo" = T9."Code"
LEFT JOIN
    "@GD_FAMPRODUCTOS" T10
		ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
INNER JOIN
	"OSLP" T11
		ON T1."SlpCode" = T11."SlpCode"
WHERE
    T1."DocDate" BETWEEN '[%1]' AND '[%2]'
	--T1."DocDate" BETWEEN {3}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{3})),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	--AND T8."ItmsGrpCod" IN ()	--	Buscar por códigos
	AND T8."ItmsGrpCod" IN ('149', '152')
AND T2."WhsCode" IN  (014)	--	bodega

UNION ALL

SELECT
	(
	T1."SlpCode" || '#' ||
	T11."SlpName" || '#' || ' '  || '#' ||
             IFNULL(T11."U_HBT_Cedula",'0')
	 ) AS "Vendedores"
--	DOCUMENTO
FROM
	"ORIN" T1
INNER JOIN
	"RIN1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"RIN12" T3
		ON T1."DocEntry" = T3."DocEntry"
INNER JOIN
	"NNM1" T4
		ON T1."Series" = T4."Series"
--	CLIENTE
INNER JOIN
	"OCRD" T5
		ON T1."CardCode" = T5."CardCode"
INNER JOIN
	"OCRG" T6
		ON T5."GroupCode" = T6."GroupCode"
--	PRODUCTO
INNER JOIN
	"OITM" T7
		ON T2."ItemCode" = T7."ItemCode"
INNER JOIN
	"OITB" T8
		ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
LEFT JOIN
	"@GD_SUBGRUPO" T9
		ON T7."U_GD_SubGrupo" = T9."Code"
LEFT JOIN
	"@GD_FAMPRODUCTOS" T10
		ON T7."U_GD_FamProducto" = T10."Code"
--	VENDEDOR
INNER JOIN
	"OSLP" T11
		ON T1."SlpCode" = T11."SlpCode"
WHERE
    T1."DocDate" BETWEEN '[%1]' AND '[%2]'
	--T1."DocDate" BETWEEN {3}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{3})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	--AND T8."ItmsGrpCod" IN ()	--	Buscar por códigos
	AND T8."ItmsGrpCod" IN ('149', '152')
AND T2."WhsCode" IN (014)	--	Bodega
)