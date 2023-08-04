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


