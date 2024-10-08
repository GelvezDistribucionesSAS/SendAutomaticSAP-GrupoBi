SELECT DISTINCT * FROM( 

SELECT
	(
	CONCAT('C',T1."SlpCode") || '#' ||
	T11."SlpName"  || '#' || 
             IFNULL(T11."U_HBT_Cedula",'0')  || '#' || ' ' || '#' ||
            T2."WhsCode" || '#' ||
            CASE T2."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE 'GELVEZ'
END) AS "Vendedores"
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
--T1."DocDate" BETWEEN '20221001' AND '20221031'
T1."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	AND T2."WhsCode" IN ('006','030')
	AND T8."ItmsGrpNam" IN ('INCAUCA',
'NESTLE SA',
'AAK COLOMBIA S.A.S',
'KIMBERLY PAÑ',
'EDGEWELL PERSONAL CARE COLOMBIA S.A.S',
'BELLEZA EXPRESS S A',
'ALIMENTOS CONCENTRADOS RAZA LTDA',
'TRILLADORA LA MONTAÑA SAS',
'KIMBERLY ICH',
'RECKITT BENCKISER',
'ARROCERA GELVEZ SAS',
'HARINERA DEL VALLE S A',
'SUPER DE ALIMENTOS S A S',
'DRINKS DE COLOMBIA SAS',
'KIMBERLY KIMBIES PAÑ',
'UNIBOL S.A.S.',
'LABORATORIOS COFARMA S.A',
'JGB SA',
'NESTLE PURINA',
'OLEOFLORES S A S',
'UNILEVER P1',
'LEVAPAN S A',
'JOHNSON & JOHNSON DE COLOMBIA S A',
'MULTIDIMENSIONALES S.A.S.',
'INDUSTRIAS BISONTE S A',
'ISABEL COLOMBIA LIMITADA',
'KIMBERLY KIMBIES ICH',
'VELAS Y VELONES SAN JORGE',
'LABORATORIO FRANCO COLOMBIANO LA FRANCOL SAS',
'MAVE CLEAR LTDA',
'COLGATE PALMOLIVE S.A.',
'ENERGIZER DE COLOMBIA S A',
'INDUSTRIAS KATORI S.A.S',
'PROGRESAR COMPANY  S A S',
'FONANDES S.A.S',
'CONFITECA COLOMBIA SA',
'FRIGORIFICO DE LA COSTA SAS',
'COMERCIALIZADORA LUHOMAR S A S',
'COMESTIBLES ITALO S.A.',
'BRINSA S.A',
'PAPELES NACIONALES SA',
'INDUSTRIAS EL TRIUNFO',
'TRULULU SAS',
'UNILEVER P2',
'KIMBERLY MNM-TAT',
'GENOMMA LAB BASE',
'INDUSTRIAS TOMY S.A.S',
'GENOMMA LAB MNM-TAT',
'KIMBERLY ICH T2',
'CONGRUPO S.A.S',
'GENOMMA LAB',
'GENOMMA LAB TAT'
)

UNION ALL

SELECT
	(
	CONCAT('C',T1."SlpCode") || '#' ||
	T11."SlpName"  || '#' || 
             IFNULL(T11."U_HBT_Cedula",'0')  || '#' || ' ' || '#' ||
            T2."WhsCode" || '#' ||
            CASE T2."WhsCode"
WHEN '006' THEN 'PRINCIPAL CUCUTA'
WHEN '011' THEN 'PRINCIPAL OCAÑA'
WHEN '008' THEN 'AVERIAS CUCUTA'
WHEN '012' THEN 'AVERIAS OCAÑA'
WHEN '013' THEN 'PRINCIPAL ARAUCA'
WHEN '030' THEN 'CUCUTA MNM-TAT'
ELSE 'GELVEZ'
END) AS "Vendedores"
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
--T1."DocDate" BETWEEN '20221001' AND '20221031'
T1."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	AND T2."WhsCode" IN ('006','030')
	AND T8."ItmsGrpNam" IN ('INCAUCA',
'NESTLE SA',
'AAK COLOMBIA S.A.S',
'KIMBERLY PAÑ',
'EDGEWELL PERSONAL CARE COLOMBIA S.A.S',
'BELLEZA EXPRESS S A',
'ALIMENTOS CONCENTRADOS RAZA LTDA',
'TRILLADORA LA MONTAÑA SAS',
'KIMBERLY ICH',
'RECKITT BENCKISER',
'ARROCERA GELVEZ SAS',
'HARINERA DEL VALLE S A',
'SUPER DE ALIMENTOS S A S',
'DRINKS DE COLOMBIA SAS',
'KIMBERLY KIMBIES PAÑ',
'UNIBOL S.A.S.',
'LABORATORIOS COFARMA S.A',
'JGB SA',
'NESTLE PURINA',
'OLEOFLORES S A S',
'UNILEVER P1',
'LEVAPAN S A',
'JOHNSON & JOHNSON DE COLOMBIA S A',
'MULTIDIMENSIONALES S.A.S.',
'INDUSTRIAS BISONTE S A',
'ISABEL COLOMBIA LIMITADA',
'KIMBERLY KIMBIES ICH',
'VELAS Y VELONES SAN JORGE',
'LABORATORIO FRANCO COLOMBIANO LA FRANCOL SAS',
'MAVE CLEAR LTDA',
'COLGATE PALMOLIVE S.A.',
'ENERGIZER DE COLOMBIA S A',
'INDUSTRIAS KATORI S.A.S',
'PROGRESAR COMPANY  S A S',
'FONANDES S.A.S',
'CONFITECA COLOMBIA SA',
'FRIGORIFICO DE LA COSTA SAS',
'COMERCIALIZADORA LUHOMAR S A S',
'COMESTIBLES ITALO S.A.',
'BRINSA S.A',
'PAPELES NACIONALES SA',
'INDUSTRIAS EL TRIUNFO',
'TRULULU SAS',
'UNILEVER P2',
'KIMBERLY MNM-TAT',
'GENOMMA LAB BASE',
'INDUSTRIAS TOMY S.A.S',
'GENOMMA LAB MNM-TAT',
'KIMBERLY ICH T2',
'CONGRUPO S.A.S',
'GENOMMA LAB',
'GENOMMA LAB TAT'
)
)

-- UNION DE LA BASE DE CUCUTA CON AL DEL GRAN DISTROBUIDOR.
union all
SELECT DISTINCT * FROM( 

SELECT
	(
	CONCAT('G',T1."SlpCode") || '#' ||
	T11."SlpName"  || '#' || 
             IFNULL(T11."U_HBT_Cedula",'0')  || '#' || ' ' || '#' ||
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
END) AS "Vendedores"
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
T1."DocDate" BETWEEN {0}--ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{0})),+1) AND  ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
	AND (T2."WhsCode" = '010' OR T2."WhsCode" = '014' OR T2."WhsCode" = '019')
	AND T8."ItmsGrpNam" IN ('INCAUCA',
'NESTLE SA',
'AAK COLOMBIA S.A.S',
'KIMBERLY PAÑ',
'EDGEWELL PERSONAL CARE COLOMBIA S.A.S',
'BELLEZA EXPRESS S A',
'ALIMENTOS CONCENTRADOS RAZA LTDA',
'TRILLADORA LA MONTAÑA SAS',
'KIMBERLY ICH',
'RECKITT BENCKISER',
'ARROCERA GELVEZ SAS',
'HARINERA DEL VALLE S A',
'SUPER DE ALIMENTOS S A S',
'DRINKS DE COLOMBIA SAS',
'KIMBERLY KIMBIES PAÑ',
'UNIBOL S.A.S.',
'LABORATORIOS COFARMA S.A',
'JGB SA',
'NESTLE PURINA',
'OLEOFLORES S A S',
'UNILEVER P1',
'LEVAPAN S A',
'JOHNSON & JOHNSON DE COLOMBIA S A',
'MULTIDIMENSIONALES S.A.S.',
'INDUSTRIAS BISONTE S A',
'ISABEL COLOMBIA LIMITADA',
'KIMBERLY KIMBIES ICH',
'VELAS Y VELONES SAN JORGE',
'LABORATORIO FRANCO COLOMBIANO LA FRANCOL SAS',
'MAVE CLEAR LTDA',
'COLGATE PALMOLIVE S.A.',
'ENERGIZER DE COLOMBIA S A',
'INDUSTRIAS KATORI S.A.S',
'PROGRESAR COMPANY  S A S',
'FONANDES S.A.S',
'CONFITECA COLOMBIA SA',
'FRIGORIFICO DE LA COSTA SAS',
'COMERCIALIZADORA LUHOMAR S A S',
'COMESTIBLES ITALO S.A.',
'BRINSA S.A',
'PAPELES NACIONALES SA',
'INDUSTRIAS EL TRIUNFO',
'TRULULU SAS',
'UNILEVER P2',
'KIMBERLY MNM-TAT',
'GENOMMA LAB BASE',
'INDUSTRIAS TOMY S.A.S',
'GENOMMA LAB MNM-TAT',
'KIMBERLY ICH T2',
'CONGRUPO S.A.S',
'GENOMMA LAB',
'GENOMMA LAB TAT'
) 

UNION ALL

SELECT
	(
	CONCAT('G',T1."SlpCode") || '#' ||
	T11."SlpName"  || '#' || 
             IFNULL(T11."U_HBT_Cedula",'0')  || '#' || ' ' || '#' ||
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
END) AS "Vendedores"
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
	AND T8."ItmsGrpNam" IN ('INCAUCA',
'NESTLE SA',
'AAK COLOMBIA S.A.S',
'KIMBERLY PAÑ',
'EDGEWELL PERSONAL CARE COLOMBIA S.A.S',
'BELLEZA EXPRESS S A',
'ALIMENTOS CONCENTRADOS RAZA LTDA',
'TRILLADORA LA MONTAÑA SAS',
'KIMBERLY ICH',
'RECKITT BENCKISER',
'ARROCERA GELVEZ SAS',
'HARINERA DEL VALLE S A',
'SUPER DE ALIMENTOS S A S',
'DRINKS DE COLOMBIA SAS',
'KIMBERLY KIMBIES PAÑ',
'UNIBOL S.A.S.',
'LABORATORIOS COFARMA S.A',
'JGB SA',
'NESTLE PURINA',
'OLEOFLORES S A S',
'UNILEVER P1',
'LEVAPAN S A',
'JOHNSON & JOHNSON DE COLOMBIA S A',
'MULTIDIMENSIONALES S.A.S.',
'INDUSTRIAS BISONTE S A',
'ISABEL COLOMBIA LIMITADA',
'KIMBERLY KIMBIES ICH',
'VELAS Y VELONES SAN JORGE',
'LABORATORIO FRANCO COLOMBIANO LA FRANCOL SAS',
'MAVE CLEAR LTDA',
'COLGATE PALMOLIVE S.A.',
'ENERGIZER DE COLOMBIA S A',
'INDUSTRIAS KATORI S.A.S',
'PROGRESAR COMPANY  S A S',
'FONANDES S.A.S',
'CONFITECA COLOMBIA SA',
'FRIGORIFICO DE LA COSTA SAS',
'COMERCIALIZADORA LUHOMAR S A S',
'COMESTIBLES ITALO S.A.',
'BRINSA S.A',
'PAPELES NACIONALES SA',
'INDUSTRIAS EL TRIUNFO',
'TRULULU SAS',
'UNILEVER P2',
'KIMBERLY MNM-TAT',
'GENOMMA LAB BASE',
'INDUSTRIAS TOMY S.A.S',
'GENOMMA LAB MNM-TAT',
'KIMBERLY ICH T2',
'CONGRUPO S.A.S',
'GENOMMA LAB',
'GENOMMA LAB TAT'
)
)
