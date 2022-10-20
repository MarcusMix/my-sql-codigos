SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBESTATISTICA;
CREATE DATABASE DBESTATISTICA;
USE DBESTATISTICA;

CREATE TABLE PESSOA (
	IDPESSOA INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(45)
	, SEXO CHAR(1)
);

CREATE TABLE ESTATISTICA (	
	HOMEM INT
	, MULHER INT
);

INSERT INTO estatistica VAlUES(0,0);

DELIMITER $$
CREATE TRIGGER tr_pessoa_bi BEFORE INSERT ON pessoa FOR EACH ROW
BEGIN

	IF NEW.sexo NOT IN ('M', 'F') OR NEW.sexo IS NULL THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sexo inválido';
	END IF;
    
END $$ 

CREATE TRIGGER tr_pessoa_ai AFTER INSERT ON pessoa FOR EACH ROW
BEGIN

	IF NEW.sexo = 'M' THEN
		UPDATE estatistica SET homem = homem + 1;
	END IF;
    
    IF NEW.sexo = 'F' THEN
		UPDATE estatistica SET mulher = mulher + 1;
	END IF;
    
END $$


CREATE TRIGGER TR_PESSOA_AD AFTER DELETE ON PESSOA FOR EACH ROW 
BEGIN
	
	IF OLD.sexo = 'M' THEN
		UPDATE estatistica SET homem = homem - 1;
	END IF;
    
    IF OLD.sexo = 'F' THEN
		UPDATE estatistica SET mulher = mulher - 1;
	END IF;
    
END $$


CREATE TRIGGER TR_PESSOA_AU AFTER UPDATE ON PESSOA FOR EACH ROW 
BEGIN

	-- DADOS NOVOS
	IF OLD.sexo = 'M' THEN
		UPDATE estatistica SET homem = homem + 1;
	END IF;
    
    IF OLD.sexo = 'F' THEN
		UPDATE estatistica SET mulher = mulher + 1;
	END IF;
	
    -- DADOS ANTIGOS
	IF OLD.sexo = 'M' THEN
		UPDATE estatistica SET homem = homem + 1;
	END IF;
    
    IF OLD.sexo = 'F' THEN
		UPDATE estatistica SET mulher = mulher + 1;
	END IF;
    
END $$


DELIMITER ;

SELECT * FROM pessoa;
SELECT * FROM estatistica;

-- INSERT INTO pessoa(nome,sexo) VALUES('ana', 'F');
-- INSERT INTO pessoa(nome,sexo) VALUES('bruno', 'M');
-- INSERT INTO pessoa(nome,sexo) VALUES('JOAO', 'X');