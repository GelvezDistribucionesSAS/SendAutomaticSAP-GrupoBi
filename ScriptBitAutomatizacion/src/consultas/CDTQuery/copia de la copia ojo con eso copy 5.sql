SELECT
--	DOCUMENTO
	YEAR(T1."DocDate") AS "AnioDocumento",
	MONTH(T1."DocDate") AS "MesDocumento",
	TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "FechaDocumento",
	T4."SeriesName" AS "SerieDocumento",
	T1."DocNum" AS "NumeroDocumento",
	'FV' AS "TipoDocumento",
	--	CLIENTE
	T1."CardCode" AS "CodigoCliente",
	T1."CardName" AS "NombreCliente",
	T5."LicTradNum" AS "NITCliente",
	T6."GroupName" AS "GrupoCliente",
	T3."StreetS" AS "Direccion",
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Municipio",
	--	PRODUCTO
	T2."ItemCode" AS "CodigoProducto",
	T2."Dscription" AS "NombreProducto",
	T7."SalPackUn" AS "Embalaje",
	T2."Quantity" AS "Cantidad",
	TO_INT(T2."Quantity" / T7."SalPackUn") AS "Cajas",
	MOD(T2."Quantity",T7."SalPackUn") AS "Unidades",
	(T2."Price" - (T2."Price" * T1."DiscPrcnt" / 100)) AS "PrecioUnitario",
	(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "SubTotal",
	(T2."VatSum") AS "IVA",
	(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum") AS "Total",
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
                T1."WTSum" AS "Valor de Retefuente",
                ((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))-T1."WTSum") AS "VAlor SubTotal con RT",
                 T1."DocTotal" AS "Total del documento",
             --(SELECT TA."CardName" FROM ORDR TA WHERE TA."DocEntry" IN (SELECT TA."BaseEntry" FROM DLN1 TA WHERE TA."DocEntry" = T2."BaseEntry")) AS "Cliente Orden",
               IFNULL(T1."U_GLV_UID",'0') AS "ID PEDIDO",
             (SELECT TA."PymntGroup" FROM OCTG TA WHERE TA."GroupNum" = T5."GroupNum") AS "CondicionPago",
             (SELECT TB."ListName" FROM OPLN TB WHERE TB."ListNum" = T5."ListNum") AS "ListaDePrecio",
                T5."City" AS "Ciudad",
                MAX(T14."ReconDate")
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


-- SELECT  T3."DocNum" FROM OITR T0  
-- INNER JOIN ITR1 T1 ON T0."ReconNum" = T1."ReconNum" 
-- INNER JOIN OJDT T2 ON T1."TransId" = T2."TransId" 
-- INNER JOIN OINV T3 ON T2."TransId" = T3."TransId" 
-- GROUP BY T3."DocNum"

LEFT JOIN "OJDT" T12 ON T12."TransId" = T1."TransId"
LEFT JOIN "ITR1" T13 ON T12."TransId" = T13."TransId"
LEFT JOIN "OITR" T14 ON T14."ReconNum" = T13."ReconNum"
WHERE
	T1."DocDate" BETWEEN '[%0]' AND '[%1]'
	--AND T1."DocNum" = '10078561'

GROUP BY T1."DocNum"


UNION ALL

SELECT
	--	DOCUMENTO
	YEAR(T1."DocDate") AS "AnioDocumento",
	MONTH(T1."DocDate") AS "MesDocumento",
	TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "FechaDocumento",
	T4."SeriesName" AS "SerieDocumento",
	T1."DocNum" AS "NumeroDocumento",
	'NC' AS "TipoDocumento",
	--	CLIENTE
	T1."CardCode" AS "CodigoCliente",
	T1."CardName" AS "NombreCliente",
	T5."LicTradNum" AS "NITCliente",
	T6."GroupName" AS "GrupoCliente",
	T3."StreetS" AS "Direccion",
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Municipio",
	--	PRODUCTO
	T2."ItemCode" AS "CodigoProducto",
	T2."Dscription" AS "NombreProducto",
	T7."SalPackUn" AS "Embalaje",
	-T2."Quantity" AS "Cantidad",
	-TO_INT(T2."Quantity" / T7."SalPackUn") AS "Cajas",
	-MOD(T2."Quantity",T7."SalPackUn") AS "Unidades",
	-(T2."Price" - (T2."Price" * T1."DiscPrcnt" / 100)) AS "PrecioUnitario",
	-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "SubTotal",
	-(T2."VatSum") AS "IVA",
	-(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum") AS "Total",
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
                 T1."WTSum" AS "Valor de Retefuente",
                ((T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))-T1."WTSum") AS "VAlor SubTotal con RT",
                T1."DocTotal" AS "Total del documento",
            -- '' AS "Cliente Orden",
              IFNULL(T1."U_GLV_UID",'0') AS "ID PEDIDO",
             (SELECT TA."PymntGroup" FROM OCTG TA WHERE TA."GroupNum" = T5."GroupNum") AS "CondicionPago",
             (SELECT TB."ListName" FROM OPLN TB WHERE TB."ListNum" = T5."ListNum") AS "ListaDePrecio",
                T5."City" AS "Ciudad",
--	DOCUMENTO
    'Fech' AS "non"
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
	T1."DocDate" BETWEEN '[%0]' AND '[%1]'
	--AND T1."DocNum" = '10078561'
/*ORDER BY
	"FechaDocumento"*/
