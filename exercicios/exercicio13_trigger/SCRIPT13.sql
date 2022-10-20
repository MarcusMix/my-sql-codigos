SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBPEDIDO;
CREATE DATABASE DBPEDIDO;

USE DBPEDIDO;

CREATE TABLE PRODUTO (
	IDPRODUTO INT NOT NULL AUTO_INCREMENT
    , NOME VARCHAR(45)
    , ESTOQUE INT
	, PRIMARY KEY(IDPRODUTO)
);

CREATE TABLE COMPRA (
	IDCOMPRA INT NOT NULL AUTO_INCREMENT
    , IDPRODUTO INT NOT NULL
	, QTDE INT
    , PRECOUNITARIO NUMERIC(8,2)
    , PRIMARY KEY (IDCOMPRA)
    , FOREIGN KEY (IDPRODUTO) REFERENCES PRODUTO(IDPRODUTO)
);

CREATE TABLE VENDA (
	IDVENDA INT NOT NULL AUTO_INCREMENT
    , IDPRODUTO INT NOT NULL
	, QTDE INT
    , PRECOUNITARIO NUMERIC(8,2)
    , PRIMARY KEY (IDVENDA)
    , FOREIGN KEY (IDPRODUTO) REFERENCES PRODUTO(IDPRODUTO)
);

INSERT INTO produto (idproduto,nome,estoque) VALUES (1,"coca",500);
INSERT INTO produto (idproduto,nome,estoque) VALUES (2,"pepsi",2000);
INSERT INTO venda  (idvenda, idproduto, qtde, precounitario) VALUES (1,1, 1, 2);
INSERT INTO venda  (idvenda, idproduto, qtde, precounitario) VALUES (2,2, 10, 1);


-- questao 01
DELIMITER $$
CREATE TRIGGER tr_venda_au AFTER UPDATE ON compra FOR EACH ROW
BEGIN
	UPDATE produto 
    SET estoque = estoque + OLD.qtde
    WHERE idproduto = OLD.idproduto;
    
END $$

-- questao 02

CREATE TRIGGER tr_compra_ai AFTER INSERT ON compra FOR EACH ROW
BEGIN
	UPDATE produto 
    SET estoque = estoque - NEW.qtde 
    WHERE idproduto = NEW.idproduto;
END $$

-- questao 03

CREATE TRIGGER tr_venda_ad AFTER DELETE ON venda FOR EACH ROW
BEGIN
	UPDATE produto 
    SET estoque = estoque + OLD.qtde 
    WHERE idproduto = OLD.idproduto;
END$$


-- questao 04


-- questao 05
      
DECLARE vEstoque = INT;
SET vEstoque = estoque;
SELECT estoque
INTO vEstoque
FROM produto
WHERE idproduto = NEW.idproduto;

CREATE TRIGGER tr_venda_bu BEFORE UPDATE venda FOR EACH ROW
BEGIN
IF NEW.qtde > vEstoque THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'QUANTIDADE NÃO DISPONÍVEL NO ESTOQUE';
END IF;
END $$



-- questao 06







DELIMITER ;    

select * from produto;
