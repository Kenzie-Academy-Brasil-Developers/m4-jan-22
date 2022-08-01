CREATE DATABASE demo;

-- DROP DATABASE demo;

CREATE TABLE IF NOT EXISTS tabela_teste(
	id BIGSERIAL PRIMARY KEY,
  	nome VARCHAR(45) NOT NULL UNIQUE
);

INSERT INTO
	tabela_teste (nome)
VALUES
	('Fabio'),
    ('Pedro');
    
DROP TABLE tabela_teste;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS pessoas(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  	nome VARCHAR(45) NOT NULL,
  	idade INTEGER NOT NULL,
  	CHECK(idade>0),
  	email VARCHAR(45) NOT NULL,
  	modulo VARCHAR(2)
);

INSERT INTO
	pessoas (nome, idade, email, modulo)
VALUES
	('Fabio', 23, 'fabio@kenzie.com.br', 'M4'),
    ('Maykel', 21, 'maykel@kenzie.com.br', NULL);
    
INSERT INTO
	pessoas (nome, idade, email)
VALUES
	('Pedro', 23, 'pedro@kenzie.com.br'),
    ('Alexandre', 21, 'alexandre@kenzie.com.br'),
    ('Felipe', 23, 'felipe@kenzie.com.br'),
    ('Renato', 21, 'renato@kenzie.com.br')
RETURNING *;

INSERT INTO
	pessoas (nome, idade, email, modulo)
VALUES
	('Joao', 23, 'joao@kenzie.com.br', 'M1'),
    ('Jose', 21, 'jose@kenzie.com.br', 'M2'),
    ('Maria', 23, 'maria@kenzie.com.br', 'M4'),
    ('Joana', 21, 'joana@kenzie.com.br', 'M5')
RETURNING *;

SELECT 
	*
FROM pessoas;

SELECT
	nome, idade
FROM
	pessoas;

SELECT 
	*
FROM
	pessoas
WHERE
	modulo = 'M4';
    
SELECT
	nome, idade
FROM
	pessoas
WHERE
	idade > 21;
    
SELECT
	nome, idade, email
FROM
	pessoas
WHERE
	idade <= 21;
    
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	idade > 21 AND modulo = 'M4';
    
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	idade <= 21 OR modulo = 'M4';
    
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	(idade <= 21 AND modulo = 'M2') OR modulo = 'M4';
    
SELECT
	nome, idade, email, modulo
FROM
	pessoas
WHERE
	(idade <= 21 AND modulo = 'M2') OR NOT modulo = 'M4';
    
SELECT
	*
FROM
	pessoas
WHERE
	email LIKE 'jo%';
    
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
    
SELECT
	*
FROM
	pessoas
WHERE
	email ILIKE '%kenzie.com%';