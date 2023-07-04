
-- Seleciona o código do produto, descrição, tempo de estoque, fornecedor e seção do estoque
SELECT CODIGO_PRODUTO, DESCRICAO, TEMPO_ESTOQUE, FORNECEDOR, SECAO
FROM (
    -- Subconsulta para realizar o cálculo do tempo de estoque para cada produto
    SELECT E.PRO_CODI AS CODIGO_PRODUTO,
           P.PRO_DESC AS DESCRICAO,
           ROUND(E.EST_QUAN / (F.SUM_QUANTIDADE / 6), 0) AS TEMPO_ESTOQUE,
           P.FOR_CODI AS FORNECEDOR,
           P.SEC_CODI AS SECAO,
           ROW_NUMBER() OVER (PARTITION BY E.PRO_CODI ORDER BY E.PRO_CODI) AS RowNum
    FROM ESTOQUE E
    INNER JOIN PRODUTO P ON E.PRO_CODI = P.PRO_CODI
    INNER JOIN (
        -- Subconsulta para calcular a quantidade média vendida por semana para cada produto no período desejado
        SELECT CODIGO_PRODUTO, SUM(QUANTIDADE) AS SUM_QUANTIDADE
        FROM VW_FATURAMENTO_DETALHADO
        WHERE DATA BETWEEN '2023-01-01' AND '2023-06-30'
        GROUP BY CODIGO_PRODUTO
    ) F ON E.PRO_CODI = F.CODIGO_PRODUTO
    WHERE P.FOR_CODI = '00940'
) T
WHERE RowNum = 1
ORDER BY DESCRICAO, TEMPO_ESTOQUE

