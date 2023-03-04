SELECT DISTINCT 
TA.*
FROM 
(SELECT
	(T1."GroupCode" || '{' ||
	T1."GroupName") AS "Tipo Negocio"
FROM
	"HBTGELVEZ_CUCUTA"."OCRG" T1
WHERE
	T1."GroupType" = 'C'

UNION ALL

SELECT
	(T1."GroupCode" || '{' ||
	T1."GroupName") AS "Tipo Negocio"
FROM
	"HBTGRANDISTRIBUIDOR"."OCRG" T1
WHERE
	T1."GroupType" = 'C'
) AS TA
