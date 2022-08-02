CREATE DATABASE demo;

-- DROP DATABASE demo;

-- CRIA UMA NOVA TABELA NO BANCO DE DADOS CHAMADA tabela_teste
CREATE TABLE IF NOT EXISTS tabela_teste(
	id BIGSERIAL PRIMARY KEY,
  	nome VARCHAR(45) NOT NULL UNIQUE
);

-- INSERE VALORES EM UMA TABELA tabela_teste
INSERT INTO
	tabela_teste (nome)
VALUES
	('Fabio'),
    ('Pedro');
    
-- EXCLUI UMA TABELA DO BANCO DE DADOS, NESSE CASO A tabela_teste
DROP TABLE tabela_teste;

-- ATIVA A EXTENSAO PARA USAR O UUID COMO CHAVE PRIMARIA NO BANCO DE DADOS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- CRIA UMA NOVA TABELA NO BANCO DE DADOS CHAMADA pessoas, AGORA COM O UUID COMO CHAVE PRIMARIA
CREATE TABLE IF NOT EXISTS pessoas(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  	nome VARCHAR(45) NOT NULL,
  	idade INTEGER NOT NULL,
  	CHECK(idade>0),
  	email VARCHAR(45) NOT NULL,
  	modulo VARCHAR(2)
);

-- INSERE DADOS NA TABELA pessoas
INSERT INTO
	pessoas (nome, idade, email, modulo)
VALUES
	('Fabio', 23, 'fabio@kenzie.com.br', 'M4'),
    ('Maykel', 21, 'maykel@kenzie.com.br', NULL);
    
-- INSERE DADOS NA TABELA pessoas, RETORNANDO ESSES DADOS PARA VISUALIZAÇÃO
INSERT INTO
	pessoas (nome, idade, email)
VALUES
	('Pedro', 23, 'pedro@kenzie.com.br'),
    ('Alexandre', 21, 'alexandre@kenzie.com.br'),
    ('Felipe', 23, 'felipe@kenzie.com.br'),
    ('Renato', 21, 'renato@kenzie.com.br')
RETURNING *;

-- INSERE DADOS NA TABELA pessoas, RETORNANDO ESSES DADOS PARA VISUALIZAÇÃO
INSERT INTO
	pessoas (nome, idade, email, modulo)
VALUES
	('Joao', 23, 'joao@kenzie.com.br', 'M1'),
    ('Jose', 21, 'jose@kenzie.com.br', 'M2'),
    ('Maria', 23, 'maria@kenzie.com.br', 'M4'),
    ('Joana', 21, 'joana@kenzie.com.br', 'M5')
RETURNING *;

-- SELECIONADO TODOS OS DADOS COM TODOS OS CAMPOS DA TABELA pessoas
SELECT 
	*
FROM pessoas;

-- SELECIONANDO TODOS OS DADOS E MOSTRANDO APENAS OS CAMPOS DE nome E idade DA TABELA DE PESSOAS
SELECT
	nome, idade
FROM
	pessoas;

-- SELECIONANDO OS DADOS DA TABELA DE pessoas QUE TENHAM O modulo SENDO IGUAL A M4
SELECT 
	*
FROM
	pessoas
WHERE
	modulo = 'M4';
    
-- SELECIONANDO OS CAMPOS DE nome E idade DAS pessoas QUE TENHAM idade SUPERIOR A 21
SELECT
	nome, idade
FROM
	pessoas
WHERE
	idade > 21;

-- SELECIONANDO OS CAMPOS DE nome E idade DAS pessoas QUE TENHAM idade INFERIOR OU IGUAL A 21
SELECT
	nome, idade, email
FROM
	pessoas
WHERE
	idade <= 21;

-- SELECIONANDO OS CAMPOS DE nome, idade, email E modulo DAS pessoas QUE TENHAM idade SUPERIOR A 21 E O modulo SEJA IGUAL A M4
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	idade > 21 AND modulo = 'M4';

-- SELECIONANDO OS CAMPOS DE nome, idade, email E modulo DAS pessoas QUE TENHAM idade INFERIOR A 21 OU O modulo SEJA IGUAL A M4
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	idade <= 21 OR modulo = 'M4';

-- SELECIONANDO OS CAMPOS DE nome, idade, email E modulo DAS pessoas
-- QUE TENHAM idade INFERIOR A 21 E O modulo SEJA IGUAL A M2, OU QUE O modulo SEJA IGUAL A M4
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	(idade <= 21 AND modulo = 'M2') OR modulo = 'M4';

-- SELECIONANDO OS CAMPOS DE nome, idade, email E modulo DAS pessoas
-- QUE TENHAM idade INFERIOR A 21 E O modulo SEJA IGUAL A M2, OU QUE O modulo SEJA DIFERENTE DE M4
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	(idade <= 21 AND modulo = 'M2') OR NOT modulo = 'M4';

-- SELECIONANDO OS DADOS DAS PESSOAS CUJO email COMEÇA COM jo
SELECT
	*
FROM
	pessoas
WHERE
	email LIKE 'jo%';

-- SELECIONANDO OS DADOS DAS PESSOAS CUJO email TERMINE COM o
SELECT
	*
FROM
	pessoas
WHERE
	nome LIKE '%o';
    
SELECT
	*
FROM
	pessoas
WHERE
	nome ILIKE '%O';

-- SELECIONANDO OS DADOS DAS PESSOAS CUJO email TENHA kenzie.com NO MEIO DA STRING
SELECT
	*
FROM
	pessoas
WHERE
	email ILIKE '%kenzie.com%';