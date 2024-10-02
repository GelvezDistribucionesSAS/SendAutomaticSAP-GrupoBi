SELECT
	T1."ItemCode" AS "CodigoProducto",
	T1."CodeBars" AS "EAN",
	T1."SuppCatNum" AS "CodigoProveedor",
	T1."ItemName" AS "NombreProducto",
	T3."ItmsGrpNam" AS "NombreGrupoProducto",
	T4."Name" AS "NombreSubGrupoProducto",
	T5."Name" AS "NombreFamiliaProducto",
	T2."WhsCode" AS "Bodega",
             T6."WhsName" AS "Nombre Bodega",
	T1."InvntryUom" AS "Presentacion",
	T1."SalPackUn" AS "Embalaje",
	T2."OnHand" AS "Stock",
	TO_INT(T2."OnHand" / T1."SalPackUn") AS "Cajas",
	MOD(T2."OnHand",T1."SalPackUn") AS "Unidades",
	T2."AvgPrice" AS "CostoPromedio",
	T1."LastPurPrc" AS "UltimoPrecioCompra",
	(T2."OnHand" * T2."AvgPrice") AS "TotalCostoPromedio",
	(T2."OnHand" * T1."LastPurPrc") AS "TotalUltimoPrecioCompra",
	--TO_VARCHAR(T1."LastPurDat", 'YYYY-MM-DD') AS "UltimaFechaCompra",
	TO_VARCHAR((SELECT MAX(TA."DocDate") FROM "OPCH" TA INNER JOIN "PCH1" TB ON TA."DocEntry" = TB."DocEntry" WHERE TB."ItemCode" = T1."ItemCode" AND TB."WhsCode" = T6."WhsCode"), 'YYYY-MM-DD') AS "UltimaFechaCompra",
	--TO_VARCHAR((SELECT MAX(TA."DocDate") FROM "OINM" TA WHERE TA."ItemCode" = T1."ItemCode" AND TA."Warehouse" = T2."WhsCode"), 'YYYY-MM-DD') AS "UltimaFechaVenta",
	TO_VARCHAR((SELECT MAX(TA."DocDate") FROM "OINV" TA INNER JOIN "INV1" TB ON TA."DocEntry" = TB."DocEntry" WHERE TB."ItemCode" = T1."ItemCode" AND TB."WhsCode" = T6."WhsCode"), 'YYYY-MM-DD') AS "UltimaFechaVenta",
	T1."TaxCodeAP" AS "IVACompra",
             T7."Name" AS "IVACompra Nombre",
	T1."TaxCodeAR" AS "IVAVenta",
             T8."Name" AS "IVAVenta Nombre",
	CASE
		WHEN T1."validFor" = 'Y' THEN 'Activo'
		ELSE 'Inactivo'
	END AS "EstadoGeneral",
	T1."FrozenComm" AS "Comentario",
	CASE
		WHEN T2."Locked" = 'Y' THEN 'Bloqueado'
		ElSE 'Desbloqueado'
	END AS "EstadoAlmacen",
	(SELECT STRING_AGG(TA."BcdCode",',' ORDER BY TA."BcdCode") FROM "OBCD" TA WHERE TA."ItemCode" = T1."ItemCode" AND TA."BcdCode" <> T1."CodeBars") AS "CodigosBarras",
	T1."LastPurPrc" AS "UltimoCostoGeneral"
FROM
	"OITM" T1
INNER JOIN
	"OITW" T2
		ON T1."ItemCode" = T2."ItemCode"
INNER JOIN
	"OITB" T3
		ON T1."ItmsGrpCod" = T3."ItmsGrpCod"
INNER JOIN "OWHS" T6 ON T6."WhsCode" = T2."WhsCode"
LEFT JOIN "OSTC" T7  ON T1."TaxCodeAP" = T7."Code"
LEFT JOIN "OSTC" T8  ON T1."TaxCodeAR" = T8."Code"
LEFT JOIN
	"@GD_SUBGRUPO" T4
		ON T1."U_GD_SubGrupo" = T4."Code"
LEFT JOIN
	"@GD_FAMPRODUCTOS" T5
		ON T1."U_GD_FamProducto" = T5."Code"
WHERE
	TO_VARCHAR(T3."ItmsGrpNam") LIKE 'KIMBERLY PAÑ'
	AND T6."WhsName" LIKE '006'
	AND T2."OnHand" > 0
ORDER BY
	T1."ItemCode", T2."WhsCode"