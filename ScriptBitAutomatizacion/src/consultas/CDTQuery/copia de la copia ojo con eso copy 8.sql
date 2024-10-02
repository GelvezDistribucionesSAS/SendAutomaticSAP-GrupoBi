SELECT
	T0."CardCode" AS "CódigoCliente",
    T0."CardName" AS "NombreCliente",
	T1."SeriesName" AS "SerieDocumento",
	T0."DocNum" AS "NúmeroDocumento",
	T0."DocDate" AS "FechaDocumento",
	T0."U_HBT_IdEnProveedor" AS "CUFE"
	
	FROM
	OINV T0 

INNER JOIN
	"NNM1" T1
		ON T0."Series" = T1."Series"

	WHERE
    	T0."DocDate" BETWEEN '[%0]' AND '[%1]'
    	AND T0."CardCode" = '[%2]'
		--T0."CardCode" = 'CN1092546084'

UNION ALL

SELECT
	T0."CardCode" AS "Código Cliente",
    T0."CardName" AS "Nombre Cliente",
	T1."SeriesName" AS "SerieDocumento",
	T0."DocNum" AS "NúmeroDocumento",
	T0."DocDate" AS "Fecha Documento",
	T0."U_HBT_IdEnProveedor" AS "CUFE"
	
	FROM
	ORIN T0 

INNER JOIN
	"NNM1" T1
		ON T0."Series" = T1."Series"

	WHERE
    	T0."DocDate" BETWEEN '[%0]' AND '[%1]'
    	AND T0."CardCode" = '[%2]'
		--T0."CardCode" = 'CN1092546084'

