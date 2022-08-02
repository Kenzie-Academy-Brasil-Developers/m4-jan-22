SELECT * FROM pessoas;

ALTER TABLE
	pessoas
ADD COLUMN 
	is_adm BOOLEAN NOT NULL;

ALTER TABLE
	pessoas
ADD COLUMN 
	is_adm BOOLEAN;
    
ALTER TABLE
	pessoas
RENAME COLUMN
	is_adm TO eh_administrador;
    
ALTER TABLE
	pessoas
DROP COLUMN
	eh_administrador;
    
ALTER TABLE
	pessoas
ADD COLUMN
	nascimento TIMESTAMP;
    
UPDATE
	pessoas
SET 
	nascimento = '1990-01-01'
RETURNING *;

ALTER TABLE
	pessoas
ALTER COLUMN
	nascimento SET NOT NULL;
    
SELECT * FROM pessoas;

ALTER TABLE
	pessoas
ALTER COLUMN
	nascimento TYPE DATE;
    
ALTER TABLE
	pessoas
ADD COLUMN
	salario DECIMAL(10, 2);
    
ALTER TABLE
	pessoas
ALTER COLUMN
	idade DROP NOT NULL;
    
SELECT * FROM pessoas;

UPDATE
	pessoas
SET
	idade = 22
WHERE
	modulo IS NULL;
  
-- NAO EXECUTEM DELETE SEM WHERE
-- DELETE FROM pessoas;

DELETE FROM
	pessoas
WHERE
	email LIKE 'a%';
    
DELETE FROM
	pessoas
WHERE
	email ILIKE 'P%'
RETURNING nome, email;

SELECT COUNT(*) total_pessoas
	FROM pessoas;
    
SELECT MAX(idade) mais_velho
	FROM pessoas;
    
SELECT MIN(idade) mais_novo
	FROM pessoas;
    
SELECT AVG(idade) media_idade
	FROM pessoas;
    
SELECT ROUND(AVG(idade), 2) media_idade
	FROM pessoas;
    
SELECT
	LOWER(email) email, UPPER(nome) nome, INITCAP(nome) nome
FROM
	pessoas;
    
SELECT
	*
FROM
	pessoas
WHERE idade = (
	SELECT MIN(idade) FROM pessoas
);

SELECT
	*
FROM
	pessoas
ORDER BY nome;

SELECT
	*
FROM
	pessoas
ORDER BY modulo;

SELECT
	*
FROM
	pessoas
ORDER BY idade DESC;

SELECT
	*
FROM
	pessoas
ORDER BY idade ASC;

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

SELECT 
	COUNT(*) pessoas_modulo, modulo
FROM
	pessoas
GROUP BY
	modulo;
    
SELECT 
	COUNT(*) pessoas_modulo, UPPER(modulo)
FROM
	pessoas
GROUP BY
	UPPER(modulo);
    
SELECT 
	ROUND(AVG(idade), 2) media_idade, UPPER(modulo) modulo
FROM
	pessoas
GROUP BY
	UPPER(modulo)
ORDER BY modulo;

SELECT
	ROUND(AVG(idade), 2) media_idade, UPPER(modulo) modulo
FROM
	pessoas
GROUP BY
	UPPER(modulo), nome
HAVING 
	nome ILIKE 'j%'
ORDER BY modulo;

SELECT
	ROUND(AVG(idade), 2) media_idade, UPPER(modulo) modulo
FROM
	pessoas
WHERE
	nome ILIKE 'j%'
GROUP BY
	UPPER(modulo)
ORDER BY modulo;