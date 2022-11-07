SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBEXERCICIO17;
CREATE DATABASE DBEXERCICIO17;
USE DBEXERCICIO17;

CREATE TABLE CLIENTE(
	IDCLIENTE INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(100)
	, CPF CHAR(11)
);

CREATE TABLE CONTA (
	IDCONTA INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, IDCLIENTE INT NOT NULL
	, DT_ABERTURA DATE
	, LIMITE_CREDITO NUMERIC(8,2)
	, TIPO ENUM('CONTA-CORRENTE', 'POUPANÇA')
	, FOREIGN KEY (IDCLIENTE) REFERENCES CLIENTE (IDCLIENTE)
);

CREATE TABLE MOVIMENTACAO(
	IDMOVIMENTACAO INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, IDCONTA INT NOT NULL
	, DT_MOVIMENTACAO DATE
	, VALOR NUMERIC(8,2)
	, TIPO ENUM('DEBITO', 'CRÉDITO')
	, OBSERVAÇÃO TEXT
	, FOREIGN KEY (IDCONTA) REFERENCES CONTA (IDCONTA)
);

-- criar uma view 
CREATE VIEW vw_saldo AS
SELECT 
	conta.idconta,
    conta.tipo,
    conta.limite_credito,
	IFNULL(SUM(movimentacao.valor), 0) as saldo,
    IFNULL(SUM(movimentacao.valor), 0) + conta.limite_credito as saldo_total
 FROM 
	conta
    LEFT JOIN movimentacao ON
    conta.idconta = movimentacao.idconta
GROUP BY
	conta.idconta,
    conta.tipo,
    conta.limite_credito,
	movimentacao.idconta;
    
    DELIMITER $$

CREATE PROCEDURE operacao (Pidconta INT, valor NUMERIC(8, 2), operacao_mov ENUM('SAQUE', 'DEPOSITO'), OUT resultado VARCHAR(100)) 
BEGIN
	DECLARE tipo_operacao VARCHAR(10);
    DECLARE vtipo_conta VARCHAR(15);
	DECLARE vsaldo NUMERIC(8, 2);
    DECLARE vsaldo_total NUMERIC(8, 2);
	
    SELECT tipo, saldo, saldo_total
    INTO vtipo_conta, vsaldo, vsaldo_total
    FROM vw_saldo
    WHERE idconta = Pidconta;
    
	IF operacao_mov = 'SAQUE' THEN
		SET tipo_operacao = 'DEBITO';
        -- transformar o saque sempre para negativo
        -- ABS sempre transforma o numero em positivo
				IF vsaldo_total < valor THEN
					SET resultado = 'SALDO INSUFICIENTE' ;
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Impossível sacar mais do que o valor em conta!';
				ELSE 
        
			IF valor > 0 THEN
				SET valor = ABS(valor) * -1;
			END IF;
				
					INSERT INTO movimentacao (idconta, dt_movimentacao, valor, tipo) 
					VALUES (Pidconta , NOW(), valor, tipo_operacao);
				END IF;
        
	ELSEIF operacao_mov = 'DEPOSITO' THEN
		SET tipo_operacao = 'CRÉDITO';
			INSERT INTO movimentacao (idconta, dt_movimentacao, valor, tipo) 
			VALUES (Pidconta , NOW(), valor, tipo_operacao);
	END IF;
    
    

	SET resultado = 'Operação realizada com sucesso!';
END $$



CREATE PROCEDURE transferencia (conta_origem INT, conta_destino INT, valor NUMERIC(8, 2), OUT resultado VARCHAR(100)) 
BEGIN
	DECLARE vresultado VARCHAR(100);
    
	CALL operacao (conta_origem, valor, 'SAQUE', @resultado);
	
    IF vresultado = 'SALDO INSUFICIENTE' THEN
		SET resultado = vresultado;
	ELSE
		CALL operacao (conta_destino, valor, 'DEPOSITO', @resultado);
        SET resultadO = 'TRANSFERENCIA REALIZADA COM SUCESSO';
    END IF;
END $$

DELIMITER ;


-- incluindo informações na tabela
INSERT INTO cliente VALUES (1, 'Carlos', '12345678901');
INSERT INTO conta VALUES (1, 1, NOW(), 100, 'CONTA-CORRENTE');
INSERT INTO conta VALUES (2, 1, NOW(), 0, 'POUPANÇA');

-- exemplo deposito
CALL operacao (1, 1000, 'DEPOSITO', @resultado);
SELECT @resultado;

-- exemplo saque
  CALL operacao (1, 300, 'SAQUE',  @resultado);
  SELECT @resultado;


select * from movimentacao;
SELECT * FROM vw_saldo;




CALL transferencia(1, 2, 900, @resultado);










-- INSERT INTO movimentacao (idconta, dt_movimentacao, valor, tipo) 
-- VALUES (1, NOW(), 200, 'DEBITO');
-- INSERT INTO movimentacao (idconta, dt_movimentacao, valor, tipo) 
-- VALUES (1, NOW(), 1000, 'CRÉDITO');
