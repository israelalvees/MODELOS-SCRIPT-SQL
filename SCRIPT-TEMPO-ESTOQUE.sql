
SELECT CODIGO_PRODUTO, DESCRICAO, ESTOQUE_ATUAL, TEMPO_ESTOQUE, FORNECEDOR, SECAO, QUANTIDADE_VENDIDA
FROM (
    -- Subconsulta para realizar o cálculo do tempo de estoque e quantidade vendida para cada produto
    SELECT E.PRO_CODI AS CODIGO_PRODUTO,
           P.PRO_DESC AS DESCRICAO,
           E.EST_QUAN AS ESTOQUE_ATUAL,
           CASE 
               WHEN F.SUM_QUANTIDADE = 0 THEN NULL 
               ELSE ROUND(E.EST_QUAN / (F.SUM_QUANTIDADE / 6), 0) 
           END AS TEMPO_ESTOQUE,
           P.FOR_CODI AS FORNECEDOR,
           P.SEC_CODI AS SECAO,
           (
               SELECT SUM(QUANTIDADE) 
               FROM VW_FATURAMENTO_DETALHADO 
               WHERE CODIGO_PRODUTO = E.PRO_CODI 
                     AND DATA BETWEEN '01-01-2023' AND '30-06-2023'
           ) AS QUANTIDADE_VENDIDA,
           ROW_NUMBER() OVER (PARTITION BY E.PRO_CODI ORDER BY E.PRO_CODI) AS RowNum
    FROM ESTOQUE E
    INNER JOIN PRODUTO P ON E.PRO_CODI = P.PRO_CODI
    INNER JOIN (
        -- Subconsulta para calcular a quantidade média vendida por semana para cada produto no período desejado
        SELECT CODIGO_PRODUTO, SUM(QUANTIDADE) AS SUM_QUANTIDADE
        FROM VW_FATURAMENTO_DETALHADO
        WHERE DATA BETWEEN '01-01-2023' AND '30-06-2023'
        GROUP BY CODIGO_PRODUTO
    ) F ON E.PRO_CODI = F.CODIGO_PRODUTO
    WHERE P.FOR_CODI = '00940' --filtro por fornecedor específico
) T
WHERE RowNum = 1
ORDER BY DESCRICAO, TEMPO_ESTOQUE;

