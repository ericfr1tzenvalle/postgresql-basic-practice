-- Criação da tabela "Funcionario", com chave primária e campos obrigatórios.
CREATE TABLE "Funcionario"(
    "idFuncionario" serial,
    "nome" varchar(100) NOT NULL,
    "dataNascimento" date NOT NULL,
    "cargo" varchar(50) NOT NULL,
    "salario" numeric(10,2) NOT NULL,
    "dataAdmissao" date NOT NULL,
    PRIMARY KEY("idFuncionario")
);

-- Consulta para visualizar os dados da tabela "Funcionario".
SELECT * FROM "Funcionario";

-- Adicionando a coluna "endereco" na tabela "Funcionario".
ALTER TABLE "Funcionario" ADD COLUMN "endereco" varchar(200);

-- Criação da tabela "Produto" com chave primária e definição de campos obrigatórios.
CREATE TABLE "Produto"(
    "idProduto" serial,
    "nome" varchar(100) NOT NULL,
    "descricao" text NOT NULL,
    "preco" numeric(10,2) NOT NULL,
    "quantidade" int CHECK(quantidade>=0),
    PRIMARY KEY("idProduto")
);

-- Adicionando a coluna "dataValidade" à tabela "Produto".
ALTER TABLE "Produto" ADD COLUMN "dataValidade" date;

-- Criação da tabela "Categoria", com chave primária.
CREATE TABLE "Categoria"(
    "idCategoria" serial,
    "nome" varchar(50) NOT NULL,
    PRIMARY KEY("idCategoria")
);

-- Adicionando a coluna "idCategoria" à tabela "Produto" para fazer a referência à "Categoria".
ALTER TABLE "Produto" ADD COLUMN "idCategoria" int;

-- Definindo a chave estrangeira para a coluna "idCategoria" em "Produto", referenciando "Categoria".
ALTER TABLE "Produto" ADD CONSTRAINT fk_idCategoria FOREIGN KEY("idCategoria")
REFERENCES "Categoria"("idCategoria");

-- Adicionando uma restrição para garantir que o preço de "Produto" seja sempre positivo.
ALTER TABLE "Produto" ADD CONSTRAINT chk_preco_positivo CHECK (preco >= 0);

-- Criação da tabela "Venda", com chaves estrangeiras referenciando "Funcionario" e "Produto".
CREATE TABLE "Venda"(
    "idVenda" serial,
    "idFuncionario" int NOT NULL,
    "idProduto" int NOT NULL,
    "dataVenda" timestamp NOT NULL,
    "quantidade" int NOT NULL,
    "valorTotal" numeric(10,2) NOT NULL,
    PRIMARY KEY("idVenda"),
    FOREIGN KEY("idFuncionario") REFERENCES "Funcionario"("idFuncionario")
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY("idProduto") REFERENCES "Produto" ("idProduto")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Criação da tabela de relacionamento "FuncionarioCurso", associando funcionários a cursos.
CREATE TABLE "FuncionarioCurso"(
    "idFuncionario" int NOT NULL,
    "idCurso" int NOT NULL,
    "dataConclusao" date NOT NULL,
    PRIMARY KEY("idFuncionario","idCurso")
);

-- Definindo as chaves estrangeiras para "FuncionarioCurso".
ALTER TABLE "FuncionarioCurso"
ADD CONSTRAINT fk_funcionario FOREIGN KEY ("idFuncionario") REFERENCES "Funcionario"("idFuncionario");

ALTER TABLE "FuncionarioCurso"
ADD CONSTRAINT fk_curso FOREIGN KEY ("idCurso") REFERENCES "Curso"("idCurso");

-- Alterando a tabela "Funcionario" para definir um valor padrão para o campo "salario".
ALTER TABLE "Funcionario" ALTER COLUMN "salario" SET DEFAULT 2000;

-- Adicionando uma restrição de unicidade para o campo "cargo" na tabela "Funcionario".
ALTER TABLE "Funcionario" ADD CONSTRAINT unique_cargo UNIQUE ("cargo");

-- Criação da tabela "Departamento", com chave primária.
CREATE TABLE "Departamento"(
    "idDepartamento" serial,
    "nome" varchar(50) NOT NULL,
    PRIMARY KEY("idDepartamento")
);

-- Adicionando a coluna "idDepartamento" à tabela "Funcionario", para referenciar "Departamento".
ALTER TABLE "Funcionario" ADD COLUMN "idDepartamento" int;

-- Definindo a chave estrangeira entre "Funcionario" e "Departamento".
ALTER TABLE "Funcionario" ADD CONSTRAINT fk_idDepartamento FOREIGN KEY("idDepartamento")
REFERENCES "Departamento"("idDepartamento");

-- Criação da tabela "Curso", que será referenciada por "FuncionarioCurso".
CREATE TABLE "Curso"(
    "idCurso" serial,
    "nome" varchar(100) NOT NULL,
    "descricao" text,
    PRIMARY KEY("idCurso")
);
