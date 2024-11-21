SELECT
	(T1."Code" || '#' ||
	T1."Name") AS municipio
FROM
	"{0}"."@HBT_MUNICIPIO" T1
ORDER BY
	T1."Code"