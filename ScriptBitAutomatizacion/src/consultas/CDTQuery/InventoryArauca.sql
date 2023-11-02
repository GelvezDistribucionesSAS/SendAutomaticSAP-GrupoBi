SELECT 
CONCAT( 'CO','|','{0}','|',TA.item,'|',TA.NameItem,'|',sum(TA.quanty),'|',TA.Valorisado,'|{2}|{1}') 
from(
select
(replace(CONVERT(varchar, getdate(), 11), '/', '')) as EndDate,  + REPLACE(REPLACE(RTRIM(REPLACE(RTRIM(LTRIM(ISNULL(CAST(a.ArtCod  AS VARCHAR(249)), ''))), '', '')), CHAR(13), ''), CHAR(10), '') as item ,
	convert( int,
	isnull((
SELECT
		sum(CASE WHEN karnat = '+' THEN((karuni +(KARCAJ * KARARTEMB))/nullif(KarArtEmb,0)) WHEN karnat = '-' THEN ((karuni +(KARCAJ * KARARTEMB))/nullif(KarArtEmb,0))* -1 END) 
	FROM
		kardex K
	LEFT JOIN Factura f ON
		f.FacSec = k.FacSec
	WHERE
	f.FacFec BETWEEN '20200101' and '{4}'
		AND k.SubBodSucCCSec = 2
		and f.facest = 'A'
		and k.artsec = a.artsec
	group by
		k.artsec),
	0) ) as quanty,
	(
	SELECT	 
		sum(CASE WHEN karnat = '+' THEN (karuni +(KARCAJ * KARARTEMB)) WHEN karnat = '-' THEN (karuni +(KARCAJ * KARARTEMB))* -1 END)
		* (SELECT max(pd.PrePreFijCosPro) from PreciosDetalle pd where pd.ArtSec = k.ArtSec)
	FROM
		kardex K
	LEFT JOIN Factura f ON
		f.FacSec = k.FacSec
	WHERE
	f.FacFec BETWEEN '20200101' and '{4}'AND
	k.SubBodSucCCSec = 2
		and f.facest = 'A'
		and k.artsec = a.ArtSec
	group by k.ArtSec 
	)as Valorisado,
	
	(
	SELECT
		TOP 1 PREARTNOM
	FROM
		ArtPre AA
	LEFT JOIN PresentacionArticulos PA ON
		AA.preartcod = PA.preartcod
	WHERE
		AA.ARTSEC = A.ARTSEC) as salpack, a.ArtCod  as coded,
	a.ArtNom as NameItem,
	a.ArtCod as CodeItem
from
	Articulos a
LEFT JOIN InventarioFamilia FF ON
	FF.InvFamCod = A.InvFamCod
LEFT JOIN InventarioSubgrupo SS ON
	SS.InvSubGruCod = FF.InvSubGruCod
where
	InvGruCod IN('{3}') ) as TA
--WHERE TA.item = '1221318'
GROUP by TA.item, TA.salpack, TA.NameItem, TA.quanty, TA.Valorisado