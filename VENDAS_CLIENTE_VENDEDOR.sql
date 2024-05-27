SELECT 
	V.DATA_VEN AS DATA , 
		CASE EXTRACT(MONTH FROM V.DATA_VEN)
			WHEN 1 THEN 'Janeiro'
		        WHEN 2 THEN 'Fevereiro'
		        WHEN 3 THEN 'Março'
		        WHEN 4 THEN 'Abril'
		        WHEN 5 THEN 'Maio'
		        WHEN 6 THEN 'Junho'
		        WHEN 7 THEN 'Julho'
		        WHEN 8 THEN 'Agosto'
		        WHEN 9 THEN 'Setembro'
		        WHEN 10 THEN 'Outubro'
		        WHEN 11 THEN 'Novembro'
		        WHEN 12 THEN 'Dezembro'
			END AS MES , 
	EXTRACT(YEAR FROM V.DATA_VEN) AS ANO , 
	TV.NOME_TPV AS TIPO_VENDA ,
	C.NOME_CLI AS NOME_CLIENTE ,
	SUM(((((IV.QUANT) * IV.VALOR) - coalesce(IV.DESCONTO, 0) + coalesce(IV.ACRESCIMO, 0)) - ((((coalesce(V.DESCONTO_VEN, 0) * 100) / coalesce(((V.TOTAL_VEN + 0.001) + coalesce(V.DESCONTO_VEN, 0)), 1)) * (((IV.QUANT) * IV.VALOR) - coalesce(IV.DESCONTO, 0))) / 100) + ((((coalesce(V.ACRESCIMO_VEN, 0) * 100) / coalesce(((V.TOTAL_VEN + 0.001) - coalesce(V.ACRESCIMO_VEN, 0)), 1)) * (((IV.QUANT) * IV.VALOR) + coalesce(IV.ACRESCIMO, 0))) / 100)))
       		AS TOTAL , 
	VE.NOME_VEND AS VENDEDOR , 
	C.CIDRES_CLI AS CIDADE ,
	PV.COD_PED AS COD_PEDIDO 
FROM VENDAS v 
INNER JOIN ITENS_VENDA iv ON V.COD_VEN = IV.COD_VEN 
LEFT JOIN PEDIDO_VENDA pv ON V.COD_VEN = PV.COD_VEN 
LEFT JOIN TIPO_VENDA tv ON PV.COD_TPV = tv.COD_TPV 
LEFT JOIN CLIENTE c ON pv.COD_CLI = c.COD_CLI 
LEFT JOIN VENDEDOR ve ON PV.COD_VEND = ve.COD_VEND 
WHERE 1=1
AND IV.CANCELADO = 0 AND IV.VENDA_CANCELADA = 0
GROUP BY 1,3,4,5, 7,8,9
