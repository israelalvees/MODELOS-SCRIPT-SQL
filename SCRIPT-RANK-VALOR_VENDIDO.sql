WITH RankedVendedores AS (
    SELECT
        CAST(b.en_codigo AS VARCHAR) AS cod_vendedor,
        b.en_nome AS nome,
        CASE 
            WHEN b.en_codigo IN ('1','2','3','4') THEN 'Supervisor A'
            WHEN b.en_codigo IN ('5','6','7','8') THEN 'Supervisor B'
            ELSE 'Supervisor C'
        END AS supervisor,
        SUM(bv.en_VALTOT) AS valor_vendido,
        DENSE_RANK() OVER (ORDER BY SUM(bv.en_VALTOT) DESC) AS rank_vendas
    FROM
        bi_vended b
    LEFT JOIN bi_vendas bv ON b.en_codigo = bv.en_vendedor 
    WHERE
        CAST(bv.en_datemi AS DATE) BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY
        b.en_codigo, b.en_nome
)

SELECT
    cod_vendedor,
    nome,
    supervisor,
    valor_vendido,
    rank_vendas
FROM
    RankedVendedores
ORDER BY
    valor_vendido DESC;
