SELECT * FROM pessoas;
-- CRIANDO UMA NOVA COLUNA CHAMADA is_adm NA TABELA pessoas
-- ESSA VAI DAR ERRO POIS UMA NOVA COLUNA NAO PODE SER NOT NULL
ALTER TABLE
	pessoas
ADD COLUMN 
	is_adm BOOLEAN NOT NULL;

-- CRIANDO UMA NOVA COLUNA CHAMADA is_adm NA TABELA pessoas
-- ESSA VAI DAR CERTO
ALTER TABLE
	pessoas
ADD COLUMN 
	is_adm BOOLEAN;
    
-- MUDANDO O NOME DA COLUNA is_adm PARA eh_administrador
ALTER TABLE
	pessoas
RENAME COLUMN
	is_adm TO eh_administrador;
    
-- REMOVENDO A COLUNA eh_administrador DA TABELA pessoas
ALTER TABLE
	pessoas
DROP COLUMN
	eh_administrador;

-- CRIANDO UMA COLUNA nascimento NA TABELA pessoas
-- O TIPO TIMESTAMP ARMAZENA UM VALOR DE DATA E HORA, ALGO PARECIDO COM O DATETIME
ALTER TABLE
	pessoas
ADD COLUMN
	nascimento TIMESTAMP;

-- ATUALIZANDO TODOS OS DADOS DA TABELA pessoas PARA RECEBEREM O VALOR DE nascimento SENDO IGUAL A 1990-01-01
-- TOMAR CUIDADO COM DELETE E UPDATE SEM A CLAUSULA WHERE, POIS IMPLICA QUE TODOS OS DADOS DA TABELA IRÃO SER ATUALIZADOS/DELETADOS
UPDATE
	pessoas
SET 
	nascimento = '1990-01-01'
RETURNING *;

-- COMO NOSSA COLUNA nascimento CONTÉM VALORES PARA TODOS OS DADOS EM pessoas, AGORA PODEMOS DIZER QUE ELA É NOT NULL
ALTER TABLE
	pessoas
ALTER COLUMN
	nascimento SET NOT NULL;
    
SELECT * FROM pessoas;

-- ALTERANDO O TIPO DA COLUNA nascimeto, DE TIMESTAMP PARA DATE
-- O TIPO DATE ARMAZENA APENAS DATA, SEM HORARIO
ALTER TABLE
	pessoas
ALTER COLUMN
	nascimento TYPE DATE;
    
-- CRIANDO UMA NOVA COLUNA salario NA TABELA pessoas COM O TIPO DECIMAL(10,2)
-- AO USAR O DECIMAL(10, 2), NÓS DEFINIMOS QUE PODE SER ARMZENADO UM FLOAT, COM NO MAXIMO 10 CARACTERES DE TAMANHO, SENDO 2 APÓS A VIRGULA
ALTER TABLE
	pessoas
ADD COLUMN
	salario DECIMAL(10, 2);

-- REMOVENDO A REGRA DE NOT NULL DA COLUNA idade
ALTER TABLE
	pessoas
ALTER COLUMN
	idade DROP NOT NULL;
    
SELECT * FROM pessoas;

-- ATUALIZANDO A idade PARA 22 DE TODAS AS pessoas QUE O MODULO SEJA NULL
UPDATE
	pessoas
SET
	idade = 22
WHERE
	modulo IS NULL;
  
-- NAO EXECUTEM DELETE SEM WHERE
-- DELETE FROM pessoas;

-- DELETANDO TODAS AS pessoas CUJO EMAIL COMEÇA COM a
DELETE FROM
	pessoas
WHERE
	email LIKE 'a%';
    
-- DELETANDO TODAS AS pessoas QUE O EMAIL COMEÇA COM P MAIUSCULO OU MINUSCULO, E RETORNANDO AS COLUNAS DE nome E email DOS DADOS DELETADOS
DELETE FROM
	pessoas
WHERE
	email ILIKE 'P%'
RETURNING nome, email;

-- CONTANDO A QUANTIDADE DE pessoas ARMAZENADAS NA TABELA DE pessoas
SELECT COUNT(*) total_pessoas
	FROM pessoas;

-- BUSCANDO A PESSOA QUE TEM A MAIOR idade ENTRE ELAS
SELECT MAX(idade) mais_velho
	FROM pessoas;

-- BUSCANDO A PESSOA QUE TEM A MENOR idade ENTRE ELAS
SELECT MIN(idade) mais_novo
	FROM pessoas;

-- BUSCANDO A MEDIA DE idade DAS pessoas
SELECT AVG(idade) media_idade
	FROM pessoas;

-- ARREDONDANDO A MEDIA DE idade PARA DUAS CASAS DECIMAIS
SELECT ROUND(AVG(idade), 2) media_idade
	FROM pessoas;

-- SELECIONANDO O email EM CAIXA BAIXA, O nome EM CAIXA ALTA, E NOVAMENTE O nome COM O INICIAL MAISCULA
SELECT
	LOWER(email) email, UPPER(nome) nome, INITCAP(nome) nome
FROM
	pessoas;
    
-- SELECIONANDO TODAS AS pessoas QUE TENHAM A MENOR IDADE
SELECT
	*
FROM
	pessoas
WHERE idade = (
	SELECT MIN(idade) FROM pessoas
);

-- SELECIONANDO TODAS AS pessoas E ORDENANDO PELO nome
-- O PADRAO DE ORDENAÇÃO É O ASC
SELECT
	*
FROM
	pessoas
ORDER BY nome;

-- SELECIONANDO TODAS AS pessoas E ORDENANDO PELO modulo
SELECT
	*
FROM
	pessoas
ORDER BY modulo;

-- SELECIONANDO TODAS AS pessoas E ORDENANDO PELA idade DE FORMA DECRESCENTE
SELECT
	*
FROM
	pessoas
ORDER BY idade DESC;

-- SELECIONANDO TODAS AS pessoas E ORDENANDO PELA idade DE FORMA CRESCENTE
SELECT
	*
FROM
	pessoas
ORDER BY idade ASC;

-- SELECIONANDO TODAS AS pessoas QUE PERTENCEM A ALGUM MODULO E ORDENANDO PELO nome
SELECT
	*
FROM
	pessoas
WHERE
	modulo IS NOT NULL
ORDER BY nome;

SELECT nome, email FROM pessoas;

SELECT
	*
FROM
	pessoas
ORDER BY idade;

-- CONTANDO QUANTAS PESSOAS TEM POR MODULO
SELECT 
	COUNT(*) pessoas_modulo, modulo
FROM
	pessoas
GROUP BY
	modulo;
    
-- SELECIONANDO A QUANTIDADE DE pessoas POR MODULO, E AGRUPANDO O MODULO ATRAVES DO UPPER
-- ESSE AGRUPAMENTO COM O UPPER, FAZ COM QUE O POSTGRES CONSIDERE TODOS OS DADOS SENDO COM LETRA MAIUSCULA NO MOMENTO DE AGRUPAR
SELECT 
	COUNT(*) pessoas_modulo, UPPER(modulo)
FROM
	pessoas
GROUP BY
	UPPER(modulo);

-- SELECIONANDO A MEDIA DE idade DAS PESSOAS POR modulo
SELECT 
	ROUND(AVG(idade), 2) media_idade, UPPER(modulo) modulo
FROM
	pessoas
GROUP BY
	UPPER(modulo)
ORDER BY modulo;

-- SELECIONANDO A MEDIA DE idade DAS PESSOAS POR modulo CUJO email COMEÇA COM j
SELECT
	ROUND(AVG(idade), 2) media_idade, UPPER(modulo) modulo
FROM
	pessoas
GROUP BY
	UPPER(modulo), nome
HAVING 
	nome ILIKE 'j%'
ORDER BY modulo;

-- SELECIONANDO A MEDIA DE idade DAS PESSOAS POR modulo CUJO email COMEÇA COM j
SELECT
	ROUND(AVG(idade), 2) media_idade, UPPER(modulo) modulo
FROM
	pessoas
WHERE
	nome ILIKE 'j%'
GROUP BY
	UPPER(modulo)
ORDER BY modulo;