select
	ISNULL(sum(case when factiptra = 'NCR' THEN karvaltotmendes *-1 ELSE karvaltotmendes END),
	0) valor
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
