-- Criação da tabela "Professor"
CREATE TABLE "Professor"(
    "cpf" char(16),  -- CPF como chave primária
    "nome" varchar(50) NOT NULL, 
    "area" varchar(50) NOT NULL,  
    PRIMARY KEY("cpf")  -- A chave primária é o CPF
);

-- Criação da tabela "Curso"
CREATE TABLE "Curso"(
    "codCurso" int,  -- Código do curso
    "nome" varchar(50) NOT NULL,  
    "nivel" varchar(50) NOT NULL,  -- Nível do curso (por exemplo, "Ensino Médio")
    PRIMARY KEY("codCurso")  -- Chave primária é o código do curso
);

-- Criação da tabela "Aluno"
CREATE TABLE "Aluno"(
    "matricula" varchar(20),  -- Matrícula do aluno como chave primária
    "nome" varchar(50) NOT NULL,  
    "dataNasc" date NOT NULL,  
    "codCurso" int NOT NULL, 
    PRIMARY KEY("matricula"),  -- A chave primária é a matrícula
    FOREIGN KEY("codCurso")  -- Chave estrangeira para o curso
        REFERENCES "Curso"("codCurso")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Criação da tabela "Disciplina"
CREATE TABLE "Disciplina"(
    "codDisciplina" int,  -- Código da disciplina
    "nome" varchar(50) NOT NULL, 
    "horas" int CHECK(horas>=0) NOT NULL,  -- Verifica se o número de horas é positivo
    "creditos" int CHECK(creditos>=0) NOT NULL,  -- Verifica se o número de créditos é positivo
    "codCurso" int NOT NULL,  -- Código do curso da disciplina
    PRIMARY KEY("codDisciplina"),  -- A chave primária é o código da disciplina
    FOREIGN KEY("codCurso")  -- Chave estrangeira para o curso
        REFERENCES "Curso"("codCurso")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Criação da tabela "Turma"
CREATE TABLE "Turma"(
    "codTurma" int,  -- Código da turma
    "semestre" int NOT NULL,  -- Semestre em que a turma foi criada
    "ano" int NOT NULL,  -- Ano em que a turma foi criada
    "codProfessor" char(16) NOT NULL,  -- Código do professor
    "codDisciplina" int NOT NULL,  -- Código da disciplina
    PRIMARY KEY("codTurma"),  -- A chave primária é o código da turma
    FOREIGN KEY("codProfessor")  -- Chave estrangeira para o professor
        REFERENCES "Professor"("cpf")
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY("codDisciplina")  -- Chave estrangeira para a disciplina
        REFERENCES "Disciplina"("codDisciplina")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Criação da tabela "preReq"
CREATE TABLE "preReq"(
    "codDisciplinaLiberada" int NOT NULL,  -- Código da disciplina liberada
    "codDisciplinaRequisito" int NOT NULL,  -- Código da disciplina requisito
    PRIMARY KEY("codDisciplinaLiberada","codDisciplinaRequisito"),  -- Chave primária composta
    FOREIGN KEY("codDisciplinaLiberada")  -- Chave estrangeira para a disciplina liberada
        REFERENCES "Disciplina"("codDisciplina")
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY("codDisciplinaRequisito")  -- Chave estrangeira para a disciplina requisito
        REFERENCES "Disciplina"("codDisciplina")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Criação da tabela "AlunoTurma"
CREATE TABLE "AlunoTurma"(
    "codAluno" varchar(20) NOT NULL,  -- Código do aluno
    "codTurma" int NOT NULL,  -- Código da turma
    PRIMARY KEY("codAluno", "codTurma"),  -- Chave primária composta
    FOREIGN KEY("codAluno")  -- Chave estrangeira para o aluno
        REFERENCES "Aluno"("matricula")
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY("codTurma")  -- Chave estrangeira para a turma
        REFERENCES "Turma"("codTurma")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- i) Alteração do nome da tabela "preReq" para "preRequisito"
ALTER TABLE "preReq" RENAME TO "preRequisito";

-- ii) Adição da coluna "rg" e restrição UNIQUE para "Aluno" e "Professor"
ALTER TABLE "Aluno" ADD COLUMN "rg" varchar(20);  -- Adiciona a coluna rg na tabela Aluno
ALTER TABLE "Aluno" ADD CONSTRAINT unique_rg_aluno UNIQUE ("rg");  -- Restrição UNIQUE para rg em Aluno
ALTER TABLE "Professor" ADD COLUMN "rg" varchar(20);  -- Adiciona a coluna rg na tabela Professor
ALTER TABLE "Professor" ADD CONSTRAINT unique_rg_prof UNIQUE ("rg");  -- Restrição UNIQUE para rg em Professor

-- iii) Adição da coluna "sexo" e restrição CHECK para "Aluno" e "Professor"
ALTER TABLE "Aluno" ADD COLUMN "sexo" char(1);  -- Adiciona a coluna sexo na tabela Aluno
ALTER TABLE "Professor" ADD COLUMN "sexo" char(1);  -- Adiciona a coluna sexo na tabela Professor

-- Restrições CHECK para garantir que o valor seja 'M' ou 'S'
ALTER TABLE "Professor" ADD CONSTRAINT chk_sexo_prof CHECK(sexo IN('M','S'));
ALTER TABLE "Aluno" ADD CONSTRAINT chk_sexo_aluno CHECK(sexo IN('M','S'));

-- iv) Restrições para garantir que as colunas "horas" e "creditos" de "Disciplina" não possam ser negativas
-- (Já feitas na criação da tabela "Disciplina", através do CHECK)

-- v) Alteração do tipo da coluna "codCurso" para "serial"
-- A alteração de tipo de coluna diretamente para "serial" não é permitida, então usamos uma sequência
-- Primeiro, alteramos a coluna "codCurso" para INTEGER (caso não seja já)
ALTER TABLE "Curso" ALTER COLUMN "codCurso" TYPE INTEGER;
-- Criamos uma sequência para "codCurso"
CREATE SEQUENCE seq_codcurso START 1;
-- Definimos a sequência como valor padrão para a coluna
ALTER TABLE "Curso" ALTER COLUMN "codCurso" SET DEFAULT nextval('seq_codcurso');

-- Teste de inserção, sem especificar o valor de "codCurso", que será gerado automaticamente
INSERT INTO "Curso" ("nome", "nivel")
VALUES ('Analise Complexa', 'Ensino Médio');
