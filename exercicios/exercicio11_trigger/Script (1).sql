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