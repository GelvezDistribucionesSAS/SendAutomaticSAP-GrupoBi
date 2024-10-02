--> QUERY PARA ACTUALIZAR PROYECTOS 00 DESDE LINEA 0 <--
UPDATE JDT1
SET "Project" = 
			CASE 
				WHEN "Project" IN ('00')  
					THEN (
                            SELECT "Project"
                            FROM JDT1 
                            WHERE "Line_ID" = 0
                        )
					ELSE "Project" 
			END
WHERE "TransId" = 261085;

--> QUERY PARA ACTUALIZAR ASIENTOS PROYECTO 04 EN CABECERA <--
UPDATE OJDT
SET "Project" = 
			CASE 
				WHEN "Project" IN ('04')  
					THEN '01' 
					ELSE "Project" 
			END
WHERE "TransId" = 261085;

--> QUERY PARA ACTUALIZAR ASIENTOS PROYECTO 04 EN LINEAS <--
UPDATE JDT1
SET "Project" = 
			CASE 
				WHEN "Project" IN ('04')  
					THEN '01' 
					ELSE "Project" 
			END
WHERE "TransId" = 261085;


--> QUERY PARA ACTUALIZAR CABECERAS DESDE LINEA 0 <--
UPDATE 
    OJDT
SET 
    "Project" = (
        SELECT
            TA."Project"
        FROM  
            (
                SELECT
                    TA."Project"
                FROM 
                    JDT1 TA
                INNER JOIN 
                    OJDT T1 ON TA."TransId" = T1."TransId"
                WHERE 
                    TA."Line_ID" = 0 AND
           			T1."TransId" = OJDT."TransId"
            ) as TA
    )
WHERE "TransId"=261085
AND "Project" IS NULL;


------------------------------------------------------------->Alternativa<-------------------------------------------------------------
UPDATE OJDT
SET "Project" = (
    SELECT 
		TA."Project"
    FROM 
		JDT1 TA
    INNER JOIN 
		OJDT T1 ON TA."TransId" = T1."TransId"
    WHERE 
		TA."Line_ID" = 0 AND
		T1."TransId" = OJDT."TransId"
)
WHERE OJDT."TransId" = 261085
AND OJDT."Project" IS NULL;
----------------------------------------------------------------------------------------------------------------------------------------

--> QUERY PARA ACTUALIZAR lINEAS DESDE CABECERA <--
UPDATE JDT1
SET "Project" = T0."Project" 
FROM OJDT T0, JDT1 
WHERE JDT1."TransId" = 261085 
AND JDT1."Project" IS NULL
AND T0."Project" IS NOT NULL
AND T0."TransId" = JDT1."TransId"
AND T0."RefDate" BETWEEN '20230101 ' AND '20230501'



------ ASIENTOS DE PRUEBA PARA EL QUERY ---------
-- ASIENTO SIN CABECERA Y PROYECTOS 4: 1488
-- ASIENTO SIN CABECERA Y PROYECTOS 1: 1493
-- ASIENTO SIN CABECERA Y LINEAS VACIAS(SI LINEA 0): 306204
-- ASIENTO SIN CABECERA Y LINEAS VACIAS(NO LINEA 0): 261085
-- ASIENTO SIN CABECERA Y PROYECTO 00: 261086
-- ASIENTO CON CABECERA Y PROYECTO 00: 261087
-----------------------------------------------







PARA ENERO 2024


--> QUERY PARA ACTUALIZAR PROYECTOS 00 DESDE LINEA 0 <--
UPDATE JDT1
SET "Project" = 
			CASE 
				WHEN "Project" IN ('00')  
					THEN (
                            SELECT "Project"
                            FROM JDT1 
                            WHERE "Line_ID" = 0
                        )
					ELSE "Project" 
			END
WHERE JDT1."RefDate" BETWEEN '20240101 ' AND '20240131';







--> QUERY PARA ACTUALIZAR ASIENTOS PROYECTO 04 EN CABECERA <--
UPDATE OJDT
SET "Project" = 
			CASE 
				WHEN "Project" IN ('04')  
					THEN '01' 
					ELSE "Project" 
			END
WHERE OJDT."RefDate" BETWEEN '20240101' AND '20240131';

--> QUERY PARA ACTUALIZAR ASIENTOS PROYECTO 04 EN LINEAS <--
UPDATE JDT1
SET "Project" = 
			CASE 
				WHEN "Project" IN ('04')  
					THEN '01' 
					ELSE "Project" 
			END
WHERE JDT1."RefDate" BETWEEN '20240101' AND '20240131';


--> QUERY PARA ACTUALIZAR CABECERAS DESDE LINEA 0 <--
UPDATE 
    OJDT
SET 
    "Project" = (
        SELECT
            TA."Project"
        FROM  
            (
                SELECT
                    TA."Project"
                FROM 
                    JDT1 TA
                INNER JOIN 
                    OJDT T1 ON TA."TransId" = T1."TransId"
                WHERE 
                    TA."Line_ID" = 0 AND
           			T1."TransId" = OJDT."TransId"
            ) as TA
    )
WHERE OJDT."RefDate" BETWEEN '20240101' AND '20240131'
AND "Project" IS NULL;

--> QUERY PARA ACTUALIZAR lINEAS DESDE CABECERA <--
UPDATE JDT1
SET "Project" = T0."Project" 
FROM OJDT T0, JDT1 
WHERE JDT1."Project" IS NULL
AND T0."Project" IS NOT NULL
AND T0."TransId" = JDT1."TransId"
AND T0."RefDate" BETWEEN '20240101' AND '20240131'














------------------------------------------------------------->Alternativa<-------------------------------------------------------------
UPDATE OJDT
SET "Project" = (
    SELECT 
		TA."Project"
    FROM 
		JDT1 TA
    INNER JOIN 
		OJDT T1 ON TA."TransId" = T1."TransId"
    WHERE 
		TA."Line_ID" = 0 AND
		T1."TransId" = OJDT."TransId"
)
WHERE OJDT."TransId" = 261085
AND OJDT."Project" IS NULL;
----------------------------------------------------------------------------------------------------------------------------------------





------ ASIENTOS DE PRUEBA PARA EL QUERY ---------
-- ASIENTO SIN CABECERA Y PROYECTOS 4: 1488
-- ASIENTO SIN CABECERA Y PROYECTOS 1: 1493
-- ASIENTO SIN CABECERA Y LINEAS VACIAS(SI LINEA 0): 306204
-- ASIENTO SIN CABECERA Y LINEAS VACIAS(NO LINEA 0): 261085
-- ASIENTO SIN CABECERA Y PROYECTO 00: 261086
-- ASIENTO CON CABECERA Y PROYECTO 00: 261087
-----------------------------------------------