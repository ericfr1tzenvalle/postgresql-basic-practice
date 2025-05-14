
DROP TABLE IF EXISTS  LOCACAO;
DROP TABLE IF EXISTS  RESERVA;
DROP TABLE IF EXISTS  DVD;
DROP TABLE IF EXISTS  STATUS;
DROP TABLE IF EXISTS  FILME;
DROP TABLE IF EXISTS  CATEGORIA;
DROP TABLE IF EXISTS  CLIENTE;


CREATE TABLE  CLIENTE
   (    CODCLIENTE serial, 
    	NOME_CLIENTE VARCHAR(30) NOT NULL, 
    	ENDERECO VARCHAR(50) NOT NULL, 
    	TELEFONE VARCHAR(12) NOT NULL, 
    	DATA_NASC DATE NOT NULL, 
    	CPF VARCHAR(11) NOT NULL, 
     	CONSTRAINT PK_CLIENTE PRIMARY KEY (CODCLIENTE),
	CONSTRAINT CPF_UNIQUE UNIQUE (CPF)
   );

CREATE TABLE  CATEGORIA 
   (    CODCATEGORIA serial, 
    	NOME_CATEGORIA VARCHAR(100) NOT NULL, 
     	CONSTRAINT CATEGORIA_PK PRIMARY KEY (CODCATEGORIA), 
     	CONSTRAINT CHECK_NOME_CATEGORIA CHECK ( NOME_CATEGORIA in ('drama','terror','ação','aventura','comédia'))
   );

CREATE TABLE  FILME 
   (    CODFILME serial, 
    	CODCATEGORIA int, 
    	NOME_FILME VARCHAR(100) NOT NULL, 
    	DIARIA numeric(10,2) NOT NULL, 
     	CONSTRAINT PK_FILME PRIMARY KEY (CODFILME), 
     	CONSTRAINT FK_FIL_CAT FOREIGN KEY (CODCATEGORIA)
      		REFERENCES  CATEGORIA (CODCATEGORIA)
		ON DELETE NO ACTION ON UPDATE CASCADE
   );

CREATE TABLE  STATUS 
   (    CODSTATUS SERIAL, 
    	NOME_STATUS VARCHAR(30) NOT NULL, 
     	CONSTRAINT PK_STATUS PRIMARY KEY (CODSTATUS),
     	CONSTRAINT CHECK_NOME_STATUS CHECK ( NOME_STATUS in ('reservado','disponível','indisponível','locado'))

   );

CREATE TABLE  DVD 
   (    CODDVD SERIAL, 
    	CODFILME int NOT NULL, 
    	CODSTATUS int NOT NULL, 
     	CONSTRAINT PK_DVD PRIMARY KEY (CODDVD), 
     	CONSTRAINT FK_DVD_FIL FOREIGN KEY (CODFILME)
      		REFERENCES  FILME (CODFILME) ON UPDATE CASCADE, 
     	CONSTRAINT FK_DVD_STA FOREIGN KEY (CODSTATUS)
      		REFERENCES  STATUS (CODSTATUS) ON UPDATE CASCADE
   );

CREATE TABLE  LOCACAO 
   (    CODLOCACAO SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
    	DATA_LOCACAO DATE NOT NULL DEFAULT NOW(), 
    	DATA_DEVOLUCAO DATE, 
     	CONSTRAINT PK_LOCACAO PRIMARY KEY (CODLOCACAO), 
     	CONSTRAINT FK_LOC_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_LOC_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

CREATE TABLE  RESERVA 
   (    CODRESERVA SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
 	DATA_RESERVA DATE DEFAULT NOW(), 
    	DATA_VALIDADE DATE NOT NULL, 
     	CONSTRAINT PK_RESERVA PRIMARY KEY (CODRESERVA), 
     	CONSTRAINT FK_RES_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_RES_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

--inserts

INSERT INTO STATUS (NOME_STATUS) VALUES ('reservado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('disponível');    
INSERT INTO STATUS (NOME_STATUS) VALUES ('locado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('indisponível');
    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('comédia');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'aventura');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'terror');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'ação');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'drama');

INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('João Paulo', 'rua XV de novembro, n:18', '88119922','05-02-1990','09328457398');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Maria', 'rua XV de novembro, n:20', '88225422','07-01-1991','93573923168');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Joana', 'rua XV de novembro, n:10', '99778122','09-07-1980','71398987234');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Jeferson', 'rua XV de novembro, n:118', '84549922','09-12-1982','02128443298');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Paula', 'rua XV de novembro, n:128', '82324232','11-04-1970','57398093284');

INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (1,'Entrando numa fria', 1.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'O Hobbit', 3.00);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (3,'Sobrenatural 2', 4.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (5,'Um sonho de liberdade', 1.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'Thor 2', 4.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (4,'Velozes e Furiosos', 1.50);

INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (1,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (3,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (5,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (6,3);

INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(1,2,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(5,1,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,2,(current_date-30),(current_date-26)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,3,(current_date-4),(current_date-1)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,1,(current_date-20),(current_date-16)); 

INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-30),(current_date-28));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(2,3,(current_date-25),(current_date-23));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-1),current_date);
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(3,2,(current_date-1),null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(6,2,current_date,null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(8,2,current_date,null);


cliente ( cod c liente, nome_cliente, endereco, telefone, data_nasc, cpf)
categoria ( cod c ategoria, nome_categoria) -- drama, ação, aventura, comédia, terror
status ( cod s tatus, nome_status) -- locado, disponível, reservado
filme ( cod f ilme, nome_filme, codcategoria, diaria)
codcategoria referencia categoria
dvd ( cod dvd, codfilme, codstatus)
codfilme referencia filme
codStatus referencia status
locacao ( cod l ocacao, coddvd, codcliente, data_locacao, data_devolucao)
coddvd referencia dvd
codcliente referencia cliente
reserva ( cod r eserva, coddvd, codcliente, data_reserva, data_validade)
coddvd referencia dvd
codcliente referencia cliente


1) Faça uma consulta que retorne o nome de cada filme e o nome de sua categoria.
SELECT f.nome_filme as "Filmes", c.nome_categoria as "Categorias" FROM filme as "f"
JOIN categoria as "c" ON f.codcategoria = c.codcategoria;

2) Faça uma consulta que liste o nome das categorias e o total de filmes por categoria que tem ao menos
um filme.
SELECT c.nome_categoria as "Categorias", count(f.codcategoria) as "TotaldeFilmes" FROM categoria as "c"
JOIN filme as "f" ON f.codcategoria = c.codcategoria
GROUP BY c.nome_categoria;

3) Liste o nome de cada filme, o nome da categoria e se o filme é “lançamento” (diária maior que 3) ou
“catálogo” (diária menor ou igual a 3).
SELECT f.nome_filme as "Filmes", c.nome_categoria as "Categorias", 
CASE
	WHEN f.diaria > 3 THEN 'Lançamento'
	WHEN f.diaria <= 3 THEN 'Catálogo'
END as "Lancamento?" FROM filme as "f"
JOIN categoria as c ON f.codcategoria = c.codcategoria;

4) Faça uma consulta que retorne o total de locações e o total de reservas realizadas (presentes no BD).
Utilize uma linha para cada.
SELECT count(l.codlocacao) as "Total", 'Locação' as "Tipo" FROM locacao as "l" 
UNION
SELECT count(r.codreserva) as "Total", 'Reservas' as "Tipo"  FROM reserva as "r";


5) Informe os dados das locações dos clientes com mais que 40 anos, ordene decrescente pela
data_locacao.
SELECT l.* FROM locacao l
JOIN cliente c ON c.codcliente = l.codcliente
WHERE EXTRACT(YEAR FROM AGE(c.data_nasc)) > 40
ORDER BY l.data_locacao desc;


SELECT * from filme;

SELECT * from dvd;

6) Informe nome do filme, nome da categoria e diária dos filmes com mais de 2 dvds.
SELECT f.nome_filme as "Filmes", c.nome_categoria as "Categorias", f.diaria as "Diaria", count(d.codfilme) as "ContagemDVD" FROM filme as f
JOIN categoria as c ON f.codcategoria = c.codcategoria
JOIN dvd as d ON f.codfilme = d.codfilme
GROUP BY f.nome_filme, c.nome_categoria, f.diaria
HAVING count(*) > 1;

7) Informe o total de locacoes finalizadas e o total de locacoes em aberto (utilize uma linha para cada).
SELECT count(*) as "TotalFinaliza", 'Locacoes Finalizadas' as "Finalzadas" FROM locacao as l
WHERE l.data_devolucao is not null
GROUP BY l.data_devolucao
UNION
SELECT count(*) as "TotalAberto", 'Locacoes em Aberto' as "Em aberto" FROM locacao as "a"
WHERE a.data_devolucao is null
GROUP BY a.data_devolucao;

8) Informe quais clientes tem ‘a’ em alguma parte do nome e uma reserva ou mais realizada.
SELECT c.* FROM cliente as c
JOIN reserva as r ON r.codCliente  = c.codcliente
WHERE c.nome_cliente ilike '%a%';


