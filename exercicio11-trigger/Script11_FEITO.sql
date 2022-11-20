SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBESTATISTICA;
CREATE DATABASE DBESTATISTICA;
USE DBESTATISTICA;

CREATE TABLE pessoa (
	idpessoa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	 nome VARCHAR(45),
	 sexo CHAR(1)
);

CREATE TABLE estatistica (	
	homem INT,
	mulher INT
);

DELIMITER $$
CREATE TRIGGER tr_estatistica_ai AFTER INSERT ON pessoa FOR EACH ROW
BEGIN
	
		IF NEW.sexo = 'M' THEN
			UPDATE estatistica SET homem = homem + 1;
		END IF;
        
        IF NEW.sexo = 'F' THEN
			UPDATE estatistica SET mulher = mulher + 1;
		END IF;

END $$


CREATE TRIGGER tr_estatistica_ad AFTER DELETE ON pessoa FOR EACH ROW
BEGIN

	IF OLD.sexo = 'M' THEN
		UPDATE estatistica SET homem = homem - 1;
	END IF;
    
    IF OLD.sexo = 'F' THEN
		UPDATE estatistica SET mulher = mulher - 1;
	END IF;
    
END $$


CREATE TRIGGER tr_estatistica_au AFTER UPDATE ON pessoa FOR EACH ROW
BEGIN

	-- DADOS NOVOS
	IF NEW.sexo = 'M' THEN
		UPDATE estatistica SET homem = homem + 1;
	END IF;
    
    IF NEW.sexo = 'F' THEN
		UPDATE estatistica SET mulher = mulher + 1;
    END IF;
    
    
    -- DADOS ANTIGOS
    IF OLD.sexo = 'M' THEN
		UPDATE estatistica SET homem = homem - 1;
	END IF;
    
    IF OLD.sexo = 'F' THEN
		UPDATE estatistica SET mulher = mulher - 1;
	END IF;
    
END $$