DROP DATABASE IF EXISTS DBSENAC;
CREATE DATABASE DBSENAC;

USE DBSENAC;

CREATE TABLE DEPARTAMENTO (
	IDDEP INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(100)
	, RESPONSAVEL VARCHAR(45)
);


CREATE TABLE EQUIPAMENTO (
	IDEQUIP INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, IDDEP INT NOT NULL
	, DESCRICAO VARCHAR(100)
	, TIPO VARCHAR(10)
	, QTDE INT
	, FOREIGN KEY (IDDEP) REFERENCES DEPARTAMENTO (IDDEP)
);

-- CREATE USER 'ADMSENAC' @ '%' IDENTIFIED BY '123456';
-- CREATE USER 'ESTAGIARIO' @ 'localhost' IDENTIFIED BY '123456';

GRANT SELECT ON DBSENAC.* TO 'ADMSENAC'@'%';

GRANT SELECT ON DBSENAC.EQUIPAMENTO TO 'ESTAGIARIO'@'localhost';

GRANT UPDATE (QTDE) ON DBSENAC.EQUIPAMENTO TO 'ESTAGIARIO'@'localhost';

