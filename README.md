## MODELOS-SCRIPT-SQL

    - Modelos variados que são utilizados no dia a dia por uma Analista de Dados. 

## SCRIPT TEMPO DE ESTOQUE

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Script SQL para calcular o tempo de estoque de produtos
- Esta consulta retorna informações sobre produtos, incluindo o tempo estimado de estoque.
- O tempo de estoque é calculado dividindo a quantidade disponível no estoque pela quantidade média vendida por semana no período desejado.
- ROW_NUMBER() utilizado para atribuir um número sequencial a cada linha agrupada pelo código do produto (E.PRO_CODI). A cláusula PARTITION BY E.PRO_CODI garante que o número sequencial seja reiniciado para cada código de produto diferente.
- Documentação:
	- CODIGO_PRODUTO: Código do produto presente na tabela ESTOQUE e PRODUTO.
	- DESCRICAO: Descrição do produto, presente na tabela PRODUTO.
	- ESTOQUE_ATUAL: Quantidade atual em estoque do produto, presente na tabela ESTOQUE.
	- TEMPO_ESTOQUE: Tempo estimado de estoque do produto, calculado na subconsulta interna.
	- FORNECEDOR: Código do fornecedor do produto, presente na tabela PRODUTO.
	- SECAO: Código da seção do produto, presente na tabela PRODUTO.
	- QUANTIDADE_VENDIDA: Quantidade total vendida do produto no período selecionado ('2023-01-01' a '2023-06-30'), calculada na subconsulta externa.
	- RowNum: Número de linha usado para selecionar apenas o primeiro registro de cada produto.

## SCRIPT GIRO ESTOQUE VALOR
<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

### Documentação: 

Este script SQL é projetado para recuperar informações sobre produtos, seus níveis de estoque e atividade de vendas durante um determinado período. Ele utiliza funções agregadas e subconsultas para calcular e apresentar as informações relevantes em relação aos produtos.

#### Colunas Selecionadas

1. **PRO_CODI**: O código único que identifica cada produto.
2. **PRO_DESC**: A descrição do produto.
3. **GIRO_FEV_JUL**: O total de quantidades vendidas para o produto durante o período de 01/02/2023 a 31/07/2023, obtido por meio de uma subconsulta.
4. **EST_QUAN**: A quantidade disponível do produto em estoque.
5. **ESTOQUE_VALOR**: O valor total do estoque do produto, calculado multiplicando o preço unitário do produto (`TAB_PRC1`) pela quantidade em estoque.

#### Funcionalidades das Funções Agregadas

1. **SUM(VP.TAB_PRC1 * E.EST_QUAN)**: Esta função de agregação calcula o valor total do estoque para cada produto, multiplicando o preço unitário do produto (`TAB_PRC1`) pela quantidade em estoque (`EST_QUAN`). A cláusula `HAVING` filtra os produtos cujo valor de estoque seja maior que zero.

#### Subconsulta para GIRO_FEV_JUL

A subconsulta é usada para calcular o total de quantidades vendidas (`QUANTIDADE`) para cada produto durante o período de 01/02/2023 a 31/07/2023 na tabela `VW_FATURAMENTO_DETALHADO`. A subconsulta é correlacionada com a tabela principal `PRODUTO` através da condição `FD.PRODUTO_ID = P.PRO_CODI`.

#### Join e Filtros

- **INNER JOIN ESTOQUE E**: Junta a tabela `ESTOQUE` com a tabela `PRODUTO` usando o campo `PRO_CODI` como chave de junção.
- **INNER JOIN TBVENDAPRO VP**: Junta a tabela `TBVENDAPRO` com a tabela `PRODUTO` usando o campo `PRO_CODI` como chave de junção.
- **WHERE P.FOR_CODI = 940**: Filtra os produtos associados ao fornecedor com código 940.

#### Agrupamento e Ordenação

O resultado é agrupado por `PRO_CODI`, `PRO_DESC`, `EST_QUAN` e `VP.TAB_PRC1`. Isso é necessário porque estamos usando funções agregadas (`SUM`) e o campo `ESTOQUE_VALOR` no `SELECT`.

## SCRIPT MÉDIA FATURAMENTO TRISMESTAL

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

## Propósito da Consulta

O objetivo desta consulta SQL é calcular e agregar várias métricas para produtos vendidos em uma localização específica e com uma natureza de vendas específica. As principais métricas incluem a quantidade total de produtos vendidos dentro de um intervalo de datas específico, bem como a média de quantidade vendida nos últimos três meses antes de uma data especificada.

## Campos da Consulta

A consulta inclui os seguintes campos no conjunto de resultados:

- `CODIGO_PRODUTO`: O identificador único do produto.
- `PRODUTO`: O nome ou descrição do produto.
- `QUANTIDADE`: A quantidade total do produto vendido dentro do intervalo de datas especificado, de 1 de setembro de 2023 a 30 de setembro de 2023.
- `MEDIA_ULTIMO_TRIMESTRE`: A média da quantidade do produto vendida nos três meses anteriores ao intervalo de datas de 1 de junho de 2023 a 31 de agosto de 2023.
- `FOR_CODI`: O identificador único do fornecedor do produto.
- `FORNECEDOR`: O nome ou descrição do fornecedor.

## Lógica da Consulta

- A expressão `SUM(CASE ... END)` calcula a quantidade total de produtos vendidos (`QUANTIDADE`) dentro do intervalo de datas especificado (de 1 de setembro de 2023 a 30 de setembro de 2023).
- A subconsulta calcula a soma das quantidades vendidas nos três meses de 1 de junho de 2023 a 31 de agosto de 2023 e armazena esse valor como `MEDIA_ULTIMO_TRIMESTRE`. Essa subconsulta está correlacionada com a consulta principal por meio da correspondência do `CODIGO_PRODUTO`.
- A consulta filtra os dados com base nas seguintes condições:
  - `LOCALIZACAO` é igual a '001'.
  - `NATUREZA` é 'VEN' ou 'BOV'.
- Os resultados são agrupados por `CODIGO_PRODUTO`, `PRODUTO`, `FOR_CODI`, `FORNECEDOR`.

Esta consulta fornece informações valiosas sobre as vendas de produtos em uma localização específica e natureza de vendas, permitindo análise das quantidades vendidas e das vendas médias ao longo do tempo.

Observe que a consulta assume formatos de data específicos ('dd/mm/yyyy') e pode exigir ajustes com base nas configurações de formato de data do seu banco de dados.


## SCRIPT VW_ESTOQUE

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Modelo de script para criação de view de quantidade de estoque atual.
- Documentação:

	- P.PRO_CODI: Código do produto. (Tabela PRODUTO)
	- P.PRO_DESC: Descrição do produto. (Tabela PRODUTO)
	- E.EST_QUAN: Quantidade atual em estoque do produto. (Tabela ESTOQUE)
	- P.FOR_CODI: Código do fornecedor do produto. (Tabela PRODUTO)
	- P.SEC_CODI: Código da seção ou tipo de produto. (Tabela PRODUTO)

- As colunas estão sendo selecionadas no comando SELECT e associadas a apelidos (aliases) P, E e C para representar as tabelas PRODUTO, ESTOQUE e TBCUSTOMATE, respectivamente. Elas são utilizadas para compor o resultado final da consulta, que retornará informações sobre os produtos em estoque. As tabelas relacionadas são ESTOQUE (E) através da chave PRO_CODI, PRODUTO (P) através das chaves PRO_CODI e FOR_CODI, FORNECEDOR (F) através da chave FOR_CODI e TBCUSTOMATE (C) através da chave MAT_CODI.


## SCRIPT VALOR TOTAL VENDIDO

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Modelo de script para visualização do valor total faturado por dias específicos.
- Comando sp_help extramamente útil, principalmente em caso de tabelas com muitos dados, para retornar somente as colunas constantes em uma tabela, sem valores.
- Documentação:

	- SUM([Valor (preço)]): Essa coluna representa o valor total, calculado como a soma dos valores de preço presentes na coluna "Valor (preço)" da tabela VW_LABORATORIO. O alias "valor_total" é usado para identificar essa coluna no resultado da consulta.

	- [Data da Operação]: Essa coluna representa a data da operação ou transação, presente na tabela VW_LABORATORIO. O alias "data" é usado para identificar essa coluna no resultado da consulta.

- A consulta está realizando uma agregação dos valores de preço com base na data da operação. A cláusula WHERE filtra os dados para incluir apenas as datas específicas 	fornecidas, e a cláusula GROUP BY agrupa os resultados pela data da operação, permitindo que o valor total seja calculado para cada uma dessas datas.
- As informações deveriam ser referentes as dias específicos. Por isso não foi utilizado o "BETWEEN".


## SCRIPT INSERIR CLIENTES BASE VENDEDOR

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Modelo de script para inserção de dados em uma tabela específica.
- Dois scripts: o primeiro inserindo todos os clientes de um determinado Bairro, o segundo de um Munícipio.
- Primeiro foram feitas algumas pesquisas constantes nos selects para melhor entendimento dos dados constantes na tabela. Nesse caso não foi utilizado o comando sp_help, pois precisava vizualizar a forma que os dados estavam gravados.
- Documentação:

	- CLI_CODI: Código do cliente, presente na tabela CLIENTE.
	- VEN_CODI: Código do vendedor a ser inserido (valor fixo: 'CODIGO DO VENDEDOR').
	- TPV_CODI: Código do tipo de venda (valor nulo, inserido como NULL).
	- VEN_CODI_ANT: Código do vendedor anterior (valor nulo, inserido como NULL).
	- CXV_STSUP: Status do cliente-vendedor (valor fixo: 'I').

- A inserção é realizada selecionando apenas os clientes que atendem às seguintes condições: bairro igual a 'ANTOZIO BEZERRA' (CLI_BAIR = 'ANTOZIO BEZERRA'), unidade do Ceará (UND_CDNAC = 'CE'), e código do município igual a '04400' (MUN_CODI = '04400'). O resultado dessa consulta é a inserção de novos registros na tabela TBCLIENTE_VENDEDOR com os dados dos clientes selecionados e os valores predefinidos para VEN_CODI, TPV_CODI, VEN_CODI_ANT e CXV_STSUP.


## SCRIPT CENÁRIOS DIA A DIA

<div align="center">
	
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white) 

</div>
<br>

- Scripts feitos para alguns casos concretos, focando na filtragem específica, buscando extrair informações mais exatas.


## SCRIPT VENDA E BONIFICAÇÃO

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- O comando SQL realiza uma consulta na tabela VW_FATURAMENTO_DETALHADO para obter informações de faturamento detalhado por cliente, com base em algumas condições.
- Documentação:

	- COD_CLIENTE_GERAL: Código do cliente, presente na tabela VW_FATURAMENTO_DETALHADO.
	- CLIENTE_GERAL: Nome do cliente, presente na tabela VW_FATURAMENTO_DETALHADO.
	- QUANTIDADE_VENDA: Quantidade total vendida do produto para o cliente, filtrada pela NATUREZA 'VEN'.
	- QUANTIDADE_BONIFICACAO: Quantidade total de bonificação concedida ao cliente, filtrada pela NATUREZA 'BOV'.
	- VALOR_TOTAL_VENDA: Valor total das vendas para o cliente, filtrado pela NATUREZA 'VEN'.
	- VALOR_TOTAL_BONIFICACAO: Valor total das bonificações concedidas ao cliente, filtrado pela NATUREZA 'BOV'.

- A consulta é filtrada por um fornecedor específico (FOR_CODI = '00262'), uma filial específica (LOCALIZACAO = '001'), um período específico de junho de 2023 ('2023-06-01' a '2023-06-30'), e apenas as naturezas de venda e bonificação são consideradas (NATUREZA IN ('VEN', 'BOV')). Além disso, a consulta é filtrada por um produto específico (CODIGO_PRODUTO = '1880'). Os resultados são agrupados por COD_CLIENTE_GERAL e CLIENTE_GERAL, e ordenados pelo código do cliente (COD_CLIENTE_GERAL). Isso permitirá que o resultado da consulta mostre informações consolidadas de vendas e bonificações para cada cliente específico.


## SCRIPT BASE CLIENTES VENDEDOR

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Destinado a retornar todos os clientes que constam na base de um vendedor (VEN_CODI) que também constam na base de outro vendedor com outro código distinto.
- Documentação:

	- VEN_CODI: Código do vendedor, presente na tabela VENDEDOR.
	- CLI_CODI: Código do cliente, presente na tabela TBCLIENTE_VENDEDOR.
	- VEN_CLI: Combinação do código do vendedor e código do cliente.
	- CLIENTE: Nome do cliente, presente na tabela CLIENTE.
	- FANTASIA: Nome fantasia do cliente, presente na tabela CLIENTE.
	- ENDERECO: Endereço do cliente, presente na tabela CLIENTE.
	- NUMERO: Número do endereço do cliente, presente na tabela CLIENTE.
	- BAIRRO: Bairro do cliente, presente na tabela CLIENTE.
	- CIDADE: Nome da cidade do cliente, presente na tabela TBMUNICIPIOS.
	- DATA: Data da última compra do cliente (formato dd/mm/aaaa), calculada a partir da tabela TBMOVCOMPRA.

- A consulta combina informações de várias tabelas (TBCLIENTE_VENDEDOR, VENDEDOR, CLIENTE, TBMOVCOMPRA, TBUF e TBMUNICIPIOS) usando INNER JOINs para relacionar os dados relevantes. A cláusula WHERE filtra os resultados para incluir apenas clientes e vendedores com condições específicas. O resultado da consulta é agrupado por vendedor (VEN_CODI), cliente (CLI_CODI), nome do cliente (CLIENTE), nome fantasia do cliente (FANTASIA), endereço (ENDERECO), número (NUMERO), bairro (BAIRRO) e cidade (CIDADE), e é ordenado pelo bairro do cliente em ordem crescente.


## SCRIPT UPDATE BASE VENDEDORES/FORNECEDOR

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Destinado a alterar a relação entre vendedor/fornecedor de uma tabela.


## SCRIPT INSERT COPY

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Esse comando SQL insere dados na tabela TBVEND_VINC a partir de uma seleção de registros existentes na mesma tabela.
- Documentação:

	- TIPO: Tipo de vínculo a ser inserido, obtido da tabela TBVEND_VINC.
	- COD_VEND: Código do vendedor a ser inserido (valor fixo: 299).
	- COD_VINC: Código de vínculo, obtido da tabela TBVEND_VINC.
	- SEC_CODI: Código da seção, obtido da tabela TBVEND_VINC.
	- UF: Unidade federativa, obtida da tabela TBVEND_VINC.
	- MUN_CODI: Código do município, obtido da tabela TBVEND_VINC.

- A inserção é realizada selecionando registros da tabela TBVEND_VINC que possuam o código de vendedor igual a 190 (COD_VEND = 190) e, em seguida, insere novos registros na tabela TBVEND_VINC com os mesmos valores de TIPO, COD_VINC, SEC_CODI, UF e MUN_CODI, mas com o valor fixo de COD_VEND igual a 299. Essa ação tem o propósito de criar um novo vínculo para o vendedor com o código 299, mantendo as mesmas informações de vínculo do vendedor com o código 190, exceto pelo novo código de vendedor. É importante notar que isso pode levar à duplicação de registros caso já existam vínculos com o mesmo TIPO, COD_VINC, SEC_CODI, UF e MUN_CODI para o novo vendedor (299) na tabela TBVEND_VINC.


## SCRIPT VIEW PRODUTOS NCM

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Em resumo, a VIEW `VW_PRODUTO_NCM` exibe as descrições e os códigos NCM dos produtos ativos pertencentes à seção de código `009`, relacionando informações das tabelas `ESTOQUE` e `PRODUTO` com base em suas chaves de relação e critérios de filtro específicos.

- Documentação: 

	- `DESCRICAO_PRODUTO`: Esta coluna contém as descrições dos produtos presentes na tabela `ESTOQUE`, ou seja, fornece informações sobre o nome ou título dos produtos.

	- `PRO_NCM`: Essa coluna corresponde ao NCM (Nomenclatura Comum do Mercosul) dos produtos da tabela `PRODUTO`. O NCM é um código numérico utilizado para classificar mercadorias, facilitando o comércio internacional.

	- `P.PRO_CODI`: Este é o código do produto na tabela `PRODUTO`. Ele é usado como chave para relacionar as tabelas `ESTOQUE` e `PRODUTO`.

	- `E.CODIGO_PRODUTO`: Esse é o código do produto na tabela `ESTOQUE`. É a outra parte da chave de relação entre as tabelas `ESTOQUE` e `PRODUTO`.

	- `P.PRO_SITU`: Este é o status do produto na tabela `PRODUTO`. A condição `PRO_SITU = 'A'` seleciona apenas produtos ativos.

	- `P.SEC_CODI`: Essa coluna representa o código da seção à qual o produto pertence, na tabela `PRODUTO`. A condição `P.SEC_CODI = 009` filtra produtos que pertencem à seção com código `009`.



