sp_help vw_laboratorio --utilizado para consultar colunas e seus respectivos nomes

SELECT
	SUM([Valor (preço)]) as valor_total,
	[Data da Operação] as data	
FROM VW_LABORATORIO
WHERE [Data da Operação] in ('02052023', '03052023','04052023','05052023',
'08052023','09052023','10052023','11052023','12052023','15052023',
'16052023','17052023','18052023','19052023','22052023','23052023',
'24052023','25052023','26052023','29052023','30052023','31052023') --nesse caso selecionei as datas específicas pois não poderia retornar nenhuma data diferente dessas
GROUP BY [Data da Operação]
