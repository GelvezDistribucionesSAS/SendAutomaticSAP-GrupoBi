SELECT T0."DocEntry", T0."DocNum", T0."DocDate", T0."CardCode", T0."CardName", T0."NumAtCard", T0."DocCur", T0."Comments", T1."Series", T1."SeriesName", T1."InitialNum", T1."LastNum", T1."BeginStr",T1."Remark", T1."EndStr",T0."Address", T0."SlpCode", T0."DocDueDate", T0."LicTradNum",
(SELECT S0."SlpName" FROM {?Schema@}.OSLP S0 WHERE S0."SlpCode" =T0."SlpCode") AS "Vendedor",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."DiscSum"
WHEN T0."DocCur" ='USD' THEN
	T0."DiscSumSy"
ELSE
	T0."DiscSumFC"
END 
AS "DiscSum",

CASE 
WHEN T0."DocCur" ='$' THEN
	T0."WTSum"
WHEN T0."DocCur" ='USD' THEN
	T0."WTSumSC"
ELSE
	T0."WTSumFC"
END 
AS "WTSum",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."DocTotal"
WHEN T0."DocCur" ='USD' THEN
	T0."DocTotalSy"
ELSE
	T0."DocTotalFC"
END 
AS "DocTotal",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."VatSum"
WHEN T0."DocCur" ='USD' THEN
	T0."VatSumSy"
ELSE
	T0."VatSumFC"
END 
AS "VatSum",
(SELECT S0."PymntGroup" FROM {?Schema@}.OCTG S0 WHERE S0."GroupNum" =T0."GroupNum") AS "Forma de pago",
T2."Phone1",


(SELECT T10."TaxbleAmnt" 
FROM INV5 T10 
INNER JOIN
OINV T11
ON
T11."DocEntry" = T10."AbsEntry"
WHERE
T10."WTCode" = 'AV26') AS "Retencion",

T0."WTSum"
FROM {?Schema@}.OINV T0 
INNER JOIN {?Schema@}.NNM1 T1 ON T1."Series"=T0."Series"
INNER JOIN {?Schema@}.OCRD T2 ON T2."CardCode"=T0."CardCode"
WHERE T0."DocEntry" ={?DocKey@}





(SELECT T10."TaxbleAmnt" 
FROM INV5 T10 
WHERE
T10."AbsEntry" = OINV."DocEntry" AND
T10."WTCode" = 'AV26') AS "Retencion",





(SELECT T10."TaxbleAmnt" 
FROM INV5 T10 
INNER JOIN
OINV T11
ON
T11."DocEntry" = T10."AbsEntry"
WHERE
T11."DocEntry" = T0."DocEntry"
AND
T10."WTCode" = 'AV26') AS "Retencion",


























SELECT T0."DocEntry", T0."Printed", T0."DocNum", T0."DocDate", T0."CardCode", T0."CardName", T0."NumAtCard", T0."DocCur", T0."Comments", T1."Series", T1."SeriesName", T1."InitialNum", T1."LastNum", T1."BeginStr",T1."Remark", T1."EndStr",T0."Address", T0."SlpCode", T0."DocDueDate", T0."LicTradNum",
(SELECT S0."SlpName" FROM {?Schema@}.OSLP S0 WHERE S0."SlpCode" =T0."SlpCode") AS "Vendedor",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."DiscSum"
WHEN T0."DocCur" ='USD' THEN
	T0."DiscSumSy"
ELSE
	T0."DiscSumFC"
END 
AS "DiscSum",

CASE 
WHEN T0."DocCur" ='$' THEN
	T0."WTSum"
WHEN T0."DocCur" ='USD' THEN
	T0."WTSumSC"
ELSE
	T0."WTSumFC"
END 
AS "WTSum",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."DocTotal"
WHEN T0."DocCur" ='USD' THEN
	T0."DocTotalSy"
ELSE
	T0."DocTotalFC"
END 
AS "DocTotal",
CASE  
WHEN T0."DocCur" ='$' THEN
	T0."VatSum"
WHEN T0."DocCur" ='USD' THEN
	T0."VatSumSy"
ELSE
	T0."VatSumFC"
END 
AS "VatSum",
(SELECT S0."PymntGroup" FROM {?Schema@}.OCTG S0 WHERE S0."GroupNum" =T0."GroupNum") AS "Forma de pago",
T2."Phone1",
T0."WTSum",
(SELECT T0."TaxbleAmnt" FROM INV5 T0 WHERE T0."AbsEntry" = {?DocKey@} AND  T0."WTCode" = 'AV26') AS "Retención",
( case T2."LicTradNum"
when '13515411-2' then ''
when '900448115-4' then ''
when '901388613-9' then ''
when '1093779674-7' then ''
when '1095836077-1' then ''
when '49555556-3' then ''
when '901248324-5' then ''
when '901248799-1' then ''
when '901293770-8' then ''
else 'CLIENTE NO APLICA PARA DESCUENTO FINANCIERO'
END) AS "FacError"

FROM {?Schema@}.OINV T0 
INNER JOIN {?Schema@}.NNM1 T1 ON T1."Series"=T0."Series"
INNER JOIN {?Schema@}.OCRD T2 ON T2."CardCode"=T0."CardCode"
WHERE T0."DocEntry" ={?DocKey@}















SELECT T0."DocEntry", T0."DocNum", T0."DocDate", T0."CardCode", T0."CardName", T0."NumAtCard", T0."DocCur", T0."Comments", T1."Series", T1."SeriesName", T1."InitialNum", T1."LastNum", T1."BeginStr",T1."Remark", T1."EndStr",T0."Address", T0."SlpCode", T0."DocDueDate", T0."LicTradNum",
(SELECT S0."SlpName" FROM {?Schema@}.OSLP S0 WHERE S0."SlpCode" =T0."SlpCode") AS "Vendedor",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."DiscSum"
WHEN T0."DocCur" ='USD' THEN
	T0."DiscSumSy"
ELSE
	T0."DiscSumFC"
END 
AS "DiscSum",

CASE 
WHEN T0."DocCur" ='$' THEN
	T0."WTSum"
WHEN T0."DocCur" ='USD' THEN
	T0."WTSumSC"
ELSE
	T0."WTSumFC"
END 
AS "WTSum",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."DocTotal"
WHEN T0."DocCur" ='USD' THEN
	T0."DocTotalSy"
ELSE
	T0."DocTotalFC"
END 
AS "DocTotal",
CASE 
WHEN T0."DocCur" ='$' THEN
	T0."VatSum"
WHEN T0."DocCur" ='USD' THEN
	T0."VatSumSy"
ELSE
	T0."VatSumFC"
END 
AS "VatSum",
(SELECT S0."PymntGroup" FROM {?Schema@}.OCTG S0 WHERE S0."GroupNum" =T0."GroupNum") AS "Forma de pago",

(SELECT T10."TaxbleAmnt" FROM {?Schema@}.INV5 T10 
INNER JOIN
 {?Schema@}.OINV T11
ON
T11."DocEntry" = T10."AbsEntry"
WHERE T11."DocEntry" = T10."AbsEntry"
AND
T10."WTCode" = 'AV26') AS "Retencion",

T2."Phone1",
T0."WTSum"
FROM {?Schema@}.OINV T0 
INNER JOIN {?Schema@}.NNM1 T1 ON T1."Series"=T0."Series"
INNER JOIN {?Schema@}.OCRD T2 ON T2."CardCode"=T0."CardCode"
WHERE T0."DocEntry" ={?DocKey@}



(SELECT T10."TaxbleAmnt" 
FROM INV5 T10 
WHERE
T10."AbsEntry" = T0."DocEntry" AND
T10."WTCode" = 'AV26') 
AS "Retencion",

HBTGRANDISTRIBUIDOR

DocNum 1031416
DocEntry 53874
G3Lv3zH4n4$%
Factura de Venta - Final - V4 - Santander