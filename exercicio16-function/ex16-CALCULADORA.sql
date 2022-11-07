SET SQL_SAFE_UPDATES = 0;
drop database if exists dbexercicio16;
create database dbexercicio16;
use dbexercicio16;

DELIMITER $$



CREATE FUNCTION soma (x INT, y INT) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE vRESULTADO INT;
    SET vRESULTADO = x + y;
    RETURN vRESULTADO;
END $$

CREATE FUNCTION sub (x INT, y INT) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE vRESULTADO INT;
    SET vRESULTADO = x - y;
    RETURN vRESULTADO;
END $$

CREATE FUNCTION mult (x INT, y INT) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE vRESULTADO INT;
    SET vRESULTADO = x * y;
    RETURN vRESULTADO;
END $$

CREATE FUNCTION divi (x INT, y INT) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE vRESULTADO INT;
    SET vRESULTADO = x / y;
    RETURN vRESULTADO;
END $$


CREATE FUNCTION calculadora (x INT, y INT, operador CHAR(1)) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE vRESULTADO INT;
    
	CASE operador
		WHEN '+' THEN  SET vRESULTADO = soma(x , y);
        WHEN '-' THEN  SET vRESULTADO = sub(x , y);
        WHEN '*' THEN  SET vRESULTADO = mult(x , y);
        WHEN '/' THEN  SET vRESULTADO = divi(x , y);
	END CASE;
    
    RETURN vRESULTADO;
    
END $$

CREATE FUNCTION calculadora2 (x INT, y INT, operador CHAR(1)) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE vRESULTADO INT;
    
	IF operador = '+' THEN
		SET operador = soma (x, y);
    ELSEIF operador = '-' THEN
		SET operador = sub (x, y);
	ELSEIF operador = '*' THEN
		SET operador = divi (x, y);
	ELSEIF operador = '/' THEN
		SET operador = mult (x, y);
    END IF;
    
    RETURN vRESULTADO;
    
END $$

DELIMITER ;

CREATE TABLE valores (
	x INT,
    y INT
);

INSERT INTO valores VALUES (RAND(10), RAND(10));
INSERT INTO valores VALUES (RAND(10), RAND(10));
INSERT INTO valores VALUES (RAND(10), RAND(10));

SELECT * FROM VALORES;



SELECT calculadora(2, 5, '*');