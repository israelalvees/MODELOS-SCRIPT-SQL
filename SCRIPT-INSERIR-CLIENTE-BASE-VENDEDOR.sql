--------------------------PESQUISA------------------------------------------

--SELECT * FROM TBCLIENTE_VENDEDOR

--SELECT * FROM CLIENTE WHERE CLI_BAIR ='INFORME O BAIRRO' AND UND_CDNAC ='CE' AND MUN_CODI ='04400'

--SELECT * FROM CLIENTE WHERE UND_CDNAC ='CE' AND   MUN_CODI ='04400'

--------------------------BAIRRO--------------------------------------------


INSERT INTO TBCLIENTE_VENDEDOR (CLI_CODI,VEN_CODI,TPV_CODI,VEN_CODI_ANT,CXV_STSUP)
SELECT CLI_CODI,'CODIGO DO VENDEDOR',NULL,NULL,'I' FROM CLIENTE 
WHERE CLI_BAIR ='ANTOZIO BEZERRA'
AND   UND_CDNAC ='CE'
AND   MUN_CODI ='04400'

--------------------------MUNICIPIO------------------------------------------


INSERT INTO TBCLIENTE_VENDEDOR (CLI_CODI,VEN_CODI,TPV_CODI,VEN_CODI_ANT,CXV_STSUP)
SELECT CLI_CODI,'CODIGO DO VENDEDOR',NULL,NULL,'I' FROM CLIENTE 
WHERE  UND_CDNAC ='CE'
AND    MUN_CODI ='03709'

--------------------------SELECT CONFIRMAÇÃO------------------------------------------

--somente para contar a quantidade de clientes, validar que foram inseridos todos
SELECT COUNT(CLI_CODI)
FROM TBCLIENTE_VENDEDOR
WHERE VEN_CODI = 'codigovendedor'
