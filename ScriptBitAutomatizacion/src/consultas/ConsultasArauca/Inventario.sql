select

	concat((replace(CONVERT(varchar, getdate(), 11), '/', '')) + '{' +
	REPLACE(REPLACE(RTRIM(REPLACE(RTRIM(LTRIM(ISNULL(CAST(ArtFicTec AS VARCHAR(249)), ''))), '', '')), CHAR(13), ''), CHAR(10), '') + '{' ,
	convert( int,
	isnull((
	SELECT
		sum(CASE WHEN karnat = '+' THEN (karuni +(KARCAJ * KARARTEMB)) WHEN karnat = '-' THEN (karuni +(KARCAJ * KARARTEMB))*-1 END)
	FROM
		kardex K
	LEFT JOIN Factura f ON
		f.FacSec = k.FacSec
	WHERE
		(year(facfec)= 2020
			or year(facfec)= 2021
				or (year(facfec)= 2023
					and month(facfec)<= 6))
		and f.facest = 'A'
		and artsec = a.artsec
		and SubBodSucCCSec in(
		select
			BodSucCCSec
		from
			BodegaSucursalCC
		where
			SucCod = 1)
	group by
		artsec),
	0) ),'{'+
	(
	SELECT
		TOP 1 PREARTNOM
	FROM
		ArtPre AA
	LEFT JOIN PresentacionArticulos PA ON
		AA.preartcod = PA.preartcod
	WHERE
		AA.ARTSEC = A.ARTSEC)+ '{A')
from
	Articulos a
LEFT JOIN InventarioFamilia FF ON
	FF.InvFamCod = A.InvFamCod
LEFT JOIN InventarioSubgrupo SS ON
	SS.InvSubGruCod = FF.InvSubGruCod
where
	InvGruCod IN('3')