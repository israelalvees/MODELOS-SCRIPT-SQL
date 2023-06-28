--Modelo de script para criação de view de quantidade de estoque atual


CREATE VIEW VW_ESTOQUE_ATUAL AS
SELECT 
P.PRO_CODI AS CODIGO_PRODUTO, 
P.PRO_DESC AS DESCRICAO_PRODUTO,
E.EST_QUAN AS QUANTIDADE_ESTOQUE,
P.FOR_CODI AS CODIGO_FORNECEDOR, --inclusão permite filtrar por fornecedor
P.SEC_CODI AS SECAO --inclusão permite filtrar por secao/tipo de produto
FROM ESTOQUE E
INNER JOIN PRODUTO P ON E.PRO_CODI = P.PRO_CODI
INNER JOIN FORNECEDOR F ON P.FOR_CODI = F.FOR_CODI
INNER JOIN TBCUSTOMATE C ON P.PRO_CODI = C.MAT_CODI
WHERE E.LOC_CODI = '001' --localização do estoque, permite filtrar por loja ou sede
AND P.DPT_CODI = '001'  --departamento do produto
AND P.PRO_SITU = 'A' --situação do produto, ativo ou inativo
AND C.LOC_CODI = '001'
GROUP BY P.PRO_CODI, P.PRO_DESC, E.EST_QUAN, P.FOR_CODI, P.SEC_CODI


