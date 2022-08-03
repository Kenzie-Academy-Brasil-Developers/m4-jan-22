-- ALTERANDO O NOME DA TABELA DE pessoas PARA facilitadores
TABLE IF EXISTS
	pessoas
RENAME TO
	facilitadores;

-- CRIANDO UMA TABELA enderecos
CREATE TABLE IF NOT EXISTS enderecos(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  	logradouro VARCHAR(45) NOT NULL,
  	cep VARCHAR(8) NOT NULL,
  	numero VARCHAR(5),
  	complemento VARCHAR(45) NOT NULL
);

-- CRIANDO UM CAMPO id_endereco COM O TIPO UUID NA TABELA facilitadores
ALTER TABLE
	facilitadores
ADD COLUMN
	id_endereco UUID;
    
SELECT * FROM facilitadores;

-- CRIANDO UMA CHAVE ESTRANGEIRA (FOREIGN KEY) NA TABELA facilitadores E ATRIBUINDO ELA AO CAMPO id_endereco
-- A CHAVE CRIADA FAZ REFERENCIA AO CAMPO id DA TABELA enderecos
ALTER TABLE
	facilitadores
FOREIGN KEY (id_endereco)
REFERENCES enderecos(id)
ON DELETE SET NULL;

-- INSERINDO DADOS NA TABELA enderecos
INSERT INTO
	enderecos(logradouro, cep, numero, complemento)
VALUES
	('Rua 1', '71000000', '123', 'Apartamento 22');
    
SELECT * FROM enderecos;

-- ATUALIZANDO O id_endereco DA TABELA facilitadores PARA O FACILITADOR CUJO email é 'fabio@kenzie.com.br'
-- O id_endereco USADO FOI O CRIADO NA EXECUÇÃO DA QUERY ANTERIOR
UPDATE
	facilitadores
SET
	id_endereco = '4a3da933-2d58-4b25-a02e-066f1e66e380'
WHERE email = 'fabio@kenzie.com.br'
RETURNING *;

-- INCLUINDO A REGRA DE QUE O id_endereco NA TABELA DE facilitadores SERÁ UNICO
-- ESSA REGRA É O QUE DEFINE QUE NOSSA RELAÇÃO SERÁ DE 1:1 E NAO 1:N
ALTER TABLE
	facilitadores
ADD UNIQUE (id_endereco);

-- INSERINDO DADOS NA TABELA DE enderecos
INSERT INTO
	enderecos(logradouro, cep, numero, complemento)
VALUES
	('Rua 1', '71000000', '123', 'Apartamento 22'),
	('Rua 2', '71000000', '45', 'Apartamento 11'),
	('Rua 3', '71000000', '13', 'Apartamento 12'),
	('Rua 4', '71000000', '1', 'Apartamento 44'),
	('Rua 5', '71000000', '3', 'Apartamento 5'),
	('Rua 6', '71000000', '123', 'Apartamento 501'),
	('Rua 7', '71000000', '566', 'Apartamento 22'),
	('Rua 8', '71000000', '31', 'Apartamento 22');
    
SELECT * FROM enderecos;
    
-- ATUALIZANDO O CAMPO id_endereco DO FACILITADOR felipe 
-- O endereco QUE O FELIPE IRÁ RECEBER, SERÁ O DA Rua 2 E numero 45
UPDATE
	facilitadores
SET
	id_endereco = (SELECT id FROM enderecos WHERE logradouro = 'Rua 2' AND numero = '45')
WHERE
	email = 'felipe@kenzie.com.br';
    
SELECT * FROM facilitadores;
	
INSERT INTO
	facilitadores (nome, email, idade, modulo, nascimento, id_endereco)
VALUES
	('Mariana', 'mariana@kenzie.com.br', 22, 'M1', '2000-01-01', '9b19f3c9-dab4-477c-b402-bfc91da77c2d'),
    ('Ana', 'ana@kenzie.com.br', 22, 'M2', '2000-01-01', (SELECT id FROM enderecos WHERE logradouro = 'Rua 7' AND numero = '566'))
RETURNING *;

-- SELECIONANDO OS DADOS DA TABELA facilitadores E JUNTANDO COM OS DADOS RELACIONADOS DA TABELA enderecos
SELECT
	*
FROM
	facilitadores f
JOIN
	enderecos e ON f.id_endereco = e.id;

-- SELECIONANDO OS DADOS DA TABELA facilitadores E JUNTANDO COM OS DADOS RELACIONADOS DA TABELA enderecos
-- NESSA QUERY, ESTÁ SENDO FILTRADO QUAIS AS COLUNAS IREMOS VISUALIZAR
SELECT
	f.id id_facilitador,
	f.nome,
    f.email,
    e.id id_endereco,
    e.logradouro,
    e.cep,
    e.numero
FROM
	facilitadores f
JOIN
	enderecos e ON e.id = f.id_endereco;
    
-- SELECIONANDO OS DADOS DA TABELA facilitadores E JUNTANDO COM OS DADOS RELACIONADOS DA TABELA enderecos
-- NESSA QUERY, ESTAMOS FILTRANDO APENAS OS facilitadores CUJO NOME COMEÇA COM A LETRA f OU F
SELECT 
	*
FROM
	facilitadores f
JOIN
	enderecos e ON f.id_endereco = e.id
WHERE
	f.nome ILIKE 'f%';

    
-- SELECIONANDO OS DADOS DA TABELA facilitadores E JUNTANDO COM OS DADOS RELACIONADOS DA TABELA enderecos
-- NESSA QUERY, ESTAMOS FILTRANDO APENAS OS facilitadores QUE A idade É DIFERENTE DE 23
SELECT
	*
FROM
	facilitadores f
JOIN 
	enderecos e ON f.id_endereco = e.id
WHERE
	idade <> 23;

