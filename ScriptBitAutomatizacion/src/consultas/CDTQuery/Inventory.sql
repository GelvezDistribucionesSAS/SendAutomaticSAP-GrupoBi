SELECT 
TB."CodePais" || '|' || TB."CodCliente" || '|' || TB."CodProducto" || '|' || TB."NombreProducto" || '|' || TB."Cajas" || '|' || TB."Costo" || '|' || TB."Fecha" || '|' || TB."ShipTo"
FROM(
SELECT
    'CO' as "CodePais",
'004015849970403001' AS "CodCliente",
    ta."CodProducto",
    ta."NombreProducto",
    TO_DECIMAL(
        SUM(
            CASE 
                WHEN T13."Father" IS NULL THEN ta."Stock" / ta."Embalado" 
                ELSE ta."Stock" * T13."Quantity" / T14."SalPackUn" 
            END
        ), 10, 3
    ) as "Cajas",
    TO_DECIMAL(SUM(ta."CostoInventario"), 10, 3) as "Costo",
    '31/05/2023' as "Fecha",
'0040158499' AS "ShipTo"
FROM
    (
        SELECT
            TO_VARCHAR(LAST_DAY(T0."CreateDate"), 'DD/MM/YYYY') AS "Fecha",
            IFNULL(T0."ItemCode", ' ') AS "CodProducto",
            IFNULL(T1."ItemName", ' ') AS "NombreProducto", 
            SUM(T0."CalcPrice") AS "CostoInventario",
            IFNULL(CAST(SUM(T0."InQty") - SUM(T0."OutQty") + IFNULL(
                (
                    SELECT SUM(TA."InQty") - SUM(TA."OutQty") 
                    FROM OINM TA 
                    WHERE (TA."CreateDate" <= LAST_DAY(ADD_MONTHS('20220101', -1))) 
                    AND TA."ItemCode" = T0."ItemCode" 
                    AND (TA."Warehouse" IN (006, 030))
                ), 
                0
            ) AS INT), '0') AS "Stock",
            IFNULL(T1."InvntryUom", '') AS "TipoStok",
            T1."SalPackUn" AS "Embalado"
        FROM
            OINM T0
        INNER JOIN OITM T1 ON
            T1."ItemCode" = T0."ItemCode"
        INNER JOIN OITB T2 ON
            T2."ItmsGrpCod" = T1."ItmsGrpCod"
        WHERE
            (T0."CreateDate" BETWEEN '20220101' AND '20230531')
            AND T2."ItmsGrpNam" LIKE CONCAT('KIMBERLY ICH', '%')
            AND (T0."Warehouse" IN (006, 030))
        GROUP BY
            T0."ItemCode",
            TO_VARCHAR(LAST_DAY(T0."CreateDate"), 'YYYYMMDD'),
            T1."InvntryUom",
            T1."ItemName",
            T0."CreateDate",
            T1."SalPackUn"
    ) AS ta
    -- Desagregar Combos
LEFT JOIN ITT1 T13 ON
    Ta."CodProducto" = T13."Father"
LEFT JOIN OITM T14 ON
    T13."Code" = T14."ItemCode"
GROUP BY
    ta."CodProducto",
    ta."NombreProducto"
ORDER BY ta."CodProducto") TB