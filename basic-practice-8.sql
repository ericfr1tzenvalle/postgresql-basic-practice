CREATE TABLE aluno (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nasc DATE,
    genero CHAR(1)
);

-- Cursos
CREATE TABLE curso (
    id_curso INT PRIMARY KEY,
    nome_curso VARCHAR(100),
    duracao_meses INT
);

-- Professores
CREATE TABLE professor (
    id_professor INT PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(100)
);

-- Disciplinas
CREATE TABLE disciplina (
    id_disciplina INT PRIMARY KEY,
    nome_disciplina VARCHAR(100),
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

-- Turmas
CREATE TABLE turma (
    id_turma INT PRIMARY KEY,
    id_disciplina INT,
    id_professor INT,
    semestre VARCHAR(10),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

-- Matrículas
CREATE TABLE matricula (
    id_matricula INT PRIMARY KEY,
    id_aluno INT,
    id_turma INT,
    data_matricula DATE,
    nota_final DECIMAL(4,2),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

INSERT INTO aluno (id_aluno, nome, data_nasc, genero) VALUES
(1, 'Ana Souza', '2005-03-22', 'F'),
(2, 'Bruno Lima', '2004-11-10', 'M'),
(3, 'Carlos Mendes', '2003-07-18', 'M'),
(4, 'Daniela Rocha', '2006-01-05', 'F'),
(5, 'Eduarda Silveira', '2005-06-25', 'F');


INSERT INTO curso (id_curso, nome_curso, duracao_meses) VALUES
(1, 'Administração', 36),
(2, 'Engenharia de Software', 48),
(3, 'Direito', 60);


INSERT INTO disciplina (id_disciplina, nome_disciplina, id_curso) VALUES
(1, 'Introdução à Administração', 1),
(2, 'Algoritmos e Lógica', 2),
(3, 'Direito Constitucional', 3),
(4, 'Gestão de Pessoas', 1),
(5, 'Banco de Dados', 2);


INSERT INTO professor (id_professor, nome, especialidade) VALUES
(1, 'João Pereira', 'Administração'),
(2, 'Luciana Costa', 'Programação'),
(3, 'Marcos Silva', 'Direito Civil');


INSERT INTO turma (id_turma, id_disciplina, id_professor, semestre) VALUES
(1, 1, 1, '2024.1'),
(2, 2, 2, '2024.1'),
(3, 3, 3, '2024.1'),
(4, 4, 1, '2024.2'),
(5, 5, 2, '2024.2');


INSERT INTO matricula (id_matricula, id_aluno, id_turma, data_matricula, nota_final) VALUES
(1, 1, 1, '2024-01-10', 8.5),
(2, 2, 2, '2024-01-11', 6.7),
(3, 3, 3, '2024-01-15', 7.2),
(4, 1, 4, '2024-07-01', 9.0),
(5, 2, 5, '2024-07-01', 8.0),
(6, 4, 2, '2024-01-20', 5.5),
(7, 5, 5, '2024-07-02', 7.8),
(8, 3, 2, '2024-01-18', 6.0);



SELECT * FROM aluno;


-- 1. Adicione uma nova coluna chamada email na tabela aluno, do tipo VARCHAR(100).
ALTER TABLE aluno ADD COLUMN email varchar(100);

-- 2. Liste o nome dos alunos e o nome do curso em que estão matriculados.
SELECT a.nome, "c".nome_curso FROM aluno as "a"
JOIN matricula as "m" ON m.id_aluno = a.id_aluno
JOIN turma as "t" ON m.id_turma = t.id_turma
JOIN disciplina as "d" ON d.id_disciplina = t.id_disciplina
JOIN curso as "c" ON c.id_curso = d.id_curso;


-- 3. Liste todas as disciplinas com o nome do professor responsável.
-- Ordene o resultado pelo nome do professor (A-Z).

SELECT d.nome_disciplina as "Disciplinas", p.nome as "Professores" FROM disciplina as d
JOIN turma as t ON t.id_disciplina = d.id_disciplina
JOIN professor as p ON t.id_professor = p.id_professor
ORDER BY p.nome;


-- 4. Mostre os alunos que tiveram nota final maior ou igual a 7.
-- Exiba: nome do aluno, nome da disciplina e nota.
SELECT a.nome, d.nome_disciplina, m.nota_final FROM aluno as a
JOIN matricula as m ON m.id_aluno = a.id_aluno
JOIN turma as t ON t.id_turma = m.id_turma
JOIN disciplina as d ON d.id_disciplina = t.id_disciplina
WHERE m.nota_final >= 7;


-- 5. Liste o nome de todos os cursos e o total de disciplinas em cada um.
-- Mostre apenas cursos que possuem pelo menos uma disciplina.
SELECT c.nome_curso, count(d.id_curso) FROM curso as c
JOIN disciplina as d ON d.id_curso = c.id_curso
GROUP BY c.nome_curso
HAVING count(*) >= 1;



-- 6. Liste o nome dos alunos e a média de suas notas finais nas disciplinas cursadas.
-- Use AVG() e agrupe por aluno.
SELECT a.nome as "Alunos", avg(m.nota_final) as "MediaNotas" FROM aluno as a
JOIN matricula as m ON m.id_aluno = a.id_aluno
GROUP BY a.nome
ORDER BY a.nome;


-- 7. Adicione uma nova coluna situacao à tabela matricula, para indicar se o aluno foi "Aprovado" ou "Reprovado".
ALTER TABLE matricula ADD COLUMN situacao boolean;
SELECT * from matricula;
ALTER TABLE matricula ALTER COLUMN situacao TYPE varchar(20);

-- 8. Atualize a coluna situacao da tabela matricula:
-- Se nota_final >= 7, defina como 'Aprovado'
-- Caso contrário, defina como 'Reprovado'
UPDATE matricula as m
SET situacao =
CASE
	WHEN m.nota_final >= 7 THEN 'Aprovado'
	ELSE 'Reprovado'
END;


SELECT * FROM matricula;


-- 9. Mostre os professores que lecionam mais de uma disciplina.
-- Exiba: nome do professor e a quantidade de disciplinas.
SELECT p.nome as "Professores", count(d.id_disciplina) as "Quantidade de Disciplinas" FROM professor as p
JOIN turma as t ON t.id_professor = p.id_professor
JOIN disciplina as d ON t.id_disciplina = d.id_disciplina
GROUP BY p.nome;


-- 10. Liste os 3 alunos com as maiores notas finais.
-- Exiba: nome do aluno, nome da disciplina e a nota.
-- Use ORDER BY nota_final DESC e LIMIT 3.
SELECT a.nome, d.nome_disciplina, m.nota_final FROM aluno as a
JOIN matricula as m ON m.id_aluno = a.id_aluno
JOIN turma as t ON t.id_turma = m.id_turma
JOIN disciplina as d ON d.id_disciplina = t.id_disciplina
ORDER BY nota_final DESC LIMIT 3;


