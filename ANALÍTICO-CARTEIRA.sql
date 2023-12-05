WITH SaldoParcelaPorDATA AS (
    SELECT 
        DATA_INCLUSAO,
        SUM(SALDO_DEVEDOR) AS SALDO,
        SUM(VALOR_PARCELA) AS VALOR_PARCELA 
    FROM TB_BASE(NOLOCK)
    GROUP BY DATA_INCLUSAO
)

SELECT 
    DATA_INCLUSAO AS DATA,
    CASE
        WHEN DIAS_ATRASO BETWEEN 121 AND 180 THEN 'A 121 A 180'
        WHEN DIAS_ATRASO BETWEEN 241 AND 360 THEN 'C 241 A 360'
        WHEN DIAS_ATRASO BETWEEN 421 AND 540 THEN 'E 421 A 540'
        WHEN DIAS_ATRASO > 660 THEN 'G HARCORE >= 661'
        ELSE 'VAZIO'
    END AS FAIXA_ATRASO,
    COUNT(DISTINCT CPF_CNPJ) AS CARTEIRA_#,
    MAX(SaldoParcelaPorDATA.SALDO) AS CARTEIRA_$,
    COUNT(DISTINCT CASE WHEN QUANTIDADE_ACIONAMENTOS_DIA > 0 THEN TRY_CAST(RTRIM(CPF_CNPJ) AS BIGINT) END) AS ACIONAMENTOS_UNIQUE,
    COUNT(DISTINCT CASE WHEN QUANTIDADE_ALO_DIA > 0 THEN TRY_CAST(RTRIM(CPF_CNPJ) AS BIGINT) END) AS ALO_UNIQUE,
    COUNT(DISTINCT CASE WHEN QUANTIDADE_CPC_DIA > 0 THEN TRY_CAST(RTRIM(CPF_CNPJ) AS BIGINT) END) AS CPC_UNIQUE,
    SUM(CASE WHEN QUANTIDADE_ACIONAMENTOS_DIA > 0 THEN 1 ELSE 0 END) AS ACIONAMENTOS,
    SUM(CASE WHEN QUANTIDADE_ALO_DIA > 0 THEN 1 ELSE 0 END) AS ALO,
    SUM(CASE WHEN QUANTIDADE_CPC_DIA > 0 THEN 1 ELSE 0 END) AS CPC,
    COUNT(DISTINCT CASE WHEN QUANTIDADE_ACORDO_DIA > 0 THEN TRY_CAST(RTRIM(CPF_CNPJ) AS BIGINT) END) AS ACORDOS,
    MAX(SaldoParcelaPorDATA.VALOR_PARCELA) AS PARCELA_$,
    COUNT(DISTINCT CASE WHEN QUANTIDADE_PAGAMENTO_ACORDO > 0 THEN TRY_CAST(RTRIM(CPF_CNPJ) AS BIGINT) END) AS ACORDOS_PAGOS   
FROM TB_BASE(NOLOCK)
INNER JOIN (
    SELECT 
        CASE 
            WHEN IDEMP_OEM = 'CODIGO-CARTEIRA' THEN 'NOME-CARTEIRA'
        END AS NOM_CARTEIRA
    FROM TB_BASE2
) AS Subquery ON NOM_CARTEIRA = NOME_CARTEIRA
LEFT JOIN SaldoParcelaPorDATA ON DATA_INCLUSAO = SaldoParcelaPorDATA.DATA_INCLUSAO
WHERE NOME_CARTEIRA = 'INSERIR-NOME'
AND DATA_INCLUSAO BETWEEN '2023-11-01' AND '2023-11-30'
GROUP BY 
    DATA_INCLUSAO,
    CASE
        WHEN DIAS_ATRASO BETWEEN 121 AND 180 THEN 'A 121 A 180'
        WHEN DIAS_ATRASO BETWEEN 241 AND 360 THEN 'C 241 A 360'
        WHEN DIAS_ATRASO BETWEEN 421 AND 540 THEN 'E 421 A 540'
        WHEN DIAS_ATRASO > 660 THEN 'G HARCORE >= 661'
        ELSE 'VAZIO'
    END
ORDER BY 
   DATA_INCLUSAO, FAIXA_ATRASO;
