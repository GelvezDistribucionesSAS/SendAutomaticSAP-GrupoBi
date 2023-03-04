SELECT DISTINCT * FROM(SELECT
	(T1."ItemCode" || '#' ||
	T1."ItemName" || '#' ||
	CASE T1."SalUnitMsr"
		WHEN 'CBO' THEN 'OF'
		ELSE 'RG'	
	END || '#' ||
	IFNULL(T1."SalUnitMsr",' ') || '#' ||
	IFNULL(T1."CodeBars",' ') || '#' ||
	IFNULL(T1."ItmsGrpCod",'0') || '#' ||
T2."ItmsGrpNam" || '#' ||
IFNULL(T4."Code",' ') || '#' ||
IFNULL(T4."Name",' ')|| '#' ||
IFNULL(T5."Code",' ') || '#' ||
IFNULL(T5."Name",' ') || '#' ||
IFNULL(T0."Warehouse",'006') || '#' ||
CASE T0."Warehouse"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
ELSE '0'
END) AS "Sku"
FROM
	"HBTGELVEZ_CUCUTA"."OINM" T0
INNER JOIN
 	"HBTGELVEZ_CUCUTA"."OITM" T1
		ON T0."ItemCode" = T1."ItemCode"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OITB" T2
		ON T1."ItmsGrpCod" = T2."ItmsGrpCod"
LEFT JOIN
	"HBTGELVEZ_CUCUTA"."@GD_SUBGRUPO" T4
			ON T1."U_GD_SubGrupo" = T4."Code"
	LEFT JOIN
		"HBTGELVEZ_CUCUTA"."@GD_FAMPRODUCTOS" T5
			ON T1."U_GD_FamProducto" = T5."Code"
WHERE
	T0."CreateDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	AND T0."Warehouse" = '006'
GROUP BY
	T1."ItemName",T1."ItemCode",T1."SalUnitMsr",T1."CodeBars",T1."ItmsGrpCod",T2."ItmsGrpNam",T4."Code",T4."Name",T5."Code",T5."Name",T0."Warehouse"
UNION ALL
SELECT
   (CASE
              WHEN T3."U_U_CheckBit" = 'Y' THEN T3."U_U_Acronimo"
              ELSE T3."ItemCode"
              END || '#' ||
              T3."ItemName" || '#' ||
             CASE T3."SalUnitMsr"
		WHEN 'CBO' THEN 'OF'
		ELSE 'RG'	
	END || '#' ||
              IFNULL(T3."SalUnitMsr",' ') || '#' ||
              IFNULL(T3."CodeBars",' ') || '#' ||
	IFNULL(T3."ItmsGrpCod",'0') || '#' ||
              T6."ItmsGrpNam" || '#' ||
IFNULL(T4."Code",' ') || '#' ||
IFNULL(T4."Name",' ')|| '#' ||
IFNULL(T5."Code",' ') || '#' ||
IFNULL(T5."Name",' ') || '#' ||
IFNULL(T2."WhsCode",'006') || '#' ||
CASE T2."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
ELSE '0'
END) AS "Sku"
FROM
	"HBTGELVEZ_CUCUTA"."OINV" T1
INNER JOIN
 	"HBTGELVEZ_CUCUTA"."INV1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OITM" T3
		ON T2."ItemCode" = T3."ItemCode"
LEFT JOIN
	"HBTGELVEZ_CUCUTA"."@GD_SUBGRUPO" T4
			ON T3."U_GD_SubGrupo" = T4."Code"
	LEFT JOIN
		"HBTGELVEZ_CUCUTA"."@GD_FAMPRODUCTOS" T5
			ON T3."U_GD_FamProducto" = T5."Code"
              INNER JOIN "HBTGELVEZ_CUCUTA"."OITB" T6 
                                          ON T3."ItmsGrpCod" = T6."ItmsGrpCod"
WHERE T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN ('006','030')
AND T3."U_U_CheckBit" = 'Y'
UNION ALL
SELECT
   (CASE
              WHEN T3."U_U_CheckBit" = 'Y' THEN T3."U_U_Acronimo"
              ELSE T3."ItemCode"
              END || '#' ||
              T3."ItemName" || '#' ||
             CASE T3."SalUnitMsr"
		WHEN 'CBO' THEN 'OF'
		ELSE 'RG'	
	END || '#' ||
              IFNULL(T3."SalUnitMsr",' ') || '#' ||
              IFNULL(T3."CodeBars",' ') || '#' ||
	IFNULL(T3."ItmsGrpCod",'0') || '#' ||
              T6."ItmsGrpNam" || '#' ||
IFNULL(T4."Code",' ') || '#' ||
IFNULL(T4."Name",' ')|| '#' ||
IFNULL(T5."Code",' ') || '#' ||
IFNULL(T5."Name",' ') || '#' ||
IFNULL(T2."WhsCode",'006') || '#' ||
CASE T2."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE '0'
END) AS "Sku"
FROM
	"HBTGELVEZ_CUCUTA"."ORIN" T1
INNER JOIN
 	"HBTGELVEZ_CUCUTA"."RIN1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"HBTGELVEZ_CUCUTA"."OITM" T3
		ON T2."ItemCode" = T3."ItemCode"
LEFT JOIN
	"HBTGELVEZ_CUCUTA"."@GD_SUBGRUPO" T4
			ON T3."U_GD_SubGrupo" = T4."Code"
	LEFT JOIN
		"HBTGELVEZ_CUCUTA"."@GD_FAMPRODUCTOS" T5
			ON T3."U_GD_FamProducto" = T5."Code"
              INNER JOIN "HBTGELVEZ_CUCUTA"."OITB" T6 
                                          ON T3."ItmsGrpCod" = T6."ItmsGrpCod"
WHERE T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN ('006','030')
AND T3."U_U_CheckBit" = 'Y')AS "TA"


-- UNION DE LA CONSULTA CON AL BASE DEL GRAN DISTRIBUIDOR.
UNION ALL 

SELECT DISTINCT * FROM(SELECT
	(T1."ItemCode" || '#' ||
	T1."ItemName" || '#' ||
	CASE T1."SalUnitMsr"
		WHEN 'CBO' THEN 'OF'
		ELSE 'RG'	
	END || '#' ||
	IFNULL(T1."SalUnitMsr",' ') || '#' ||
	IFNULL(T1."CodeBars",' ') || '#' ||
	IFNULL(T1."ItmsGrpCod",'0') || '#' ||
T2."ItmsGrpNam" || '#' ||
IFNULL(T4."Code",' ') || '#' ||
IFNULL(T4."Name",' ')|| '#' ||
IFNULL(T5."Code",' ') || '#' ||
IFNULL(T5."Name",' ') || '#' ||
IFNULL(T0."Warehouse",'006') || '#' ||
CASE T0."Warehouse"
WHEN '010' THEN 'PRINCIPAL CALI'
WHEN '014' THEN 'PRINCIPAL GIRON'
WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
ELSE '0'
END) AS "Sku"
FROM
	"HBTGRANDISTRIBUIDOR"."OINM" T0
INNER JOIN
 	"HBTGRANDISTRIBUIDOR"."OITM" T1
		ON T0."ItemCode" = T1."ItemCode"
INNER JOIN
	"HBTGRANDISTRIBUIDOR"."OITB" T2
		ON T1."ItmsGrpCod" = T2."ItmsGrpCod"
LEFT JOIN
	"HBTGRANDISTRIBUIDOR"."@GD_SUBGRUPO" T4
			ON T1."U_GD_SubGrupo" = T4."Code"
	LEFT JOIN
		"HBTGRANDISTRIBUIDOR"."@GD_FAMPRODUCTOS" T5
			ON T1."U_GD_FamProducto" = T5."Code"
WHERE
	T0."CreateDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	AND T0."Warehouse" IN (010,014,019)
GROUP BY
	T1."ItemName",T1."ItemCode",T1."SalUnitMsr",T1."CodeBars",T1."ItmsGrpCod",T2."ItmsGrpNam",T4."Code",T4."Name",T5."Code",T5."Name",T0."Warehouse"
UNION ALL
SELECT
   (T3."U_U_Acronimo" || '#' ||
              T3."ItemName" || '#' ||
             CASE T3."SalUnitMsr"
		WHEN 'CBO' THEN 'OF'
		ELSE 'RG'	
	END || '#' ||
              IFNULL(T3."SalUnitMsr",' ') || '#' ||
              IFNULL(T3."CodeBars",' ') || '#' ||
	IFNULL(T3."ItmsGrpCod",'0') || '#' ||
              T6."ItmsGrpNam" || '#' ||
IFNULL(T4."Code",' ') || '#' ||
IFNULL(T4."Name",' ')|| '#' ||
IFNULL(T5."Code",' ') || '#' ||
IFNULL(T5."Name",' ') || '#' ||
IFNULL(T2."WhsCode",'006') || '#' ||
CASE T2."WhsCode"
WHEN '010' THEN 'PRINCIPAL CALI'
WHEN '014' THEN 'PRINCIPAL GIRON'
WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
ELSE '0'
END) AS "Sku"
FROM
	"HBTGRANDISTRIBUIDOR"."OINV" T1
INNER JOIN
 	"HBTGRANDISTRIBUIDOR"."INV1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"HBTGRANDISTRIBUIDOR"."OITM" T3
		ON T2."ItemCode" = T3."ItemCode"
LEFT JOIN
	"HBTGRANDISTRIBUIDOR"."@GD_SUBGRUPO" T4
			ON T3."U_GD_SubGrupo" = T4."Code"
	LEFT JOIN
		"HBTGRANDISTRIBUIDOR"."@GD_FAMPRODUCTOS" T5
			ON T3."U_GD_FamProducto" = T5."Code"
              INNER JOIN "HBTGRANDISTRIBUIDOR"."OITB" T6 
                                          ON T3."ItmsGrpCod" = T6."ItmsGrpCod"
WHERE T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN (010,014,019)
AND T3."U_U_CheckBit" = 'Y'
UNION ALL
SELECT
   ( T3."U_U_Acronimo" || '#' ||
              T3."ItemName" || '#' ||
             CASE T3."SalUnitMsr"
		WHEN 'CBO' THEN 'OF'
		ELSE 'RG'	
	END || '#' ||
              IFNULL(T3."SalUnitMsr",' ') || '#' ||
              IFNULL(T3."CodeBars",' ') || '#' ||
	IFNULL(T3."ItmsGrpCod",'0') || '#' ||
              T6."ItmsGrpNam" || '#' ||
IFNULL(T4."Code",' ') || '#' ||
IFNULL(T4."Name",' ')|| '#' ||
IFNULL(T5."Code",' ') || '#' ||
IFNULL(T5."Name",' ') || '#' ||
IFNULL(T2."WhsCode",'006') || '#' ||
CASE T2."WhsCode"
WHEN '010' THEN 'PRINCIPAL CALI'
WHEN '014' THEN 'PRINCIPAL GIRON'
WHEN '019' THEN 'PRINCIPAL EJE CAFETERO'
ELSE '0'
END) AS "Sku"
FROM
	"HBTGRANDISTRIBUIDOR"."ORIN" T1
INNER JOIN
 	"HBTGRANDISTRIBUIDOR"."RIN1" T2
		ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"HBTGRANDISTRIBUIDOR"."OITM" T3
		ON T2."ItemCode" = T3."ItemCode"
LEFT JOIN
	"HBTGRANDISTRIBUIDOR"."@GD_SUBGRUPO" T4
			ON T3."U_GD_SubGrupo" = T4."Code"
	LEFT JOIN
		"HBTGRANDISTRIBUIDOR"."@GD_FAMPRODUCTOS" T5
			ON T3."U_GD_FamProducto" = T5."Code"
              INNER JOIN "HBTGRANDISTRIBUIDOR"."OITB" T6 
                                          ON T3."ItmsGrpCod" = T6."ItmsGrpCod"
WHERE T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
AND T2."WhsCode" IN (010,014,019)
AND T3."U_U_CheckBit" = 'Y')AS "TA"
