SELECT
	YEAR(T1."DocDate") AS "AnioDocumento",
	MONTH(T1."DocDate") AS "MesDocumento",
	TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "FechaDocumento",
	T4."SeriesName" AS "SerieDocumento",
	T1."DocNum" AS "NumeroDocumento",
	'FV' AS "TipoDocumento",
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
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Cod Municipio",
	SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "SumaSubTotal",
	SUM(T2."VatSum") AS "SumaIVA",
	SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum") AS "SumaTotal",
CAST((SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum")*100) / T1."DocTotal" AS DECIMAL (10 , 2)) || '%' AS "Porcentaje",



	T1."DocTotal" AS "Total Factura",

	T1."PaidToDate" as "PagadoHastaLaFecha",

(CASE
		WHEN T1."DocStatus" = 'O'
		THEN 'Abierto'
		ELSE 'Cerrado'
		END
) 
		AS "Estado",


	T8."ItmsGrpNam" AS "NombreGrupoProducto",
	T1."SlpCode" AS "CodigoVendedor",
	T11."SlpName" AS "NombreVendedor",
	T2."WhsCode" AS "Bodega",
    T14."WhsName" AS "NombreBodega",
	T5."City" AS "Ciudad",
	'NONE' AS "Motivo de devolución",
	T13."U_GLV_CodSup" AS "Area",
	T5."Phone1" AS "Telefono",
	T5."Phone2" AS "Telefono 2",
	T5."Cellular" AS "Telefono 3",
	T5."E_Mail" AS "Email"
FROM
	"OINV" T1
INNER JOIN
	"INV1" T2 ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"INV12" T3 ON T1."DocEntry" = T3."DocEntry"
INNER JOIN
	"NNM1" T4 ON T1."Series" = T4."Series"
INNER JOIN
	"OCRD" T5 ON T1."CardCode" = T5."CardCode"
INNER JOIN
	"OCRG" T6 ON T5."GroupCode" = T6."GroupCode"
INNER JOIN
	"OITM" T7 ON T2."ItemCode" = T7."ItemCode"
INNER JOIN
	"OITB" T8 ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
LEFT JOIN
	"@GD_SUBGRUPO" T9 ON T7."U_GD_SubGrupo" = T9."Code"
LEFT JOIN
	"@GD_FAMPRODUCTOS" T10 ON T7."U_GD_FamProducto" = T10."Code"
INNER JOIN
	"OSLP" T11 ON T1."SlpCode" = T11."SlpCode"
LEFT JOIN
	"@HBT_MUNICIPIO" T12 ON T3."U_HBT_MunMedS" = T12."Code"
LEFT JOIN 
	"@SIS_SUPERVISORES" T13 ON T11."U_GLV_Supervisor" = T13."DocEntry"
LEFT JOIN
    "OWHS" T14 ON T14."WhsCode" = T2."WhsCode"
WHERE
    T1."DocDate" BETWEEN '[%0]' AND '[%1]'
GROUP BY
T1."DocDate",
T1."DocDate",
T1."DocDate",
	T4."SeriesName",
	T1."DocNum",
	T1."CardCode",
T5."U_HBT_CorreoSuperv",
T1."CardName",
	T5."LicTradNum",
	T6."GroupName",
	T3."StreetS",
	T3."BlockS",
	T3."U_HBT_MunMedS",
	T1."DocTotal",
	T8."ItmsGrpNam",
	T1."SlpCode",
	T11."SlpName",
	T2."WhsCode",
	T5."City",
	T13."U_GLV_CodSup",
	T5."Phone1",
	T5."Phone2",
	T5."Cellular",
	T5."E_Mail",
    T14."WhsName",
    T1."PaidToDate",
    T1."DocStatus"

UNION ALL

SELECT
	YEAR(T1."DocDate") AS "AnioDocumento",
	MONTH(T1."DocDate") AS "MesDocumento",
	TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "FechaDocumento",
	T4."SeriesName" AS "SerieDocumento",
	T1."DocNum" AS "NumeroDocumento",
	'FV' AS "TipoDocumento",
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
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Cod Municipio",
	'-' || SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "SumaSubTotal",
	'-' || SUM(T2."VatSum") AS "SumaIVA",
	'-' || SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum") AS "SumaTotal",
    '-' || CAST((SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum")*100) / T1."DocTotal" AS DECIMAL (10 , 2)) || '%' AS "Porcentaje",
	'-' || T1."DocTotal" AS "Total Factura",

	NULL as "PagadoHastaLaFecha",

(CASE
		WHEN T1."DocStatus" = 'O'
		THEN 'Abierto'
		ELSE 'Cerrado'
		END
) 
		AS "Estado",

	T8."ItmsGrpNam" AS "NombreGrupoProducto",
	T1."SlpCode" AS "CodigoVendedor",
	T11."SlpName" AS "NombreVendedor",
	T2."WhsCode" AS "Bodega",
    T14."WhsName" AS "NombreBodega",
	T5."City" AS "Ciudad",
	'NONE' AS "Motivo de devolución",
	T13."U_GLV_CodSup" AS "Area",
	T5."Phone1" AS "Telefono",
	T5."Phone2" AS "Telefono 2",
	T5."Cellular" AS "Telefono 3",
	T5."E_Mail" AS "Email"
FROM
	"ORIN" T1
INNER JOIN
	"RIN1" T2 ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"RIN12" T3 ON T1."DocEntry" = T3."DocEntry"
INNER JOIN
	"NNM1" T4 ON T1."Series" = T4."Series"
INNER JOIN
	"OCRD" T5 ON T1."CardCode" = T5."CardCode"
INNER JOIN
	"OCRG" T6 ON T5."GroupCode" = T6."GroupCode"
INNER JOIN
	"OITM" T7 ON T2."ItemCode" = T7."ItemCode"
INNER JOIN
	"OITB" T8 ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
LEFT JOIN
	"@GD_SUBGRUPO" T9 ON T7."U_GD_SubGrupo" = T9."Code"
LEFT JOIN
	"@GD_FAMPRODUCTOS" T10 ON T7."U_GD_FamProducto" = T10."Code"
INNER JOIN
	"OSLP" T11 ON T1."SlpCode" = T11."SlpCode"
LEFT JOIN
	"@HBT_MUNICIPIO" T12 ON T3."U_HBT_MunMedS" = T12."Code"
LEFT JOIN 
	"@SIS_SUPERVISORES" T13 ON T11."U_GLV_Supervisor" = T13."DocEntry"
LEFT JOIN
    "OWHS" T14 ON T14."WhsCode" = T2."WhsCode"
WHERE
    T1."DocDate" BETWEEN '[%0]' AND '[%1]'
GROUP BY
T1."DocDate",
T1."DocDate",
T1."DocDate",
	T4."SeriesName",
	T1."DocNum",
	T1."CardCode",
T5."U_HBT_CorreoSuperv",
T1."CardName",
	T5."LicTradNum",
	T6."GroupName",
	T3."StreetS",
	T3."BlockS",
	T3."U_HBT_MunMedS",
	T1."DocTotal",
	T8."ItmsGrpNam",
	T1."SlpCode",
	T11."SlpName",
	T2."WhsCode",
	T5."City",
	T13."U_GLV_CodSup",
	T5."Phone1",
	T5."Phone2",
	T5."Cellular",
	T5."E_Mail",
    T14."WhsName",
    T1."DocStatus"

    _____________________________________________________________________________________________________________







SELECT
	YEAR(T1."DocDate") AS "AnioDocumento",
	MONTH(T1."DocDate") AS "MesDocumento",
	TO_VARCHAR(T1."DocDate", 'YYYY-MM-DD') AS "FechaDocumento",
	T4."SeriesName" AS "SerieDocumento",
	T1."DocNum" AS "NumeroDocumento",
	'FV' AS "TipoDocumento",
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
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Cod Municipio",
	SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "SumaSubTotal",
	SUM(T2."VatSum") AS "SumaIVA",
	SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum") AS "SumaTotal",

CAST((SUM(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum")*100) / T1."DocTotal" , 2) || '%' AS "Porcentaje",


	T1."DocTotal" AS "Total Factura",
	T8."ItmsGrpNam" AS "NombreGrupoProducto",
	T1."SlpCode" AS "CodigoVendedor",
	T11."SlpName" AS "NombreVendedor",
	T2."WhsCode" AS "Bodega",
    T14."WhsName" AS "NombreBodega",
	T5."City" AS "Ciudad",
	'NONE' AS "Motivo de devolución",
	T13."U_GLV_CodSup" AS "Area",
	T5."Phone1" AS "Telefono",
	T5."Phone2" AS "Telefono 2",
	T5."Cellular" AS "Telefono 3",
	T5."E_Mail" AS "Email"
FROM
	"OINV" T1
INNER JOIN
	"INV1" T2 ON T1."DocEntry" = T2."DocEntry"
INNER JOIN
	"INV12" T3 ON T1."DocEntry" = T3."DocEntry"
INNER JOIN
	"NNM1" T4 ON T1."Series" = T4."Series"
INNER JOIN
	"OCRD" T5 ON T1."CardCode" = T5."CardCode"
INNER JOIN
	"OCRG" T6 ON T5."GroupCode" = T6."GroupCode"
INNER JOIN
	"OITM" T7 ON T2."ItemCode" = T7."ItemCode"
INNER JOIN
	"OITB" T8 ON T7."ItmsGrpCod" = T8."ItmsGrpCod"
LEFT JOIN
	"@GD_SUBGRUPO" T9 ON T7."U_GD_SubGrupo" = T9."Code"
LEFT JOIN
	"@GD_FAMPRODUCTOS" T10 ON T7."U_GD_FamProducto" = T10."Code"
INNER JOIN
	"OSLP" T11 ON T1."SlpCode" = T11."SlpCode"
LEFT JOIN
	"@HBT_MUNICIPIO" T12 ON T3."U_HBT_MunMedS" = T12."Code"
LEFT JOIN 
	"@SIS_SUPERVISORES" T13 ON T11."U_GLV_Supervisor" = T13."DocEntry"
LEFT JOIN
    "OWHS" T14 ON T14."WhsCode" = T2."WhsCode"
WHERE
    T1."DocDate" BETWEEN '[%0]' AND '[%1]'
GROUP BY
T1."DocDate",
T1."DocDate",
T1."DocDate",
	T4."SeriesName",
	T1."DocNum",
	T1."CardCode",
T5."U_HBT_CorreoSuperv",
T1."CardName",
	T5."LicTradNum",
	T6."GroupName",
	T3."StreetS",
	T3."BlockS",
	T3."U_HBT_MunMedS",
	T1."DocTotal",
	T8."ItmsGrpNam",
	T1."SlpCode",
	T11."SlpName",
	T2."WhsCode",
	T5."City",
	T13."U_GLV_CodSup",
	T5."Phone1",
	T5."Phone2",
	T5."Cellular",
	T5."E_Mail",
    T14."WhsName"


_______________________________________________________________________________________________
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
	CASE 
			WHEN T5."U_HBT_CorreoSuperv" = '742000PS' THEN
				SUBSTR(T1."CardName", 1, INSTR(T1."CardName", ' ') - 1) || ' S.A.S'
			ELSE 
				T1."CardName"
		END AS "NombreCliente",
	T5."LicTradNum" AS "NITCliente",
	T6."GroupName" AS "GrupoCliente",
	T3."StreetS" AS "Direccion",
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Cod Municipio",
	--T12."Name" AS "Municipio",
	--	PRODUCTO

	(T2."Price" - (T2."Price" * T1."DiscPrcnt" / 100)) AS "PrecioUnitario",
	(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "SubTotal",
	(T2."VatSum") AS "IVA",
	(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum") AS "Total",

-- TOTAL DOCUMENTO

    T1."DocTotal" AS "Total Factura",

	--T7."ItmsGrpCod" AS "CodigoGrupoProducto",
	T8."ItmsGrpNam" AS "NombreGrupoProducto",
	--	VENDEDOR
	T1."SlpCode" AS "CodigoVendedor",
	T11."SlpName" AS "NombreVendedor",
	T2."WhsCode" AS "Bodega",
	T5."City" AS "Ciudad",
	'NONE' AS "Motivo de devolución",
	T13."U_GLV_CodSup" AS "Area",
	--	CONTACTO DE CLIENTE
             T5."Phone1" AS "Telefono",
             T5."Phone2" AS "Telefono 2",
             T5."Cellular" AS "Telefono 3",
             T5."E_Mail" AS "Email"
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
LEFT JOIN
	"@HBT_MUNICIPIO" T12
		ON T3."U_HBT_MunMedS" = T12."Code"
LEFT JOIN 
	"@SIS_SUPERVISORES" T13
		ON T11."U_GLV_Supervisor" = T13."DocEntry"
WHERE

    T1."DocDate" = '20240601'
	--AND T1."DocNum" = '10078561'
GROUP BY
T8."ItmsGrpNam",T1."DocDate", T4."SeriesName"

--	T1."DocDate" BETWEEN '[%0]' AND '[%1]'




_______________________________________________________________________________________________


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
	CASE 
			WHEN T5."U_HBT_CorreoSuperv" = '742000PS' THEN
				SUBSTR(T1."CardName", 1, INSTR(T1."CardName", ' ') - 1) || ' S.A.S'
			ELSE 
				T1."CardName"
		END AS "NombreCliente",
	T5."LicTradNum" AS "NITCliente",
	T6."GroupName" AS "GrupoCliente",
	T3."StreetS" AS "Direccion",
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Cod Municipio",
	--T12."Name" AS "Municipio",
	--	PRODUCTO

	(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100)) AS "SubTotal",
	(T2."VatSum") AS "IVA",
	(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100) + T2."VatSum") AS "Total",

-- TOTAL DOCUMENTO

    T1."DocTotal" AS "Total Factura",

	--T7."ItmsGrpCod" AS "CodigoGrupoProducto",
	T8."ItmsGrpNam" AS "NombreGrupoProducto",
	--	VENDEDOR
	T1."SlpCode" AS "CodigoVendedor",
	T11."SlpName" AS "NombreVendedor",
	T2."WhsCode" AS "Bodega",
	T5."City" AS "Ciudad",
	'NONE' AS "Motivo de devolución",
	T13."U_GLV_CodSup" AS "Area",
	--	CONTACTO DE CLIENTE
             T5."Phone1" AS "Telefono",
             T5."Phone2" AS "Telefono 2",
             T5."Cellular" AS "Telefono 3",
             T5."E_Mail" AS "Email"
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
LEFT JOIN
	"@HBT_MUNICIPIO" T12
		ON T3."U_HBT_MunMedS" = T12."Code"
LEFT JOIN 
	"@SIS_SUPERVISORES" T13
		ON T11."U_GLV_Supervisor" = T13."DocEntry"
WHERE

    T1."DocDate" BETWEEN '[%0]' AND '[%1]'
	--AND T1."DocNum" = '10078561'

GROUP BY
T1."DocDate",
T1."DocDate",
T1."DocDate",
	T4."SeriesName",
	T1."DocNum",
	T1."CardCode",
T5."U_HBT_CorreoSuperv",
T1."CardName",
	T5."LicTradNum",
	T6."GroupName",
	T3."StreetS",
	T3."BlockS",
	T3."U_HBT_MunMedS",
	T1."DocTotal",
	T8."ItmsGrpNam",
	T1."SlpCode",
	T11."SlpName",
	T2."WhsCode",
	T5."City",
	T13."U_GLV_CodSup",
	T5."Phone1",
	T5."Phone2",
	T5."Cellular",
	T5."E_Mail"



_____________________________________________________________________________________________________________




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
	CASE 
			WHEN T5."U_HBT_CorreoSuperv" = '742000PS' THEN
				SUBSTR(T1."CardName", 1, INSTR(T1."CardName", ' ') - 1) || ' S.A.S'
			ELSE 
				T1."CardName"
		END AS "NombreCliente",
	T5."LicTradNum" AS "NITCliente",
	T6."GroupName" AS "GrupoCliente",
	T3."StreetS" AS "Direccion",
	T3."BlockS" AS "Barrio",
	T3."U_HBT_MunMedS" AS "Cod Municipio",
	-- T12."Name" AS "Municipio",
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
	(SELECT TA."PymntGroup" FROM OCTG TA WHERE TA."GroupNum" = T5."GroupNum") AS "CondicionPago",
	(SELECT TB."ListName" FROM OPLN TB WHERE TB."ListNum" = T5."ListNum") AS "ListaDePrecio",
	T5."City" AS "Ciudad",
	T13."Reason" AS "Motivo de devolución",
	T14."U_GLV_CodSup" AS "Area",
	--	CONTACTO DE CLIENTE
             T5."Phone1" AS "Telefono",
             T5."Phone2" AS "Telefono 2",
             T5."Cellular" AS "Telefono 3",
             T5."E_Mail" AS "Email"
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
LEFT JOIN 
	"@HBT_MUNICIPIO" T12
		ON T3."U_HBT_MunMedS" = T12."Code"
LEFT JOIN
	"ORER" T13 
		ON T2."ReturnRsn"=T13."AbsEntry"
LEFT JOIN 
	"@SIS_SUPERVISORES" T14
		ON T11."U_GLV_Supervisor" = T14."DocEntry"

WHERE
	T1."DocDate" BETWEEN '[%0]' AND '[%1]'
	--AND T1."DocNum" = '10078561'
/*ORDER BY
	"FechaDocumento"*/