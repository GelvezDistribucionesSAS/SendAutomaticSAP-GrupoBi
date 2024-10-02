SELECT
		--	DOCUMENTO
		YEAR(T1."TaxDate") AS "AnioDocumento",
		MONTH(T1."TaxDate") AS "MesDocumento",
		TO_VARCHAR(T1."TaxDate", 'YYYY-MM-DD') AS "FechaDocumento",
		T4."SeriesName" AS "SerieDocumento",
		T1."DocNum" AS "NumeroDocumento",
		'FP' AS "TipoDocumento",
		--	CLIENTE
		T1."CardCode" AS "CodigoCliente",
		CASE 
			WHEN T5."U_HBT_CorreoSuperv" = '742000PS' THEN
				SUBSTR(T1."CardName", 1, INSTR(T1."CardName", ' ') - 1) || ' S.A.S'
			ELSE 
				T1."CardName"
		END AS "NombreCliente",
		T5."LicTradNum" AS "NITCliente",
		T6."GroupName" AS "GrupoCliente",
		T3."StreetS" AS "Direccion",
		--	PRODUCTO
		T2."ItemCode" AS "CodigoProducto",
		T2."Dscription" AS "NombreProducto",
		T7."SalPackUn" AS "Embalaje",
		CASE 
              WHEN T1."CANCELED" = 'Y' THEN -(T2."Quantity") 
              ELSE T2."Quantity"
              END AS "Cantidad",
		TO_INT(T2."Quantity" / T7."SalPackUn") AS "Cajas",
		MOD(T2."Quantity",T7."SalPackUn") AS "Unidades",
		(T2."Price" - (T2."Price" * T1."DiscPrcnt" / 100)) AS "PrecioUnitario",
		CASE
WHEN T1."CANCELED" = 'Y' THEN -(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
WHEN T2."TaxOnly" = 'Y' THEN '0'
ELSE (T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
END AS "SubTotal",
		(T2."VatSum") AS "IVA",
		CASE 
WHEN T1."CANCELED" = 'Y' THEN -(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum")
WHEN T2."TaxOnly" = 'Y' THEN T2."VatSum"
ELSE (T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum")
END AS "Total",
		T7."LastPurPrc" AS "UltimoPrecioCompra",
		--T7."ItmsGrpCod" AS "CodigoGrupoProducto",
		T8."ItmsGrpNam" AS "NombreGrupoProducto",
		--T7."U_GD_SubGrupo" AS "CodigoSubGrupoProducto",
		T9."Name" AS "NombreSubGrupoProducto",
		--T7."U_GD_FamProducto" AS "CodigoFamiliaProducto",
		T10."Name" AS "NombreFamiliaProducto",
		--	VENDEDOR
		T1."SlpCode" AS "CodigoVendedor",
		T11."SlpName" AS "NombreVendedor",
		T2."WhsCode" AS "Bodega",
		T1."NumAtCard" AS "N Ref Acreedor",
		T2."DiscPrcnt" AS "% de Descuento",

		--	GASTOS ADICIONALES		
CASE
WHEN
((
		CASE
WHEN T1."CANCELED" = 'Y' THEN -(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
WHEN T2."TaxOnly" = 'Y' THEN '0'
ELSE (T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
END)
/
NULLIF((
CASE
WHEN
    (SELECT DISTINCT 
    MAX (TB."LineTotal")
    FROM
    "PCH1" TA
    INNER JOIN
    "PCH2" TB ON TA."DocEntry" = TB."DocEntry" AND TA."LineNum" = TB."LineNum"
    WHERE
    TB."LineNum" = T2."LineNum" AND TB."DocEntry" = T2."DocEntry")
IS NULL THEN '0'
ELSE
    (SELECT DISTINCT 
    MAX (TB."LineTotal")
    FROM
    "PCH1" TA
    INNER JOIN
    "PCH2" TB ON TA."DocEntry" = TB."DocEntry" AND TA."LineNum" = TB."LineNum"
    WHERE
    TB."LineNum" = T2."LineNum" AND TB."DocEntry" = T2."DocEntry")
END), 0 )
) IS NULL THEN '0'
	END
	AS "PorcentajeDeGastosAdicionales",




				(
		    SELECT DISTINCT 
    MAX (TC."ExpnsName")

    FROM
    "PCH1" TA
    INNER JOIN
    "PCH2" TB ON TA."DocEntry" = TB."DocEntry" AND TA."LineNum" = TB."LineNum"
    INNER JOIN
	"OEXD" TC ON TC."ExpnsCode" = TB."ExpnsCode"
	WHERE
    TB."LineNum" = T2."LineNum" AND TB."DocEntry" = T2."DocEntry"
		) AS "TipoGastoAdicional",

		(
    SELECT DISTINCT 
    MAX (TB."LineTotal")
    FROM
    "PCH1" TA
    INNER JOIN
    "PCH2" TB ON TA."DocEntry" = TB."DocEntry" AND TA."LineNum" = TB."LineNum"
    WHERE
    TB."LineNum" = T2."LineNum" AND TB."DocEntry" = T2."DocEntry"
) AS "GastosAdicionales",
	

		(T2."VatSum") AS "IVA"





	--	DOCUMENTO
	FROM
		"OPCH" T1
		INNER JOIN
		"PCH1" T2
		ON T1."DocEntry" = T2."DocEntry"
		INNER JOIN
		"PCH12" T3
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
	T1."TaxDate" BETWEEN '[%0]' AND '[%1]'
	--AND T1."DocNum" = '10078561'




























UNION ALL

	SELECT
		--	DOCUMENTO
		YEAR(T1."TaxDate") AS "AnioDocumento",
		MONTH(T1."TaxDate") AS "MesDocumento",
		TO_VARCHAR(T1."TaxDate", 'YYYY-MM-DD') AS "FechaDocumento",
		T4."SeriesName" AS "SerieDocumento",
		T1."DocNum" AS "NumeroDocumento",
		'NC' AS "TipoDocumento",
		--	CLIENTE
		T1."CardCode" AS "CodigoCliente",
		CASE 
			WHEN T5."U_HBT_CorreoSuperv" = '742000PS' THEN
				SUBSTR(T1."CardName", 1, INSTR(T1."CardName", ' ') - 1) || ' S.A.S'
			ELSE 
				T1."CardName"
		END AS "NombreCliente",
		T5."LicTradNum" AS "NITCliente",
		T6."GroupName" AS "GrupoCliente",
		T3."StreetS" AS "Direccion",
		--	PRODUCTO
		T2."ItemCode" AS "CodigoProducto",
		T2."Dscription" AS "NombreProducto",
		T7."SalPackUn" AS "Embalaje",
		CASE
              WHEN T1."JrnlMemo" LIKE '%Abono de compras%' THEN  T2."Quantity"
              ELSE -(T2."Quantity")
              END AS "Cantidad",
		-TO_INT(T2."Quantity" / T7."SalPackUn") AS "Cajas",
		-MOD(T2."Quantity",T7."SalPackUn") AS "Unidades",
		-(T2."Price" - (T2."Price" * T1."DiscPrcnt" / 100)) AS "PrecioUnitario",
		CASE
              WHEN T1."JrnlMemo" LIKE '%Abono de compras%' THEN (T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
	ELSE -(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
              END AS "SubTotal",
		-(T2."VatSum") AS "IVA",
		CASE 
              WHEN T1."JrnlMemo" LIKE '%Abono de compras%' THEN (T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum")
	ELSE -(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum")
              END AS "Total",
		-T7."LastPurPrc" AS "UltimoPrecioCompra",
		--T7."ItmsGrpCod" AS "CodigoGrupoProducto",
		T8."ItmsGrpNam" AS "NombreGrupoProducto",
		--T7."U_GD_SubGrupo" AS "CodigoSubGrupoProducto",
		T9."Name" AS "NombreSubGrupoProducto",
		--T7."U_GD_FamProducto" AS "CodigoFamiliaProducto",
		T10."Name" AS "NombreFamiliaProducto",
		--	VENDEDOR
		T1."SlpCode" AS "CodigoVendedor",
		T11."SlpName" AS "NombreVendedor",
		T2."WhsCode" AS "Bodega",
		T1."NumAtCard" AS "N Ref Acreedor",
		T2."DiscPrcnt" AS "% de Descuento",
		--	GASTOS ADICIONALES
				(
		    SELECT DISTINCT 
    MAX (TC."ExpnsName")

    FROM
    "RPC1" TA
    INNER JOIN
    "RPC2" TB ON TA."DocEntry" = TB."DocEntry" AND TA."LineNum" = TB."LineNum"
    INNER JOIN
	"OEXD" TC ON TC."ExpnsCode" = TB."ExpnsCode"
	WHERE
    TB."LineNum" = T2."LineNum" AND TB."DocEntry" = T2."DocEntry"
		) AS "TipoGastoAdicional",

		-(
    SELECT DISTINCT 
    MAX (TB."LineTotal")
    FROM
    "RPC1" TA
    INNER JOIN
    "RPC2" TB ON TA."DocEntry" = TB."DocEntry" AND TA."LineNum" = TB."LineNum"
    WHERE
    TB."LineNum" = T2."LineNum" AND TB."DocEntry" = T2."DocEntry"
) AS "GastosAdicionales"

	--	DOCUMENTO
	FROM
		"ORPC" T1
		INNER JOIN
		"RPC1" T2
		ON T1."DocEntry" = T2."DocEntry"
		INNER JOIN
		"RPC12" T3
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
	T1."TaxDate" BETWEEN '[%0]' AND '[%1]'