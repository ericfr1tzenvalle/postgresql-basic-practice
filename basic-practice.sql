-- Criação da tabela Cliente
CREATE TABLE "Cliente" (
  "cpf" CHAR(14) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "telefone" VARCHAR(20) NOT NULL,
  PRIMARY KEY ("cpf")
);

-- Criação da tabela Empregado
CREATE TABLE "Empregado" (
  "cpf" CHAR(14) NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "cargo" VARCHAR(50) NOT NULL,
  PRIMARY KEY ("cpf")
);

-- Criação da tabela Projeto, com chaves estrangeiras para Empregado (gerente) e Cliente
CREATE TABLE "Projeto" (
  "codProj" INT NOT NULL,
  "nome" VARCHAR(50) NOT NULL,
  "descricao" TEXT NOT NULL,
  "preco" DECIMAL(10,2) NOT NULL,
  "dtFim" DATE NOT NULL,
  "dtEstimada" DATE NOT NULL,
  "dtSolicitacao" DATE NOT NULL,
  "cpfGerente" CHAR(14) NOT NULL,
  "cpfCliente" CHAR(14) NOT NULL,
  PRIMARY KEY ("codProj"),
  FOREIGN KEY ("cpfGerente") REFERENCES "Empregado" ("cpf")
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY ("cpfCliente") REFERENCES "Cliente" ("cpf")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Renomeia a tabela "Empregado" para "Empregados"
ALTER TABLE "Empregado" RENAME TO "Empregados";

-- Adiciona uma nova coluna "rg" à tabela "Clientes"
ALTER TABLE "Clientes" ADD COLUMN "rg" VARCHAR(20);

-- Visualiza os registros da tabela Cliente
SELECT * FROM "Cliente";

-- Altera o tipo da coluna "preco" da tabela Projeto para NUMERIC(12,2)
ALTER TABLE "Projeto" ALTER COLUMN "preco" TYPE NUMERIC(12,2);

-- Seleciona todos os dados da tabela Projeto
SELECT * FROM "Projeto";

-- Adiciona uma restrição de unicidade ao campo "rg" da tabela Cliente
ALTER TABLE "Cliente" ADD CONSTRAINT "uk_rg_cliente" UNIQUE ("rg");

-- Cria uma sequência para geração automática de códigos de projeto
CREATE SEQUENCE cod_proj_seq
START WITH 1
INCREMENT BY 1;

-- Define a sequência criada como valor padrão para a coluna codProj
ALTER TABLE "Projeto" ALTER COLUMN "codProj" SET DEFAULT nextval('cod_proj_seq');

-- Insere dados na tabela Cliente
INSERT INTO "Cliente" ("cpf","nome","telefone","rg")
VALUES
('123.456.789-01', 'Ana Costa', '(31) 99888-7777', 'MG-01.234.567'),
('987.654.321-02', 'Carlos Almeida', '(31) 97777-6666', 'SP-23.456.789'),
('321.654.987-03', 'Fernanda Souza', '(31) 96666-5555', 'RJ-34.567.890'),
('456.789.123-04', 'Marcos Oliveira', '(31) 95555-4444', 'MG-45.678.901'),
('654.321.987-05', 'Juliana Pereira', '(31) 94444-3333', 'SP-56.789.012'),
('111.222.333-06', 'Roberta Lima', '(31) 93333-2222', 'RJ-67.890.123'),
('222.333.444-07', 'José Santos', '(31) 92222-1111', 'MG-78.901.234'),
('333.444.555-08', 'Eduardo Martins', '(31) 91111-0000', 'SP-89.012.345'),
('444.555.666-09', 'Patrícia Silva', '(31) 90000-9999', 'RJ-90.123.456'),
('555.666.777-10', 'Lucas Rocha', '(31) 88999-8888', 'MG-12.345.678');

-- Exibe todos os registros da tabela Cliente
SELECT * FROM "Cliente";

-- Deleta um cliente com nome João (caso existisse)
DELETE FROM "Cliente" WHERE "nome" = 'Joao';

-- Renomeia a tabela Cliente para Clientes
ALTER TABLE "Cliente" RENAME TO "Clientes";

-- Insere um empregado na tabela Empregados
INSERT INTO "Empregados" ("cpf", "nome", "cargo")
VALUES ('98765432100', 'Carlos Pereira', 'Gerente de TI');

-- Exibe todos os registros da tabela Empregados
SELECT * FROM "Empregados";

-- Remove a tabela antiga "Empregado"
DROP TABLE "Empregado";

-- Insere um projeto com gerente e cliente vinculados
INSERT INTO "Projeto" ("nome", "descricao", "preco", "dtFim", "dtEstimada", "dtSolicitacao", "cpfGerente", "cpfCliente")
VALUES ('AKABU', 'DESENVOLVER JOGOS', 90000.00, '2026-12-24', '2026-10-24', '2020-01-12', '98765432100', '222.333.444-07');

-- Seleciona todos os projetos
SELECT * FROM "Projeto";

-- Cria a tabela Departamento
CREATE TABLE "Departamento"(
  "codDep" INT,
  "nome" VARCHAR(50) NOT NULL,
  "localizacao" VARCHAR(100) NOT NULL,
  PRIMARY KEY ("codDep")
);

-- Adiciona a coluna "Status" à tabela Projeto
ALTER TABLE "Projeto" ADD COLUMN "Status" VARCHAR(20);

-- Adiciona a coluna "codDep" (departamento) à tabela Projeto
ALTER TABLE "Projeto" ADD COLUMN "codDep" INT;

-- Define a chave estrangeira de codDep referenciando Departamento
ALTER TABLE "Projeto"
ADD CONSTRAINT "fk_codDep"
FOREIGN KEY("codDep") REFERENCES "Departamento" ("codDep");

-- Visualiza os dados da tabela Projeto
SELECT * FROM "Projeto";

-- Consulta a quantidade de projetos por cliente
SELECT "Clientes".nome AS "Nome Cliente", COUNT("Projeto"."codProj") AS "Numero de Projetos"
FROM "Clientes", "Projeto"
WHERE "Projeto"."cpfCliente" = "Clientes".cpf
GROUP BY "Clientes".nome;

-- Insere múltiplos empregados
INSERT INTO "Empregados" ("cpf", "nome", "cargo") VALUES
('11111111111', 'Ana Beatriz', 'Gerente de Projetos'),
('22222222222', 'Bruno Silva', 'Analista de Sistemas'),
('33333333333', 'Carla Mendes', 'Engenheira de Software'),
('44444444444', 'Diego Ramos', 'Gerente de TI'),
('55555555555', 'Elisa Castro', 'Coordenadora de Projetos');

-- Insere departamentos
INSERT INTO "Departamento" ("codDep", "nome", "localizacao") VALUES
(1, 'Desenvolvimento', 'São Paulo'),
(2, 'Pesquisa e Inovação', 'Belo Horizonte'),
(3, 'Marketing', 'Rio de Janeiro'),
(4, 'Financeiro', 'Curitiba'),
(5, 'Recursos Humanos', 'Porto Alegre');

-- Insere projetos com campos adicionais
INSERT INTO "Projeto" ("nome", "descricao", "preco", "dtFim", "dtEstimada", "dtSolicitacao", "cpfGerente", "cpfCliente", "Status", "codDep") VALUES
('Sistema de Vendas', 'Desenvolvimento de sistema de vendas online', 50000.00, '2025-09-01', '2025-07-01', '2024-08-05', '11111111111', '123.456.789-01', 'Ativo', 1),
('Gestão de Estoque', 'Plataforma para controle de estoque', 30000.00, '2025-10-15', '2025-08-10', '2024-09-20', '22222222222', '123.456.789-01', 'Ativo', 1),
('Sistema Contábil', 'Sistema de controle contábil para empresas', 65000.00, '2025-11-10', '2025-09-01', '2024-07-01', '33333333333', '987.654.321-02', 'Em Andamento', 4),
('Portal Acadêmico', 'Sistema web para universidades', 72000.00, '2026-03-01', '2025-12-01', '2025-02-14', '44444444444', '321.654.987-03', 'Ativo', 2);

-- Outra consulta que retorna a quantidade de projetos por cliente
SELECT COUNT("Projeto"."codProj") AS "NumeroProjetos", "Clientes".nome AS "Nome"
FROM "Projeto", "Clientes"
WHERE "Projeto"."cpfCliente" = "Clientes".cpf
GROUP BY "Clientes".nome;

-- Versão com JOIN explícito da consulta anterior
SELECT "Clientes".nome, 
       COUNT("Projeto"."codProj") AS "NumeroProjetos"
FROM "Projeto"
JOIN "Clientes" ON "Projeto"."cpfCliente" = "Clientes".cpf
GROUP BY "Clientes".nome;
