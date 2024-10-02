SELECT
	T2.NitIde + '#' + v.VenNom + '# #' + T2.NitIde
FROM
	MantisWebEv3.dbo.Vendedores v
left join MantisWebEv3.dbo.Nit T2 on
	T2.NitSec = v.VenNitSec
WHERE
	(
	SELECT
		sum(k.karvaltotMenDes)
	FROM
		MantisWebEv3.dbo.Kardex k
	LEFT JOIN MantisWebEv3.dbo.Articulos t1 on
		t1.ArtSec = k.ArtSec
	LEFT JOIN MantisWebEv3.dbo.InventarioFamilia t2 on
		t2.InvFamCod = t1.InvFamCod
	LEFT JOIN MantisWebEv3.dbo.InventarioSubgrupo t3 on
		t3.InvSubGruCod = t2.InvSubGruCod
	LEFT JOIN MantisWebEv3.dbo.Factura t4 on
		t4.FacSec = k.FacSec
	WHERE
		t4.FacTipTra in ('FDV','NCR')
		AND t4.FacEst = 'A'
		AND year(facfec)= 2024 AND month(facfec) = 8--{1}
				AND t4.FacVenCod = V.VenCod
				AND t3.InvGruCod IN ('{0}'))<> 0