SELECT
    REPLACE(REPLACE(RTRIM(REPLACE(RTRIM(LTRIM(ISNULL(CAST(T1.ArtCod AS VARCHAR(249)), ''))), '', '')), CHAR(13), ''), CHAR(10), '') + '{' + T1.ArtNom + '{' + 'RG' + '{' + (
        SELECT
            TOP 1 PREARTNOM
        FROM
            ArtPre AA
            LEFT JOIN PresentacionArticulos PA ON AA.preartcod = PA.preartcod
        WHERE
            AA.ARTSEC = T1.ARTSEC
    ) + '{' + T1.ArtCod + '{' + T3.InvGruCod 
FROM
    MantisWebEv3.dbo.Articulos T1
    LEFT JOIN MantisWebEv3.dbo.InventarioFamilia T2 ON T2.InvFamCod = T1.InvFamCod
    LEFT JOIN MantisWebEv3.dbo.InventarioSubgrupo T3 ON T3.InvSubGruCod = T2.InvSubGruCod
Where
    T3.InvGruCod in ('1')