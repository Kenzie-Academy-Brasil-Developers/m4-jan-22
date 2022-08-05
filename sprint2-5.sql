-- CRIANDO TABELA alunos
CREATE TABLE IF NOT EXISTS alunos(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  	nome VARCHAR(45) NOT NULL,
  	email VARCHAR(45) NOT NULL
);

-- CRIANDO TABELA PIVÔ QUE IRÁ PERMITIR O RELACIONAMENTO N:N ENTRE alunos E turmas
-- OU SEJA, UMA TURMA PODERÁ TER VÁRIOS alunos, E UM ALUNO PASSARÁ POR VÁRIAS turmas
CREATE TABLE IF NOT EXISTS alunos_turmas(
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  	id_turma UUID NOT NULL,
  	FOREIGN KEY (id_turma) REFERENCES turmas(id) ON DELETE RESTRICT,
  	id_aluno UUID NOT NULL,
  	FOREIGN KEY (id_aluno) REFERENCES alunos(id) ON DELETE CASCADE,
  	nota_final DECIMAL(5,2)
);

-- INSERINDO NOVOS alunos
INSERT INTO
	alunos(nome, email)
VALUES
	('Matheus', 'matheus@email.com'),
    ('Hugo', 'hugo@email.com'),
    ('Luccas', 'luccas@email.com'),
    ('Ana Vitória', 'ana@email.com');
    
SELECT * FROM alunos;

SELECT * FROM turmas;

-- INSERINDO OS alunos CRIADOS ANTERIORMENTE A turmas JÁ EXISTENTES
INSERT INTO
	alunos_turmas(id_aluno, id_turma)
VALUES
	((SELECT id FROM alunos WHERE email='ana@email.com'), '3c0fbc14-a200-4b20-bd5b-4132d256fb20'),
	((SELECT id FROM alunos WHERE email='hugo@email.com'), '3c0fbc14-a200-4b20-bd5b-4132d256fb20'),
	((SELECT id FROM alunos WHERE email='matheus@email.com'), '3c0fbc14-a200-4b20-bd5b-4132d256fb20'),
	((SELECT id FROM alunos WHERE email='luccas@email.com'), 'd1154824-066b-4672-8c37-16a924bfc545'),
	((SELECT id FROM alunos WHERE email='ana@email.com'), 'd1154824-066b-4672-8c37-16a924bfc545'),
	((SELECT id FROM alunos WHERE email='matheus@email.com'), 'd1154824-066b-4672-8c37-16a924bfc545');
    
SELECT * FROM alunos_turmas

-- DELETANDO turmas
-- COMO O ON DELETE DE id_turma ESTÁ COMO RESTRICT NA TABELA alunos_turmas
-- O DELETE DARÁ ERRADO CASO A TURMA TENHA ALGUM ALUNO
DELETE FROM
	turmas
WHERE
	id = '3c0fbc14-a200-4b20-bd5b-4132d256fb20';
    
DELETE FROM
	turmas
WHERE
	id = '75835d6e-2b95-4c1e-894f-8d7f9da769ba';

-- DELETANDO UM aluno
-- COMO O ON DELETE DE id_ALUNO ESTÁ COMO CASCADE NA TABELA alunos_turmas
-- O ALUNO TAMBÉM SERÁ REMOVIDO DA TABELA alunos_turmas
DELETE FROM
	alunos
WHERE
	email = 'hugo@email.com';

-- SELECIONANDO TODOS OS DADOS DE alunos_turmas E UNINDO COM turmas E alunos
-- MOSTRANDO APENAS O NOME DO ALUNO, EMAIL DO ALUNO, NOME DA TURMA E MODULO NA VISUALIZAÇÃO
SELECT 
	a.nome nome_aluno,
    a.email,
    t.nome nome_turma,
    t.modulo
FROM
	alunos_turmas at
JOIN
	turmas t ON t.id = at.id_turma
JOIN
	alunos a ON a.id = at.id_aluno;
    
SELECT 
	a.nome nome_aluno,
    a.email,
    t.nome nome_turma,
    f.nome nome_facilitador,
    t.modulo
FROM
	alunos_turmas at
JOIN
	turmas t ON t.id = at.id_turma
JOIN
	alunos a ON a.id = at.id_aluno
JOIN
	facilitadores f ON f.id = t.id_facilitador
WHERE t.modulo = 'M1';

-- REMOVENDO A CONSTRAINT DE RESTRICT DA CHAVE ESTRANGEIRA DE id_turma DA TABELA alunos_turmas
ALTER TABLE
	alunos_turmas
DROP CONSTRAINT alunos_turmas_id_turma_fkey RESTRICT;

-- COMO A CHAVE ESTRANGEIRA FOI REMOVIDA, CRIAMOS UMA NOVA
-- DESSA VEZ, SEM O ON DELETE RESTRICT
ALTER TABLE
	alunos_turmas
ADD CONSTRAINT turmas_fk
FOREIGN KEY (id_turma)
REFERENCES turmas(id);

-- CONTANDO TODOS OS ALUNOS DA turma T11 no modulo M4
SELECT
	COUNT(*)
FROM
	alunos_turmas al
JOIN
	turmas t ON al.id_turma = t.id
WHERE t.nome = 'T11' AND t.modulo = 'M4';

INSERT INTO
	alunos(nome, email)
VALUES
	('jOAO', 'Joao@email.com');

SELECT
	*
FROM
	alunos a
LEFT JOIN
	alunos_turmas al ON al.id_aluno = a.id
LEFT JOIN
	turmas t ON t.id = al.id_turma;

-- AGRUPANDO A CONTAGEM DE ALUNOS, PARA SABER QUANTOS ALUNOS CADA TURMA DE CADA MODULO TEM
SELECT
	t.nome, t.modulo, COUNT(*) 
FROM
	turmas t
JOIN
	alunos_turmas at ON at.id_turma = t.id
GROUP BY t.nome, t.modulo;