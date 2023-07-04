<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>
    
SELECT
    E.PRO_CODI AS CODIGO_PRODUTO,
    P.PRO_DESC AS DESCRICAO,
    ROUND(E.EST_QUAN / (SUM(F.QUANTIDADE) / 6), 0) AS TEMPO_ESTOQUE, --valor dividido pelo (sum(f.quantidade) deve ser alterado de acordo com quantidade de meses
    P.FOR_CODI AS FORNECEDOR,
    P.SEC_CODI AS SECAO
FROM ESTOQUE E
INNER JOIN VW_FATURAMENTO_DETALHADO F ON E.PRO_CODI = F.CODIGO_PRODUTO
INNER JOIN PRODUTO P ON E.PRO_CODI = P.PRO_CODI
WHERE F.DATA BETWEEN '01-01-2023' AND '30-06-2023' --período deve ser alterado mês a mês
    --AND P.FOR_CODI = '00940' --filtrar por fornecedor específico
GROUP BY E.PRO_CODI, P.PRO_DESC, P.FOR_CODI, P.SEC_CODI, E.EST_QUAN
ORDER BY P.PRO_DESC, TEMPO_ESTOQUE 
