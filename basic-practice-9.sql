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

-- 1) Liste o título dos livros, seus autores e a categoria a que pertencem.



-- 2) Informe o nome das categorias e quantos livros há em cada uma delas. Mostre apenas as categorias com pelo menos 3 livros.

-- 3) Mostre o nome do livro, o nome do autor e indique se o livro é “recente” (publicado a partir de 2020) ou “antigo” (antes de 2020).

-- 4) Mostre a quantidade total de empréstimos realizados e a quantidade total de reservas feitas (em uma linha para cada resultado).

-- 5) Liste os dados dos empréstimos realizados por alunos do curso de ‘Engenharia’ que ingressaram antes de 2022, ordenados da devolução mais recente para a mais antiga.

-- 6) Liste os livros (título e autor) que possuem mais de 3 exemplares registrados.

-- 7) Informe o total de empréstimos finalizados (com data_devolucao preenchida) e o total de empréstimos em aberto (sem data_devolucao). Uma linha para cada.

-- 8) Liste os nomes dos alunos que têm pelo menos uma reserva ativa (data_validade maior ou igual a hoje) e cujo nome contenha a letra ‘e’.

