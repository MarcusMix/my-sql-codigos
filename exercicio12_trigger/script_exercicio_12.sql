SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBCLASSIFICACAO;
CREATE DATABASE DBCLASSIFICACAO;
USE DBCLASSIFICACAO;

CREATE TABLE aluno (
	idaluno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	idade INT
);

CREATE TABLE classificacao (	
	criancas INT,
	jovens INT,
	adultos INT
);

INSERT INTO CLASSIFICACAO VALUES (0,0,0);

/*
Regra:
abaixo 10 - Criancas
10 a 18 - Jovens
Acima de 18 - Adulto
*/

INSERT INTO aluno VALUES (1,'Marcus' , 20);
INSERT INTO aluno VALUES (2,'Milena' , 15);
INSERT INTO aluno VALUES (3,'Pocahontas' , 7);

DELIMITER $$
CREATE TRIGGER tr_classificacao_ai AFTER INSERT ON aluno FOR EACH ROW
BEGIN

	IF NEW.idade < 10 THEN
		UPDATE classificacao SET criancas = criancas + 1;   
	ELSEIF NEW.idade > 10 AND  NEW.idade <= 18 THEN
		UPDATE classificacao SET jovens = jovens + 1;
	ELSE 
		UPDATE classificacao SET adultos = adultos + 1;
	END IF;

END $$

CREATE TRIGGER tr_classificacao_ad AFTER DELETE ON aluno FOR EACH ROW
BEGIN

	IF OLD.idade < 10 THEN
		UPDATE classificacao SET criancas = criancas - 1;
	ELSEIF OLD.idade > 10 AND OLD.idade <= 18 THEN
		UPDATE classificacao SET jovens = jovens -1;
	ELSE
		UPDATE classificacao SET adultos = adultos -1;
	END IF;
END $$


CREATE TRIGGER tr_classificacao_au AFTER UPDATE ON aluno FOR EACH ROW 
BEGIN

	-- DADOS QUE ESTÃO SAINDO
	IF OLD.idade < 10 THEN
		UPDATE classificacao SET criancas = criancas - 1;
	ELSEIF OLD.idade > 10 AND OLD.idade <= 18 THEN
		UPDATE classificacao SET jovens = jovens -1;
	ELSE
		UPDATE classificacao SET adultos = adultos -1;
	END IF;
    
    -- DADOS QUE ESTÃO ENTRANDO
    IF NEW.idade < 10 THEN
		UPDATE classificacao SET criancas = criancas + 1;   
	ELSEIF NEW.idade > 10 AND  NEW.idade <= 18 THEN
		UPDATE classificacao SET jovens = jovens + 1;
	ELSE 
		UPDATE classificacao SET adultos = adultos + 1;
	END IF;

END $$



DELIMITER ;












SELECT * FROM classificacao;

DELETE FROM aluno WHERE idaluno = 6;

 INSERT INTO aluno(nome,idade) VALUES('ana', 9);
  INSERT INTO aluno(nome,idade) VALUES('bruno', 12);
 INSERT INTO aluno(nome,idade) VALUES('JOAO', 20);