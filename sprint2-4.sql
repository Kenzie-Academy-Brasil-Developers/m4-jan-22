-- CRIANDO A TABELA turmas
CREATE TABLE IF NOT EXISTS turmas(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  	nome VARCHAR(45) NOT NULL,
  	modulo VARCHAR(2) NOT NULL,
  	data_inicio DATE NOT NULL,
  	data_final DATE,
  	id_facilitador UUID,
  	FOREIGN KEY (id_facilitador) REFERENCES facilitadores(id)
); 


SELECT * FROM turmas;

SELECT * FROM facilitadores;

-- INSERINDO DADOS NA TABELA turmas
INSERT INTO
	turmas (nome, modulo, data_inicio, data_final, id_facilitador)
VALUES
	('T11', 'M4', '2022-08-01', NULL, '24258202-df74-434a-b20c-e21b00a15ae5'),
	('T11', 'M1', '2022-01-01', '2022-03-01', '24258202-df74-434a-b20c-e21b00a15ae5'),  
	('T11', 'M2', '2022-04-01', '2022-06-01', '24258202-df74-434a-b20c-e21b00a15ae5'),   
	('T11', 'M4', '2022-06-01', NULL, (SELECT id FROM facilitadores WHERE email = 'felipe@kenzie.com.br')), 
	('T11', 'M1', '2022-04-01', '2022-06-01', (SELECT id FROM facilitadores WHERE email = 'felipe@kenzie.com.br')),  
	('T11', 'M4', '2022-04-01', '2022-06-01', (SELECT id FROM facilitadores WHERE email = 'felipe@kenzie.com.br'));
    
   
-- SELECIONANDO OS DADOS DA TABELA DE facilitadores E JUNTANDO COM OS DADOS DE turmas
-- NO CASO DO INNER JOIN, SERAO SELECIONADOS APENAS OS DADOS DE facilitadores QUE TEM ALGUMA turma, E DAS turmas QUE TEM ALGUM facilitador
SELECT
	f.nome nome_facilitador,
    t.nome nome_turma,
    t.modulo,
    f.id id_facilitador,
    t.id_facilitador id_facilitador_turma
FROM
	facilitadores f
INNER JOIN
	turmas t ON f.id = t.id_facilitador;

-- INSERINDO MAIS DADOS EM turmas
INSERT INTO
	turmas (nome, modulo, data_inicio, data_final, id_facilitador)
VALUES
	('T10', 'M4', '2022-08-01', NULL, NULL),
	('T10', 'M1', '2022-01-01', NULL, NULL);

-- COM O USO DO LEFT JOIN, ALÉM DE JUNTAR OS DADOS DE turmas E facilitadores, TAMBÉM SERÃO SELECIONADOS OS DADOS DAS turmas QUE NÃO TEM NENHUM facilitador
SELECT
	f.nome nome_facilitador,
    t.nome nome_turma,
    t.modulo,
    f.id id_facilitador,
    t.id_facilitador id_facilitador_turma
FROM
	turmas t
LEFT JOIN
	facilitadores f ON f.id = t.id_facilitador;

-- COM O USO DO ROGHT JOIN, ALÉM DE JUNTAR OS DADOS DE turmas E facilitadores, TAMBÉM SERÃO SELECIONADOS OS DADOS DE facilitadores QUE NÃO TEM NENHUMA turma
SELECT
	f.nome nome_facilitador,
    t.nome nome_turma,
    t.modulo,
    f.id id_facilitador,
    t.id_facilitador id_facilitador_turma
FROM
	turmas t
RIGHT JOIN
	facilitadores f ON f.id = t.id_facilitador;

-- COM O USO DO FULL JOIN, SERÃO SELECIONADOS OS DADOS DE turmas E facilitadores RELACIONADOS, ALÉM DE TODOS OS DADOS DE turmas E TODOS OS DADOS DE facilitadores
SELECT
	f.nome nome_facilitador,
    t.nome nome_turma,
    t.modulo,
    f.id id_facilitador,
    t.id_facilitador id_facilitador_turma
FROM
	turmas t
FULL JOIN
	facilitadores f ON f.id = t.id_facilitador;
    
SELECT
	t.nome nome_turma,
    f.nome nome_facilitador,
    e.logradouro
FROM 
	turmas t
JOIN
	facilitadores f ON f.id = t.id_facilitador AND t.modulo = 'M4'
LEFT JOIN
	enderecos e ON e.id = f.id_endereco
WHERE
	t.nome = 'T11';

SELECT
	t.nome nome_turma,
    f.nome nome_facilitador,
    f.email,
    e.logradouro
FROM 
	turmas t
RIGHT JOIN
	facilitadores f ON f.id = t.id_facilitador
LEFT JOIN
	enderecos e ON e.id = f.id_endereco;
