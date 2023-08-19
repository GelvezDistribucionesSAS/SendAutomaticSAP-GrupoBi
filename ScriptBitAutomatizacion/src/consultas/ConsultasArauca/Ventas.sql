select
CONCAT(
	n.NitIde + '{' +
	n2.NitIde + '{'+
	REPLACE(REPLACE(RTRIM(REPLACE(RTRIM(LTRIM(ISNULL(CAST(ArtFicTec AS VARCHAR(249)), ''))), '', '')), CHAR(13), ''), CHAR(10), '')+ '{' +
	RTRIM(CAST(replace(CONVERT(varchar, facfec, 103) , '/', '')AS VARCHAR(249))) + '{'+
	facnro + '{' +
	ltrim(rtrim(str((k.KarUni  + (karcaj * karartemb))* case when factiptra = 'NCR' THEN -1 else 1 end)))+ '{',
	ltrim(rtrim(str(case when factiptra = 'NCR' THEN karvaltotmendes *-1 ELSE karvaltotmendes END)))
 + '{' + ltrim(rtrim(str(case when factiptra = 'NCR' THEN 1 ELSE 0 END)))+ '{' + ltrim(rtrim(str(case when factiptra = 'NCR' THEN (karpre *(karuni +(karcaj * karartemb)))*-1 ELSE karpre END)))
 + '{A')
from
	KARDEX K
left join articulos a on
	a.artsec = k.artsec
LEFT JOIN InventarioFamilia FF ON
	FF.InvFamCod = A.InvFamCod
LEFT JOIN InventarioSubgrupo SS ON
	SS.InvSubGruCod = FF.InvSubGruCod
LEFT JOIN factura F ON
	F.FACSEC = K.FacSec
left join nit n on
	n.nitsec = f.FacNitSec
LEFT JOIN Vendedores V ON
	V.VenCod = F.FacVenCod
left join nit n2 on
	n2.nitsec = v.VenNitSec
left join Cotizaciones1 ct on
	ct.CotSec = k.FacSecRem
where
	year(facfec)= 2023
	and month(facfec)= 8
	and factiptra in('FDV', 'NCR')
	AND FACEST = 'A'
	and InvGruCod IN('3')
	and facnitsec <> 19519

