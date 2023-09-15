SELECT 
    CODIGO_PRODUTO,
    PRODUTO,
    COALESCE(SUM(CASE WHEN CONVERT(DATE, DATA, 103) BETWEEN '2023-09-01' AND '2023-09-30' THEN QUANTIDADE END), 0) AS QUANTIDADE,
    COALESCE(
        CAST(
            (
                SELECT SUM(QUANTIDADE) / 3
                FROM VW_FATURAMENTO_DETALHADO AS SubQuery
                WHERE CONVERT(DATE, DATA, 103) BETWEEN '2023-06-01' AND '2023-08-31'
                AND NATUREZA = 'VEN'
                AND SubQuery.CODIGO_PRODUTO = VW_FATURAMENTO_DETALHADO.CODIGO_PRODUTO
            ) AS INT
        ), 0
    ) AS MEDIA_ULTIMO_TRIMESTRE,  
    COALESCE(
        CAST(
            (
                ((SUM(CASE WHEN CONVERT(DATE, DATA, 103) BETWEEN '2023-09-01' AND '2023-09-30' THEN QUANTIDADE END) - 
                COALESCE(
                    CAST(
                        (
                            SELECT SUM(QUANTIDADE) / 3
                            FROM VW_FATURAMENTO_DETALHADO AS SubQuery
                            WHERE CONVERT(DATE, DATA, 103) BETWEEN '2023-06-01' AND '2023-08-31'
                            AND NATUREZA = 'VEN'
                            AND SubQuery.CODIGO_PRODUTO = VW_FATURAMENTO_DETALHADO.CODIGO_PRODUTO
                        ) AS INT
                    ), 0
                )) / NULLIF(
                    COALESCE(
                        CAST(
                            (
                                SELECT SUM(QUANTIDADE) / 3
                                FROM VW_FATURAMENTO_DETALHADO AS SubQuery
                                WHERE CONVERT(DATE, DATA, 103) BETWEEN '2023-06-01' AND '2023-08-31'
                                AND NATUREZA = 'VEN'
                                AND SubQuery.CODIGO_PRODUTO = VW_FATURAMENTO_DETALHADO.CODIGO_PRODUTO
                            ) AS INT
                        ), 0
                    ), 0
                )) * 100
            ) AS INT
        ), 0
    ) AS CRESCIMENTO_RELATIVO,
    FOR_CODI, 
    FORNECEDOR
FROM VW_FATURAMENTO_DETALHADO
WHERE LOCALIZACAO = '001'
AND FOR_CODI = 940
AND NATUREZA = 'VEN'
GROUP BY CODIGO_PRODUTO, PRODUTO, FOR_CODI, FORNECEDOR
ORDER BY PRODUTO
