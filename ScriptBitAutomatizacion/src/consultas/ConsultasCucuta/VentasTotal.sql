SELECT
	(T1."CardCode" || '#' ||
	CONCAT('C',T1."SlpCode") || '#' ||
	CONCAT('C',CASE
              WHEN T7."U_U_CheckBit" = 'Y' THEN T7."U_U_Acronimo"
              ELSE T7."ItemCode"
              END) || '#' ||
	TO_VARCHAR(T1."DocDate", 'DDMMYYYY')|| '#' ||
	T1."DocNum" || '#' ||
	IFNULL(cast(T2."Quantity" as int),'0') || '#' ||
	IFNULL(round((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)),0),'0')|| '#' ||
	0 || '#' ||
	IFNULL(cast(T2."StockValue" as int), '0') || '#' ||
IFNULL(IFNULL(T7."InvntryUom",T7."SalUnitMsr"),'UNIDAD') || '#' ||
T2."WhsCode" || '#' ||
            CASE T2."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE 'GELVEZ'
END
) AS "Ventas"
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
T1."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN ('006','030','011')
UNION ALL

SELECT
	(T1."CardCode" || '#' ||
	CONCAT('C',T1."SlpCode") || '#' ||
	CONCAT('C',CASE
              WHEN T7."U_U_CheckBit" = 'Y' THEN T7."U_U_Acronimo"
              ELSE T7."ItemCode"
              END) || '#' ||
	TO_VARCHAR(T1."DocDate", 'DDMMYYYY')|| '#' ||
	T1."DocNum" || '#' ||
	IFNULL(cast(T2."Quantity" as int),'0') || '#' ||
	IFNULL(round(-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)),0),'0')|| '#' ||
	0 || '#' ||
	IFNULL(cast(T2."StockValue" as int), '0') || '#' ||
IFNULL(IFNULL(T7."InvntryUom",T7."SalUnitMsr"),'UNIDAD')|| '#' ||
T2."WhsCode" || '#' ||
            CASE T2."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE 'GELVEZ'
END
) AS "Ventas"
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
T1."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN ('006','030','011')



--UNION DE LA BASE DE CUCUTA CON LA DEL GRAN DISTRIBUIDOSR
UNION ALL

SELECT
	(T1."CardCode" || '#' ||
	CONCAT('G',T1."SlpCode") || '#' ||
               CONCAT('G',CASE
              WHEN T7."U_U_CheckBit" = 'Y' THEN T7."U_U_Acronimo"
              ELSE T7."ItemCode"
              END) || '#' ||
	TO_VARCHAR(T1."DocDate", 'DDMMYYYY')|| '#' ||
	T1."DocNum" || '#' ||
	IFNULL(cast(T2."Quantity" as int),'0') || '#' ||
	IFNULL(round((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)),0),'0')|| '#' ||
	0 || '#' ||
	IFNULL(cast(T2."StockValue" as int), '0') || '#' ||
IFNULL(IFNULL(T7."InvntryUom",T7."SalUnitMsr"),'UNIDAD') || '#' ||
T2."WhsCode" || '#' ||
           CASE T2."WhsCode"
WHEN '010' THEN 'PRINCIPAL CALI'
WHEN '011' THEN 'AVERIAS CALI'
WHEN '014' THEN 'PRINCIPAL GIRON'
WHEN '015' THEN 'AVERIAS GIRON'
WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
WHEN '020' THEN 'AVERIAS EJE CAFETERO'
WHEN '021' THEN 'AUXILIAR EJE CAFETERO'
ELSE '0'
END
) AS "Ventas"
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
T1."DocDate"  BETWEEN  {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND (T2."WhsCode" = '010' OR T2."WhsCode" = '014' OR T2."WhsCode" = '019')
UNION ALL

SELECT
	(T1."CardCode" || '#' ||
	CONCAT('G',T1."SlpCode") || '#' ||
	CONCAT('G',CASE
              WHEN T7."U_U_CheckBit" = 'Y' THEN T7."U_U_Acronimo"
              ELSE T7."ItemCode"
              END) || '#' ||
	TO_VARCHAR(T1."DocDate", 'DDMMYYYY')|| '#' ||
	T1."DocNum" || '#' ||
	IFNULL(cast(T2."Quantity" as int),'0') || '#' ||
	IFNULL(round(-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)),0),'0')|| '#' ||
	0 || '#' ||
	IFNULL(cast(T2."StockValue" as int), '0') || '#' ||
IFNULL(IFNULL(T7."InvntryUom",T7."SalUnitMsr"),'UNIDAD') || '#' ||
T2."WhsCode" || '#' ||
           CASE T2."WhsCode"
WHEN '010' THEN 'PRINCIPAL CALI'
WHEN '011' THEN 'AVERIAS CALI'
WHEN '014' THEN 'PRINCIPAL GIRON'
WHEN '015' THEN 'AVERIAS GIRON'
WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
WHEN '020' THEN 'AVERIAS EJE CAFETERO'
WHEN '021' THEN 'AUXILIAR EJE CAFETERO'
ELSE '0'
END
) AS "Ventas"
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
T1."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND (T2."WhsCode" = '010' OR T2."WhsCode" = '014' OR T2."WhsCode" = '019')