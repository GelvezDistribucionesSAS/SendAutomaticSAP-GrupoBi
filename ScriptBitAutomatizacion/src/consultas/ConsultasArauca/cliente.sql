SELECT DISTINCT 
	T2.NitIde + '{' + T1.CliNom + '{' + CAST(
		replace (CONVERT(varchar, CliFecIng, 103), '/', '') as varchar(20)
	) + '{' + T2.NitIde + '{' + CAST(
		RTRIM (
			replace (
				REPLACE (
					REPLACE (substring(clidir, 1, 50), '|', ' '),
					' ',
					' '
				),
				' ',
				''
			)
		) as varchar(50)
	) + '{SIN REPRESENTANTE' + '{'+ REPLACE(REPLACE(T1.CliTel,'-',''),' ','') +'{'+ isnull (T1.CliCiuCod, '54001') + '{' + RTRIM (
		LTRIM (
			STR (
				T1.TipCliCod
			)
		)
	)
FROM
	MantisWebEv3.dbo.Clientes T1
	LEFT JOIN MantisWebEv3.dbo.Nit T2 on T1.NitSec = T2.NitSec
WHERE
	ISNULL (
		(
			SELECT
				SUM(k.karvaltotMenDes)
			FROM
				MantisWebEv3.dbo.Kardex k
				LEFT JOIN MantisWebEv3.dbo.Factura f ON f.FacSec = k.FacSec
			WHERE
				f.FacTipTra in ('FDV','NCR')
				--AND f.FacEst = 'A'
				AND YEAR (f.FacSec) >= 2022
				--AND MONTH (f.FacSec) >= 4
				AND f.FacNitSec = T2.NitSec
		),
		0
	) <> 0