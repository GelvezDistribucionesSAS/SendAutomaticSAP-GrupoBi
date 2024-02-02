SELECT 

    TD."CodePais"
    || '|' || TD."CodCliente" 
    || '|' || TD."CodProducto" 
    || '|' || TD."NombreProducto"
    || '|' || SUM(TD."CantidadUnidad") 
    || '|' || SUM(TD."Costo") 
    --|| '|' || TD."CANTIDADCOMBO"    --pruebas
    || '|' || TD."Fecha" 
    || '|' || TD."ShipTo"

    FROM (
    SELECT DISTINCT
        -- Constantes
        'CO' AS "CodePais",
        '{0}' AS "CodCliente",

        CASE
            WHEN T2."Father" IS NULL 
                THEN T1."ItemCode"
            ELSE T3."ItemCode"
        END AS "CodProducto",
        --ta."CodProducto",

        
        CASE
            WHEN T2."Father" IS NULL 
                THEN T1."ItemName"
            ELSE T3."ItemName"
        END AS "NombreProducto",
        -- ta."NombreProducto",
        
        CASE
            WHEN T2."Father" IS NULL THEN
                CASE
                    WHEN T1."SalUnitMsr" = 'BULTO' THEN SRR."Stock" * BUD."CantidadBultosTrue"
                    ELSE SRR."Stock"
                END
            ELSE
                CASE
                    WHEN T3."SalUnitMsr" = 'BULTO' THEN (SRC."Stock" * T2."Quantity") * BUDC."CantidadBultosCombo"
                    ELSE (SRC."Stock" * T2."Quantity")
                END
        END AS "CantidadUnidad",
        -- Cantidad de unidades
        
       (TO_DECIMAL( CASE
            WHEN T2."Father" IS NULL THEN
                    SRR."Stock" * T1."LastPurPrc"
            ELSE
                 (SRC."Stock" * T2."Quantity" * T3."LastPurPrc")
        END)) AS "Costo",
            
        -- CASE WHEN T2."Father" IS NULL THEN
        -- T1."ItemCode" 
        -- ELSE T2."Father" 
        -- END AS "CANTIDADCOMBO",



        TO_VARCHAR( '{6}' , 'DD/MM/YYYY') AS "Fecha",

        '{1}' AS "ShipTo"

        FROM
            {3}.OINM T0

        INNER JOIN {3}.OITM T1 
            ON T0."ItemCode" = T1."ItemCode"

        -- Desagregar Combos
        LEFT JOIN {3}.ITT1 T2 
            ON T0."ItemCode" = T2."Father"

        LEFT JOIN {3}.OITM T3 
            ON T2."Code" = T3."ItemCode"
        
        -- Corvertir bulto a unidad/display
        LEFT JOIN (
            -- ConversiÃ³n de bulto a unidad/display para productos regulares
            SELECT
                Ta."ItemCode",
                TO_INTEGER(
                    REPLACE(
                        SUBSTRING_REGEXPR('X(\d+)' IN Ta."ItemName")
                    , 'X', '')
                ) AS "CantidadBultosTrue"
            FROM
                {3}.OITM Ta
            WHERE
                Ta."SalUnitMsr" = 'BULTO'
        ) AS BUD  -- de Bulto a Unidad/Display
            ON T1."ItemCode" = BUD."ItemCode"


    
        LEFT JOIN (
            -- ConversiÃ³n de bulto a unidad/display para productos de combo
            SELECT
                Ta."ItemCode",
                TO_INTEGER(
                    REPLACE(
                        SUBSTRING_REGEXPR('X(\d+)' IN Ta."ItemName")
                    , 'X', '')
                ) AS "CantidadBultosCombo"
            FROM
                {3}.OITM Ta
            WHERE
                Ta."SalUnitMsr" = 'BULTO'
        ) AS BUDC ON T3."ItemCode" = BUDC."ItemCode"

        LEFT JOIN (
            -- Obtener stock real regular
            SELECT
                Ta."ItemCode",
                SUM(Ta."InQty") - SUM(Ta."OutQty") AS "Stock"
            FROM
                {3}.OINM Ta
            INNER JOIN {3}.OITM Tb ON Ta."ItemCode" = Tb."ItemCode"
            WHERE
                (Ta."CreateDate" BETWEEN '20220101' AND '{6}') AND
                (Tb."ItmsGrpCod" IN ({5})) AND
                (Ta."Warehouse" IN ({4})) AND
                Tb."SalUnitMsr" <> 'CBO'
            GROUP BY
                Ta."ItemCode"
        ) AS SRR ON T1."ItemCode" = SRR."ItemCode"
        
        LEFT JOIN (
            -- Obtener stock real combo
            SELECT
                Ta."ItemCode",
                SUM(Ta."InQty" - Ta."OutQty") AS "Stock"
            FROM
                {3}.OINM Ta
            INNER JOIN {3}.OITM Tb ON Ta."ItemCode" = Tb."ItemCode"
            LEFT JOIN {3}.ITT1 tc ON Ta."ItemCode" = Tc."Code"
            WHERE
                (Ta."CreateDate" BETWEEN '20220101' AND '{6}') AND
                (Tb."ItmsGrpCod" IN ({5})) AND
                (Ta."Warehouse" IN ({4})) AND
                Tb."SalUnitMsr" = 'CBO'
            GROUP BY
                Ta."ItemCode"
        ) AS SRC ON T1."ItemCode" = SRC."ItemCode"
        
    WHERE
        (T0."CreateDate" BETWEEN '20220101' AND '{6}') AND
        (T1."ItmsGrpCod" IN ({5})) AND
        (T0."Warehouse" IN ({4}))
    ORDER BY
        "CodProducto",
        "NombreProducto",
        "CantidadUnidad",
        "Costo",
        "Fecha",
        "ShipTo"
     ) TD
GROUP BY
    TD."CodePais",
    TD."CodCliente" ,
   TD."CodProducto" ,
    TD."NombreProducto",
    --|| '|' || TD."CANTIDADCOMBO"    --pruebas
   TD."Fecha" ,
   TD."ShipTo"