SELECT 
CONCAT(max(TA.EndDate),'#', TA.CodeItem,'#',sum(TA.quanty),'#',TA.salpack) 
from(
select
	(replace(CONVERT(varchar, getdate(), 12), '/', '')) as EndDate,  + REPLACE(REPLACE(RTRIM(REPLACE(RTRIM(LTRIM(ISNULL(CAST(ArtFicTec AS VARCHAR(249)), ''))), '', '')), CHAR(13), ''), CHAR(10), '') as item ,
	convert( int,
	isnull((
SELECT
		sum(CASE WHEN karnat = '+' THEN (karuni +(KARCAJ * KARARTEMB)) WHEN karnat = '-' THEN (karuni +(KARCAJ * KARARTEMB))* -1 END)
	FROM
		kardex K
	LEFT JOIN Factura f ON
		f.FacSec = k.FacSec
	WHERE
	f.FacFec BETWEEN '20200101' and '20240131'--'{1}'
		AND k.SubBodSucCCSec = 2
		and f.facest = 'A'
		and artsec = a.artsec
	group by
		artsec),
	0) ) as quanty,
	(
	SELECT
		TOP 1 PREARTNOM
	FROM
		ArtPre AA
	LEFT JOIN PresentacionArticulos PA ON
		AA.preartcod = PA.preartcod
	WHERE
		AA.ARTSEC = A.ARTSEC) as salpack, a.ArtCod  as coded,
		REPLACE(REPLACE(RTRIM(REPLACE(RTRIM(LTRIM(ISNULL(CAST(ArtCod AS VARCHAR(249)), ''))), '', '')), CHAR(13), ''), CHAR(10), '') as CodeItem
from
	Articulos a
LEFT JOIN InventarioFamilia FF ON
	FF.InvFamCod = A.InvFamCod
LEFT JOIN InventarioSubgrupo SS ON
	SS.InvSubGruCod = FF.InvSubGruCod
where
	InvGruCod IN('{0}') ) as TA

GROUP by TA.item, TA.EndDAte, TA.salpack , TA.CodeItem