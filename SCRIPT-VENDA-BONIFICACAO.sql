SELECT
  COD_CLIENTE_GERAL,
  CLIENTE_GERAL,
  --FILTRAGEM PARA RETORNAR QUANTIDADE E VALOR POR NATUREZA
  SUM(CASE WHEN NATUREZA = 'VEN' THEN QUANTIDADE ELSE 0 END) AS QUANTIDADE_VENDA,
  SUM(CASE WHEN NATUREZA = 'BOV' THEN QUANTIDADE ELSE 0 END) AS QUANTIDADE_BONIFICACAO,
  SUM(CASE WHEN NATUREZA = 'VEN' THEN VALOR_TOTAL ELSE 0 END) AS VALOR_TOTAL_VENDA,
  SUM(CASE WHEN NATUREZA = 'BOV' THEN VALOR_TOTAL ELSE 0 END) AS VALOR_TOTAL_BONIFICACAO
FROM VW_FATURAMENTO_DETALHADO
WHERE FOR_CODI = '00262' --FILTRO POR FORNECEDOR
  AND LOCALIZACAO = '001' --FILTRO POR FILIAL
  AND CONVERT(DATE, DATA, 103) BETWEEN '2023-06-01' AND '2023-06-30'  --UTILIZADO PARA CONVERTER DATAS PARA MESMO FORMATO
  AND NATUREZA IN ('VEN', 'BOV') --TRAZER SOMENTE AS NATUREZAS DE VENDA E BONIFICAÇÃO
  AND CODIGO_PRODUTO = '1880' --FILTRO POR PRODUTO, UTILIZANDO O CÓDIGO
GROUP BY COD_CLIENTE_GERAL, CLIENTE_GERAL
ORDER BY COD_CLIENTE_GERAL;