SELECT
    IFNULL(T2."AcctCode", '') AS "Cuenta Contable",
    IFNULL(T2."AcctName", '') AS "Nombre Cuenta Contable",
    T6."CardCode" AS "Codigo SN",
    T6."CardName"  AS "Nombre SN",
    T7."LicTradNum" AS "NIT",
    IFNULL(T3."PrjName", '') AS "Nombre Proyecto",
    T4."SeriesName" AS "Serie",
    T0."TransId" AS "No. Transaccion",
    T0."BaseRef" AS "No. Origen",
    CASE 
    WHEN T0."TransType" = '10000071' THEN 'Contabilización de Stocks'
    WHEN T0."TransType" = '13' THEN 'Factura de Deudores'
    WHEN T0."TransType" = '14' THEN 'Notas Credito Clientes'
    WHEN T0."TransType" = '15' THEN 'Entregas'
    WHEN T0."TransType" = '16' THEN 'Devolución'
    WHEN T0."TransType" = '18' THEN 'Notas Debito Proveedores'
    WHEN T0."TransType" = '19' THEN 'Notas Credito Proveedores'
    WHEN T0."TransType" = '20' THEN 'Entrada de Mercancias'
    WHEN T0."TransType" = '24' THEN 'Pagos Recibidos'
    WHEN T0."TransType" = '321' THEN 'Reconciliación'
    WHEN T0."TransType" = '46' THEN 'Pagos Efectuados'
    WHEN T0."TransType" = '59' THEN 'Recibo de Producción'
    WHEN T0."TransType" = '60' THEN 'Emisión para Producción'
    WHEN T0."TransType" = '67' THEN 'Transferencia de Stock'
    ELSE T0."Memo"
    END AS "Tipo Origen (Documento)",
    T0."Ref1" AS "Referencia 1",
    T0."Ref2" AS "Referencia 2",
    T1."Debit" AS "Debito",
    T1."Credit" AS "Credito",
    T0."Ref3" AS "Referencia 3",
    T0."Memo" AS "Comentarios",
    T0."RefDate" AS "Fecha Contabilización",
    T0."DueDate" AS "Fecha Vencimiento",
    T0."TaxDate" AS "Fecha Documento",
    T0."Project" AS "Proyecto",
    T1."ProfitCode" AS "Sede",
    T1."OcrCode2" As "Centro de Costo",
    T5."U_NAME" AS "Usuario",
    T6."U_GD_Ruteros" AS "Ruteros",
     T6."JrnlMemo" AS "Comentario PR"
FROM
    OJDT T0
    INNER JOIN JDT1 T1 ON T0."TransId" = T1."TransId"
    INNER JOIN OACT T2 ON T1."Account" = T2."AcctCode"
    LEFT JOIN OPRJ T3 ON T0."Project" = T3."PrjCode"
    INNER JOIN NNM1 T4 ON T0."Series" = T4."Series"
    LEFT JOIN OUSR T5 ON T0."UserSign" = T5."USERID"
    INNER JOIN ORCT T6 ON T0."BaseRef" = T6."DocNum"
    INNER JOIN OCRD T7 ON T6."CardCode" = T7."CardCode"
WHERE
    T0."RefDate" BETWEEN '[%0]' AND '[%1]'
    AND T1."ShortName" = '11050501'
ORDER BY T0."TransId"



SELECT
T0."DocNum" AS "Factura",
T0."DocStatus" AS "Estado",
(SELECT TA."PymntGroup" FROM OCTG TA WHERE TA."GroupNum" = T5."GroupNum") AS "CondicionPago"
FROM
OINV T0
INNER JOIN
	"OCRD" T5
		ON T0."CardCode" = T5."CardCode"
WHERE
    T0."DocDate" BETWEEN '[%0]' AND '[%1]'


	(SELECT TA."PymntGroup" FROM OCTG TA WHERE TA."GroupNum" = T5."GroupNum") AS "CondicionPago",




	_____________________




SELECT
T4."SeriesName" AS "SerieDocumento",
T0."DocNum" AS "Factura",
T0."DocDate" AS "Fecha",
CASE
WHEN T0."DocStatus" = 'C'
THEN 'CERRADO'
ELSE 'ABIERTO' 
END AS "Estado",
(SELECT TA."PymntGroup" FROM OCTG TA WHERE TA."GroupNum" = T5."GroupNum") AS "CondicionPago"
FROM
OINV T0
INNER JOIN
	"OCRD" T5
		ON T0."CardCode" = T5."CardCode"
INNER JOIN
	"NNM1" T4
		ON T0."Series" = T4."Series"
WHERE
    T0."DocDate" BETWEEN '[%0]' AND '[%1]'