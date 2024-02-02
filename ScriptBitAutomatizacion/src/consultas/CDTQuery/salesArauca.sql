--CONSULTA EN REVISIÓN (NO ESTÁ EN PRODUCTIVO)

SELECT CONCAT(
	'CO','|',
	'{0}','|',
	n2.NitIde,'|',
	n2.NitCom , '|',
	TA.CliDir ,'|',
		n2.NitCom , '|',
		'0','|', 
		V.VenCod , '|',
		v.VenNom , '|',
		a.ArtCod ,'|',
		a.ArtNom , '|',
		--CONVERT(DECIMAL(10,3),(ltrim(rtrim(str(((k.KarUni  + (karcaj * karartemb))/karartemb)* case when factiptra = 'NCR' THEN -1 else 1 end, 10, 3))))) ,'|',
		--ltrim(rtrim(str(case when factiptra = 'NCR' THEN karvaltotmendes *-1 ELSE karvaltotmendes END, 15, 3))) , '|',
		--ltrim(rtrim(str(case when factiptra = 'NCR' THEN karvaltotmendes *-1 ELSE karvaltotmendes END, 15, 3))) , '|',
		--CANTIDAD
		ltrim(rtrim(str((k.KarUni  + (karcaj * karartemb))* case when factiptra = 'NCR' THEN -1 else 1 end))) , '|',
		--Monto neto
		ltrim(rtrim(str(case when factiptra = 'NCR' THEN karvaltotmendes *-1 ELSE karvaltotmendes END))) , '|',
		--Monto Bruto
		ltrim(rtrim(str(case when factiptra = 'NCR' THEN karvaltotmendes *-1 ELSE karvaltotmendes END))) , '|',
		--ltrim(rtrim(str(case when factiptra = 'NCR' THEN (karpre *(karuni +(karcaj * karartemb)))*-1 ELSE karpre END))) , '|',


		'0','|',
		CONVERT(varchar, facfec, 103), '|',
		' ', '|',
		' ', '|',
		TA.CliCiuCod, '|',
		' ','|',
		TA.TipCliCod,'|',
		CONCAT(n.NitIde,'-',n.NitDiv), '|',
		' ', '|',
		' ', '|',
		'{1}', '|',
		' ', '|',
		' ', '|',
		ci.CiuNom, '|',
		b.BarNom , '|',
		tc.TipCliNom 	
		)
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
left join Clientes TA  on TA.NitSec  = n2.NitSec 
left join TipoClientes tc  on TA.TipCliCod  = tc.TipCliCod 
left join Barrio b on TA.BarCod  = b.BarCod 
left join Ciudad ci on TA.CliCiuCod = ci.CiuCod 
where
	year(facfec)= 2023
	and month(facfec)= 10
	and day(facfec) <= 31
		-- Puedes indicar una día en concreto como límite.
	and factiptra in('FDV', 'NCR')
	AND FACEST = 'A'
	and InvGruCod IN('{3}')
	and facnitsec <> 19519