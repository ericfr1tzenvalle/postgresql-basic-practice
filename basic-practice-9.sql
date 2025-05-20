CREATE TABLE aluno (
  codaluno INT PRIMARY KEY,
  nome_aluno VARCHAR(100),
  curso VARCHAR(100),
  ano_ingresso INT,
  data_nasc DATE
);

CREATE TABLE autor (
  codautor INT PRIMARY KEY,
  nome_autor VARCHAR(100)
);

CREATE TABLE categoria (
  codcategoria INT PRIMARY KEY,
  nome_categoria VARCHAR(50)
);

CREATE TABLE livro (
  codlivro INT PRIMARY KEY,
  titulo VARCHAR(200),
  codcategoria INT,
  codautor INT,
  ano_publicacao INT,
  FOREIGN KEY (codcategoria) REFERENCES categoria(codcategoria),
  FOREIGN KEY (codautor) REFERENCES autor(codautor)
);

CREATE TABLE exemplar (
  codexemplar INT PRIMARY KEY,
  codlivro INT,
  status VARCHAR(20), -- disponível, emprestado, danificado
  FOREIGN KEY (codlivro) REFERENCES livro(codlivro)
);

CREATE TABLE emprestimo (
  codemprestimo INT PRIMARY KEY,
  codexemplar INT,
  codaluno INT,
  data_emprestimo DATE,
  data_devolucao DATE,
  FOREIGN KEY (codexemplar) REFERENCES exemplar(codexemplar),
  FOREIGN KEY (codaluno) REFERENCES aluno(codaluno)
);

CREATE TABLE reserva (
  codreserva INT PRIMARY KEY,
  codexemplar INT,
  codaluno INT,
  data_reserva DATE,
  data_validade DATE,
  FOREIGN KEY (codexemplar) REFERENCES exemplar(codexemplar),
  FOREIGN KEY (codaluno) REFERENCES aluno(codaluno)
);
-- Tabela autor
INSERT INTO autor (codautor, nome_autor) VALUES
(1, 'Machado de Assis'),
(2, 'J.K. Rowling'),
(3, 'Stephen King'),
(4, 'Yuval Noah Harari');

-- Tabela categoria
INSERT INTO categoria (codcategoria, nome_categoria) VALUES
(1, 'Literatura'),
(2, 'Fantasia'),
(3, 'Terror'),
(4, 'História');

-- Tabela livro
INSERT INTO livro (codlivro, titulo, codcategoria, codautor, ano_publicacao) VALUES
(1, 'Dom Casmurro', 1, 1, 1899),
(2, 'Harry Potter e a Pedra Filosofal', 2, 2, 1997),
(3, 'It - A Coisa', 3, 3, 1986),
(4, 'Sapiens', 4, 4, 2011),
(5, 'Harry Potter e o Cálice de Fogo', 2, 2, 2000),
(6, 'The Institute', 3, 3, 2019),
(7, '21 Lições para o Século 21', 4, 4, 2018),
(8, 'Harry Potter e as Relíquias da Morte', 2, 2, 2007),
(9, 'Carrie', 3, 3, 1974);

-- Tabela aluno
INSERT INTO aluno (codaluno, nome_aluno, curso, ano_ingresso, data_nasc) VALUES
(1, 'Ana Beatriz', 'Engenharia', 2020, '2001-05-12'),
(2, 'Carlos Eduardo', 'Medicina', 2019, '1999-08-03'),
(3, 'Renata Silva', 'Engenharia', 2021, '2002-11-22'),
(4, 'Pedro Henrique', 'Direito', 2018, '1998-02-10'),
(5, 'Mariana Oliveira', 'Engenharia', 2017, '1997-07-15');

-- Tabela exemplar
INSERT INTO exemplar (codexemplar, codlivro, status) VALUES
(1, 1, 'disponível'),
(2, 2, 'emprestado'),
(3, 2, 'disponível'),
(4, 3, 'emprestado'),
(5, 4, 'disponível'),
(6, 5, 'emprestado'),
(7, 6, 'disponível'),
(8, 6, 'disponível'),
(9, 6, 'disponível'),
(10, 7, 'disponível'),
(11, 8, 'disponível'),
(12, 9, 'emprestado');

-- Tabela emprestimo
INSERT INTO emprestimo (codemprestimo, codexemplar, codaluno, data_emprestimo, data_devolucao) VALUES
(1, 2, 1, '2025-04-01', '2025-04-10'),
(2, 4, 2, '2025-04-05', NULL),
(3, 6, 5, '2025-03-20', '2025-04-01'),
(4, 12, 3, '2025-04-10', NULL);

-- Tabela reserva
INSERT INTO reserva (codreserva, codexemplar, codaluno, data_reserva, data_validade) VALUES
(1, 3, 1, '2025-05-01', '2025-05-15'),
(2, 5, 4, '2025-05-05', '2025-05-20'),
(3, 7, 3, '2025-05-10', '2025-05-30');

-- Autores novos para esses livros recentes
INSERT INTO autor (codautor, nome_autor) VALUES
(10, 'Yuval Harari'),
(11, 'André Diamand'),
(12, 'Bruna Lombardi');

-- Livros recentes (a partir de 2020)
INSERT INTO livro (codlivro, titulo, codcategoria, codautor, ano_publicacao) VALUES
(15, '21 Lições para o Século 21', 4, 10, 2020),
(16, 'Revolução dos Bichos', 1, 11, 2021),
(17, 'A Vida Não Precisa Ser Tão Complicada', 1, 12, 2022);


-- 1) Liste o título dos livros, seus autores e a categoria a que pertencem.
SELECT l.titulo, a.nome_autor, c.nome_categoria from livro as l
JOIN autor as a ON a.codautor = l.codautor
JOIN categoria as c ON c.codcategoria = l.codcategoria;

-- 2) Informe o nome das categorias e quantos livros há em cada uma delas. Mostre apenas as categorias com pelo menos 3 livros.
SELECT c.nome_categoria as "Categorias", count(l.codcategoria) as "Quantidade" from categoria as c
JOIN livro as l ON l.codcategoria = c.codcategoria
GROUP BY c.nome_categoria
HAVING count(*) > 2;

-- 3) Mostre o nome do livro, o nome do autor e indique se o livro é “recente” (publicado a partir de 2020) ou “antigo” (antes de 2020).
SELECT l.titulo, a.nome_autor,
CASE
	WHEN l.ano_publicacao >= 2020 THEN 'Recente'
	WHEN l.ano_publicacao < 2020 THEN 'Antigo'
END as "Recente?" FROM livro as l
JOIN autor as a ON a.codautor = l.codautor
ORDER BY l.ano_publicacao DESC;


-- 4) Mostre a quantidade total de empréstimos realizados e a quantidade total de reservas feitas (em uma linha para cada resultado).
SELECT count(e.codemprestimo) as "Quantidade", 'de emprestimo' as "Total" FROM emprestimo as e
UNION
SELECT count(r.codreserva), 'de reserva' FROM reserva as r;


-- 5) Liste os dados dos empréstimos realizados por alunos do curso de ‘Engenharia’ que ingressaram antes de 2022, ordenados da devolução mais recente para a mais antiga.
SELECT e.* from emprestimo as e
JOIN aluno as a ON a.codaluno = e.codaluno
WHERE a.curso = 'Engenharia' and a.ano_ingresso < 2022 and a.ano_ingresso IS NOT NULL
ORDER BY e.data_devolucao DESC;
-- 6) Liste os livros (título e autor) que possuem mais de 2 exemplares registrados.
SELECT l.titulo, a.nome_autor, count(e.codLivro) as "TotalExemplares" from Livro as l
JOIN exemplar as e ON e.codlivro = l.codlivro
JOIN autor as a ON a.codautor = l.codautor
GROUP BY l.titulo, a.nome_autor
HAVING count(*) > 2;

-- 7) Informe o total de empréstimos finalizados (com data_devolucao preenchida) e o total de empréstimos em aberto (sem data_devolucao). Uma linha para cada.
SELECT count(ed.codemprestimo) as "Emprestimos", 'Finalizados' as "Finalizados?" from emprestimo as ed
WHERE ed.data_devolucao IS NOT NULL
UNION
SELECT count(eb.codemprestimo), 'Aberto' from emprestimo as eb
WHERE eb.data_devolucao is NULL;





-- 8) Liste os nomes dos alunos que têm pelo menos uma reserva ativa (data_validade maior ou igual a hoje) e cujo nome contenha a letra ‘e’.

SELECT a.nome_aluno, count(*) as total_reserva from aluno as "a"
JOIN reserva as r ON r.codaluno = a.codaluno
GROUP BY a.nome_aluno, r.data_validade
HAVING a.nome_aluno ILIKE '%e%' 
AND r.data_validade >= CURRENT_DATE;

