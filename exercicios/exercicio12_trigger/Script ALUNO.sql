SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBCLASSIFICACAO;
CREATE DATABASE DBCLASSIFICACAO;
USE DBCLASSIFICACAO;

CREATE TABLE ALUNO (
	IDALUNO INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(45)
	, IDADE INT
);

CREATE TABLE CLASSIFICACAO (	
	CRIANCAS INT
	, JOVENS INT
	, ADULTOS INT
);

INSERT INTO CLASSIFICACAO VALUES (0,0,0);

/*
Regra:
abaixo 10 - Criancas
10 a 18 - Jovens
Acima de 18 - Adulto
*/
DELIMITER $$
CREATE TRIGGER tr_aluno_bi BEFORE INSERT ON aluno FOR EACH ROW
BEGIN

	IF NEW.idade  <= 0 THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Idade inválida';
	END IF;
    
END $$ 



CREATE TRIGGER tr_aluno_ai AFTER INSERT ON aluno FOR EACH ROW
BEGIN

	IF NEW.idade < 10 THEN 
		UPDATE classificacao SET criancas = criancas +1;
	ELSEIF NEW.idade > 10 AND NEW.idade <= 18 THEN
		UPDATE classificacao SET jovens = jovens +1;
	ELSE 
		UPDATE classificacao SET adultos = adultos + 1;
	END IF;
    
END $$ 

SELECT * FROM aluno;
SELECT * FROM classificacao;

 -- INSERT INTO aluno(nome,idade) VALUES('ana', 9);
 -- INSERT INTO aluno(nome,idade) VALUES('bruno', 12);
 INSERT INTO aluno(nome,idade) VALUES('JOAO', 0);