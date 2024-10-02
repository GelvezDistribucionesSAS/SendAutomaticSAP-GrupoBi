SELECT 
	X1."ReconNum",
	x0."LineSeq",
	X0."ShortName",
	X0."TransId",
	X0."TransRowId",
	X0."ReconSum",
	X0."Account",
	X1."DocNum",
	X1."DocDate",
	X1."DocTotal",
	X1."PaidToDate" as "PagadoHastaLaFecha",
	CASE 
		WHEN X2."TransType" = '13' 
			THEN 'Factura' 
		WHEN X2."TransType" = '24' 
			THEN 'PagoRecibido'
		WHEN X2."TransType" = '14' 
			THEN 'NotaCredito'
		ELSE X2."TransType"
END AS "TipoTrans",
	X2."Memo" as "ComentarioAsiento",
	X1."Memo" as "ComentarioFactura",
	X2."BaseRef" as "NumOrigen"
FROM ITR1 X0
INNER JOIN (
    SELECT
        T0."DocNum",
        T2."ReconNum",
        T0."DocDate",
        T0."CardCode",
        T0."CardName",
        T0."DocTotal",
        T0."PaidToDate",
        T1."BatchNum",
        T1."TransId",
        T1."BaseRef",
        T1."Ref1",
        T1."Ref2",
        T2."LineSeq",
        T2."SrcObjTyp",
        T2."SrcObjAbs",
        T2."IsCredit",
        T1."Memo",
        T0."TransId" AS "TransId_T0"
    FROM OINV T0
    INNER JOIN OJDT T1 ON T0."TransId" = T1."TransId"
    INNER JOIN ITR1 T2 ON T1."TransId" = T2."TransId"
) X1 ON X0."ReconNum" = X1."ReconNum"
INNER JOIN OJDT X2 ON X0."TransId" = X2."TransId"
LEFT JOIN "OUSR" X3 ON X2."UserSign" = X3."INTERNAL_K"