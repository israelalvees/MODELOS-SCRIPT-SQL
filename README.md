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

## SCRIPT VW_ESTOQUE

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Modelo de script para criação de view de quantidade de estoque atual.
- Permitindo filtar por fornecedor, seção (tipo) produto, localização (sede), departamento, produto ativo ou inativo, produtos em estoque.


## SCRIPT VALOR TOTAL VENDIDO

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Modelo de script para visualização do valor total faturado por dias específicos.
- Comando sp_help extramamente útil, principalmente em caso de tabelas com muitos dados, para retornar somente as colunas constantes em uma tabela, sem valores.


## SCRIPT INSERIR CLIENTES BASE VENDEDOR

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Modelo de script para inserção de dados em uma tabela específica.
- Dois scripts: o primeiro inserindo todos os clientes de um determinado Bairro, o segundo de um Munícipio.
- Primeiro foram feitas algumas pesquisas constantes nos selects para melhor entendimento dos dados constantes na tabela. Nesse caso não foi utilizado o comando sp_help, pois precisava vizualizar a forma que os dados estavam gravados.


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

- Este script SQL é destinado a recuperar dados de faturamento com base em determinados critérios de filtro. Ele retorna as quantidades de venda e bonificação, bem como os valores totais de venda e bonificação para um determinado período e produto.
- Filtra os dados com base nos seguintes critérios:
	- FOR_CODI = 'XXX' (código específico).
	- LOCALIZACAO = 'XXX' (localização específica).
	- DATA entre 'XX/XX/XXXX' e 'XX/XX/XXXX' (período específico).
	- NATUREZA igual a 'VEN' (venda) e 'BOV' (bonificação).
	- CODIGO_PRODUTO igual a 'XXXX' (produto específico).


## SCRIPT BASE CLIENTES VENDEDOR

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Destinado a retornar todos os clientes que constam na base de um vendedor (VEN_CODI) que também constam na base de outro vendedor com outro código distinto.


## SCRIPT UPDATE BASE VENDEDORES/FORNECEDOR

<div align="center">
	
![MicrosoftSQLServer](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) ![SQL](https://img.shields.io/badge/SQL-%2300758F.svg?style=for-the-badge&logo=sql&logoColor=white)
</div>
<br>

- Destinado a alterar a relação entre vendedor/fornecedor de uma tabela.


