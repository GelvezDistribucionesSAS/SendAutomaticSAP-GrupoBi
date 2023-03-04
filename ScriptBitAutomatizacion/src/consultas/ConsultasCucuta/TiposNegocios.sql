SELECT
	(T1."GroupCode" || '#' ||
	T1."GroupName") AS "Tipo Negocio"
FROM
	{0}."OCRG" T1
WHERE
	T1."GroupType" = 'C'
ORDER BY
	T1."GroupCode"