-- DROPS: Apaga as tabelas "Funcionario" e "Departamento" caso já existam
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Departamento;

-- Criação da tabela "Departamento" com a coluna CODDEPARTAMENTO como chave primária
CREATE TABLE Departamento
(
    CODDEPARTAMENTO serial, 
    NOME VARCHAR(100), 
    CONSTRAINT "DepartamentoPK" PRIMARY KEY (CODDEPARTAMENTO)
);

-- Criação da tabela "Funcionario" com chave primária e restrições de sexo e relacionamento com a tabela "Departamento"
CREATE TABLE Funcionario
(
    codFuncionario serial,
    codDepartamento integer,
    CPF varchar(15) UNIQUE, 
    Nome varchar(50) NOT NULL,
    Salario numeric(7,2) NOT NULL,
    DataNascimento date,
    Sexo varchar(1),
    CONSTRAINT "FuncionarioPK" PRIMARY KEY (codFuncionario),
    CONSTRAINT "CheckSexo" CHECK (Sexo = 'M' OR Sexo = 'F'),
    CONSTRAINT "FuncionarioFKDepartamento" FOREIGN KEY (codDepartamento)
        REFERENCES Departamento (codDepartamento)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Inserção de dados nos departamentos
INSERT INTO departamento (nome) VALUES ('Marketing');
INSERT INTO departamento (nome) VALUES ('Vendas');
INSERT INTO departamento (nome) VALUES ('Gestão');
INSERT INTO departamento (nome) VALUES ('Produção');

-- Inserção de dados dos funcionários com diferentes cargos e departamentos
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (1, '8736201', 'Maria Julia', 3765, to_date('02/04/1985','DD/MM/YYYY'), 'F');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (4, '092887221', 'Jose Geraldo', 8765, to_date('02/03/1980','DD/MM/YYYY'), 'M');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (2, '765527221', 'Jean Valjean', 4560.7, to_date('10/11/1950','DD/MM/YYYY'), 'M');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (1, '12998762', 'Ricardo Uno Dos', 1770, to_date('20/09/1977','DD/MM/YYYY'), 'M');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (4, '828722121', 'Geraldo Julio Sperafico', 18765, to_date('28/02/1945','DD/MM/YYYY'), 'M');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (3, '121232521', 'Paulo Lopes', 5600, to_date('15/08/1999','DD/MM/YYYY'), 'M');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (2, '0344617221', 'Carla Montenegro', 7000.23, to_date('02/03/1995','DD/MM/YYYY'), 'F');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (3, '09232287221', 'Josefa Fátima', 4666, to_date('12/07/1970','DD/MM/YYYY'), 'F');

-- Inserção de mais departamentos
INSERT INTO departamento(nome) VALUES('TI');
INSERT INTO departamento(nome) VALUES('RH');
INSERT INTO departamento(nome) VALUES('Administração');
INSERT INTO departamento(nome) VALUES('Almox');

-- Inserção de mais funcionários nos departamentos criados
INSERT INTO funcionario(codDepartamento, cpf, nome, salario, datanascimento)
VALUES(5, '01243565478', 'João Matias', 0, to_date('28/05/1995', 'DD/MM/YYYY'));
INSERT INTO funcionario(codDepartamento, cpf, nome, salario, datanascimento, sexo)
VALUES(6, '12578487878', 'Marieli Correia', 1000, to_date('12/12/1998', 'DD/MM/YYYY'), 'F');
INSERT INTO funcionario(codDepartamento, cpf, nome, salario, datanascimento, sexo)
VALUES(7, '02876487878', 'Marireia', 1200, to_date('22/12/1991', 'DD/MM/YYYY'), 'F');
INSERT INTO funcionario (codDepartamento, CPF, nome, salario, datanascimento, sexo)
VALUES (5, '725722121', 'Carlos Jumio Sperafico', 18765, to_date('28/02/1945','DD/MM/YYYY'), 'M');

-- Inserção do departamento P&D
INSERT INTO departamento(nome) VALUES('P&D');

-- Atualização de João Matias para o departamento P&D
UPDATE Funcionario
SET codDepartamento = 9
WHERE nome = 'João Matias';

-- Alteração do nome do departamento Almox para Almoxarifado
UPDATE departamento
SET nome = 'Almoxarifado'
WHERE nome = 'Almox';

-- Concatenação de 'Depto' com o nome de todos os departamentos
UPDATE departamento
SET nome = 'Depto ' || nome;

-- Exibição dos funcionários homens que trabalham no departamento TI ou RH
SELECT * FROM funcionario
WHERE sexo = 'M' AND (codDepartamento = 5 OR codDepartamento = 6);

-- Exibição apenas dos nome e CPF de funcionários com salários entre 2000 e 10000
SELECT nome, cpf FROM funcionario
WHERE salario BETWEEN 2000 AND 10000;

-- Exibição do nome e idade (calculada a partir da data de nascimento) de todos os funcionários
SELECT nome, datanascimento, EXTRACT(YEAR FROM age(datanascimento)) AS idade FROM funcionario;

-- Exibição do nome e idade dos funcionários, com cálculo direto da função "age"
SELECT nome, datanascimento, age(datanascimento) AS idade FROM funcionario;

-- Exibição dos funcionários do departamento 03
SELECT * FROM funcionario
WHERE codDepartamento = 3;

-- Exclusão de funcionários com mais de 50 anos de idade
DELETE FROM funcionario
WHERE EXTRACT(YEAR FROM age(datanascimento)) > 50;

-- Aumento de 10% para o salário de todas as mulheres
UPDATE funcionario
SET salario = salario * 1.10
WHERE sexo = 'F';
