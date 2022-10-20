SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS dbexemplos;
CREATE DATABASE dbexemplos;
USE dbexemplos;




CREATE TABLE produtos (
	codigo INT NOT NULL PRIMARY KEY,
    nome VARCHAR(100),
    preco FLOAT
);

CREATE TABLE produtos_backup (
    codigo INT,
    nome VARCHAR(100),
    preco FLOAT
);

CREATE TABLE produtos_historico (
    codigo INT,
    nome VARCHAR(100),
    preco FLOAT,
    data_alteracao DATETIME
);



INSERT INTO produtos (codigo, nome, preco) VALUES (1, 'cafézinho com leite', 3);
INSERT INTO produtos (codigo, nome, preco) VALUES (2, 'mentos', 2);
INSERT INTO produtos (codigo, nome, preco) VALUES (3, 'prestígio', 3);
INSERT INTO produtos (codigo, nome, preco) VALUES (4, 'moranguete', 2.5);
INSERT INTO produtos (codigo, nome, preco) VALUES (5, 'açai', 9);
INSERT INTO produtos (codigo, nome, preco) VALUES (6, 'empanado de calabresa', 7);
INSERT INTO produtos (codigo, nome, preco) VALUES (7, 'salschicha', 4);
INSERT INTO produtos (codigo, nome, preco) VALUES (8, 'beijin da milena', 50);


 UPDATE produtos SET nome = 'nescau' WHERE codigo = 3;

DELIMITER $$


CREATE TRIGGER tg_produtos_bd BEFORE DELETE ON produtos FOR EACH ROW
BEGIN

	INSERT INTO produtos_backup (codigo, nome, preco) VALUES
    (OLD.codigo, OLD.nome, OLD.preco);

END $$

CREATE TRIGGER tg_produtos_historico_bd BEFORE DELETE ON produtos FOR EACH ROW
BEGIN

	INSERT INTO produtos_historico (codigo, nome, preco, data_alteracao) VALUES
    (OLD.codigo, OLD.nome, OLD.preco, NOW());

END $$

DELIMITER ;


DELETE FROM produtos WHERE codigo = 5;
-- drop table produtosup;

CREATE TABLE produtosUP (
	codigoUP INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_antes VARCHAR(100),
	nome_depois VARCHAR(100)
);


DROP TRIGGER IF EXISTS tg_produtosup_au;
DELIMITER $$ 

CREATE TRIGGER tg_produtosup_au AFTER UPDATE ON produtos FOR EACH ROW 

BEGIN

	INSERT INTO produtosUP (nome_antes, nome_depois) VALUES
	(OLD.nome, NEW.nome);

END $$

DELIMITER ;


SELECT * FROM produtos;

SELECT * FROM produtos_backup;

SELECT * FROM produtos_historico;

SELECT * FROM produtosup;

 UPDATE produtos SET nome = 'trident' WHERE codigo = 2;

