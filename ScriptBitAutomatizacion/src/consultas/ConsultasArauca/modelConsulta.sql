--Consulta para optener la fecha
SELECT 

replace(CONVERT(varchar,getdate(),103),'/','') fec,month(getdate()) mon

FROM Empresa;

--barrios 
SELECT
	CONCAT(T1."CiuCod", '{',
T1."CiuNom") as "Barrios"
FROM
	MantisWebEv3.dbo.Ciudad T1

--Sku
SELECT 

RTRIM(LTRIM(ISNULL(CAST(T1.ArtFicTec AS varchar(249)),''))) + '{'+
T1.ArtNom+'{'+'RG'+'{'+
(SELECT TOP 1 PREARTNOM FROM ArtPre AA LEFT JOIN PresentacionArticulos PA ON AA.preartcod=PA.preartcod WHERE AA.ARTSEC=T1.ARTSEC)+'{'+
T1.ArtCod +'{'+
T3.InvGruCod +'{A' 
FROM MantisWebEv3.dbo.Articulos T1
LEFT JOIN MantisWebEv3.dbo.InventarioFamilia T2 ON T2.InvFamCod = T1.InvFamCod 
LEFT JOIN MantisWebEv3.dbo.InventarioSubgrupo T3 ON T3.InvSubGruCod = T2.InvSubGruCod 
Where T3.InvGruCod in ('3')

--Tipo negocio

SELECT 
CONCAT( T1.CanPref,'{',
T1.CanNom 
) 
FROM  MantisWebEv3.dbo.Canales T1



--Vendedores 
SELECT
	T2.NitIde + '{' + v.VenNom + '{ {' + T2.NitIde
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
		t4.FacTipTra = 'FDV'
		AND t4.FacEst = 'A'
		AND YEAR(t4.FacSec) = 2023
			AND MONTH(t4.FacSec)= 3
				AND t4.FacVenCod = V.VenCod
				AND t3.InvGruCod IN ('3'))<> 0

--Clientes

SELECT
	T2.NitIde + '{' + T1.CliNom + '{' + CAST(replace(CONVERT(varchar, CliFecIng, 103), '/', '') as varchar(20)) +
'{' + T2.NitIde + '{' + CAST(RTRIM(replace(REPLACE(REPLACE(substring(clidir, 1, 50) , '|', ' '), ' ', '-'), ' ', '')) as varchar(50)) +
'{' + isnull(T1.CliCiuCod,
	'54001') + '{' + RTRIM(LTRIM(STR(case when T1.tipclicod = 13 then 12 when T1.tipclicod = 15 then 14 else 12 end)))
FROM
	MantisWebEv3.dbo.Clientes T1
LEFT JOIN MantisWebEv3.dbo.Nit T2 on
	T1.NitSec = T2.NitSec
WHERE
	ISNULL((
	SELECT
		SUM(k.karvaltotMenDes)
	FROM
		MantisWebEv3.dbo.Kardex k
	LEFT JOIN MantisWebEv3.dbo.Factura f ON
		f.FacSec = k.FacSec
	WHERE
		f.FacTipTra in ('FDV', 'NCR')
			AND f.FacEst = 'A'
			AND YEAR(f.FacSec) >= 2023
				AND f.FacNitSec = T2.NitSec 
),
	0) <> 0

--Inventario

select

	concat((replace(CONVERT(varchar, getdate(), 11), '/', '')) + '{' +
	RTRIM(replace(RTRIM(LTRIM(ISNULL(CAST(ArtFicTec AS VARCHAR(249)), ''))), ' ', '')) + '{' ,
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
					and month(facfec)<= 5))
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

--ventas
select
CONCAT(
	n.NitIde + '{' +
	n2.NitIde + '{'+
	RTRIM(LTRIM(ISNULL(CAST(ArtFicTec AS VARCHAR(249)), '')))+ '{' +
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
	and month(facfec)= 6
	and factiptra in('FDV', 'NCR')
	AND FACEST = 'A'
	and InvGruCod IN('3')
	and facnitsec <> 19519



--TotalVentas

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
	year(facfec)= 2024
	and month(facfec)= 1
	and factiptra in('FDV', 'NCR')
	AND FACEST = 'A'
	and InvGruCod IN('3')
	and facnitsec <> 19519



SELECT 
a.ArtEmb, k.KarUni , k.KarCaj , k.KarArtEmb , k.KarPre 
FROM 
Articulos a 
inner join Kardex k  on a.ArtSec  = k.ArtSec 

WHERE 

a.ArtFicTec = '61000953'
    


