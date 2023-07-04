--QUESTÃO 1
--Apresente a query para listar o código e o nome do vendedor com maior número de vendas (contagem), e que estas vendas estejam com o status concluída. As colunas presentes no 
--resultado devem ser, portanto, codigovendedor (cdvdd) e nomevendedor (nmvdd).

SELECT 	v.codigovendedor,
		TRIM(c.nomevendedor) AS nomevendedor
FROM dw.fato_vendas v
INNER JOIN dw.dim_vendedor c on v.codigovendedor = c.codigovendedor
WHERE v.codigostatusvenda = '1'
GROUP BY v.codigovendedor , c.nomevendedor
ORDER BY COUNT(*) DESC
LIMIT 1

--QUESTÃO 2
--Apresente a query para listar o código e nome do produto mais vendido entre as datas de 2014-02-03 até 2018-02-02. As colunas presentes no resultado 
--devem ser codigoproduto (cdpro) e nomeproduto (nmpro).

--alterei o order by para soma de quantidade, deixei comentado a maneira anterior
SELECT 	v.codigoproduto,
		p.nomeproduto
FROM dw.fato_vendas v
INNER JOIN dw.dim_produto p on v.codigoproduto = p.codigoproduto
WHERE v.datavenda BETWEEN '2014-02-03' AND '2018-02-02' 
--AND v.quantidadevendas > 0
AND v.codigostatusvenda = '1'
GROUP BY v.codigoproduto , p.nomeproduto, v.quantidadevendas
ORDER BY SUM(v.quantidadevendas) DESC
LIMIT 1

--QUESTAO 3
--Apresente a query para listar o código e nome cliente com maior gasto na loja. As colunas presentes no resultado devem ser codigocliente (cdcli), 
--nomecliente (nmcli) e gasto, esta última representando o somatório das vendas atribuídas ao cliente.

SELECT 	v.codigocliente,
		c.nomecliente,
		SUM ((v.quantidadevendas * v.valorunitariovenda)) AS gasto
FROM dw.fato_vendas v
INNER JOIN dw.dim_cliente c on v.codigocliente = c.codigocliente
WHERE v.codigostatusvenda = '1'
GROUP BY v.codigocliente , c.nomecliente
ORDER BY gasto DESC
LIMIT 1

--QUESTÃO 4
--Apresente a query para listar código, nome e data de nascimento dos dependentes do vendedor
--com menor valor total bruto em vendas (não sendo zero). As colunas presentes no resultado
--devem ser codigodependente (cddep), nomedependente (nmdep), datanascimento (dtnasc).	

SELECT 	d.codigodependente,
		d.nomedependente,
		d.datanascimentodependente		
FROM dw.dim_dependente d
INNER JOIN dw.fato_vendas v on d.codigovendedor = v.codigovendedor
AND v.codigostatusvenda = '1'
GROUP BY d.codigodependente,
		d.nomedependente,
		d.datanascimentodependente,
		v.quantidadevendas,
		v.valorunitariovenda
ORDER BY v.quantidadevendas * v.valorunitariovenda ASC
LIMIT 1		

--QUESTÃO 5
--Apresente a query para listar os 3 produtos menos vendidos pelos canais de E-Commerce ou
--Matriz. As colunas presentes no resultado devem ser canalvendas (canal), codigoproduto
--(cdpro), nomeproduto (nmpro) e quantidade_vendas.


SELECT 	
	CASE
	WHEN v.codigocanal = '1' THEN 'E-Commerce'
	ELSE 'Matriz' 
	END AS Canal,
		v.codigoproduto,
		p.nomeproduto,
		v.quantidadevendas
FROM dw.fato_vendas v
INNER JOIN dw.dim_produto p on v.codigoproduto = p.codigoproduto
WHERE v.quantidadevendas > 0
AND v.codigostatusvenda = '1'
GROUP BY v.codigoproduto , p.nomeproduto, v.quantidadevendas, v.codigocanal
ORDER BY v.quantidadevendas ASC
LIMIT 3

--QUESTÃO 6
--Apresente a query para listar o gasto médio por estado da federação. As colunas presentes no
--resultado devem ser estado e gastomedio. Considere apresentar a coluna gastomedio
--arredondada na segunda casa decimal.	

SELECT 	c.estadocliente,
	ROUND(AVG ((v.quantidadevendas * v.valorunitariovenda)),2) AS gastomedio
FROM dw.fato_vendas v
INNER JOIN dw.dim_cliente c on v.codigocliente = c.codigocliente
WHERE v.codigostatusvenda = '1'
GROUP BY c.estadocliente
ORDER BY gastomedio DESC

--QUESTÃO 7
--Apresente a query para listar o código das vendas (cdven) identificadas como deletadas.
--Apresente o resultado em ordem crescente.

SELECT DISTINCT
v.codigovenda,
v.deletado 
FROM dw.fato_vendas v
WHERE v.deletado = '1'
ORDER BY v.codigovenda ASC

--QUESTÃO 8
--Apresente a query para listar a quantidade média vendida de cada produto agrupado por estado
--da federação. As colunas presentes no resultado devem ser estado e nomeproduto (nmprod) e
--quantidade_media. Considere arredondar o valor da coluna quantidade_media na quarta casa
--decimal. Ordene os resultados pelo estado (1º) e nome do produto (2º).

SELECT 	c.estadocliente AS estado,
	p.nomeproduto,
	ROUND(AVG (v.quantidadevendas),4) AS quantidade_media
FROM dw.fato_vendas v
INNER JOIN dw.dim_cliente c on v.codigocliente = c.codigocliente
INNER JOIN dw.dim_produto p on v.codigoproduto = p.codigoproduto
WHERE v.codigostatusvenda = '1'
GROUP BY c.estadocliente, p.nomeproduto
ORDER BY c.estadocliente, p.nomeproduto

--QUESTÃO 9
--Calcule a receita bruta por ano.

SELECT 	d.ano,
		SUM ((v.quantidadevendas * v.valorunitariovenda)) AS receitabruta 		
FROM dw.fato_vendas	v
INNER JOIN dw.dim_data d ON v.datavenda = d.data
GROUP BY d.ano
ORDER BY d.ano ASC

--QUESTÃO 10
--Calcule a receita bruta por ano e por estado.


--inclui um filtro para status de venda, onde pode ser considerado como faturamento bruto somente status 1
--ou tudo que não estiver com status 3(cancelado)
SELECT 	d.ano,
		c.estadocliente,
		SUM ((v.quantidadevendas * v.valorunitariovenda)) AS receitabruta 		
FROM dw.fato_vendas	v
INNER JOIN dw.dim_data d ON v.datavenda = d.data
INNER JOIN dw.dim_cliente c ON v.codigocliente = c.codigocliente
WHERE v.codigostatusvenda = '1'
--WHERE v.codigostatusvenda <> '3'
GROUP BY d.ano, c.estadocliente
ORDER BY d.ano ASC

--QUESTÃO 11 
--Proponha um indicador.
	
--indicador apresenta classificação por vendedor, constando produtos vendidos, quantidade de itens e valor total deles
--pode-se ainda filtrar por data, algum período específico

SELECT 
	c.codigovendedor,
	TRIM(c.nomevendedor) AS nomevendedor,
	p.nomeproduto,
	SUM(v.quantidadevendas) AS quantidadevendidaproduto,
	SUM((v.quantidadevendas * v.valorunitariovenda)) AS valortotalproduto
FROM dw.fato_vendas v
INNER JOIN dw.dim_vendedor c ON c.codigovendedor = v.codigovendedor
INNER JOIN dw.dim_produto p ON p.codigoproduto = v.codigoproduto
WHERE v.codigostatusvenda = '1'
--AND fato_vendas.datavenda BETWEEN '2014-02-03' AND '2018-02-02'
GROUP BY c.codigovendedor, c.nomevendedor, p.nomeproduto
ORDER BY c.codigovendedor ASC, valortotalproduto DESC, quantidadevendidaproduto DESC

--exemplo de como seria para mostrar somente o produto mais vendido, ao invés de todos
--aqui fiz pela curiosidade, pesquisei no google e achei essa função row number
--precisei de uma ajuda significativa pois essa função nunca tinha visto
SELECT codigovendedor, nomevendedor, nomeproduto, quantidadevendidaproduto, valortotalproduto
FROM (
    SELECT
        c.codigovendedor,
        TRIM(c.nomevendedor) AS nomevendedor,
        p.nomeproduto,
        SUM(v.quantidadevendas) AS quantidadevendidaproduto,
        SUM((v.quantidadevendas * v.valorunitariovenda)) AS valortotalproduto,
        ROW_NUMBER() OVER (PARTITION BY c.codigovendedor ORDER BY SUM(v.quantidadevendas) DESC) AS rn
    FROM dw.fato_vendas v
    INNER JOIN dw.dim_vendedor c ON c.codigovendedor = v.codigovendedor
    INNER JOIN dw.dim_produto p ON p.codigoproduto = v.codigoproduto
    WHERE v.codigostatusvenda = '1'
    --AND fato_vendas.datavenda BETWEEN '2014-02-03' AND '2018-02-02'
    GROUP BY c.codigovendedor, c.nomevendedor, p.nomeproduto
) AS subquery
WHERE rn = 1
ORDER BY codigovendedor ASC, valortotalproduto DESC, quantidadevendidaproduto DESC

--QUESTÃO 13
--Mostre o nome do vendedor, sem espaço na frente, e a quantidade de dependentes (usando subselect)


SELECT 
TRIM(v.nomevendedor) AS nomevendedor,
	(SELECT 
	 	COUNT(d.codigodependente) 
	 FROM dw.dim_dependente d
	 WHERE d.codigovendedor = v.codigovendedor) AS quantidadedependentes
FROM dw.dim_vendedor v
WHERE v.codigovendedor IN (SELECT codigovendedor FROM dw.dim_dependente)
GROUP BY v.codigovendedor, v.nomevendedor
ORDER BY codigovendedor ASC

--apresentando todos os vendedores, tendo dependentes ou não
SELECT 
	TRIM(v.nomevendedor) AS nomevendedor,
       (SELECT COUNT(d.codigodependente)
        FROM dw.dim_dependente d
        WHERE d.codigovendedor = v.codigovendedor) AS quantidadedependentes
FROM dw.dim_vendedor v
WHERE v.codigovendedor IN (SELECT codigovendedor FROM dw.dim_dependente)
   OR v.codigovendedor NOT IN (SELECT codigovendedor FROM dw.dim_dependente)
      AND v.nomevendedor IS NOT NULL
ORDER BY v.codigovendedor ASC


--QUESTAO EXTRA
--A comissão de um vendedor é definida a partir de um percentual sobre o total de vendas (quantidade * valor unitário) por ele realizado.
--O percentual de comissão de cada vendedor está armazenado na coluna perccomissao, tabela dim_vendedor.
--Com base em tais informações, calcule a comissão de todos os vendedores, considerando todas as vendas armazenadas na base de dados.
--As colunas presentes no resultado devem ser vendedor, valor_total_vendas, percentualcomissao e comissao. 
--O valor de comissão deve ser apresentado em ordem decrescente arredondado na segundacasa decimal.
	
--deixei comentado o filtro de status de venda pois entendi que eram todas as vendas da base indiferente do status dela
--caso sejam só as com status concluido, só descomentar a linha
SELECT 
	TRIM(c.nomevendedor) AS vendedor,
	SUM((v.quantidadevendas * v.valorunitariovenda)) AS valor_total_vendas,
	c.percentualcomissão,
	ROUND(SUM(v.quantidadevendas * v.valorunitariovenda * (c.percentualcomissão / 100)), 2) AS comissao
FROM dw.fato_vendas v
INNER JOIN dw.dim_vendedor c ON c.codigovendedor = v.codigovendedor
INNER JOIN dw.dim_produto p ON p.codigoproduto = v.codigoproduto
--WHERE v.codigostatusvenda = '1'
GROUP BY c.codigovendedor, c.nomevendedor, c.percentualcomissão
ORDER BY comissao DESC 

--exemplos mostrando todos os vendedores, mesmo que não exista valor vendido
SELECT 
    TRIM(c.nomevendedor) AS vendedor,
    SUM((v.quantidadevendas * v.valorunitariovenda)) AS valor_total_vendas,
    c.percentualcomissão,
    ROUND(SUM(v.quantidadevendas * v.valorunitariovenda * (c.percentualcomissão / 100)), 2) AS comissao
FROM dw.dim_vendedor c
INNER JOIN dw.fato_vendas v ON c.codigovendedor = v.codigovendedor --AND v.codigostatusvenda = '1'
GROUP BY c.codigovendedor, c.nomevendedor, c.percentualcomissão

UNION ALL

SELECT 
    TRIM(c.nomevendedor) AS vendedor,
    0 AS valor_total_vendas,
    c.percentualcomissão,
    0 AS comissao
FROM dw.dim_vendedor c
WHERE c.codigovendedor NOT IN (SELECT codigovendedor FROM dw.fato_vendas) --WHERE codigostatusvenda = '1')
AND c.nomevendedor IS NOT NULL
ORDER BY comissao DESC





