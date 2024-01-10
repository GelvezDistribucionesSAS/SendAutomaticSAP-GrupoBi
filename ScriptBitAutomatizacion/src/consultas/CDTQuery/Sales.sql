SELECT
	ta."Pais" 
    || '|' || ta."Sold" 
    || '|' || ta."CodPos" 
    || '|' || ta."Nombre" 
    || '|' || ta."Direccion" 
    || '|' || ta."RazonSocial" 
    || '|' || ta."Telefono" 
    || '|' || ta."CodAgente" 
    || '|' || ta."NombreAgente" 
    || '|' || ta."CodigoProducto" 
    || '|' || ta."NombreProducto" 
    || '|' || ta."CantidadUnidad" 
    || '|' || ta."MontoNeto" 
    || '|' || ta."MontoBruto" 
    || '|' || ta."Costo" 
    || '|' || ta."Fecha" 
    || '|' || ta."CodZona" 
    || '|' || ta."CodEstado" 
    || '|' || ta."CodCiudad" 
    || '|' || ta."CodBarrio" 
    || '|' || ta."CodTipoPtoVta" 
    || '|' || ta."CedulaJuridica" 
    || '|' || ta."Longitud" -- Placeholder
    || '|' || ta."Latitud" -- Placeholder 
    || '|' || ta."ShipTo" 
    || '|' || ta."NombreZona"  -- Placeholder
    || '|' || ta."NombreEstado" -- Placeholder
    || '|' || ta."NombreCiudad" -- Placeholder
    || '|' || ta."NombreBarrio" -- Placeholder
    || '|' || ta."NombreTipoPtoVta"
FROM
	(
	SELECT
		'CO' AS "Pais",
		TO_VARCHAR('{0}') AS "Sold",
		T5."CardCode" AS "CodPos",
		T5."CardName" AS "Nombre",
		TO_NVARCHAR(REPLACE(T1."Address", CHAR(13), '')) AS "Direccion",
		IFNULL (T5."U_GD_NombComercial", ' ' ) AS "RazonSocial",
		REPLACE(IFNULL(IFNULL(T5."Phone1", IFNULL(T5."Phone2", T5."Cellular")), '0'),'"','') AS "Telefono",
		T1."SlpCode" AS "CodAgente",
		T11."SlpName" AS "NombreAgente",
		 CASE
		 	WHEN T13."Father" IS NULL THEN T7."ItemCode"
		 	ELSE T14."ItemCode"
		 END AS "CodigoProducto",
		-- T2."ItemCode" AS "CodigoProducto",
		 CASE
		 	WHEN T13."Father" IS NULL THEN T7."ItemName"
		 	ELSE T14."ItemName"
		 END AS "NombreProducto",
		-- T2."Dscription" AS "NombreProducto",
		TO_DECIMAL(CASE 
			WHEN T13."Father" IS NULL THEN T2."Quantity"
            ELSE T2."Quantity" * T13."Quantity"
        END
        ) AS "CantidadUnidad",
		CASE
            WHEN T2."ItemCode" LIKE '%B%'
                THEN '0'
            ELSE
                CASE
                    WHEN T13."Father" IS NULL 
                        THEN (T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
                    ELSE ((T13."Price" * T13."Quantity") * (T2."Quantity") / (T2."GPTtlBasPr" / T2."LineTotal"))
                END 
        END AS "MontoNeto",
		
		
		CASE



            WHEN T2."ItemCode" OR T13."Code" LIKE '%B%'
                THEN '0'
            ELSE
	
		        CASE
                    WHEN T13."Father" IS NULL 
                        THEN (T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
                    ELSE ((T13."Price" * T13."Quantity") * (T2."Quantity") / (T2."GPTtlBasPr" / T2."LineTotal"))
        
		
		        END 
        END AS "MontoBruto",
		'0' AS "Costo",
		TO_VARCHAR(T1."DocDate", 'DD/MM/YYYY') AS "Fecha",
		' ' AS "CodZona",
		T5."U_HBT_MunMed" AS "CodEstado",
        CASE
            WHEN LENGTH(IFNULL((SELECT DISTINCT TD."ZipCode"
                                FROM {4}."CRD1" TD 
                                WHERE TD."CardCode" = T5."CardCode" AND TD."LineNum" = 0), ' ')) <> 5
            THEN '0'
            ELSE IFNULL((SELECT DISTINCT TD."ZipCode" 
                            FROM {4}."CRD1" TD 
                            WHERE TD."CardCode" = T5."CardCode" AND TD."LineNum" = 0), ' ')
        END AS "CodCiudad",
		' ' AS "CodBarrio",
		T5."GroupCode" AS "CodTipoPtoVta",
		' ' AS "Longitud",
		' ' AS "Latitud",
		T5."LicTradNum" AS "CedulaJuridica",
		'{1}' AS "ShipTo",
		' ' AS "NombreZona",
        ' ' AS "NombreEstado",
        ' ' AS "NombreCiudad",
        ' ' AS "NombreBarrio",
		-- (
		-- SELECT DISTINCT 
		-- 	IFNULL(TD."County", ' ')
		-- FROM
		-- 	CRD1 TD
		-- WHERE
		-- 	TD."CardCode" = T5."CardCode"
		-- 	AND TD."LineNum" = 0) AS "NombreEstado",
		-- (
		-- SELECT
		-- 	IFNULL(TD."City", ' ')
		-- FROM
		-- 	CRD1 TD
		-- WHERE
		-- 	TD."CardCode" = T5."CardCode"
		-- 	AND TD."LineNum" = 0) AS "NombreCiudad",
		-- (
		-- SELECT
		-- 	IFNULL(TD."Block", ' ')
		-- FROM
		-- 	CRD1 TD
		-- WHERE
		-- 	TD."CardCode" = T5."CardCode"
		-- 	AND TD."LineNum" = 0) AS "NombreBarrio",
		T6."GroupName" AS "NombreTipoPtoVta"
		--	DOCUMENTO
	FROM
		{4}."OINV" T1
		INNER JOIN
		{4}."INV1" T2
			ON
			T1."DocEntry" = T2."DocEntry"
		INNER JOIN
		{4}."INV12" T3
			ON
			T1."DocEntry" = T3."DocEntry"
		INNER JOIN
		{4}."NNM1" T4
			ON
			T1."Series" = T4."Series"
			--	CLIENTE
		INNER JOIN
		{4}."OCRD" T5
			ON
			T1."CardCode" = T5."CardCode"
			--LEFT JOIN CRD1 TD ON TD."CardCode" = T5."CardCode" 
		INNER JOIN
		{4}."OCRG" T6
			ON
			T5."GroupCode" = T6."GroupCode"
			--	PRODUCTO
		INNER JOIN
		{4}."OITM" T7
			ON
			T2."ItemCode" = T7."ItemCode"
		INNER JOIN
		{4}."OITB" T8
			ON
			T7."ItmsGrpCod" = T8."ItmsGrpCod"
		LEFT JOIN
		{4}."@GD_SUBGRUPO" T9
			ON
			T7."U_GD_SubGrupo" = T9."Code"
		LEFT JOIN
		{4}."@GD_FAMPRODUCTOS" T10
			ON
			T7."U_GD_FamProducto" = T10."Code"
			--	VENDEDOR
		INNER JOIN
		{4}."OSLP" T11
			ON
			T1."SlpCode" = T11."SlpCode"
			--Generar Desagregado de combos
		LEFT JOIN 
		{4}."ITT1" T13 
			ON
			T7."ItemCode" = T13."Father"
		LEFT JOIN 
		{4}."OITM" T14 
			ON
			T13."Code" = T14."ItemCode"
		LEFT JOIN (
			SELECT
				TA."Father",
					sum(TA."Quantity")AS "Quantity"
			FROM
				{4}."ITT1" TA
			INNER JOIN 
			{4}."OITM" TB 
				ON
				TA."Code" = TB."ItemCode"
	GROUP BY
		TA."Father")AS P1 ON
		T7."ItemCode" = P1."Father"
	WHERE
		T1."DocDate" BETWEEN '{5}' AND '{6}'
		--T1."DocDate" BETWEEN '20231001' AND '20231031'
		--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		AND T8."ItmsGrpCod" = {2}
		--	Buscar por códigos
		AND T2."WhsCode" IN ({3})
    UNION ALL
	SELECT 
		'CO' AS "Pais",
		TO_VARCHAR('{0}') AS "Sold",
		T5."CardCode" AS "CodPos",
		T5."CardName" AS "Nombre",
		TO_NVARCHAR(REPLACE(T1."Address", CHAR(13), '')) AS "Direccion",
		IFNULL (T5."U_GD_NombComercial", ' ' ) AS "RazonSocial",
		REPLACE(IFNULL(IFNULL(T5."Phone1", IFNULL(T5."Phone2", T5."Cellular")), '0'),'"','') AS "Telefono",
		T1."SlpCode" AS "CodAgente",
		T11."SlpName" AS "NombreAgente",
		 CASE
		 	WHEN T13."Father" IS NULL THEN T7."ItemCode"
		 	ELSE T14."ItemCode"
		 END AS "CodigoProducto",
		-- T2."ItemCode" AS "CodigoProducto",
		 CASE
		 	WHEN T13."Father" IS NULL THEN T7."ItemName"
		 	ELSE T14."ItemName"
		 END AS "NombreProducto",
		-- T2."Dscription" AS "NombreProducto",
		-1 * TO_DECIMAL(CASE 
		WHEN T13."Father" IS NULL THEN T2."Quantity"
            ELSE T2."Quantity" * T13."Quantity"
        END
        ) AS "CantidadUnidad",
		CASE
            WHEN T2."ItemCode" LIKE '%B%'
                THEN '0'
            ELSE
                CASE
                    WHEN T13."Father" IS NULL 
                        THEN -(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
                    ELSE -((T13."Price" * T13."Quantity") * (T2."Quantity") / (T2."GPTtlBasPr" / T2."LineTotal"))
                END 
        END AS "MontoNeto",
		CASE
            WHEN T2."ItemCode" LIKE '%B%'
                THEN '0'
            ELSE
                CASE
                    WHEN T13."Father" IS NULL 
                        THEN -(T2."LineTotal" - (T2."LineTotal" * T1."DiscPrcnt" / 100))
                    ELSE -((T13."Price" * T13."Quantity") * (T2."Quantity") / (T2."GPTtlBasPr" / T2."LineTotal"))
                END 
        END AS "MontoBruto",
		' ' AS "Costo",
		TO_VARCHAR(T1."DocDate", 'DD/MM/YYYY') AS "Fecha",
		' ' AS "CodZona",
		T5."U_HBT_MunMed" AS "CodEstado",
        CASE
            WHEN 
				LENGTH(
					IFNULL(
						(SELECT DISTINCT TD."ZipCode" 
						FROM {4}."CRD1" TD 
						WHERE TD."CardCode" = T5."CardCode" AND TD."LineNum" = 0), ' ')) <> 5
            THEN '0'
            ELSE 
				IFNULL((
					SELECT DISTINCT TD."ZipCode" 
					FROM {4}."CRD1" TD 
					WHERE TD."CardCode" = T5."CardCode" AND TD."LineNum" = 0), ' ')
        END AS "CodCiudad",
		' ' AS "CodBarrio",
		T5."GroupCode" AS "CodTipoPtoVta",
		' ' AS "Longitud",
		' ' AS "Latitud",
		T5."LicTradNum" AS "CedulaJuridica",
		'{1}' AS "ShipTo",
		' ' AS "NombreZona",
        ' ' AS "NombreEstado",
        ' ' AS "NombreCiudad",
        ' ' AS "NombreBarrio",
		-- (
		-- SELECT
		-- 	IFNULL(TD."County", ' ')
		-- FROM
		-- 	CRD1 TD
		-- WHERE
		-- 	TD."CardCode" = T5."CardCode"
		-- 	AND TD."LineNum" = 0) AS "NombreEstado",
		-- (
		-- SELECT
		-- 	IFNULL(TD."City", ' ')
		-- FROM
		-- 	CRD1 TD
		-- WHERE
		-- 	TD."CardCode" = T5."CardCode"
		-- 	AND TD."LineNum" = 0) AS "NombreCiudad",
		-- (
		-- SELECT
		-- 	IFNULL(TD."Block", ' ')
		-- FROM
		-- 	CRD1 TD
		-- WHERE
		-- 	TD."CardCode" = T5."CardCode" 
		-- 	AND TD."LineNum" = 0) AS "NombreBarrio",
		T6."GroupName" AS "NombreTipoPtoVta"
		--	DOCUMENTO
	FROM
		{4}."ORIN" T1
		INNER JOIN
		{4}."RIN1" T2
			ON
			T1."DocEntry" = T2."DocEntry"
		INNER JOIN
		{4}."RIN12" T3
			ON
			T1."DocEntry" = T3."DocEntry"
		INNER JOIN
		{4}."NNM1" T4
			ON
			T1."Series" = T4."Series"
			--	CLIENTE
		INNER JOIN
		{4}."OCRD" T5
			ON
			T1."CardCode" = T5."CardCode"
		INNER JOIN
		{4}."OCRG" T6
			ON
			T5."GroupCode" = T6."GroupCode"
			--	PRODUCTO
		INNER JOIN
		{4}."OITM" T7
			ON
			T2."ItemCode" = T7."ItemCode"
		INNER JOIN
		{4}."OITB" T8
			ON
			T7."ItmsGrpCod" = T8."ItmsGrpCod"
		LEFT JOIN
		{4}."@GD_SUBGRUPO" T9
			ON
			T7."U_GD_SubGrupo" = T9."Code"
		LEFT JOIN
		{4}."@GD_FAMPRODUCTOS" T10
			ON
			T7."U_GD_FamProducto" = T10."Code"
			--	VENDEDOR
		INNER JOIN
		{4}."OSLP" T11
			ON
			T1."SlpCode" = T11."SlpCode"
			--Generar Desagregado de combos
		LEFT JOIN 
		{4}."ITT1" T13 
			ON
			T7."ItemCode" = T13."Father"
		LEFT JOIN 
		{4}."OITM" T14 
			ON
			T13."Code" = T14."ItemCode"
		LEFT JOIN (
			SELECT
				TA."Father",
					sum(TA."Quantity")AS "Quantity"
			FROM
				{4}."ITT1" TA
			INNER JOIN 
			{4}."OITM" TB 
				ON
				TA."Code" = TB."ItemCode"
			GROUP BY
				TA."Father")AS P1 ON
			T7."ItemCode" = P1."Father"
	WHERE
		--T1."DocDate" BETWEEN '{5}' AND '{6}'
		T1."DocDate" BETWEEN '20231001' AND '20231130'
		--T1."DocDate" BETWEEN ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1)),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )
		AND T8."ItmsGrpCod" = {2}
		--	Buscar por códigos
		AND T2."WhsCode" IN ({3})
) ta