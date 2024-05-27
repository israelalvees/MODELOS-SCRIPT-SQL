SELECT 
	V.COD_VEN AS ID_VENDA , 
	V.DATA_VEN AS DATA , 
	IV.COD_PRO ,
	IV.NOME_PRODUTO ,
	SUM((IV.QUANT - coalesce(IV.QUANT_TROCA, 0))) AS QUANT ,
	SUM(((((IV.QUANT) * IV.VALOR) - coalesce(IV.DESCONTO, 0) + coalesce(IV.ACRESCIMO, 0)) - ((((coalesce(V.DESCONTO_VEN, 0) * 100) / coalesce(((V.TOTAL_VEN + 0.001) + coalesce(V.DESCONTO_VEN, 0)), 1)) * (((IV.QUANT) * IV.VALOR) - coalesce(IV.DESCONTO, 0))) / 100) + ((((coalesce(V.ACRESCIMO_VEN, 0) * 100) / coalesce(((V.TOTAL_VEN + 0.001) - coalesce(V.ACRESCIMO_VEN, 0)), 1)) * (((IV.QUANT) * IV.VALOR) + coalesce(IV.ACRESCIMO, 0))) / 100)))
       AS TOTAL , 
    SUM(IV.VALOR_CUSTO * (IV.QUANT - COALESCE(IV.QUANT_TROCA, 0))) AS  VALOR_CUSTO ,
    V.COD_VEND ,
    SG.DESCRICAO AS SUBCAT ,
    S.NOME_SEC AS SECAO , 
	    CASE 	
			WHEN s.NOME_SEC = 'PEIXES' THEN 'PEIXES'
			WHEN s.NOME_SEC = 'EMBUTIDOS E INDUSTRIALIZADOS' THEN 'EMBUTIDOS'
			WHEN s.NOME_SEC = 'BOVINAS' THEN 'BOVINAS'
			WHEN s.NOME_SEC = 'AVES' THEN 'AVES'
			WHEN s.NOME_SEC = 'SUINOS' THEN 'SUINOS' ELSE 'OUTROS'
		END AS SECAO_PART , 
	TV.NOME_TPV AS TIPO_VENDA ,
	C.CIDRES_CLI AS CIDADE ,
	VE.NOME_VEND AS VENDEDOR
FROM VENDAS v 
INNER JOIN ITENS_VENDA iv ON V.COD_VEN = IV.COD_VEN 
LEFT JOIN PRODUTO p ON P.COD_PRO = IV.COD_PRO 
INNER JOIN SECAO S on P.COD_SEC = S.COD_SEC
LEFT JOIN SECAO_GRUPO SG on P.COD_SEC = SG.COD_SEC and P.COD_GRUPO = SG.COD_GRUPO
LEFT JOIN PEDIDO_VENDA pv ON V.COD_VEN = PV.COD_VEN 
LEFT JOIN TIPO_VENDA tv ON PV.COD_TPV = tv.COD_TPV 
LEFT JOIN CLIENTE c ON pv.COD_CLI = c.COD_CLI 
LEFT JOIN VENDEDOR ve ON PV.COD_VEND = ve.COD_VEND 
WHERE 1=1
AND IV.CANCELADO = 0 AND IV.VENDA_CANCELADA = 0
GROUP BY 1,2,3,4,8,9,10,12,13,14
